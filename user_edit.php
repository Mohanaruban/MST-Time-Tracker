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
import('ttProjectHelper');
import('ttTeamHelper');
import('ttUserHelper');
import('form.Table');
import('form.TableColumn');

// Access check.
// if (!ttAccessCheck(right_manage_team)) {
//   header('Location: access_denied.php');
//   exit();
// }

// Access check.
if (ttAccessCheck(right_data_entry)) {
  if(!$user->isAdmin() && !$user->isManager()) {
  header('Location: access_denied.php');
  exit();
}
}

// Get user id we are editing from the request.
$user_id = (int) $request->getParameter('id');

// Get user details.
$user_details = ttUserHelper::getUserDetails($user_id);

// Security checks.

// if(!$user->isAdmin()) {
//     header('Location: access_denied.php'); // Admin only have editing permission
//   exit();
// }
// if (!$user->canManageTeam() && !$user->isAdmin()) {
//   header('Location: access_denied.php'); // Admin only have editing permission
//   exit();
// $ok_to_go = $user->canManageTeam(); // Are we authorized for user management?
// if ($ok_to_go) $ok_to_go = $ok_to_go && $user_details; // Are we editing a real user?
// if ($ok_to_go) $ok_to_go = $ok_to_go && ($user->team_id == $user_details['team_id']); // User belongs to our team?
// if ($ok_to_go && $user->isCoManager() && (ROLE_COMANAGER == $user_details['role']))
//   $ok_to_go = ($user->id == $user_details['id']); // Comanager is not allowed to edit other comanagers.
// if ($ok_to_go && $user->isCoManager() && (ROLE_MANAGER == $user_details['role']))
//   $ok_to_go = false; // Comanager is not allowed to edit a manager.
// if (!$ok_to_go) {
//   die ($i18n->getKey('error.sys'));
// }
// }
if ($user->isPluginEnabled('cl'))
  $clients = ttTeamHelper::getActiveClients($user->team_id);
$projects = ttTeamHelper::getActiveProjects($user->team_id);
if($user->isManager()) {
$projects = ttProjectHelper::getAssignedProjects($user_id);
}
if($user->isAdmin()) { 
  $teamid = "";
  $getTeamID = ttTeamHelper::getTeamIDAdmin($user_id);
  foreach ($getTeamID as $id) {
  $teamid = $id['team_id'];
}
$projects = ttTeamHelper::getActiveProjectsAdmin($teamid);
if($teamid != "") {
$projects = ttTeamHelper::getActiveProjectsUserEditAdmin($user_id, $teamid);
}
}
 $cl_billable = array();
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
  $cl_client_id = $request->getParameter('client');
  $cl_status = $request->getParameter('status');
  $cl_rate = $request->getParameter('rate');
  $cl_projects = $request->getParameter('projects');
  $cl_projectList = $request->getParameter('projectList');
  $cl_billableProjects = $request->getParameter('billable');
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
} else {
  $cl_name = $user_details['name'];
  $cl_login = $user_details['login'];
  $cl_email = $user_details['email'];
  $cl_rate = str_replace('.', $user->decimal_mark, $user_details['rate']);
  $cl_role = $user_details['role'];
  $cl_client_id = $user_details['client_id'];
  $cl_status = $user_details['status'];
  $cl_projects = array();
  $assigned_projects = ttProjectHelper::getAssignedProjects($user_id);
  if($user->isAdmin()) {
  $assigned_projects = ttProjectHelper::getAssignedProjectsAdmin($user_id,$teamid);
  }
  if($user->isManager()) {
  $assigned_projects = ttProjectHelper::getProjectsManager($user_id);
  }
  foreach($assigned_projects as $p) {
    $cl_projects[] = $p['id'];
  }
    if($user->isAdmin()) {
  $assigned_billable = ttProjectHelper::getAssignedbillableAdmin($user_id,$teamid);
  }
    foreach($assigned_billable as $b) {
    $cl_billable[] = $b['id'];
  }
}
$form = new Form('userForm');
$form->addFormStyle(array('class'=>'form-horizontal'));

// Dropdown for projects assigned to user.
  // $get_manager = ttTeamHelper::getManagerList();
  // $form->addInput(array('type'=>'combobox',
  //   'class'=>'form-control',
  //   'onchange'=>'fillTaskDropdown(this.value);',
  //   'name'=>'manager_list',
  //   'value'=>"",
  //   'data'=>$get_manager,
  //   'datakeys'=>array('id','name'),
  //   //'empty'=>array(''=>$i18n->getKey('dropdown.select'))
  //   ));
$form->addInput(array('type'=>'hidden','name'=>'manager_list','value'=>'1'));
$form->addInput(array('type'=>'text','maxlength'=>'100','name'=>'name', 'class'=>'form-control','value'=>$cl_name));
$form->addInput(array('type'=>'text','maxlength'=>'100','name'=>'login', 'class'=>'form-control','value'=>$cl_login));
if (!$auth->isPasswordExternal()) {
  $form->addInput(array('type'=>'text','maxlength'=>'30', 'class'=>'form-control', 'name'=>'pas1','aspassword'=>true,'value'=>$cl_password1));
  $form->addInput(array('type'=>'text','maxlength'=>'30', 'class'=>'form-control', 'name'=>'pas2','aspassword'=>true,'value'=>$cl_password2));
}
$form->addInput(array('type'=>'text','maxlength'=>'100', 'class'=>'form-control', 'name'=>'email','placeholder'=>'Enter valid email with mstsolutions.com domain','value'=>$cl_email));

