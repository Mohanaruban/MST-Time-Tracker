<script>
// The setDefaultRate function sets / unsets default rate for a project
// when a corresponding checkbox is ticked.
function setDefaultRate(element) {
  // var default_rate = document.userForm.rate.value;
  // if (default_rate == '') {
  //   // No default rate, nothing to do!
  //   return;
  // }
  // // Iterate through elements of the form to find and set the project rate. 
  // for (var i = 0; i < userForm.elements.length; i++) {
  //   if ((userForm.elements[i].type == 'text') && (userForm.elements[i].name == ('rate_'+element.value))) {
  //     if (element.checked) {
  //       userForm.elements[i].value = default_rate;
  //     } else {
  //       userForm.elements[i].value = '';
  //     }
  //     break; // Element is found and set, nothing more to do, break out of the loop.
  //   }
  // }
}

// handleClientControl - controls visibility of the client dropdown depending on the selected user role.
// We need to show it only when the "Client" user role is selected.
function handleClientControl() {
  var clientControl = document.getElementById("client");
  // if ("16" == document.getElementById("role").value)
  //   clientControl.style.visibility = "visible";
  // else
  //   clientControl.style.visibility = "hidden";
}

</script>

<div class="col-md-12 text-center">
{$forms.userForm.open}

<div class="row">
    <div class="col-sm-12">
      {if $user->isAdmin()}
      {$forms.userForm.manager_list.control}
      {/if}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.person_name} (*)</label>
        <div class="col-sm-7">{$forms.userForm.name.control}</div>
        <div class="clo-sm-2"></div>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.login} (*)</label>
        <div class="col-sm-7">{$forms.userForm.login.control}</div>
        <div class="clo-sm-2"></div>
      </div>
{if !$auth_external}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.password} (*)</label>
        <div class="col-sm-7">{$forms.userForm.pas1.control}</div>
        <div class="clo-sm-2"></div>
      </div>
          <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.confirm_password} (*)</label>
        <div class="col-sm-7">{$forms.userForm.pas2.control}</div>
        <div class="clo-sm-2"></div>
      </div>
{/if}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.email}</label>
        <div class="col-sm-7">{$forms.userForm.email.control}</div>
        <div class="clo-sm-2"></div>
      </div>
{if $user->isAdmin()}

      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.form.users.role}</label>
        <div class="col-sm-7">{$forms.userForm.role.control} {$forms.userForm.client.control}</div>
        <div class="clo-sm-2"></div>
      </div>
{/if}
<!--       <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.form.users.default_rate}&nbsp;(0{$user->decimal_mark}00)</label>
        <div class="col-sm-9">{$forms.userForm.rate.control}</div>
      </div> -->
{if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}

      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.projects}</label>
        <div class="col-sm-5">{$forms.userForm.projects.control}</div>
        <div class="col-sm-4"></div>
      </div>
{/if}

  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
      <div class="col-sm-12">{$forms.userForm.btn_submit.control}</div>
      </div>
    </div>
  </div>

{$forms.userForm.close}
</div>
</div>
</div>
