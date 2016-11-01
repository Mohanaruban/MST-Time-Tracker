
<div class="col-sm-8 col-sm-offset-2 text-center">
{$forms.userDeleteForm.open}
<div class="row">
    <div class="col-sm-12">
      <div class="form-group">
      <div class="col-sm-9 control-label">{$user_to_delete|escape:'html'}</div>
    
      </div>
    </div>
  </div>

    <div class="row">
    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-9">{$forms.userDeleteForm.btn_delete.control} {$forms.userDeleteForm.btn_cancel.control}</div>
      </div>
    </div>
  </div>
{$forms.userDeleteForm.close}
</div>