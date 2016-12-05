<div class="col-sm-12 text-center">
  {$forms.projectDeleteForm.open}
  <div class="row">
    <div class="col-sm-12">

      <div class="form-group">
        <div class="col-md-12">
          <p class="h3"> Are you sure to delete project - <i>{$project_to_delete|escape:'html'}</i>?</p><br/><br/>
        </div>

          <div class="form-group">
            <div class="col-md-12">
              {$forms.projectDeleteForm.btn_delete.control}&nbsp; &nbsp;{$forms.projectDeleteForm.btn_cancel.control}
            </div>
          </div>
        </div>
        {$forms.projectDeleteForm.close}
      </div>
    </div>
  </div>
</div>