<?php
// +----------------------------------------------------------------------+
// | Anuko Time Tracker
// +----------------------------------------------------------------------+
// | Copyright (c) Anuko International Ltd. (https://www.anuko.com)
// +----------------------------------------------------------------------+
// | LIBERAL FREEWARE LICENSE: This source code document may be used
// | by anyone for any purpose, and freely redistributed alone or in
// | combination with other software, provided that the license is obeyed.
// |
// | There are only two ways to violate the license:
// |
// | 1. To redistribute this code in source form, with the copyright
// |    notice or license removed or altered. (Distributing in compiled
// |    forms without embedded copyright notices is permitted).
// |
// | 2. To redistribute modified versions of this code in *any* form
// |    that bears insufficient indications that the modifications are
// |    not the work of the original author(s).
// |
// | This license applies to this document only, not any other software
// | that it may be combined with.
// |
// +----------------------------------------------------------------------+
// | Contributors:
// | https://www.anuko.com/time_tracker/credits.htm
// +----------------------------------------------------------------------+

require_once('initialize.php');
import('form.Form');
import('ttUserHelper');

// Access check.
if (!ttAccessCheck(right_administer_site)) {
  header('Location: access_denied.php');
  exit();
}

if ($request->isPost()) {
  $cl_name = trim($request->getParameter('name'));
  $cl_login = trim($request->getParameter('login'));
  if (!$auth->isPasswordExternal()) {
    $cl_password1 = $request->getParameter('password1');
    $cl_password2 = $request->getParameter('password2');
  }
  $cl_email = trim($request->getParameter('email'));
} else {
  $cl_name = $user->name;
  $cl_login = $user->login;
  $cl_email = $user->email;
}

$form = new Form('optionsForm');
$form->addFormStyle(array('class'=>'form-horizontal'));
$form->addInput(array('type'=>'text','maxlength'=>'100', 'class'=>'form-control', 'name'=>'name','value'=>$cl_name,'class'=>'form-control','placeholder'=>'Enter Name'));
$form->addInput(array('type'=>'text','maxlength'=>'100', 'class'=>'form-control', 'name'=>'login','value'=>$cl_login,'class'=>'form-control','placeholder'=>'Enter Login Name'));
if (!$auth->isPasswordExternal()) {
  $form->addInput(array('type'=>'text','maxlength'=>'30', 'class'=>'form-control', 'name'=>'password1','aspassword'=>true,'value'=>$cl_password1));
  $form->addInput(array('type'=>'text','maxlength'=>'30', 'class'=>'form-control', 'name'=>'password2','aspassword'=>true,'value'=>$cl_password2));
}
$form->addInput(array('type'=>'text','maxlength'=>'100', 'class'=>'form-control', 'name'=>'email','value'=>$cl_email,'class'=>'form-control','placeholder'=>'Enter Email'));
$form->addInput(array('type'=>'submit', 'class'=>'btn btn-success', 'name'=>'btn_submit','value'=>$i18n->getKey('button.submit')));

if ($request->isPost()) {
  // Validate user input.
  if (!ttValidString($cl_name)) $err->add($i18n->getKey('error.field'), $i18n->getKey('label.person_name'));
  if (!ttValidString($cl_login)) $err->add($i18n->getKey('error.field'), $i18n->getKey('label.login'));
  // New login must be unique.
  if ($cl_login != $user->login && ttUserHelper::getUserByLogin($cl_login))
    $err->add($i18n->getKey('error.user_exists'));
  if (!$auth->isPasswordExternal() && ($cl_password1 || $cl_password2)) {
    if (!ttValidString($cl_password1)) $err->add($i18n->getKey('error.field'), $i18n->getKey('label.password'));
    if (!ttValidString($cl_password2)) $err->add($i18n->getKey('error.field'), $i18n->getKey('label.confirm_password'));
    if ($cl_password1 !== $cl_password2)
      $err->add($i18n->getKey('error.not_equal'), $i18n->getKey('label.password'), $i18n->getKey('label.confirm_password'));
  }
  if (!ttValidEmail($cl_email, true)) $err->add($i18n->getKey('error.field'), $i18n->getKey('label.email'));
  // Finished validating user input.

  if ($err->no()) {
    if (ttUserHelper::update($user->id, array(
      'name' => $cl_name,
      'login' => $cl_login,
      'password' => $cl_password1,
      'email' => $cl_email,
      'status' => ACTIVE))) {
      header('Location: admin_teams.php');
      exit();
    } else {
      $err->add($i18n->getKey('error.db'));
    }
  }
} // isPost

$smarty->assign('auth_external', $auth->isPasswordExternal());
$smarty->assign('forms', array($form->getName()=>$form->toArray()));
$smarty->assign('title', $i18n->getKey('title.options'));
$smarty->assign('content_page_name', 'admin_options.tpl');
$smarty->display('index.tpl');
