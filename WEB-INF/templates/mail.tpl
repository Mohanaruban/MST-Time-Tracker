<div class="col-sm-12 text-center">
  {$forms.mailForm.open}
  <div class="row">
    <div class="col-sm-12">

      <div class="form-group">
        <div class="col-md-12">
          <label class="col-sm-3 control-label">{$i18n.form.mail.from} <span class="requiredField">*</span></label>
          <div class="col-sm-8 text-left">
            {$smarty.const.SENDER}
          </div>
        </div>
      </div>
      
      <div class="form-group">
        <div class="col-md-12">
          <label class="col-sm-3 control-label">{$i18n.form.mail.to} <span class="requiredField">*</span></label>
          <div class="col-sm-8">
            {$forms.mailForm.receiver.control}
          </div>
        </div>
      </div>
      
      <div class="form-group">
        <div class="col-md-12">
          <label class="col-sm-3 control-label">{$i18n.form.mail.cc}:</label>
          <div class="col-sm-8">
            {$forms.mailForm.cc.control}
          </div>
        </div>
      </div>
      
      <div class="form-group">
        <div class="col-md-12">
          <label class="col-sm-3 control-label">{$i18n.form.mail.subject} <span class="requiredField">*</span></label>
          <div class="col-sm-8">
            {$forms.mailForm.subject.control}
          </div>
        </div>
      </div>
      
      <div class="form-group">
        <div class="col-md-12">
          <label class="col-sm-3 control-label">{$i18n.label.comment}</label>
          <div class="col-sm-8">
            {$forms.mailForm.comment.control}
          </div>
        </div>
      </div>

      <div class="row">
        <div class="col-md-12">
          <div class="form-group">
            <div class="col-sm-8 col-sm-offset-3">{$forms.mailForm.btn_send.control}</div>
          </div>
        </div>
      </div>
      {$forms.mailForm.close}
    </div>
  </div>
</div>
