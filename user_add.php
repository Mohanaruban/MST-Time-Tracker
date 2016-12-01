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
import('ttTeamHelper');
import('ttUserHelper');
import('form.Table');
import('form.TableColumn');

// Access check.
if (!ttAccessCheck(right_manage_team)) {
  header('Location: access_denied.php');
  exit();
}

// Use the "limit" plugin if we have one. Ignore include errors.
// The "limit" plugin is not required for normal operation of the Time Tracker.
@include('plugins/limit/user_add.php');

if ($user->isPluginEnabled('cl'))
  $clients = ttTeamHelper::getActiveClients($user->team_id);

$assigned_projects = array();
if ($request->isPost()) {
  $cl_teamid = trim($request->getParameter('manager_list'));
  $cl_name = trim($request->getParameter('name'));
  $cl_login = trim($request->getParameter('login'));
  if (!$auth->isPasswordExternal()) {
    $cl_password1 = $request->getParameter('pas1');
    $cl_password2 = $request->getParameter('pas2');
  }
  $cl_email = trim($request->getParameter('email'));
  $cl_role = $request->getParameter('role');
  if (!$cl_role) $cl_role = ROLE_USER;
  $cl_client_id = $request->getParameter('client');
  $cl_rate = $request->getParameter('rate');
  $cl_projects = $request->getParameter('projects');
  if (is_array($cl_projects)) {
    foreach ($cl_projects as $p) {
      if (ttValidFloat($request->getParameter('rate_'.$p), true)) {
      	$project_with_rate = array();
        $project_with_rate['id'] = $p;
        $project_with_rate['rate'] = $request->getParameter('rate_'.$p);
        $assigned_projects[] = $project_with_rate;
      } else
        $err->add($i18n->getKey('error.field'), 'rate_'.$p);
    }
  }
}

$form = new Form('userForm');
$form->addFormStyle(array('class'=>'form-horizontal'));

// Dropdown for projects assigned to user.
  $get_manager = ttTeamHelper::getManagerList();
  // $form->addInput(array('type'=>'hidden',
  //   'class'=>'form-control',
  //   'onchange'=>'fillTaskDropdown(this.value);',
  //   'name'=>'manager_list',
  //   'value'=>"",
  //   'data'=>$get_manager,
  //   'datakeys'=>array('id','name'),
  //   //'empty'=>array(''=>$i18n->getKey('dropdown.select'))
  //   ));

$form->addInput(array('type'=>'text','maxlength'=>'100','name'=>'name','value'=>$cl_name,'class'=>'form-control','placeholder'=>'Enter Name'));
$form->addInput(array('type'=>'hidden','name'=>'manager_list','value'=>'1'));
$form->addInput(array('type'=>'text','maxlength'=>'100','name'=>'login','value'=>$cl_login,'class'=>'form-control','placeholder'=>'Enter Login Name'));
if (!$auth->isPasswordExternal()) {
  $form->addInput(array('type'=>'text','maxlength'=>'30', 'class'=>'form-control', 'name'=>'pas1','aspassword'=>true,'value'=>$cl_password1));
  $form->addInput(array('type'=>'text','maxlength'=>'30', 'class'=>'form-control', 'name'=>'pas2','aspassword'=>true,'value'=>$cl_password2));
}
$form->addInput(array('type'=>'text','maxlength'=>'100','name'=>'email','value'=>$cl_email,'class'=>'form-control','placeholder'=>'Enter Email'));

// $roles[ROLE_USER] = $i18n->getKey('label.user');
// $roles[ROLE_COMANAGER] = $i18n->getKey('form.users.comanager');
$roles[ROLE_USER] = $i18n->getKey('label.user');
$roles[ROLE_MANAGER] = $i18n->getKey('form.users.manager');
// if ($user->isPluginEnabled('cl'))
//   $roles[ROLE_CLIENT] = $i18n->getKey('label.client');
$form->addInput(array('type'=>'combobox','onchange'=>'handleClientControl()', 'class'=>'form-control', 'name'=>'role','value'=>$cl_role,'data'=>$roles));
if ($user->isPluginEnabled('cl'))
  $form->addInput(array('type'=>'combobox', 'class'=>'form-control', 'name'=>'client','value'=>$cl_client_id,'data'=>$clients,'datakeys'=>array('id', 'name'),'empty'=>array(''=>$i18n->getKey('dropdown.select'))));

$form->addInput(array('type'=>'floatfield','maxlength'=>'10', 'class'=>'form-control', 'name'=>'rate','format'=>'.2','value'=>$cl_rate));

