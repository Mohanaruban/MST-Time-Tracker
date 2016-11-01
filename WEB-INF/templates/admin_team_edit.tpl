<div class="col-sm-6 col-sm-offset-3 text-center">
  {$forms.teamForm.open}
  <div class="row">
    <div class="col-sm-12">

      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.team_name}</label>
        <div class="col-sm-9">{$forms.teamForm.team_name.control}</div>
      </div>

      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.manager_name}*</label>
        <div class="col-sm-9">{$forms.teamForm.manager_name.control}</div>
      </div>

      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.manager_login}*</label>
        <div class="col-sm-9">{$forms.teamForm.manager_login.control}</div>
      </div>
{if !$auth_external}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.password}*</label>
        <div class="col-sm-9">{$forms.teamForm.password1.control}</div>
      </div>
     
     <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.confirm_password}*</label>
        <div class="col-sm-9">{$forms.teamForm.password2.control}</div>
      </div>
{/if}
        <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.email}</label>
        <div class="col-sm-9">{$forms.teamForm.manager_email.control}</div>
      </div>

    </div>
  </div>

  <div class="row">
    <div class="col-sm-12">

     <div class="form-group">
      <div class="col-md-12 text-center">
        {$forms.teamForm.btn_save.control}&nbsp;{$forms.teamForm.btn_cancel.control}
      </div>
    </div>
    
  </div>
</div>
{$forms.teamForm.close}
</div>


<!--

{$forms.teamForm.open}
<table cellspacing="4" cellpadding="7" border="0">
  <tr>
    <td>
      <table cellspacing="1" cellpadding="2" border="0">
        <tr>
          <td align="right" nowrap>{$i18n.label.team_name}:</td>
          <td>{$forms.teamForm.team_name.control}</td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
          <td align="right" nowrap>{$i18n.label.manager_name} (*):</td>
          <td>{$forms.teamForm.manager_name.control}</td>
        </tr>
        <tr>
          <td align="right" nowrap>{$i18n.label.manager_login} (*):</td>
          <td>{$forms.teamForm.manager_login.control}</td>
        </tr>
{if !$auth_external}
        <tr>
          <td align="right" nowrap>{$i18n.label.password} (*):</td>
          <td>{$forms.teamForm.password1.control}</td>
        </tr>
        <tr>
          <td align="right" nowrap>{$i18n.label.confirm_password} (*):</td>
          <td>{$forms.teamForm.password2.control}</td>
        </tr>
{/if}
        <tr>
          <td align="right" nowrap>{$i18n.label.email}:</td>
          <td>{$forms.teamForm.manager_email.control}</td>
        </tr>
        <tr>
          <td></td>
          <td>{$i18n.label.required_fields}</td>
        </tr>
        <tr><td colspan="2">&nbsp;</td></tr>
        <tr>
          <td colspan="2" height="50" align="center">{$forms.teamForm.btn_save.control}&nbsp;{$forms.teamForm.btn_cancel.control}</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
{$forms.teamForm.close}

-->