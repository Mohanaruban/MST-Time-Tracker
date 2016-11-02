<script>
// Prepare an array of rates.
// Format: project_rates[0] = Array(100, '25.00'), project_rates[1] = Array(120, '30.00'), etc...
// First element = project_id, second element = rate for project. Quotes needed for string representation of rates.
project_rates = new Array();
var idx = 0;
{foreach $rates as $rate}
project_rates[idx] = new Array({$rate.id}, '{$rate.rate}');
idx++;
{/foreach}

// getRate - returns a rate for the project. If rate was set for user previously we'll get this old rate
// if project time entries for user exists. Otherwise return user default rate.
function getRate(project_id) {
  var length = project_rates.length;
  for(var i = 0; i < length; i++) {
    if(project_rates[i][0] == project_id) {
      return project_rates[i][1];
    }
  }
  var default_rate = document.userForm.rate.value;
  return default_rate;
}

// The setRate function sets / unsets user rate for a project when a corresponding checkbox is ticked.
function setRate(element) {
  var default_rate = document.userForm.rate.value;
  if (default_rate == '') {
    // No default rate, nothing to do!
    return;
  }
  // Iterate through elements of the form to find and set the project rate. 
  for (var i = 0; i < userForm.elements.length; i++) {
    if ((userForm.elements[i].type == 'text') && (userForm.elements[i].name == ('rate_'+element.value))) {
      if (element.checked) {
        userForm.elements[i].value = getRate(element.value);
      } else {
        userForm.elements[i].value = '';
      }
      break; // Element is found and set, nothing more to do, break out of the loop.
    }
  }
}

// handleClientControl - controls visibility of the client dropdown depending on the selected user role.
// We need to show it only when the "Client" user role is selected.
function handleClientControl() {
  var clientControl = document.getElementById("client");
  if ("16" == document.getElementById("role").value)
    clientControl.style.visibility = "visible";
  else
    clientControl.style.visibility = "hidden";
}

window.onload = function() {
  handleClientControl();
  var tableInputElement = document.getElementById('projectTable').getElementsByTagName('input');
  for(var i = 1; i < tableInputElement.length; i++) {
    if(tableInputElement[i].type.toLowerCase() == 'text') {
      tableInputElement[i].className = 'form-control';
    }
  }
}
</script>
<div class="col-sm-8 col-sm-offset-2 text-center">
  {$forms.userForm.open}
  <div class="row">
    <div class="col-sm-12">
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.person_name} (*)</label>
        <div class="col-sm-9">{$forms.userForm.name.control}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.login} (*)</label>
        <div class="col-sm-9">{$forms.userForm.login.control}</div>
      </div>
      {if !$auth_external}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.password} (*)</label>
        <div class="col-sm-9">{$forms.userForm.pas1.control}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.confirm_password} (*)</label>
        <div class="col-sm-9">{$forms.userForm.pas2.control}</div>
      </div>
      {/if}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.email}</label>
        <div class="col-sm-9">{$forms.userForm.email.control}</div>
      </div>
      {if $user->isManager() && ($user->id != $user_id)}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.form.users.role}</label>
        <div class="col-sm-9">{$forms.userForm.role.control} {$forms.userForm.client.control}</div>
      </div>
      {/if}
      {* Prohibit deactivating team manager. Deactivating others is ok. *}
      {if $user->canManageTeam() && !($user->isManager() && $user->id == $user_id)}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.status}</label>
        <div class="col-sm-9">{$forms.userForm.status.control}</div>
      </div>
      {/if}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.form.users.default_rate}&nbsp;(0{$user->decimal_mark}00)</label>
        <div class="col-sm-9">{$forms.userForm.rate.control}</div>
      </div>
      {if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.projects}</label>
        <div class="col-sm-9">{$forms.userForm.projects.control}</div>
      </div>
      {/if}
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="form-group">
          <div class="col-sm-9 col-sm-offset-3">{$forms.userForm.btn_submit.control}</div>
        </div>
      </div>
    </div>
  </div>
  {$forms.userForm.close}
</div>
