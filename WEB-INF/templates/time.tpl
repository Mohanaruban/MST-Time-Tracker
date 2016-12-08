<script>
// We need a few arrays to populate project and task dropdowns.
// When client selection changes, the project dropdown must be re-populated with only relevant projects.
// When project selection changes, the task dropdown must be repopulated similarly.
// Format:
// project_ids[143] = "325,370,390,400";  // Comma-separated list of project ids for client.
// project_names[325] = "Time Tracker";   // Project name.
// task_ids[325] = "100,101,302,303,304"; // Comma-separated list ot task ids for project.
// task_names[100] = "Coding";            // Task name.

// Prepare an array of project ids for clients.
project_ids = new Array();
{foreach $client_list as $client}
project_ids[{$client.id}] = "{$client.projects}";
{/foreach}
// Prepare an array of project names.
project_names = new Array();
{foreach $project_list as $project}
project_names[{$project.id}] = "{$project.name|escape:'javascript'}";
{/foreach}
// We'll use this array to populate project dropdown when client is not selected.
var idx = 0;
projects = new Array();
{foreach $project_list as $project}
projects[idx] = new Array("{$project.id}", "{$project.name|escape:'javascript'}");
idx++;
{/foreach}

// Prepare an array of task ids for projects.
task_ids = new Array();
{foreach $project_list as $project}
task_ids[{$project.id}] = "{$project.tasks}";
{/foreach}
// Prepare an array of task names.
task_names = new Array();
{foreach $task_list as $task}
task_names[{$task.id}] = "{$task.name|escape:'javascript'}";
{/foreach}

// Mandatory top options for project and task dropdowns.
empty_label_project = '{$i18n.dropdown.select|escape:'javascript'}';
empty_label_task = '{$i18n.dropdown.select|escape:'javascript'}';

// The fillDropdowns function populates the "project" and "task" dropdown controls
// with relevant values.
function fillDropdowns() {
  if(document.body.contains(document.timeRecordForm.client))
    fillProjectDropdown(document.timeRecordForm.client.value);

  fillTaskDropdown(document.timeRecordForm.project.value);
}

// The fillProjectDropdown function populates the project combo box with
// projects associated with a selected client (client id is passed here as id).
function fillProjectDropdown(id) {
  var str_ids = project_ids[id];
  var dropdown = document.getElementById("project");
  // Determine previously selected item.
  var selected_item = dropdown.options[dropdown.selectedIndex].value;

  // Remove existing content.
  dropdown.length = 0;
  var project_reset = true;
  // Add mandatory top option.
  dropdown.options[0] = new Option(empty_label_project, '', true);

  // Populate project dropdown.
  if (!id) {
    // If we are here, client is not selected.
    var len = projects.length;
    for (var i = 0; i < len; i++) {
      dropdown.options[i+1] = new Option(projects[i][1], projects[i][0]);
      if (dropdown.options[i+1].value == selected_item)  {
        dropdown.options[i+1].selected = true;
        project_reset = false;
      }
    }
  } else if (str_ids) {
    var ids = new Array();
    ids = str_ids.split(",");
    var len = ids.length;

    for (var i = 0; i < len; i++) {
      var p_id = ids[i];
      dropdown.options[i+1] = new Option(project_names[p_id], p_id);
      if (dropdown.options[i+1].value == selected_item)  {
        dropdown.options[i+1].selected = true;
        project_reset = false;
      }
    }
  }

  // If project selection was reset - clear the tasks dropdown.
  if (project_reset) {
    dropdown = document.getElementById("task");
    dropdown.length = 0;
    dropdown.options[0] = new Option(empty_label_task, '', true);
  }
}

// The fillTaskDropdown function populates the task combo box with
// tasks associated with a selected project (project id is passed here as id).
function fillTaskDropdown(id) {
  var str_ids = task_ids[id];

  var dropdown = document.getElementById("task");
  if (dropdown == null) return; // Nothing to do.

  // Determine previously selected item.
  var selected_item = dropdown.options[dropdown.selectedIndex].value;

  // Remove existing content.
  dropdown.length = 0;
  // Add mandatory top option.
  dropdown.options[0] = new Option(empty_label_task, '', true);

  // Populate the dropdown from the task_names array.
  if (str_ids) {
    var ids = new Array();
    ids = str_ids.split(",");
    var len = ids.length;

    var idx = 1;
    for (var i = 0; i < len; i++) {
      var t_id = ids[i];
      if (task_names[t_id]) {
        dropdown.options[idx] = new Option(task_names[t_id], t_id);
        idx++;
      }
    }

    // If a previously selected item is still in dropdown - select it.
    if (dropdown.options.length > 0) {
      for (var i = 0; i < dropdown.options.length; i++) {
        if (dropdown.options[i].value == selected_item)  {
          dropdown.options[i].selected = true;
        }
      }
    }
  }
}

