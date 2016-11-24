<div class="col-sm-8 col-sm-offset-2 text-center">
  {$forms.taskDeleteForm.open}
  <div class="row">
      <div class="form-group">
        <div class="col-md-12 text-center">
          <p class="h3"> Are you sure to delete <i>{$task_to_delete|escape:'html'}</i> Task?</p><br/><br/>
        </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-12">{$forms.taskDeleteForm.btn_delete.control}&nbsp;&nbsp;{$forms.taskDeleteForm.btn_cancel.control}</div>
      </div>
    </div>
  </div>
  {$forms.taskDeleteForm.close}
</div>