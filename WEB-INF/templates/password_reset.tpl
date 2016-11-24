<div class="col-md-12">
<div class="col-md-3"></div>
<div class="col-md-6 text-center">
  <div class="panel-login panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">Reset Password</h3>
    </div>
    <div class="panel-body">
      <div class="col-sm-12">
{$forms.resetPasswordForm.open}
 

      
{if $result_message}
<div class="form-group">
     <label class="control-label"><font color="red"><b>{$result_message}</b></font>

     </label>
      </div>
{else}
      <div class="form-group">
        <label class="control-label">Login ID</label>
       <div class="col-sm-12">
        {$forms.resetPasswordForm.login.control}
</div>

       </div>

     
        <div class="form-group">
          <div class="col-md-12 text-center">
          {$forms.resetPasswordForm.btn_submit.control}
       </div>
       </div>
      
   
      
{/if}
</div>
</div>
   
{$forms.resetPasswordForm.close}
</div>
</div>
<div class="col-md-3"></div>
</div>