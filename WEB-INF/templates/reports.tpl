<script>
// We need a couple of array-like objects, one for associated task ids, another for task names.
// For performance, and because associated arrays are frowned upon in JavaScript, we'll use a simple object
// with properties for project tasks. Format:

// obj_tasks.p325 = "100,101,302,303,304"; // Tasks ids for project 325 are "100,101,302,303,304".
// obj_tasks.p408 = "100,302";  // Tasks ids for project 408 are "100,302".

// Create an object for task ids.
obj_tasks = {};
var project_prefix = "p"; // Prefix for project property.
var project_property;

// Populate obj_tasks with task ids for each relevant project.
{foreach $project_list as $project}
project_property = project_prefix + {$project.id};
obj_tasks[project_property] = "{$project.tasks}";
{/foreach}

// Prepare an array of task names.
// Format: task_names[0] = Array(100, 'Coding'), task_names[1] = Array(302, 'Debugging'), etc...
// First element = task_id, second element = task name.
task_names = new Array();
var idx = 0;
{foreach $task_list as $task}
task_names[idx] = new Array({$task.id}, "{$task.name|escape:'javascript'}");
idx++;
{/foreach}


// empty_label is the mandatory top option in the tasks dropdown.
empty_label = '{$i18n.dropdown.all|escape:'javascript'}';

// inArray - determines whether needle is in haystack array.
function inArray(needle, haystack) {
  var length = haystack.length;
  for(var i = 0; i < length; i++) {
    if(haystack[i] == needle) return true;
  }
  return false;
}

