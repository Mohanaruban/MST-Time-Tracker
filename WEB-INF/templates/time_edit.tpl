<script>
// We need a few arrays to populate project and task dropdowns.
// When client selection changes, the project dropdown must be re-populated with only relevant projects.
// When project selection changes, the task dropdown must be repopulated similarly.
// Format:
// project_ids[143] = "325,370,390,400";  // Comma-separated list of project ids for client.
// project_names[325] = "Time Tracker";   // Project name.
// task_ids[325] = "100,101,302,303,304"; // Comma-separated list ot task ids for project.
// task_names[100] = "Coding";            // Task name.

//Prepare an array of projects ids for clients.
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
// projects associated with a selected clientt (client id is passed here as id).
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
  var formFieldValue = eval("document.timeRecordForm." + formField + ".value");
  var formFieldName = eval("document.timeRecordForm." + formField + ".name");

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
</script>


<div class="col-sm-8 col-sm-offset-2 text-center">
  {$forms.timeRecordForm.open}
  <div class="row">
    <div class="col-md-12">

      {if $user->isPluginEnabled('cl')}
      <div class="form-group">
        <label class="col-sm-2 control-label">{$i18n.label.client}{if $user->isPluginEnabled('cm')} <span class="requiredField">*</span>{/if}</label>
        <div class="col-sm-10">{$forms.timeRecordForm.client.control}</div>
      </div>
      {/if}

      {if $user->isPluginEnabled('iv')}
      <div class="form-group">
        <label class="col-sm-2 control-label">&nbsp;</label>
        <div class="col-sm-10 text-left">{$forms.timeRecordForm.billable.control}{$i18n.form.time.billable}</div>
      </div>
      {/if}

      {if ($custom_fields && $custom_fields->fields[0])} 
      <div class="form-group">
        <label class="col-sm-2 control-label">{$custom_fields->fields[0]['label']|escape:'html'}{if $custom_fields->fields[0]['required']} <span class="requiredField">*</span>{/if}</label>
        <div class="col-sm-10">{$forms.timeRecordForm.cf_1.control}</div>
      </div>
      {/if}

      {if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
      <div class="form-group">
        <label class="col-sm-2 control-label">{$i18n.label.project} <span class="requiredField">*</span></label>
        <div class="col-sm-10">{$forms.timeRecordForm.project.control}</div>
      </div>
      {/if}

      {if ($smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
      <div class="form-group">
        <label class="col-sm-2 control-label">{$i18n.label.task} <span class="requiredField">*</span></label>
        <div class="col-sm-10">{$forms.timeRecordForm.task.control}</div>
      </div>
      {/if}

      {if (($smarty.const.TYPE_START_FINISH == $user->record_type) || ($smarty.const.TYPE_ALL == $user->record_type))}
      <div class="form-group">
        <label class="col-sm-2 control-label">{$i18n.label.start}</label>
        <div class="col-sm-10">{$forms.timeRecordForm.start.control}&nbsp;<span class="pull-down" style="margin-top: -30px;padding-left: 90%;"><input onclick="setNow('start');" type="button" tabindex="-1" value="{$i18n.button.now}" class="btn btn-primary btn-xs"></span></div>
      </div>
      <div class="form-group">
        <label class="col-sm-2 control-label">{$i18n.label.finish}</label>
        <div class="col-sm-10">{$forms.timeRecordForm.finish.control}&nbsp;<span class="pull-down" style="margin-top: -30px;padding-left: 90%;"><input onclick="setNow('finish');" type="button" tabindex="-1" value="{$i18n.button.now}" class="btn btn-primary btn-xs"></span></div>
      </div>
      {/if}

      {if (($smarty.const.TYPE_DURATION == $user->record_type) || ($smarty.const.TYPE_ALL == $user->record_type))}
      <div class="form-group">
        <label class="col-sm-2 control-label">{$i18n.label.duration} <span class="requiredField">*</span></label>
        <div class="col-sm-10">{$forms.timeRecordForm.duration.control}</div>
      </div>
      {/if}
      
      <div class="form-group">
        <label class="col-sm-2 control-label">{$i18n.label.date} <span class="requiredField">*</span></label>
        <div class="col-sm-10">{$forms.timeRecordForm.date.control}</div>
      </div>

      <div class="form-group">
        <label class="col-sm-2 control-label">{$i18n.label.note}</label>
        <div class="col-sm-10">{$forms.timeRecordForm.note.control}</div>
      </div>    
    </div>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-9 col-sm-offset-3">{$forms.timeRecordForm.btn_save.control} {$forms.timeRecordForm.btn_copy.control} {$forms.timeRecordForm.btn_delete.control}
        <a class="btn btn-info" href="time.php">Back</a>
        </div>
      </div>
    </div>
  </div>
  {$forms.timeRecordForm.close}
</div>