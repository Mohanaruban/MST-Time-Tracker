<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="content-type" content="text/html; charset={$smarty.const.CHARSET}">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="favicon.ico" type="image/x-icon">
  <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
  <link href="{$smarty.const.DEFAULT_CSS}" rel="stylesheet" type="text/css">
  <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
  <link href="css/footer.css" rel="stylesheet" type="text/css">
  <link href="css/custom.css" rel="stylesheet" type="text/css">
  {if $i18n.language.rtl}
  <link href="{$smarty.const.RTL_CSS}" rel="stylesheet" type="text/css">
  {/if}
  <title>MST Time Tracker{if $title} - {$title}{/if}</title>
  <script src="js/strftime.js"></script>
  <script
  src="https://code.jquery.com/jquery-3.0.0.min.js"
  integrity="sha256-JmvOoLtYsmqlsWxa7mDSLMwa6dZ9rrIdtrrVYRnDRH0="
  crossorigin="anonymous"></script>
  
  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt-1.10.13/datatables.min.css"/>
  <script>
    {* Setup locale for strftime *}
    {$js_date_locale}
  </script>
  <script src="js/strptime.js"></script>
</head>

<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0" {$onload}>

  {assign var="tab_width" value="700"}
  <div class="wrapper">
    <nav class="navbar navbar-default">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="http://www.mstsolutions.com/" target="_blank"><img src="./images/mst-logo.png" alt="MST Solutions" style="width: 144px;
            "><span style="font-size: 15px; float: right; padding-top: 2px; color: white;">Time Tracker</span></a>
          </div>

          <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            {if $authenticated}
            <ul class="nav navbar-nav">
              {if $user->isAdmin()}
              {if $user->isPluginEnabled('ex') && !$user->isClient()}
              <li {if $title=="Expenses"}class="active"{/if}><a class="mainMenu" href="expenses.php">{$i18n.menu.expenses}</a></li>
              {/if}
              <li {if $title=="Reports"}class="active"{/if}><a class="mainMenu" href="reports.php">{$i18n.menu.reports}</a></li>

              <li {if $title=="Projects"}class="active"{/if}><a class="mainMenu" href="projects.php">{$i18n.menu.projects}</a></li>

              {if ($user->canManageTeam() || $user->isClient()) && $user->isPluginEnabled('iv')}
              <li {if $title=="Invoice"}class="active"{/if}><a class="mainMenu" href="invoices.php">{$i18n.title.invoices}</a></li>
              {/if}

              {if $user->canManageTeam() && ($smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
              <li {if $title=="Tasks"}class="active"{/if}><a class="mainMenu" href="tasks.php">{$i18n.menu.tasks}</a></li>
              {/if}

              <li {if $title=="Users"}class="active"{/if}><a class="mainMenu" href="users.php">{$i18n.menu.users}</a></li>

              {if $user->canManageTeam() && $user->isPluginEnabled('cl')}
              <li {if $title=="Clients"}class="active"{/if}><a class="mainMenu" href="clients.php">{$i18n.menu.clients}</a></li>
              {/if}

              {else}
              <li {if $title=="Time"}class="active"{/if}>
                <a class="mainMenu" href="time.php">{$i18n.menu.time}</a>
              </li>

              <li {if $title=="Reports"}class="active"{/if}><a class="mainMenu" href="reports.php">{$i18n.menu.reports}</a></li>

              {if !$user->isClient() && ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
              <li {if $title=="Projects"}class="active"{/if}><a class="mainMenu" href="projects.php">{$i18n.menu.projects}</a></li>
              {/if}

              {if $user->isClient() || $user->isAdmin() || $user->isManager()}
              <li {if $title=="Users"}class="active"{/if}><a class="mainMenu" href="users.php">{$i18n.menu.users}</a></li>
              {/if}

              {/if}
            </ul>
            {/if}

            <ul class="nav navbar-nav navbar-right">
              <li class="dropdown">
                {if $authenticated}
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Logged in as {$user->name|escape:'html'}{if $user->isAdmin()} {$i18n.label.role_admin}{elseif $user->isManager()} {$i18n.label.role_manager}{elseif $user->canManageTeam()} {$i18n.label.role_comanager}{/if}
                  <span class="caret"></span></a>
                  <ul class="dropdown-menu" role="menu">
                    {if $user->isAdmin()}
                    <li><a href="profile_edit.php">Edit Profile</a></li>
                    {else}
                    <li><a href="profile_edit.php">Edit Profile</a></li>
                    <li class="divider visible-md visible-lg visible-sm"></li>
                    {/if}
                    <li><a href="logout.php">{$i18n.menu.logout}</a></li>
                  </ul>
                  {else}
                  {/if}
                </li>
              </ul>
            </div>
          </div>
        </nav>

        {if $authenticated}
        {if $title}
        <div class="breadcrumb">
          <h5>
            {if $user->isAdmin()}<span class="text-muted">Administrator / </span>{/if}
            {if $user->isManager()}<span class="text-muted">Manager / </span>{/if}
            {if !$user->isAdmin() && !$user->isManager()}
            <span class="text-muted">User / </span>
            {/if}

            <span class="text-primary">{$title}</span>    
          </h5>
        </div>
        {/if}
        {/if}
        <div class="container">
          <div class="row">
            <!-- output errors -->
            {if $err->yes()}
            <div class="col-md-12 text-center">
              <div class="alert alert-dismissible alert-danger">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>Oops!</strong> Fix these error(s)<br/>
                {foreach $err->getErrors() as $error}
                {$error.message}<br>
                {/foreach}
              </div>
            </div>
            {/if}
            <!-- end of output errors -->

            <!-- output messages -->
            {if $msg->yes()}
            <div class="col-md-12 text-center">
              <div class="alert alert-dismissible alert-info">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>Heads Up!</strong><br/>
                {foreach $msg->getErrors() as $message}
                {$message.message}<br> {* No need to escape. *}
                {/foreach}
              </div>
            </div>
            {/if}
            <!-- end of output messages -->
          </div>

          <div class="row">