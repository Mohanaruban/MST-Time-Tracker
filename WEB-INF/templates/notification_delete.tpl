<div class="col-sm-8 col-sm-offset-2 text-center">
{$forms.notificationDeleteForm.open}
  <div class="row">
    <div class="col-sm-12">
      <div class="form-group">
        <div class="col-md-12 control-label">
          <p class="h3"> Are you sure to delete notification <i>{$notification_to_delete|escape:'html'}</i>?</p><br/><br/>
        </div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-12">{$forms.notificationDeleteForm.btn_delete.control}&nbsp;&nbsp;{$forms.notificationDeleteForm.btn_cancel.control}</div>
      </div>
    </div>
  </div>
{$forms.notificationDeleteForm.close}
</div>