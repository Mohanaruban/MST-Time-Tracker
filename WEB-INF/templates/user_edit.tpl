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

</script>
<div class="col-sm-8 col-sm-offset-2 text-center">
  {$forms.userForm.open}
  <div class="row">
    <div class="col-sm-12">
      {if $user->isAdmin()}
      {$forms.userForm.manager_list.control}
      <!-- <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.manager_list}*</label>
        <div class="col-sm-9">{$forms.userForm.manager_list.control}</div>
      </div> -->

      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.person_name} <span class="requiredField">*</span></label>
        <div class="col-sm-9">{$forms.userForm.name.control}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.login} <span class="requiredField">*</span></label>
        <div class="col-sm-9">{$forms.userForm.login.control}</div>
      </div>
      {if !$auth_external}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.password} <span class="requiredField">*</span></label>
        <div class="col-sm-9">{$forms.userForm.pas1.control}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.confirm_password} <span class="requiredField">*</span></label>
        <div class="col-sm-9">{$forms.userForm.pas2.control}</div>
      </div>
      {/if}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.email} <span class="requiredField">*</span></label>
        <div class="col-sm-9">{$forms.userForm.email.control}</div>
      </div>
      {if ($user->isManager() && ($user->id != $user_id)) || ($user->isAdmin())}
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
      
     <!--  {if $user->canManageTeam() && !($user->isManager() && $user->id == $user_id)}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.status}</label>
        <div class="col-sm-9">{$forms.userForm.status.control}</div>
      </div>
      {/if}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.form.users.default_rate}&nbsp;(0{$user->decimal_mark}00)</label>
        <div class="col-sm-9">{$forms.userForm.rate.control}</div>
      </div>-->
      {/if}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.projects}</label>
        <div class="col-sm-9">{$forms.userForm.projects.control}</div>
      </div>
     <!--  {if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode || $user->isAdmin())}
      <div class="form-group">
      {if $user->isAdmin()}
        <label class="col-sm-3 control-label">{$i18n.label.projects}</label>
        <label class="col-sm-9 text-left" style="padding: 13px;">{implode("<br><br> ",array_column($projectList, 'name'))}</label>
        {/if} -->
      </div>
      {/if}
    </div>

    {if $user->isAdmin()}
    <div class="row">
      <div class="col-md-12">
        <div class="form-group">
          <div class="col-sm-9 col-sm-offset-3">{$forms.userForm.btn_submit.control} 
            <a class="btn btn-info" href="users.php">Back</a>
          </div>
        </div>
      </div>
    </div>
    {/if}
  </div>
  {$forms.userForm.close}
</div>
