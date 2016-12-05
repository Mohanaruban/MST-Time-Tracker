<script>
// We need a few arrays to populate project dropdown.
// When client selection changes, the project dropdown must be re-populated with only relevant projects.
// Format:
// project_ids[143] = "325,370,390,400";  // Comma-separated list of project ids for client.
// project_names[325] = "Time Tracker";   // Project name.

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

// Mandatory top option for project dropdown.
empty_label_project = '{$i18n.dropdown.select|escape:'javascript'}';

// The fillProjectDropdown function populates the project combo box with
// projects associated with a selected client (client id is passed here as id).
function fillProjectDropdown(id) {
  var str_ids = project_ids[id];
  var dropdown = document.getElementById("project");
  // Determine previously selected item.
  var selected_item = dropdown.options[dropdown.selectedIndex].value;

  // Remove existing content.
  dropdown.length = 0;
  // Add mandatory top option.
  dropdown.options[0] = new Option(empty_label_project, '', true);

  // Populate project dropdown.
  if (!id) {
    // If we are here, client is not selected.
    var len = projects.length;
    for (var i = 0; i < len; i++) {
      dropdown.options[i+1] = new Option(projects[i][1], projects[i][0]);
      if (dropdown.options[i+1].value == selected_item)
        dropdown.options[i+1].selected = true;
    }
  } else if (str_ids) {
    var ids = new Array();
    ids = str_ids.split(",");
    var len = ids.length;

    for (var i = 0; i < len; i++) {
      var p_id = ids[i];
      dropdown.options[i+1] = new Option(project_names[p_id], p_id);
      if (dropdown.options[i+1].value == selected_item)
        dropdown.options[i+1].selected = true;
    }
  }
}

function get_date() {
  var date = new Date();
  return date.strftime("%Y-%m-%d");
}
</script>


<div class="col-sm-8 col-sm-offset-2 text-center">
{$forms.expensesForm.open}
  <div class="row">
    <div class="col-sm-6">
{if $on_behalf_control}
    <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.user}</label>
        <div class="col-sm-9">{$forms.expensesForm.onBehalfUser.control}</div>
    </div>
{/if}
{if $user->isPluginEnabled('cl')}
    <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.client}{if $user->isPluginEnabled('cm')} (*){/if}</label>
        <div class="col-sm-9">{$forms.expensesForm.client.control}</div>
    </div>
{/if}
{if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
    <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.project} (*)</label>
        <div class="col-sm-9">{$forms.expensesForm.project.control}</div>
    </div>
{/if}
    <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.item} (*)</label>
        <div class="col-sm-9">{$forms.expensesForm.item_name.control}</div>
    </div>

            <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.cost} (*)</label>
        <div class="col-sm-9">{$forms.expensesForm.cost.control}<span class="pull-right" style="margin-top: -30px;">{$user->currency|escape:'html'}</span></div>
    </div>

</div>
<div class="col-md-6">
      {$forms.expensesForm.date.control}
    </div>
</div>
  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
      <div class="col-sm-9 col-sm-offset-2">{$forms.expensesForm.btn_submit.control}</div>
      </div>
    </div>
  </div>




{if $expense_items}
      <table class="table table-responsive table-hover table-bordered">
      <thead>
      <tr>
  {if $user->isPluginEnabled('cl')}

        <th>{$i18n.label.client}</th>
  {/if}
  {if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
        <th>{$i18n.label.project}</th>
  {/if}
        <th>{$i18n.label.item}</th>
        <th>{$i18n.label.cost}</th>
        <th>{$i18n.label.edit}</th>
      </tr>
      </thead>
  {foreach $expense_items as $item}
      <tr>
    {if $user->isPluginEnabled('cl')}
        <td valign='top'>{$item.client|escape:'html'}</td>
    {/if}
    {if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
        <td valign='top'>{$item.project|escape:'html'}</td>
    {/if}
        <td valign='top'>{$item.item|escape:'html'}</td>
        <td valign='top' align='right'>{$item.cost}</td>
        <td valign='top' align='center'>{if $item.invoice_id}&nbsp;{else}<a href='expense_edit.php?id={$item.id}'>{$i18n.label.edit}</a>{/if}</td>
      </tr>
  {/foreach}
    </table>
    <table border="0" cellpadding="3" cellspacing="1" >
      <tr>
        <td nowrap align="right">{$i18n.label.day_total}: {$user->currency|escape:'html'} {$day_total}</td>
      </tr>
    </table>
{/if}

{$forms.expensesForm.close}
</div>
