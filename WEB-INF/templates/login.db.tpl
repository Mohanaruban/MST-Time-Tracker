<div class="form-group">
  <label class="control-label">{$i18n.label.login} ID</label>
  {$forms.loginForm.login.control}
</div>

<div class="form-group">
  <label class="control-label">{$i18n.label.password}</label>
  {$forms.loginForm.password.control}
</div>

<div class="form-group">
    {$forms.loginForm.btn_login.control}
    {$forms.loginForm.btn_reset.control}
</div>
<a href='password_reset.php' class="text-muted" style="color:#545758 !important;">{$i18n.form.login.forgot_password}</a>