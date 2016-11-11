<div class="col-sm-8 col-sm-offset-2">
{$forms.fieldForm.open}
{if $user->canManageTeam()}
  <div class="row">
    <div class="col-sm-12">
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.thing_name} (*)</label>
        <div class="col-sm-9">{$forms.fieldForm.name.control}</div>
      </div>
    </div>
        <div class="col-sm-12">
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.type}</label>
        <div class="col-sm-9">{$forms.fieldForm.type.control}</div>
      </div>
    </div>
            <div class="col-sm-12">
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.required}</label>
        <div class="col-sm-9">{$forms.fieldForm.required.control}</div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-12 text-center">{$forms.fieldForm.btn_save.control}</div>
      </div>
    </div>
  </div>
{/if}
{$forms.fieldForm.close}
</div>