$projects = ttTeamHelper::getActiveProjects($user->team_id);

// Define classes for the projects table.
class NameCellRenderer extends DefaultCellRenderer {
  function render(&$table, $value, $row, $column, $selected = false) {
    $this->setOptions(array('width'=>200,'valign'=>'top'));
    $this->setValue('<label for = "'.$table->getName().'_'.$row.'">'.htmlspecialchars($value).'</label>');
    return $this->toString();
  }
}
class RateCellRenderer extends DefaultCellRenderer {
  function render(&$table, $value, $row, $column, $selected = false) {
    global $assigned_projects;
    $field = new FloatField('rate_'.$table->getValueAtName($row, 'id'), $table->getValueAtName($row, 'p_rate'));
    $field->setFormName($table->getFormName());
    $field->setLocalization($GLOBALS['I18N']);
    $field->setSize(5);
    $field->setFormat('.2');
    foreach ($assigned_projects as $p) {
      if ($p['id'] == $table->getValueAtName($row,'id')) $field->setValue($p['rate']);
    }
    $this->setValue($field->toStringControl());
    return $this->toString();
  }
}
// Create projects table.
$table = new Table('projects');
$table->setIAScript('setDefaultRate');
$table->setTableOptions(array('class'=>'table table-responsive table-striped table-hover table-bordered text-left', 'id'=>"projectTable"));
$table->setRowOptions(array('valign'=>'top'));
$table->setData($projects);
$table->setKeyField('id');
$table->setValue($cl_projects);
$table->addColumn(new TableColumn('name', $i18n->getKey('label.project'), new NameCellRenderer()));
//$table->addColumn(new TableColumn('p_rate', $i18n->getKey('form.users.rate'), new RateCellRenderer()));
$form->addInputElement($table);

$form->addInput(array('type'=>'submit','name'=>'btn_submit','class'=>'btn btn-success','value'=>$i18n->getKey('button.submit')));

if ($request->isPost()) {
  // Validate user input.
  if (!ttValidString($cl_name)) $err->add($i18n->getKey('error.field'), $i18n->getKey('label.person_name'));
  if (!ttValidString($cl_login)) $err->add($i18n->getKey('error.field'), $i18n->getKey('label.login'));
  if (!$auth->isPasswordExternal()) {
    if (!ttValidString($cl_password1)) $err->add($i18n->getKey('error.field'), $i18n->getKey('label.password'));
    if (!ttValidString($cl_password2)) $err->add($i18n->getKey('error.field'), $i18n->getKey('label.confirm_password'));
if(strlen($cl_password1)<6){
  $err->add($i18n->getKey('error.min_length'), $i18n->getKey('label.password'));
}
    
    if ($cl_password1 !== $cl_password2)
      $err->add($i18n->getKey('error.not_equal'), $i18n->getKey('label.password'), $i18n->getKey('label.confirm_password'));
  }
  // if (!ttValidEmail($cl_email, true)) $err->add($i18n->getKey('error.field'), $i18n->getKey('label.email'));
  $user_email = ttUserHelper::getmailvalidate($cl_email);
  if(!$user_email) {
    $err->add($i18n->getKey('error.mstmail'), $i18n->getKey('label.email'));
  }
  if (!ttValidFloat($cl_rate, true)) $err->add($i18n->getKey('error.field'), $i18n->getKey('form.users.default_rate'));

  if ($err->no()) {
    if (!ttUserHelper::getUserByLogin($cl_login)) {
      $fields = array(
        'name' => $cl_name,
        'login' => $cl_login,
        'password' => $cl_password1,
        'rate' => $cl_rate,
        // 'team_id' => $user->team_id,
        'team_id' => $cl_teamid,
        'role' => $cl_role,
        'client_id' => $cl_client_id,
        'projects' => $assigned_projects,
        'email' => $cl_email);
      if (ttUserHelper::insert($fields)) {
        header('Location: users.php');
        exit();
      } else
        $err->add($i18n->getKey('error.db'));
    } else
      $err->add($i18n->getKey('error.user_exists'));
  }
} // isPost

$smarty->assign('auth_external', $auth->isPasswordExternal());
$smarty->assign('forms', array($form->getName()=>$form->toArray()));
$smarty->assign('onload', 'onLoad="document.userForm.name.focus();handleClientControl();"');
$smarty->assign('title', $i18n->getKey('title.add_user'));
$smarty->assign('teamid', $get_manager);
$smarty->assign('content_page_name', 'user_add.tpl');
$smarty->display('index.tpl');
