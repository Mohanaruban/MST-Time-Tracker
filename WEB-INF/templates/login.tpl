<script>
  <!--
  function get_date() {
    var date = new Date();
    return date.strftime("%Y-%m-%d");
  }
//-->
</script>
<style>
  html {
    background-image: url("./images/homebg/18.jpg") !important;
    background-size:cover; 
  }

  .text-muted {
    color: #ffffff !important;
  }
</style>
<div class="col-md-12">
<div class="col-md-7"></div>
<div class="col-md-5 text-center">
  <div class="panel-login panel-default">
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
<!-- <div class="col-md-3"></div> -->
</div>
