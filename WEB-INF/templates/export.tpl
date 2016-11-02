<div class="col-sm-8 col-sm-offset-2 text-center">
{$forms.exportForm.open}
{if $user->isManager()}
  <div class="row">
    <div class="col-sm-12">
      <div class="form-group">
        <div class="col-sm-9 col-sm-offset-2"><h5>{$i18n.form.export.hint}</h5></div>
      </div>
      <div class="col-sm-12"></div>
      <div class="form-group">
      <label class="col-sm-3 control-label">{$i18n.form.export.compression}</label>
      <div class="col-sm-9">{$forms.exportForm.compression.control}<div>
      </div>

      </div>
      </div>
  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
      <div class="col-sm-9 col-sm-offset-3">{$forms.exportForm.btn_submit.control}</div>
      </div>
    </div>
  </div>

{/if}
{$forms.exportForm.close}
</div>