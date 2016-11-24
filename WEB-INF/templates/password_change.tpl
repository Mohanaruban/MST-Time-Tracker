<div class="col-md-12 text-center">
  {$forms.newPasswordForm.open}
  <div class="panel-login panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">Change New Password</h3>
    </div>
    <div class="panel-body">
      <div class="col-sm-12">
      {if $result_message}
      <table cellspacing="4" cellpadding="7" border="0" width="100%">
        <tr><td align="center"><font color="red"><b>{$result_message}</b></font></td></tr>
      </table>
      {else}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.password}*</label>
        <div class="col-sm-9">{$forms.newPasswordForm.password1.control}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.confirm_password}*</label>
        <div class="col-sm-9">{$forms.newPasswordForm.password2.control}</div>
      </div>
      {/if}
      </div>
    </div>
    <div class="row">
    <div class="col-sm-12">
      <div class="form-group">
        <div class="col-md-12 text-center">{$forms.newPasswordForm.btn_save.control}
        </div>
      </div>
    </div>
  </div>
  </div>
  {$forms.newPasswordForm.close}
</div>