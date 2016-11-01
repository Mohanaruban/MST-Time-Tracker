<div class="col-sm-6 col-sm-offset-3 text-center">
  {$forms.projectForm.open}
  <div class="row">
    <div class="col-sm-12">

      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.thing_name}</label>
        <div class="col-sm-9">{$forms.projectForm.project_name.control}</div>
      </div>

      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.description}</label>
        <div class="col-sm-9">{$forms.projectForm.description.control}</div>
      </div>

      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.status}</label>
        <div class="col-sm-9">{$forms.projectForm.status.control}</div>
      </div>

      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.users}</label>
        <div class="col-sm-9">{$forms.projectForm.users.control}</div>
      </div>
      {if ($smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}

      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.tasks}</label>
        <div class="col-sm-9">{$forms.projectForm.tasks.control}</div>
      </div>
      {/if}

    </div>
  </div>

  <div class="row">
    <div class="col-sm-12">

     <div class="form-group">
      <div class="col-md-12 text-center">
        {$forms.projectForm.btn_save.control} {$forms.projectForm.btn_copy.control}
      </div>
    </div>
    
  </div>
</div>
{$forms.projectForm.close}
</div>
<!--
<table cellspacing="4" cellpadding="7" border="0">
  <tr>
    <td>
      <table cellspacing="1" cellpadding="2" border="0">
        <tr>
          <td align = "right">{$i18n.label.thing_name} (*):</td>
          <td>{$forms.projectForm.project_name.control}</td>
        </tr>
        <tr>
          <td align = "right">{$i18n.label.description}:</td>
          <td>{$forms.projectForm.description.control}</td>
        </tr>
        <tr>
          <td align="right">{$i18n.label.status}:</td>
          <td>{$forms.projectForm.status.control}</td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
          <td align="right">{$i18n.label.users}:</td>
          <td>{$forms.projectForm.users.control}</td>
        </tr>
{if ($smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
        <tr><td>&nbsp;</td></tr>
        <tr>
          <td align="right">{$i18n.label.tasks}:</td>
          <td>{$forms.projectForm.tasks.control}</td>
        </tr>
{/if}
        <tr>
          <td></td>
          <td>{$i18n.label.required_fields}</td>
        </tr>
        <tr>
          <td></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td colspan="2" align="center" height="50">{$forms.projectForm.btn_save.control} {$forms.projectForm.btn_copy.control}</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
{$forms.projectForm.close}

-->