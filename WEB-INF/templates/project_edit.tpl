<div class="col-sm-6 col-sm-offset-3 text-center">
  {$forms.projectForm.open}
  <div class="row">
    <div class="col-sm-12">

      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.thing_name}*</label>
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