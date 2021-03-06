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
import('ttTimeHelper');

// Access check.
if (ttAccessCheck(right_data_entry)) {
  if(!$user->isAdmin() && !$user->isManager()) {
  header('Location: access_denied.php');
  exit();
}
}
// Get users.
$active_users = ttTeamHelper::getActiveUsers(array('getAllFields'=>true));
if($user->isAdmin()) {
	$active_users = "";
	$active_users = ttTeamHelper::getActiveUsersAdmin(array('getAllFields'=>true));
	$can_delete_manager = (1 == count($active_users));
  $inactive_users = ttTeamHelper::getInactiveUsersAdmin(true);

  
}
if($user->isManager()) {
   $active_users = "";
   //$active_users = ttTeamHelper::getActiveUsersManager($user->id, array('getAllFields'=>true));
   $active_users = ttTeamHelper::getActiveUsersManagerUserpage($user->id, array('getAllFields'=>true));
   //$active_users = ttTeamHelper::getActiveProjectView($user->id, array('getAllFields'=>true));
}

if($user->canManageTeam()) {
  $can_delete_manager = (1 == count($active_users));
  $inactive_users = ttTeamHelper::getInactiveUsers($user->team_id, true);
}

// Check if the team is set to show indicators for uncompleted time entries.
if (UNCOMPLETED_INDICATORS == $user->uncompleted_indicators) {
  // Check each active user if they have an uncompleted time entry.
  foreach ($active_users as $key => $user) {
    $active_users[$key]['has_uncompleted_entry'] = (bool) ttTimeHelper::getUncompleted($user['id']);
  }
}

$smarty->assign('active_users', $active_users);
$smarty->assign('inactive_users', $inactive_users);
$smarty->assign('can_delete_manager', $can_delete_manager);
$smarty->assign('title', $i18n->getKey('title.users'));
$smarty->assign('content_page_name', 'users.tpl');
$smarty->display('index.tpl');
