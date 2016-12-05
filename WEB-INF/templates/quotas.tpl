<div class="col-sm-12 text-center">
  <div class="form-group">
    <div class="col-sm-12"><h5>{$i18n.form.quota.hint}</h5></div>
  </div>
</div>
<div class="col-sm-8 col-sm-offset-2">
  {$forms.monthlyQuotasForm.open}
  <div class="row">
    <div class="col-sm-12">
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.form.quota.workday_hours}</label>
        <div class="col-sm-8">{$forms.monthlyQuotasForm.workdayHours.control}</div><div class="col-sm-1"><input type="submit" class="btn btn-success" name="btn_hours" value="{$i18n.button.save}"></div>
      </div>
    </div>
    <div class="col-sm-12">
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.form.quota.year}</label>
        <div class="col-sm-9">{$forms.monthlyQuotasForm.year.control}</div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12">
      <div class="form-group">

        <table class="table table-responsive table-bordered">
          <thead>
            <tr>
              <th>{$i18n.form.quota.month}</th>
              <th>{$i18n.form.quota.quota}</th>
            </tr>
          </thead>
          {foreach $months as $month}
          <tr>
            <th>{$month}</th>
            <td>{$forms.monthlyQuotasForm.$month.control}</td>
          </tr>
          {/foreach}
        </table>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-12 text-center"><input type="submit" name="btn_submit" class="btn btn-success" value="{$i18n.button.save}"></div>
      </div>
    </div>
  </div>
  {$forms.monthlyQuotasForm.close}
</div>
<script>
  function yearChange(value){
    var url = window.location.href;

    if (url.indexOf('?') > 0){
      var parameter = url.substring(url.indexOf('?') + 1, url.length);
      url = url.replace(parameter, 'year=' + value);
    } else {
      url = '?year=' + value;
    }
    window.location = url;
  }
</script>