// The fillTaskDropdown function populates the task combo box with
// tasks associated with a selected project_id.
function fillTaskDropdown(project_id) {
  var str_task_ids;
  // Get a string of comma-separated task ids.
  if (project_id) {  
    var property = "p" + project_id;
    str_task_ids = obj_tasks[property];
  }
  if (str_task_ids) {
    var task_ids = new Array(); // Array of task ids.
    task_ids = str_task_ids.split(",");
  }

  var dropdown = document.getElementById("task");
  // Determine previously selected item.
  var selected_item = dropdown.options[dropdown.selectedIndex].value;

  // Remove existing content.
  dropdown.length = 0;
  // Add mandatory top option.
  dropdown.options[0] = new Option(empty_label, '', true);

  // Populate the dropdown with associated tasks.
  len = task_names.length;
  var dropdown_idx = 0;
  for (var i = 0; i < len; i++) {
    if (!project_id) {
      // No project is selected. Fill in all tasks.
      dropdown.options[dropdown_idx+1] = new Option(task_names[i][1], task_names[i][0]);
      dropdown_idx++;
    } else if (str_task_ids) {
      // Project is selected and has associated tasks. Fill them in.
      if (inArray(task_names[i][0], task_ids)) {
        dropdown.options[dropdown_idx+1] = new Option(task_names[i][1], task_names[i][0]);
        dropdown_idx++;
      }
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

// Build JavaScript array for assigned projects out of passed in PHP array.
var assigned_projects = new Array();
{if $assigned_projects}
{foreach $assigned_projects as $user_id => $projects}
assigned_projects[{$user_id}] = new Array();
{if $projects}
{foreach $projects as $idx => $project_id}
assigned_projects[{$user_id}][{$idx}] = {$project_id};
{/foreach}
{/if}
{/foreach}
{/if}

// selectAssignedUsers is called when a project is changed in project dropdown.
// It selects users on the form who are assigned to this project.
function selectAssignedUsers(project_id) {
  var user_id;
  var len;

  for (var i = 0; i < document.reportForm.elements.length; i++) {
    if ((document.reportForm.elements[i].type == 'checkbox') && (document.reportForm.elements[i].name == 'users[]')) {
      user_id = document.reportForm.elements[i].value;
      if (project_id)
        document.reportForm.elements[i].checked = false;
      else
        document.reportForm.elements[i].checked = true;

      if(assigned_projects[user_id] != undefined)
        len = assigned_projects[user_id].length;
      else
        len = 0;

      if (project_id != '')
        for (var j = 0; j < len; j++) {
          if (project_id == assigned_projects[user_id][j]) {
            document.reportForm.elements[i].checked = true;
            break;
          }
        }
      }
    }
  }

// handleCheckboxes - unmarks and disables the "Totals only" checkbox when
// "no grouping" is selected in the associated dropdown.
// In future we need to improve this function and hide not relevant elements completely.
function handleCheckboxes() {
  var totalsOnlyCheckbox = document.getElementById("chtotalsonly");
  if ("no_grouping" == document.getElementById("group_by").value) {
    // Unmark and disable the "Totals only" checkbox.
    totalsOnlyCheckbox.checked = false;
    totalsOnlyCheckbox.disabled = true;
  } else
  totalsOnlyCheckbox.disabled = false;
}
</script>

<div class="col-sm-12 text-center">
  {$forms.reportForm.open}
  <div class="row">
    <div class="col-sm-12">
      <ul class="nav nav-tabs">
        <li class="active"><a href="#NewReport" class="btn btn-primary btn-lg" data-toggle="tab" aria-expanded="true">Generate fresh report</a></li>
        <li class=""><a href="#FavoriteReport" class="btn btn-primary btn-lg" data-toggle="tab" aria-expanded="false">Generate from favorite</a></li>
      </ul>
      <div id="myTabContent" class="tab-content">
        <div class="tab-pane fade active in" id="NewReport">
          <div class="panel panel-default">
            <div class="panel-body">
              <div class="col-md-12">

                {if (($user->isPluginEnabled('cl') && !($user->isClient() && $user->client_id)) || ($custom_fields && $custom_fields->fields[0] && $custom_fields->fields[0]['type'] == CustomFields::TYPE_DROPDOWN))}
                <div class="form-group">
                  <div class="col-sm-12">
                    <label class="col-sm-3 control-label">{if $user->isPluginEnabled('cl') && !($user->isClient() && $user->client_id)}{$i18n.label.client}{/if}
                    </label>
                    <div class="col-sm-8">
                      {$forms.reportForm.client.control}
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <div class="col-sm-12">
                    <label class="col-sm-3 control-label">{if ($custom_fields && $custom_fields->fields[0] && $custom_fields->fields[0]['type'] == CustomFields::TYPE_DROPDOWN)}{$i18n.label.option}{/if}
                    </label>
                    <div class="col-sm-8">
                      {$forms.reportForm.option.control}
                    </div>
                  </div>
                </div>
                {/if}

                {if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode || $user->isAdmin())}
                <div class="form-group">
                  <div class="col-sm-12">
                    <label class="col-sm-3 control-label">{$i18n.label.project}</label>
                    <div class="col-sm-8">
                      {$forms.reportForm.project.control}
                    </div>
                  </div>
                </div>
                {/if}

                {if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
                <div class="form-group">
                  <div class="col-sm-12">
                    <label class="col-sm-3 control-label">{if ($smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
                      {$i18n.label.task}
                      {/if}
                    </label>
                    <div class="col-sm-8">{if ($smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
                      {$forms.reportForm.task.control}
                      {/if}</div>
                    </div>
                  </div>
                  {/if}

                  {if $user->isPluginEnabled('iv')}
                  <div class="form-group">
                    <div class="col-md-12">
                      <label class="col-sm-3 control-label">{$i18n.form.time.billable}</label>
                      <div class="col-sm-8">{$forms.reportForm.include_records.control}</div>
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="col-md-12">
                      <label class="col-sm-3 control-label">{$i18n.label.invoice}</label>
                      <div class="col-sm-8">{$forms.reportForm.invoice.control}</div>
                    </div>
                  </div>
                  {/if}

                  {if $user->canManageTeam() || $user->isClient()}
                  <div class="form-group">
                    <div class="col-md-12">
                      <label class="col-sm-3 control-label">{$i18n.label.users}</label>
                      <div class="col-sm-8">{$forms.reportForm.users.control}</div>
                    </div>
                  </div>
                  {/if}

                  <div class="form-group">
                    <div class="col-md-12">
                      <label class="col-sm-3 control-label">{$i18n.form.reports.select_period}</label>
                      <div class="col-sm-8">
                        {$forms.reportForm.period.control}
                      </div>
                    </div>
                  </div>


                  <div class="form-group">
                    <div class="col-md-12">
                      <label class="col-sm-3 control-label">{$i18n.form.reports.set_period}</label>
                      <div class="col-sm-4">{$forms.reportForm.start_date.control}</div>
                      <div class="col-sm-4">{$forms.reportForm.end_date.control}</div>
                    </div>
                  </div>

                  <div class="form-group">
                    <div class="col-md-12">
                      <label class="col-sm-3 control-label">{$i18n.form.reports.show_fields}</label>
                      <div class="col-sm-8">
                        <table class="table">
                          {if $user->isPluginEnabled('cl') || $user->isPluginEnabled('iv')}
                          <tr align="left">
                            {if $user->isPluginEnabled('cl')}
                            <td width="25%"><label>{$forms.reportForm.chclient.control}&nbsp;{$i18n.label.client}</label></td>
                            {/if}
                            {if ($user->canManageTeam() || $user->isClient()) && $user->isPluginEnabled('iv')}
                            <td width="25%"><label>{$forms.reportForm.chinvoice.control}&nbsp;{$i18n.label.invoice}</label></td>
                            {/if}
                          </tr>
                          {/if}
                          <tr align="left">
                            <td width="25%">{if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}<label>{$forms.reportForm.chproject.control}&nbsp;{$i18n.label.project}</label>{/if}</td>
                            <td width="25%">{if (($smarty.const.TYPE_START_FINISH == $user->record_type) || ($smarty.const.TYPE_ALL == $user->record_type))}<label>{$forms.reportForm.chstart.control}&nbsp;{$i18n.label.start}</label>{/if}</td>
                            <td width="25%"><label>{$forms.reportForm.chduration.control}&nbsp;{$i18n.label.duration}</label></td>
                            <!-- {if ((($user->canManageTeam() || $user->isClient()) || $user->isPluginEnabled('ex')) && defined('COST_ON_REPORTS') && isTrue($smarty.const.COST_ON_REPORTS))}
                            <td width="25%"><label>{$forms.reportForm.chcost.control}&nbsp;{$i18n.label.cost}</label></td>
                            {else}
                            <td></td>
                            {/if} -->
                          </tr>
                          <tr align="left">
                            <td>{if ($smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}<label>{$forms.reportForm.chtask.control}&nbsp;{$i18n.label.task}</label>{/if}</td>
                            <td>{if (($smarty.const.TYPE_START_FINISH == $user->record_type) || ($smarty.const.TYPE_ALL == $user->record_type))}<label>{$forms.reportForm.chfinish.control}&nbsp;{$i18n.label.finish}</label>{/if}</td>
                            <td><label>{$forms.reportForm.chnote.control}&nbsp;{$i18n.label.note}</label></td>
                            {if ($custom_fields && $custom_fields->fields[0])}
                            <td><label>{$forms.reportForm.chcf_1.control}&nbsp;{$custom_fields->fields[0]['label']|escape:'html'}</label></td>
                            {else}
                            <td></td>
                            {/if}
                          </tr>
                        </table>
                      </div>
                    </div>
                  </div>

                  <div class="form-group">
                    <div class="col-md-12">
                      <label class="col-sm-3 control-label">{$i18n.form.reports.group_by}</label>
                      <div class="col-sm-8">
                        {$forms.reportForm.group_by.control}
                      </div>
                    </div>
                  </div>

                  <div class="form-group">
                    <div class="col-md-12">
                      <label class="col-sm-3 control-label"></label>
                      <div class="col-sm-8 text-left">
                        {$forms.reportForm.chtotalsonly.control} {$i18n.form.reports.totals_only}
                      </div>
                    </div>
                  </div>

                  <div class="form-group">
                    <div class="col-md-12">
                      <label class="col-sm-3 control-label">{$i18n.form.reports.save_as_favorite}</label>
                      <div class="col-sm-8">{$forms.reportForm.new_fav_report.control}
                        <span class="pull-down" style="margin-top: -30px; padding-left: 90%;">{$forms.reportForm.btn_save.control}</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="panel-footer">
                <div class="row">
                  <div class="col-md-12">
                    {$forms.reportForm.btn_generate.control}
                  </div>
                </div>
              </div>

            </div>
          </div>

          <div class="tab-pane fade" id="FavoriteReport">
            <div class="panel panel-default">
              <div class="panel-body">
                <div class="form-group">
                  <label class="col-sm-3 control-label">{$i18n.label.fav_report}</label>
                  <div class="col-sm-8">{$forms.reportForm.favorite_report.control}</div>
                </div>

                <div class="form-group">
                  <div class="col-sm-12 text-center">{$forms.reportForm.btn_generate.control}&nbsp;{$forms.reportForm.btn_delete.control}</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    {$forms.reportForm.close}
  </div>
