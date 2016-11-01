<div class="col-sm-6 col-sm-offset-3 text-center">
  {$forms.teamForm.open}
  <div class="row">
    <div class="col-sm-12">

      <div class="form-group">
        <div class="col-md-12 text-center">
          <p class="h3"> Are you sure to delete <i>{$team_to_delete|escape:'html'}</i> team?</p><br/><br/>
        </div>

        <div class="form-group">
          <div class="col-md-12 text-center">
            {$forms.teamForm.btn_delete.control}&nbsp; &nbsp;{$forms.teamForm.btn_cancel.control}
          </div>

        </div>
      </div>
      {$forms.teamForm.close}
    </div>
  </div>
</div>