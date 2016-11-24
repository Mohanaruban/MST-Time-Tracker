<div class="col-sm-8 col-sm-offset-2 text-center">
  {$forms.optionAddForm.open}
  {if $user->canManageTeam()}
  <div class="row">
    <div class="col-sm-12">
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.thing_name} (*)</label>
        <div class="col-sm-9">{$forms.optionAddForm.name.control}</div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-12 text-center">{$forms.optionAddForm.btn_add.control}</div>
      </div>
    </div>
  </div>
  {/if}
  {$forms.optionAddForm.close}
</div>