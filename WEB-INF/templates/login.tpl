<script>
  <!--
  function get_date() {
    var date = new Date();
    return date.strftime("%Y-%m-%d");
  }
//-->
</script>
<div class="row">
  <div class="col-sm-4 col-sm-offset-4">
    {$forms.loginForm.open}
    {include file="login.`$smarty.const.AUTH_MODULE`.tpl"}
    {$forms.loginForm.close}
  </div>
</div>