$roles[ROLE_USER] = $i18n->getKey('label.user');
$roles[ROLE_MANAGER] = $i18n->getKey('form.users.manager');
if ($user->isPluginEnabled('cl'))
  $roles[ROLE_CLIENT] = $i18n->getKey('label.client');
$form->addInput(array('type'=>'combobox', 'class'=>'form-control', 'name'=>'role','value'=>$cl_role,'data'=>$roles));
if ($user->isPluginEnabled('cl'))
  $form->addInput(array('type'=>'combobox', 'class'=>'form-control', 'name'=>'client', 'value'=>$cl_client_id,'data'=>$clients,'datakeys'=>array('id', 'name'),'empty'=>array(''=>$i18n->getKey('dropdown.select'))));

$form->addInput(array('type'=>'combobox', 'class'=>'form-control', 'name'=>'status', 'value'=>$cl_status,
  'data'=>array(ACTIVE=>$i18n->getKey('dropdown.status_active'),INACTIVE=>$i18n->getKey('dropdown.status_inactive'))));
$form->addInput(array('type'=>'floatfield','maxlength'=>'10', 'class'=>'form-control', 'name'=>'rate','format'=>'.2','value'=>$cl_rate));

// Define classes for the projects table.
class NameCellRenderer extends DefaultCellRenderer {

  function render(&$table, $value, $row, $column, $selected = false) {
    //$this->setOptions(array('width'=>200,'valign'=>'top'));
    $this->setValue('<label for = "'.$table->getName().'_'.$row.'">'.htmlspecialchars($value).'</label>');
    return $this->toString();
  }
}

class BoxCellRenderer extends DefaultCellRenderer {
  function render(&$table, $value, $row, $column, $selected = false) {
    global $cl_billable;
    $this->setOptions(array('width'=>200,'valign'=>'top'));
    $this->setValue("<input type='checkbox' id='billable_".$row."' name = 'billable[]' value=".$table->getValueAtName($row, 'id').">");
    foreach ($cl_billable as $value) {
      if($table->getValueAtName($row, 'id') == $value) {
        $this->setValue("<input type='checkbox' id='billable_".$row."' name = 'billable[]' value=".$table->getValueAtName($row, 'id')." checked>");
      }
    }
    return $this->toString();
  }
}

class RateCellRenderer extends DefaultCellRenderer {
  function render(&$table, $value, $row, $column, $selected = false) {
    global $assigned_projects;
    $field = new FloatField('rate_'.$table->getValueAtName($row,'id'), $table->getValueAtName($row, 'p_rate'));
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
$table->setTableOptions(array('class'=>'table table-responsive table-hover table-bordered', 'id'=>"projectTable"));
$table->setRowOptions(array('valign'=>'top'));
$table->setData($projects);
$table->setKeyField('id');
$table->setValue($cl_projects);
// $table->setValue($cl_billable);
$table->addColumn(new TableColumn('name', $i18n->getKey('label.project'), new NameCellRenderer()));
$table->addColumn(new TableColumn('', "Billable",new BoxCellRenderer()));
// if($user->isAdmin()) {
// $table->addColumn(new TableColumn('p_rate', $i18n->getKey('form.users.rate'), new RateCellRenderer()));
// }
$form->addInputElement($table);

$form->addInput(array('type'=>'hidden','name'=>'id','value'=>$user_id));
$form->addInput(array('type'=>'submit', 'class'=>'btn btn-success', 'name'=>'btn_submit','value'=>$i18n->getKey('button.save')));
if ($request->isPost()) {
  // Validate user input.
  if (!ttValidString($cl_name)) $err->add($i18n->getKey('error.field'), $i18n->getKey('label.person_name'));
  if (!ttValidString($cl_login)) $err->add($i18n->getKey('error.field'), $i18n->getKey('label.login'));
  if (!$auth->isPasswordExternal() && ($cl_password1 || $cl_password2)) {
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
    $existing_user = ttUserHelper::getUserByLogin($cl_login);
    if (!$existing_user || ($user_id == $existing_user['id'])) {

      $fields = array(
        'team_id' => $cl_teamid,
        'name' => $cl_name,
        'login' => $cl_login,
        'password' => $cl_password1,
        'email' => $cl_email,
        'status' => $cl_status,
        'rate' => $cl_rate,
        'billable' => $cl_billableProjects,
        'projects' => $assigned_projects);
      if (right_assign_roles & $user->rights) {
        $fields['role'] = $cl_role;
        $fields['client_id'] = $cl_client_id;
      }

      if (ttUserHelper::updateAdmin($user_id, $fields)) {

        // If our own login changed, set new one in cookie to remember it.
        if (($user_id == $user->id) && ($user->login != $cl_login)) {
          setcookie('tt_login', $cl_login, time() + COOKIE_EXPIRE, '/');
        }

        // In case the name of the "on behalf" user has changed - set it in session.
        if (($user->behalf_id == $user_id) && ($user->behalf_name != $cl_name)) {
          $_SESSION['behalf_name'] = $cl_name;
        }

        // If we deactivated our own account, do housekeeping and logout.
        if ($user->id == $user_id && !is_null($cl_status) && $cl_status == INACTIVE) {
          // Remove tt_login cookie that stores login name.
          unset($_COOKIE['tt_login']);
          setcookie('tt_login', NULL, -1);

          $auth->doLogout();
          header('Location: login.php');
          exit();
        }

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
$smarty->assign('onload', 'onLoad="document.userForm.name.focus();"');
$smarty->assign('user_id', $user_id);
$smarty->assign('teamid', $get_manager);
$smarty->assign('projectList',$projects);
$smarty->assign('title', $i18n->getKey('title.edit_user'));
$smarty->assign('content_page_name', 'user_edit.tpl');
$smarty->display('index.tpl');
