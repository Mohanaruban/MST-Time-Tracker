<div class="col-sm-8 col-sm-offset-2 text-center">
  {$forms.taskForm.open}
  <div class="row">
    <div class="col-sm-12">
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.thing_name} <span class="requiredField">*</span></label>
        <div class="col-sm-9">{$forms.taskForm.name.control}</div>
      </div>
    </div>
    <div class="col-sm-12">
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.description}</label>
        <div class="col-sm-9">{$forms.taskForm.description.control}</div>
      </div>
    </div>
    <div class="col-sm-12">
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.projects}</label>
        <div class="col-sm-9">{$forms.taskForm.projects.control}</div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-12 text-center">{$forms.taskForm.btn_submit.control}
          <a class="btn btn-info" href="tasks.php">Back</a> 
        </div>
      </div>
    </div>
  </div>
  {$forms.taskForm.close}
</div>
