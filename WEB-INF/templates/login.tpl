<script>
  <!--
  function get_date() {
    var date = new Date();
    return date.strftime("%Y-%m-%d");
  }
//-->
</script>

<div class="col-md-5 col-md-offset-4 text-center">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">Login Information</h3>
    </div>
    <div class="panel-body">
      <div class="col-sm-12">
        {$forms.loginForm.open}
        {include file="login.`$smarty.const.AUTH_MODULE`.tpl"}
        {$forms.loginForm.close}
      </div>
    </div>
  </div>
</div>
