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
import('form.ActionForm');
import('DateAndTime');
import('ttTeamHelper');
import('Period');
import('ttProjectHelper');
import('ttFavReportHelper');
import('ttClientHelper');


if (!ttAccessCheck(right_view_reports)) {
  header('Location: access_denied.php');
  exit();
}

$cl_client = $request->getParameter('client', ($request->getMethod()=='POST' ? null : @$_SESSION['client']));
$_SESSION['client'] = $cl_client;
$cl_manager = $request->getParameter('manager', ($request->getMethod()=='POST' ? null : @$_SESSION['manager']));
$_SESSION['manager'] = $cl_manager;
$cl_project = $request->getParameter('project', ($request->getMethod()=='POST' ? null : @$_SESSION['project']));
$_SESSION['project'] = $cl_project;


// Use custom fields plugin if it is enabled.
if ($user->isPluginEnabled('cf')) {
  require_once('plugins/CustomFields.class.php');
  $custom_fields = new CustomFields($user->team_id);
  $smarty->assign('custom_fields', $custom_fields);
}

$form = new Form('reportForm');

$form->addFormStyle(array('class'=>'form-horizontal'));

// Get saved favorite reports for user.
$report_list = ttFavReportHelper::getReports($user->id);
$form->addInput(array('type'=>'combobox',
  'class'=>'form-control',
  'name'=>'favorite_report',
  'onchange'=>'document.reportForm.fav_report_changed.value=1;document.reportForm.submit();',
  'data'=>$report_list,
  'datakeys'=>array('id','name'),
  'empty'=>array('-1'=>$i18n->getKey('dropdown.no'))));
$form->addInput(array('type'=>'hidden','name'=>'fav_report_changed'));
// Generate and Delete buttons.
$form->addInput(array('type'=>'submit','class'=>'btn btn-primary','name'=>'btn_generate','value'=>$i18n->getKey('button.generate')));
$form->addInput(array('type'=>'submit','class'=>'btn btn-danger','name'=>'btn_delete','value'=>$i18n->getKey('label.delete'),'onclick'=>"return confirm('".$i18n->getKey('form.reports.confirm_delete')."')"));

// Dropdown for clients if the clients plugin is enabled.
if ($user->isPluginEnabled('cl') && !($user->isClient() && $user->client_id)) {
  if ($user->canManageTeam() || ($user->isClient() && !$user->client_id))
    $client_list = ttClientHelper::getClients($user->team_id);
  else
    $client_list = ttClientHelper::getClientsForUser();
  $form->addInput(array('type'=>'combobox',
    'onchange'=>'fillProjectDropdown(this.value);',
    'class'=>'form-control',
    'name'=>'client',
    'data'=>$client_list,
    'datakeys'=>array('id', 'name'),
    'empty'=>array(''=>$i18n->getKey('dropdown.all'))));
}




// If we have a TYPE_DROPDOWN custom field - add control to select an option.
if ($custom_fields && $custom_fields->fields[0] && $custom_fields->fields[0]['type'] == CustomFields::TYPE_DROPDOWN) {
  $form->addInput(array('type'=>'combobox','name'=>'option',
    'class'=>'form-control',
    'value'=>$cl_cf_1,
    'data'=>$custom_fields->options,
    'empty'=>array(''=>$i18n->getKey('dropdown.all'))));
}

// Add controls for projects and tasks.
if ($user->canManageTeam() || $user->isAdmin() || $user->isManager()) {
  if($user->isAdmin()) {
    $project_list = ttProjectHelper::getProjectsAdmin();
  } elseif($user->isManager()) {
    $project_list = ttProjectHelper::getProjectsManager($user->id);
  } else {
  $project_list = ttProjectHelper::getProjects(); // Manager and co-managers can run reports on all active and inactive projects.
} 
} elseif ($user->isClient()) {
  $project_list = ttProjectHelper::getProjectsForClient();
} else {
  //$project_list = ttProjectHelper::getAssignedProjects($user->id);	
  $project_list = ttProjectHelper::getProjectsManager($user->id);
}
// $form->addInput(array('type'=>'combobox',
//   'class'=>'form-control',
//   'onchange'=>'selectAssignedUsers(this.value)',
//   'name'=>'project',
//   'value'=>$cl_project,
//   'data'=>$project_list,
//   'datakeys'=>array('id','name'),
//   'multiple'=>true,
//   'empty'=>array(''=>$i18n->getKey('dropdown.all'))));

$form->addInput(array('type'=>'checkboxgroup',
  'name'=>'project',
  'onchange'=>'selectAssignedUsers()',
  'onClickSelect'=>'selectAssignedUsers()',
  'onClickDeselect'=>'selectAssignedUsers()',
  'data'=>array_column($project_list,"name","id"),
  'layout'=>'C'));


