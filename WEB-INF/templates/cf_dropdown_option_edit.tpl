<div class="col-sm-8 col-sm-offset-2 text-center">
  {$forms.optionEditForm.open}
  {if $user->canManageTeam()}
  <div class="row">
    <div class="col-sm-12">
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.thing_name} <span class="requiredField">*</span></label>
        <div class="col-sm-9">{$forms.optionEditForm.name.control}</div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-9 col-sm-offset-3">{$forms.optionEditForm.btn_save.control}</div>
      </div>
    </div>
  </div>
  {/if}
  {$forms.optionEditForm.close}
</div>