<div class="col-sm-8 col-sm-offset-2 text-center">
  {$forms.clientForm.open}
  <div class="row">
    <div class="col-sm-12">
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.client_name} (*)</label>
        <div class="col-sm-9">{$forms.clientForm.name.control}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.client_address}</label>
        <div class="col-sm-9">{$forms.clientForm.address.control}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.tax}, %</label>
        <div class="col-sm-9">{$forms.clientForm.tax.control}&nbsp;(0{$user->decimal_mark}00)</div>
      </div>
      {if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.projects}</label>
        <div class="col-sm-9">{$forms.clientForm.projects.control}</div>
      </div>
      {/if}
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-9 col-sm-offset-3">{$forms.clientForm.btn_submit.control}</div>
      </div>
    </div>
  </div>
  {$forms.clientForm.close}
</div>