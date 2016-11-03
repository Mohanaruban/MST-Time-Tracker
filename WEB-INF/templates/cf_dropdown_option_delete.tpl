<div class="col-sm-8 col-sm-offset-2 text-center">
  {$forms.optionDeleteForm.open}
  {if $user->canManageTeam()}
  <div class="row">
      <div class="col-md-12">
          <p class="h3"> Are you sure to delete <i>{$option|escape:'html'}</i> option?</p><br/><br/>
      </div>
  </div>
  <div class="row">
        <div class="col-sm-12">{$forms.optionDeleteForm.btn_delete.control}&nbsp;{$forms.optionDeleteForm.btn_cancel.control}</div>
  </div>
  {/if}
  {$forms.optionDeleteForm.close}
</div>