<script>
// handleControls - controls visibility of controls.
function handlePluginCheckboxes() {
  var clientsCheckbox = document.getElementById("clients");
  var invoicesCheckbox = document.getElementById("invoices");
  var requiredCheckbox = document.getElementById("client_required");
  var requiredLabel = document.getElementById("required_label");
  if (clientsCheckbox.checked) {
    requiredCheckbox.style.visibility = "visible";
    requiredLabel.style.visibility = "visible";
    invoicesCheckbox.disabled = false;
  } else {
    requiredCheckbox.checked = false;
    requiredCheckbox.style.visibility = "hidden";
    requiredLabel.style.visibility = "hidden";
    invoicesCheckbox.checked = false;
    invoicesCheckbox.disabled = true;
  }

  var expensesCheckbox = document.getElementById("expenses");
  var taxCheckbox = document.getElementById("tax_expenses");
  var taxLabel = document.getElementById("tax_label");
  if (expensesCheckbox.checked) {
    taxCheckbox.style.visibility = "visible";
    taxLabel.style.visibility = "visible";
  } else {
    taxCheckbox.checked = false;
    taxCheckbox.style.visibility = "hidden";
    taxLabel.style.visibility = "hidden";
  }

  var customFieldsCheckbox = document.getElementById("custom_fields");
  var configureLabel = document.getElementById("cf_config");
  if (customFieldsCheckbox.checked) {
    configureLabel.style.visibility = "visible";
  } else {
    configureLabel.style.visibility = "hidden";
  }

  var notificationsCheckbox = document.getElementById("notifications");
  configureLabel = document.getElementById("notifications_config");
  if (notificationsCheckbox.checked) {
    configureLabel.style.visibility = "visible";
  } else {
    configureLabel.style.visibility = "hidden";
  }

  var lockingCheckbox = document.getElementById("locking");
  configureLabel = document.getElementById("locking_config");
  if (lockingCheckbox.checked) {
    configureLabel.style.visibility = "visible";
  } else {
    configureLabel.style.visibility = "hidden";
  }

  var quotasCheckbox = document.getElementById("quotas");
  configureLabel = document.getElementById("quotas_config");
  if (quotasCheckbox.checked){
    configureLabel.style.visibility = "visible";
  } else {
    configureLabel.style.visibility = "hidden";
  }
}
</script>


