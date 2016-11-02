<div class="col-sm-8 col-sm-offset-2 text-center">
  {$forms.projectForm.open}
  <div class="row">
    <div class="col-sm-12">

      <div class="form-group">
        <div class="col-md-12 text-center">
          <p class="h3"> Are you sure to delete <i>{$project_to_delete|escape:'html'}</i> project?</p><br/><br/>
        </div>

          <div class="form-group">
            <div class="col-md-12 text-center">
              {$forms.projectDeleteForm.btn_delete.control}&nbsp; &nbsp;{$forms.projectDeleteForm.btn_cancel.control}
            </div>

          </div>
        </div>
        {$forms.projectDeleteForm.close}
      </div>
    </div>
  </div>
</div>