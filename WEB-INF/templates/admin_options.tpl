
<div class="col-sm-6 col-sm-offset-3 text-center">
  {$forms.optionsForm.open}
  <div class="row">
    <div class="col-sm-12">

      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.person_name}*</label>
        <div class="col-sm-9">{$forms.optionsForm.name.control}</div>
      </div>

      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.login}*</label>
        <div class="col-sm-9">{$forms.optionsForm.login.control}</div>
      </div>
{if !$auth_external}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.password}</label>
        <div class="col-sm-9">{$forms.optionsForm.password1.control}</div>
      </div>

      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.confirm_password}</label>
        <div class="col-sm-9">{$forms.optionsForm.password2.control}</div>
      </div>
      
   {/if}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.email}</label>
        <div class="col-sm-9">{$forms.optionsForm.email.control}</div>
      </div>
   

    </div>
  </div>

  <div class="row">
    <div class="col-sm-12">

     <div class="form-group">
      <div class="col-md-12 text-center">
        {$forms.optionsForm.btn_submit.control}
      </div>
    </div>
    
  </div>
</div>
{$forms.optionsForm.close}
</div>


<!--
{$forms.optionsForm.open}
<table cellspacing="4" cellpadding="7" border="0">
  <tr>
    <td>
      <table cellspacing="1" cellpadding="2" border="0">
        <tr>
          <td align="right" nowrap>{$i18n.label.person_name} (*):</td>
          <td>{$forms.optionsForm.name.control}</td>
        </tr>
        <tr>
          <td align="right" nowrap>{$i18n.label.login} (*):</td>
          <td>{$forms.optionsForm.login.control}</td>
        </tr>
{if !$auth_external}
        <tr>
          <td align="right">{$i18n.label.password}:</td>
          <td>{$forms.optionsForm.password1.control}</td>
        </tr>
        <tr>
          <td align="right">{$i18n.label.confirm_password}:</td>
          <td>{$forms.optionsForm.password2.control}</td>
        </tr>
{/if}
        <tr>
          <td align="right" nowrap>{$i18n.label.email}:</td>
          <td>{$forms.optionsForm.email.control}</td>
        </tr>
        <tr>
          <td></td>
          <td>{$i18n.label.required_fields}</td>
        </tr>
        <tr>
          <td colspan="2" align="center" height="50">{$forms.optionsForm.btn_submit.control}</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
{$forms.optionsForm.close}
-->