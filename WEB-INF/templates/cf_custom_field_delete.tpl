<div class="col-sm-8 col-sm-offset-2 text-center">
{$forms.fieldDeleteForm.open}
{if $user->canManageTeam()}
<div class="row">
    <div class="col-sm-12">
      <div class="col-md-12">
          <p class="h3"> Are you sure to delete custom field <i>{$field|escape:'html'}</i>?</p><br/><br/>
        </div>
    </div>

    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-12">{$forms.fieldDeleteForm.btn_delete.control}&nbsp;&nbsp;{$forms.fieldDeleteForm.btn_cancel.control}</div>
      </div>
    </div>
  </div>
{/if}
{$forms.fieldDeleteForm.close}