// The formDisable function disables some fields depending on what we have in other fields.
function formDisable(formField) {
  formFieldValue = eval("document.timeRecordForm." + formField + ".value");
  formFieldName = eval("document.timeRecordForm." + formField + ".name");

  if (((formFieldValue != "") && (formFieldName == "start")) || ((formFieldValue != "") && (formFieldName == "finish"))) {
    var x = eval("document.timeRecordForm.duration");
    x.value = "";
    x.disabled = true;
    x.style.background = "#e9e9e9";
  }

  if (((formFieldValue == "") && (formFieldName == "start") && (document.timeRecordForm.finish.value == "")) || ((formFieldValue == "") && (formFieldName == "finish") && (document.timeRecordForm.start.value == ""))) {
    var x = eval("document.timeRecordForm.duration");
    x.value = "";
    x.disabled = false;
    x.style.background = "white";
  }

  if ((formFieldValue != "") && (formFieldName == "duration")) {
    var x = eval("document.timeRecordForm.start");
    x.value = "";
    x.disabled = true;
    x.style.background = "#e9e9e9";
    var x = eval("document.timeRecordForm.finish");
    x.value = "";
    x.disabled = true;
    x.style.background = "#e9e9e9";
  }

  if ((formFieldValue == "") && (formFieldName == "duration")) {
    var x = eval("document.timeRecordForm.start");
    x.disabled = false;
    x.style.background = "white";
    var x = eval("document.timeRecordForm.finish");
    x.disabled = false;
    x.style.background = "white";
  }
}

// The setNow function fills a given field with current time.
function setNow(formField) {
  var x = eval("document.timeRecordForm.start");
  x.disabled = false;
  x.style.background = "white";
  var x = eval("document.timeRecordForm.finish");
  x.disabled = false;
  x.style.background = "white";
  var today = new Date();
  var time_format = '{$user->time_format}';
  var obj = eval("document.timeRecordForm." + formField);
  obj.value = today.strftime(time_format);
  formDisable(formField);
}

function get_date() {
  var date = new Date();
  return date.strftime("%Y-%m-%d");
}

function get_time() {
  var date = new Date();
  return date.strftime("%H:%M");
}
</script>

<style>
  .not_billable td {
    color: #ff6666;
  }
  a {
    color: #1778bd;
    text-decoration: none
  }
  a:hover,
  a:focus {
    color: #2c3e50;
    text-decoration: underline
  }
</style>

