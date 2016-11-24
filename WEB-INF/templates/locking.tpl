<div class="col-sm-8 col-sm-offset-2 text-center">
  {$forms.lockingForm.open}
  <div class="row">
    <div class="col-sm-12">
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.cron_schedule}</label>
        <div class="col-sm-9">{$forms.lockingForm.lock_spec.control}</div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
      <div class="col-sm-12 text-center">{$forms.lockingForm.btn_save.control}</div>
        </div>
      </div>
    </div>
  </div>
  {$forms.lockingForm.close}
</div>