if ($user->isPluginEnabled('cl')) {
  $active_clients = ttTeamHelper::getActiveClients($user->team_id, true);
    // We need an array of assigned project ids to do some trimming. 
  foreach($project_list as $project)
    $projects_assigned_to_user[] = $project['id'];

    // Build a client list out of active clients. Use only clients that are relevant to user.
    // Also trim their associated project list to only assigned projects (to user).
  foreach($active_clients as $client) {
    $projects_assigned_to_client = explode(',', $client['projects']);
    $intersection = array_intersect($projects_assigned_to_client, $projects_assigned_to_user);
    if ($intersection) {
      $client['projects'] = implode(',', $intersection);
      $client_list[] = $client;
    }
  }
  $form->addInput(array('type'=>'combobox',
    'onchange'=>'fillProjectDropdown(this.value);',
    'name'=>'client',
    'class'=>'form-control',
    'value'=>$cl_client,
    'data'=>$client_list,
    'datakeys'=>array('id', 'name'),
    'empty'=>array(''=>$i18n->getKey('dropdown.all'))));
}

//$manager_list = ttTeamHelper::getManagerListReport();
$manager_lists = ttTeamHelper::getManagerListReport();
    // We need an array of assigned project ids to do some trimming. 
foreach($project_list as $project)
  $projects_assigned_to_user[] = $project['id'];

    // Build a client list out of active clients. Use only clients that are relevant to user.
    // Also trim their associated project list to only assigned projects (to user).
foreach($manager_lists as $manager) {
  $projects_assigned_to_client = explode(',', $manager['projects']);
  $intersection = array_intersect($projects_assigned_to_client, $projects_assigned_to_user);
  if ($intersection) {
    $manager['projects'] = implode(',', $intersection);
    $manager_list[] = $manager;
  }
}
$form->addInput(array('type'=>'combobox',
  'onchange'=>'selectAssignedProjects(this.value);selectAssignedUsers();',
  'name'=>'manager',
  'class'=>'form-control',
  'value'=>$cl_manager,
  'data'=>$manager_list,
  'datakeys'=>array('id', 'name'),
  'empty'=>array(''=>$i18n->getKey('dropdown.all'))
  ));

if (MODE_PROJECTS_AND_TASKS == $user->tracking_mode) {
  $task_list = ttTeamHelper::getActiveTasks($user->team_id);
  $form->addInput(array('type'=>'combobox',
    'class'=>'form-control',
    'name'=>'task',
    'data'=>$task_list,
    'datakeys'=>array('id','name'),
    'empty'=>array(''=>$i18n->getKey('dropdown.all'))));
}

// Add include records control.
$include_options = array('1'=>$i18n->getKey('form.reports.include_billable'),
  '2'=>$i18n->getKey('form.reports.include_not_billable'));
$form->addInput(array('type'=>'combobox',
  'class'=>'form-control',
  'name'=>'include_records',
  'data'=>$include_options,
  'empty'=>array(''=>$i18n->getKey('dropdown.all'))));

// Add invoiced / not invoiced selector.
$invoice_options = array('1'=>$i18n->getKey('form.reports.include_invoiced'),
  '2'=>$i18n->getKey('form.reports.include_not_invoiced'));
$form->addInput(array('type'=>'combobox',
  'class'=>'form-control',
  'name'=>'invoice',
  'data'=>$invoice_options,
  'empty'=>array(''=>$i18n->getKey('dropdown.all'))));

$user_list = array();
if ($user->canManageTeam() || $user->isClient()) {
  // Prepare user and assigned projects arrays.
  if ($user->canManageTeam())
    $users = ttTeamHelper::getUsers(); // Active and inactive users for managers.
  if($user->isAdmin()) {
    $users = ttTeamHelper::getUsersAdmin();
  }
  if($user->isManager()) {
    $users = ttTeamHelper::getActiveUsersManager($user->id, array('getAllFields'=>true));
  }
  elseif ($user->isClient())
    $users = ttTeamHelper::getUsersForClient(); // Active and inactive users for clients.

  foreach ($users as $single_user) {
    $user_list[$single_user['id']] = $single_user['name'];
    $projects = ttProjectHelper::getAssignedProjects($single_user['id']);
    if ($projects) {
      foreach ($projects as $single_project) {
        $assigned_projects[$single_user['id']][] = $single_project['id'];
      }
    }
  }
  $row_count = ceil(count($user_list)/3);
  $form->addInput(array('type'=>'checkboxgroup',
    'name'=>'users',
    'data'=>$user_list,
    'layout'=>'C',
    'groupin'=>$row_count));
}