<div class="col-sm-12 text-center">
  {$forms.timeRecordForm.open}
  <div class="row">
    <div class="col-md-7">

      {if $on_behalf_control}
      <div class="form-group">
        <label class="col-md-3 control-label">{$i18n.label.user}</label>
        <div class="col-md-9">{$forms.timeRecordForm.onBehalfUser.control}</div>
      </div>
      {/if}

      {if $user->isPluginEnabled('cl')}
      <div class="form-group">
        <label class="col-md-3 control-label">{$i18n.label.client}{if $user->isPluginEnabled('cm')} <span class="requiredField">*</span>{/if}</label>
        <div class="col-md-9">{$forms.timeRecordForm.client.control}</div>
      </div>
      {/if}

      {if $user->isPluginEnabled('iv')}
      <div class="form-group">
        <label class="col-md-3 control-label">&nbsp;</label>
        <div class="col-md-9 text-left">{$forms.timeRecordForm.billable.control}{$i18n.form.time.billable}</div>
      </div>
      {/if}

      {if ($custom_fields && $custom_fields->fields[0])}
      <div class="form-group">
        <label class="col-md-3 control-label">{$custom_fields->fields[0]['label']|escape:'html'}{if $custom_fields->fields[0]['required']} <span class="requiredField">*</span>{/if}</label>
        <div class="col-md-9">{$forms.timeRecordForm.cf_1.control}</div>
      </div>
      {/if}

      {if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
      <div class="form-group">
        <label class="col-md-3 control-label">{$i18n.label.project} <span class="requiredField">*</span></label>
        <div class="col-md-9">{$forms.timeRecordForm.project.control}</div>
      </div>
      {/if}

      {if ($smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
      <div class="form-group">
        <label class="col-md-3 control-label">{$i18n.label.task} <span class="requiredField">*</span></label>
        <div class="col-md-9">{$forms.timeRecordForm.task.control}</div>
      </div>
      {/if}

      {if (($smarty.const.TYPE_START_FINISH == $user->record_type) || ($smarty.const.TYPE_ALL == $user->record_type))}
      <div class="form-group">
        <label class="col-md-3 control-label">{$i18n.label.start}</label>
        <div class="col-md-9">{$forms.timeRecordForm.start.control}<span class="pull-down" style="float:right;"><input class="btn btn-primary btn-xs" onclick="setNow('start');" type="button" tabindex="-1" value="{$i18n.button.now}"></span></div>
      </div>
      <div class="form-group">
        <label class="col-md-3 control-label">{$i18n.label.finish}</label>
        <div class="col-md-9">{$forms.timeRecordForm.finish.control}<span class="pull-down" style="float:right;"><input class="btn btn-primary btn-xs" onclick="setNow('finish');" type="button" tabindex="-1" value="{$i18n.button.now}"></span></div>
      </div>
      {/if}
      {if (($smarty.const.TYPE_DURATION == $user->record_type) || ($smarty.const.TYPE_ALL == $user->record_type))}
      <div class="form-group">
        <label class="col-md-3 control-label">{$i18n.label.duration} <span class="requiredField">*</span></label>
        <div class="col-md-9">{$forms.timeRecordForm.duration.control}</div>
      </div>
      {/if}
      <div class="form-group">
        <label class="col-md-3 control-label">{$i18n.label.note}</label>
        <div class="col-md-9">{$forms.timeRecordForm.note.control}</div>
      </div>
    </div>

    <div class="col-md-5">
      {$forms.timeRecordForm.date.control}
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12 text-center">
      <div class="col-md-7">
        <div class="col-md-3"></div>
        <div class="col-md-9">
          {$forms.timeRecordForm.btn_submit.control}
        </div>
      </div>
    </div>
  </div>
  {$forms.timeRecordForm.close}
</div>

<div class="col-xs-12" style="height:30px;"></div>

<div class="col-sm-12">
  <div class="row">
    <div class="col-sm-12">
      {if $time_records}
      <table class="table table-responsive table-hover table-bordered">
        <thead>
          <tr>
            {if $user->isPluginEnabled('cl')}
            <th>{$i18n.label.client}</th>
            {/if}
            {if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
            <th>{$i18n.label.project}</th>
            {/if}
            {if ($smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
            <th>{$i18n.label.task}</th>
            {/if}
            {if (($smarty.const.TYPE_START_FINISH == $user->record_type) || ($smarty.const.TYPE_ALL == $user->record_type))}
            <th align='right'>{$i18n.label.start}</th>
            <th align='right'>{$i18n.label.finish}</th>
            {/if}
            <th>{$i18n.label.duration}</th>
            <th>{$i18n.label.note}</th>
            <th style="width: 100px">{$i18n.label.edit}</th>
          </tr>
        </thead>
        <tbody>
          {foreach $time_records as $record}
          <!-- <tr {if !$record.billable} class="not_billable" {/if}> -->
          <tr>
            {if $user->isPluginEnabled('cl')}
            <td valign='top'>{$record.client|escape:'html'}</td>
            {/if}
            {if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
            <td valign='top'>{$record.project|escape:'html'}</td>
            {/if}
            {if ($smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
            <td valign='top'>{$record.task|escape:'html'}</td>
            {/if}
            {if (($smarty.const.TYPE_START_FINISH == $user->record_type) || ($smarty.const.TYPE_ALL == $user->record_type))}
            <td nowrap align='right' valign='top'>{if $record.start}{$record.start}{else}&nbsp;{/if}</td>
            <td nowrap align='right' valign='top'>{if $record.finish}{$record.finish}{else}&nbsp;{/if}</td>
            {/if}
            <td valign='top'>{if ($record.duration == '0:00' && $record.start <> '')}<font color="#ff0000">{$i18n.form.time.uncompleted}</font>{else}{$record.duration}{/if}</td>
            <td valign='top'>{if $record.comment}{nl2br($record.comment|escape:'html')}{else}&nbsp;{/if}</td>
            <td valign='top' align='center'>
              {if $record.invoice_id}
              &nbsp;
              {else}
              <a class="btn btn-info btn-xs" href="time_edit.php?id={$record.id}">{$i18n.label.edit}</a>
              {if ($record.duration == '0:00' && $record.start <> '')}
              <input type='hidden' name='record_id' value='{$record.id}'>
              <input type='hidden' name='browser_date' value=''>
              <input type='hidden' name='browser_time' value=''>
              {/if}
              {/if}
            </td>
          </tr>
          {/foreach}
        </tbody>
      </table>
      {/if}
    </td>
  </tr>
</table>
{if $time_records}
<table class="table">
  <tr>
    <td align="left">{$i18n.label.week_total}: <strong>{$week_total}</strong></td>
    <td align="right">{$i18n.label.day_total}: <strong>{$day_total}</strong></td>
  </tr>
  {if $user->isPluginEnabled('mq')}
  <tr>
    <td align="left">{$i18n.label.month_total}: {$month_total}</td>
    {if $over_quota}
    <td align="right">{$i18n.form.time.over_quota}: <span style="color: green;">{$quota_remaining}</span></td>
    {else}
    <td align="right">{$i18n.form.time.remaining_quota}: <span style="color: red;">{$quota_remaining}</span></td>
    {/if}
  </tr>
  {/if}
</table>
{/if}
</div>
</div>
</div>