<div class="col-sm-8 col-sm-offset-2 text-center">
{$forms.invoiceDeleteForm.open}
  <div class="row">
    <div class="col-sm-12">
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.form.invoice.invoice_to_delete}</label>
        <label class="col-sm-9 text-left">{$invoice_to_delete|escape:'html'}</label>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.form.invoice.invoice_entries}</label>
        <div class="col-sm-9">{$forms.invoiceDeleteForm.delete_invoice_entries.control}</div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
      <div class="col-sm-12">{$forms.invoiceDeleteForm.btn_delete.control}&nbsp;{$forms.invoiceDeleteForm.btn_cancel.control}</div>
      </div>
    </div>
  </div>
{$forms.invoiceDeleteForm.close}
</div>