// Add control for time period.
$form->addInput(array('type'=>'combobox',
  'class'=>'form-control',
  'name'=>'period',
  'onchange'=> 'handleTimePeriod()',
  'data'=>array(INTERVAL_THIS_MONTH=>$i18n->getKey('dropdown.this_month'),
    INTERVAL_LAST_MONTH=>$i18n->getKey('dropdown.last_month'),
    INTERVAL_THIS_WEEK=>$i18n->getKey('dropdown.this_week'),
    INTERVAL_LAST_WEEK=>$i18n->getKey('dropdown.last_week')),
  'empty'=>array(''=>$i18n->getKey('dropdown.select'))));
// Add controls for start and end dates.
$form->addInput(array('type'=>'datefield','maxlength'=>'20','name'=>'start_date', 'class'=>'form-control'));
$form->addInput(array('type'=>'datefield','maxlength'=>'20','name'=>'end_date', 'class'=>'form-control'));

// Add checkboxes for fields.
if ($user->isPluginEnabled('cl'))
  $form->addInput(array('type'=>'checkbox','name'=>'chclient','data'=>1));
if (($user->canManageTeam() || $user->isClient()) && $user->isPluginEnabled('iv'))
  $form->addInput(array('type'=>'checkbox','name'=>'chinvoice','data'=>1));
if (MODE_PROJECTS == $user->tracking_mode || MODE_PROJECTS_AND_TASKS == $user->tracking_mode)
  $form->addInput(array('type'=>'checkbox','name'=>'chproject','data'=>1));
if (MODE_PROJECTS_AND_TASKS == $user->tracking_mode)
  $form->addInput(array('type'=>'checkbox','name'=>'chtask','data'=>1));
if ((TYPE_START_FINISH == $user->record_type) || (TYPE_ALL == $user->record_type)) {
  $form->addInput(array('type'=>'checkbox','name'=>'chstart','data'=>1));
  $form->addInput(array('type'=>'checkbox','name'=>'chfinish','data'=>1));
}
$form->addInput(array('type'=>'checkbox','name'=>'chduration','data'=>1));
$form->addInput(array('type'=>'checkbox','name'=>'chnote','data'=>1));
if (defined('COST_ON_REPORTS') && isTrue(COST_ON_REPORTS))
  $form->addInput(array('type'=>'checkbox','name'=>'chcost','data'=>1));
// If we have a custom field - add a checkbox for it.
if ($custom_fields && $custom_fields->fields[0])
  $form->addInput(array('type'=>'checkbox','name'=>'chcf_1','data'=>1));

// Add group by control.
$group_by_options['no_grouping'] = $i18n->getKey('form.reports.group_by_no');
$group_by_options['date'] = $i18n->getKey('form.reports.group_by_date');
if ($user->canManageTeam() || $user->isClient())
  $group_by_options['user'] = $i18n->getKey('form.reports.group_by_user');
if ($user->isPluginEnabled('cl') && !($user->isClient() && $user->client_id))
  $group_by_options['client'] = $i18n->getKey('form.reports.group_by_client');
if (MODE_PROJECTS == $user->tracking_mode || MODE_PROJECTS_AND_TASKS == $user->tracking_mode)
  $group_by_options['project'] = $i18n->getKey('form.reports.group_by_project');
if (MODE_PROJECTS_AND_TASKS == $user->tracking_mode)
  $group_by_options['task'] = $i18n->getKey('form.reports.group_by_task');
  //$group_by_options['user_project'] = "user_project";
if ($custom_fields && $custom_fields->fields[0] && $custom_fields->fields[0]['type'] == CustomFields::TYPE_DROPDOWN) {
  $group_by_options['cf_1'] = $custom_fields->fields[0]['label'];
}
$form->addInput(array('type'=>'combobox','onchange'=>'handleCheckboxes();','name'=>'group_by','data'=>$group_by_options, 'class'=>'form-control'));
$form->addInput(array('type'=>'checkbox','name'=>'chtotalsonly','data'=>1));

// Add text field for a new favorite report name.
$form->addInput(array('type'=>'text','name'=>'new_fav_report','maxlength'=>'30','class'=>'form-control','placeholder'=>'Enter Favorite'));
// Save button.
$form->addInput(array('type'=>'submit', 'class'=>'btn btn-success', 'name'=>'btn_save','value'=>$i18n->getKey('button.save')));

$form->addInput(array('type'=>'submit', 'name'=>'btn_generate','value'=>$i18n->getKey('button.generate')));

// Create a bean (which is a mechanism to remember form values in session).
$bean = new ActionForm('reportBean', $form, $request);
// At this point form values are obtained from session if they are there.

