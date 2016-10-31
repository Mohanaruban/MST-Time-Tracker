<script>
  <!--
  function get_date() {
    var date = new Date();
    return date.strftime("%Y-%m-%d");
  }
//-->
</script>
<div class="wrapper">
  <div class="container">
    <div class="row">
      <div class="col-sm-4 col-sm-offset-4">
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
    </div>
  </div>
</div>