<div class="col-sm-12 text-center">
  {$forms.profileForm.open}

  {if $user->canManageTeam()}
  {include file="datetime_format_preview.tpl"}
  {/if}
  <div class="row">
    <div class="col-sm-12">

      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.person_name}*</label>
        <div class="col-sm-7">{$forms.profileForm.name.control}</div>
        <div class="col-md-2"></div>
      </div>

      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.login}*</label>
        <div class="col-sm-7">{$forms.profileForm.login.control}</div>
        <div class="col-md-2"></div>
      </div>
      {if !$auth_external}

      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.password}*</label>
        <div class="col-sm-7">{$forms.profileForm.password1.control}</div>
        <div class="col-md-2"></div>
      </div>

      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.confirm_password}*</label>
        <div class="col-sm-7">{$forms.profileForm.password2.control}</div>
        <div class="col-md-2"></div>
      </div>
      {/if}
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.email}</label>
        <div class="col-sm-7">{$forms.profileForm.email.control}</div>
        <div class="col-md-2"></div>
      </div>
      
      {if $user->isAdmin()}

      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.team_name}</label>
        <div class="col-sm-7">{$forms.profileForm.team_name.control}</div>
        <div class="col-md-2"></div>
      </div>
      <!-- <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.currency}</label>
        <div class="col-sm-9">{$forms.profileForm.currency.control}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.language}</label>
        <div class="col-sm-9">{$forms.profileForm.lang.control}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.decimal_mark} <font id="decimal_preview" color="#777777">&nbsp;</font></label>
        <div class="col-sm-9">{$forms.profileForm.decimal_mark.control}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.date_format} <font id="date_format_preview" color="#777777">&nbsp;</font></label>
        <div class="col-sm-9">{$forms.profileForm.format_date.control}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.time_format} <font id="time_format_preview" color="#777777">&nbsp;</font></label>
        <div class="col-sm-9">{$forms.profileForm.format_time.control}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.label.week_start}</label>
        <div class="col-sm-9">{$forms.profileForm.start_week.control}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.form.profile.tracking_mode}</label>
        <div class="col-sm-9">{$forms.profileForm.tracking_mode.control}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.form.profile.record_type}</label>
        <div class="col-sm-9">{$forms.profileForm.record_type.control}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-3 control-label">{$i18n.form.profile.uncompleted_indicators}</label>
        <div class="col-sm-9">{$forms.profileForm.uncompleted_indicators.control}</div>
      </div>



      {* initialize preview text *}
      <script>
        MakeFormatPreview("date_format_preview", document.getElementById("format_date"));
        MakeFormatPreview("time_format_preview", document.getElementById("format_time"));

        function adjustDecimalPreview()
        {
          var mark = document.getElementById("decimal_mark").value;
          var example = document.getElementById("decimal_preview");
          example.innerHTML = "<i>3"+mark+"14</i>";
        }
        adjustDecimalPreview();
      </script> -->

      <div class="form-group">
        <hr/>
        <div class="col-sm-12"><span class="h4">{$i18n.form.profile.plugins}</span></div>
        <hr/>
      </div>

      <div class="form-group">
        <label class="col-sm-3 control-label" for="charts">{$i18n.title.charts} (Manager)</label>
        <div class="col-sm-7 col-sm-offset-1 text-left">
          <div class="col-sm-12">
            <div class="checkbox">{$forms.profileForm.charts.control}</div>
          </div>
        </div>
      </div>


      <!-- <div class="form-group">
        <label class="col-sm-3 control-label" for="clients">{$i18n.title.clients}</label>
        <div class="col-sm-7 col-sm-offset-1 text-left">
          <div class="checkbox">
            <div class="col-sm-2">
              {$forms.profileForm.clients.control}
            </div>
            <div class="col-sm-10">
              {$forms.profileForm.client_required.control} <span id="required_label"><label for="client_required">{$i18n.label.required}</label></span>
            </div>
          </div>
        </div>
      </div>


      <div class="form-group">
        <label class="col-sm-3 control-label" for="invoices">{$i18n.title.invoices}</label>
        <div class="col-sm-7 col-sm-offset-1 text-left">
          <div class="col-sm-12">
            <div class="checkbox">{$forms.profileForm.invoices.control}</div>
          </div>
        </div>
      </div>

      <div class="form-group">
        <label class="col-sm-3 control-label" for="custom_fields">{$i18n.label.custom_fields}</label>
        <div class="col-sm-7 col-sm-offset-1 text-left">
          <div class="checkbox">
            <div class="col-sm-2">{$forms.profileForm.custom_fields.control}</div>
            <div class="col-sm-10">
              <span id="cf_config"><a href="cf_custom_fields.php">{$i18n.label.configure}</a></span>
            </div>
          </div>
        </div>
      </div>

      <div class="form-group">
        <label class="col-sm-3 control-label" for="expenses">{$i18n.title.expenses}</label>
        <div class="col-sm-7 col-sm-offset-1 text-left">
          <div class="checkbox">
            <div class="col-sm-2">
              {$forms.profileForm.expenses.control}
            </div>
            <div class="col-sm-10">
              {$forms.profileForm.tax_expenses.control} <span id="tax_label"><label for="tax_expenses">{$i18n.label.tax}</label></span>
            </div>
          </div>
        </div>
      </div>

      <div class="form-group">
        <label class="col-sm-3 control-label" for="notifications">{$i18n.title.notifications}</label>
        <div class="col-sm-7 col-sm-offset-1 text-left">
          <div class="checkbox">
            <div class="col-sm-2">{$forms.profileForm.notifications.control}</div>
            <div class="col-sm-10">
              <span id="notifications_config"><a href="notifications.php">{$i18n.label.configure}</a></span>
            </div>
          </div>
        </div>
      </div>

      <div class="form-group">
        <label class="col-sm-3 control-label" for="locking">{$i18n.title.locking}</label>
        <div class="col-sm-7 col-sm-offset-1 text-left">
          <div class="checkbox">
            <div class="col-sm-2">{$forms.profileForm.locking.control}</div>
            <div class="col-sm-10">
              <span id="locking_config"><a href="locking.php">{$i18n.label.configure}</a></span>
            </div>
          </div>
        </div>
      </div>

      <div class="form-group">
        <label class="col-sm-3 control-label" for="quotas">{$i18n.title.monthly_quotas}</label>
        <div class="col-sm-7 col-sm-offset-1 text-left">
          <div class="checkbox">
            <div class="col-sm-2">{$forms.profileForm.quotas.control}</div>
            <div class="col-sm-10">
              <span id="quotas_config"><a href="quotas.php">{$i18n.label.configure}</a></span>
            </div>
          </div>
        </div>
      </div> -->
      {/if}
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12">
      <div class="form-group">
        <div class="col-md-12 text-center">
          {$forms.profileForm.btn_save.control}
        </div>
      </div>
    </div>
  </div>
  {$forms.profileForm.close}
</div>