if (($request->getMethod() == 'GET') && !$bean->isSaved()) {
  // No previous form data were found in session. Use the following default values.
  $form->setValueByElement('users', array_keys($user_list));
  $period = new Period(INTERVAL_THIS_MONTH, new DateAndTime($user->date_format));
  $form->setValueByElement('start_date', $period->getBeginDate());
  $form->setValueByElement('end_date', $period->getEndDate());
  $form->setValueByElement('chclient', 1);
  $form->setValueByElement('chinvoice', 0);
  $form->setValueByElement('chproject', 1);
  $form->setValueByElement('chstart', 1);  
  $form->setValueByElement('chduration', 1);
  $form->setValueByElement('chcost', 0);
  $form->setValueByElement('chtask', 1);
  $form->setValueByElement('chfinish', 1);
  $form->setValueByElement('chnote', 1);
  $form->setValueByElement('chcf_1', 0);
  $form->setValueByElement('chtotalsonly', 0);
}

$form->setValueByElement('fav_report_changed','');

// Disable the Delete button when no favorite report is selected.
if (!$bean->getAttribute('favorite_report') || ($bean->getAttribute('favorite_report') == -1))
  $form->getElement('btn_delete')->setEnable(false);

if ($request->isPost()) {
  if((!$bean->getAttribute('btn_generate') && ($request->getParameter('fav_report_changed')))) {
    // User changed favorite report. We need to load new values into the form.
    if ($bean->getAttribute('favorite_report')) {
      // This loads new favorite report options into the bean (into our form).
      ttFavReportHelper::loadReport($user->id, $bean);
      // If user selected no favorite report - mark all user checkboxes (most probable scenario).
      if ($bean->getAttribute('favorite_report') == -1)
        $form->setValueByElement('users', array_keys($user_list));

      // Save form data in session for future use.
      $bean->saveBean();
      header('Location: reports.php');
      exit();
    }
  } elseif ($bean->getAttribute('btn_save')) {
    // User clicked the Save button. We need to save form options as new favorite report.
    if (!ttValidString($bean->getAttribute('new_fav_report'))) $err->add($i18n->getKey('error.field'), $i18n->getKey('form.reports.save_as_favorite'));

    if ($err->no()) {
      $id = ttFavReportHelper::saveReport($user->id, $bean);
      if (!$id)
        $err->add($i18n->getKey('error.db'));
      if ($err->no()) {
        $bean->setAttribute('favorite_report', $id);
        $bean->saveBean();
        header('Location: reports.php');
        exit();
      }
    }
  } elseif($bean->getAttribute('btn_delete')) {
    // Delete button pressed. User wants to delete a favorite report.
    if ($bean->getAttribute('favorite_report')) {
      ttFavReportHelper::deleteReport($bean->getAttribute('favorite_report'));
      // Load default report.
      $bean->setAttribute('favorite_report','');
      $bean->setAttribute('new_fav_report', $report_list[0]['name']);
      ttFavReportHelper::loadReport($user->id, $bean);
      $form->setValueByElement('users', array_keys($user_list));
      $bean->saveBean();
      header('Location: reports.php');
      exit();
    }
  } else {
    // Generate button pressed. Check some values.
    if (!$bean->getAttribute('period')) {
      $start_date = new DateAndTime($user->date_format, $bean->getAttribute('start_date'));

      if ($start_date->isError() || !$bean->getAttribute('start_date'))
        $err->add($i18n->getKey('error.field'), $i18n->getKey('label.start_date'));

      $end_date = new DateAndTime($user->date_format, $bean->getAttribute('end_date'));
      if ($end_date->isError() || !$bean->getAttribute('end_date'))
        $err->add($i18n->getKey('error.field'), $i18n->getKey('label.end_date'));

      if ($start_date->compare($end_date) > 0)
        $err->add($i18n->getKey('error.interval'), $i18n->getKey('label.end_date'), $i18n->getKey('label.start_date'));
    }

    $bean->saveBean();

    if ($err->no()) {
      // Now we can go ahead and create a report.
      header('Location: report.php');
      exit();
    }
  }
} // isPost
$smarty->assign('client_list', $client_list);
$smarty->assign('manager_list', $manager_list);
$smarty->assign('project_list', $project_list);
$smarty->assign('task_list', $task_list);
$smarty->assign('assigned_projects', $assigned_projects);
$smarty->assign('forms', array($form->getName()=>$form->toArray()));
$smarty->assign('onload', 'onLoad="loadOnLoad()"');
$smarty->assign('title', $i18n->getKey('title.reports'));
$smarty->assign('content_page_name', 'reports.tpl');
$smarty->display('index.tpl');
