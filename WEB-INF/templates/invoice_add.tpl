<div class="col-sm-8 col-sm-offset-2 text-center">
  {$forms.invoiceForm.open}
  <div class="row">
    <div class="col-sm-12">
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.form.invoice.number} (*)</label>
        <div class="col-sm-9">{$forms.invoiceForm.number.control}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.date} (*)</label>
        <div class="col-sm-9">{$forms.invoiceForm.date.control}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.client} (*)</label>
        <div class="col-sm-9">{$forms.invoiceForm.client.control}</div>
      </div>
      {if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.project}</label>
        <div class="col-sm-9">{$forms.invoiceForm.project.control}</div>
      </div>
      {/if}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.start_date} (*)</label>
        <div class="col-sm-9">{$forms.invoiceForm.start.control}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.end_date} (*)</label>
        <div class="col-sm-9">{$forms.invoiceForm.finish.control}</div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-9 col-sm-offset-3">{$forms.invoiceForm.btn_submit.control}</div>
      </div>
    </div>
  </div>
  {$forms.invoiceForm.close}
</div>
<script>
// Set the date field to browser today in user date format.
var dateField = document.getElementById("date");
if (dateField && !dateField.value) {
  var today = new Date();
  dateField.value = today.strftime("{$user->date_format}");
}
</script>
