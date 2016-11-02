<div class="col-sm-8 col-sm-offset-2 text-center">
  {$forms.clientDeleteForm.open}
  <div class="row">
    <div class="col-sm-12">
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.form.client.client_to_delete}</label>
        <div class="col-sm-9">{$client_to_delete|escape:'html'}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.form.client.client_entries}</label>
        <div class="col-sm-9">{$forms.clientDeleteForm.delete_client_entries.control}</div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-9 col-sm-offset-2">{$forms.clientDeleteForm.btn_delete.control}&nbsp;{$forms.clientDeleteForm.btn_cancel.control}</div>
      </div>
    </div>
  </div>
  {$forms.clientDeleteForm.close}
</div>