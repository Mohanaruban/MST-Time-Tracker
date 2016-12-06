<div class="col-sm-8 col-sm-offset-2 text-center">
  {$forms.notificationForm.open}
  <div class="row">
    <div class="col-sm-12">
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.fav_report} <span class="requiredField">*</span></label>
        <div class="col-sm-9">{$forms.notificationForm.fav_report.control}</div>
      </div>
    </div>
    <div class="col-sm-12">
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.cron_schedule} <span class="requiredField">*</span></label>
        <div class="col-sm-9">{$forms.notificationForm.cron_spec.control}</div>
      </div>
    </div>
    <div class="col-sm-12">
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.email} <span class="requiredField">*</span></label>
        <div class="col-sm-9">{$forms.notificationForm.email.control}</div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-12 text-center">{$forms.notificationForm.btn_submit.control}</div>
      </div>
    </div>
    </div>
  {$forms.notificationForm.close}
</div>