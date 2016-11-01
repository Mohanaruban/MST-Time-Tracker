
<div class="col-sm-6 col-sm-offset-3 text-center">
  {$forms.importForm.open}
  <div class="row">
    <div class="col-sm-12">

     <div class="form-group">
     
      <div class="col-sm-9">{$i18n.form.import.hint}</div>
    </div>

    <div class="form-group">
      <label class="col-sm-3 control-label">{$i18n.form.import.file}</label>
      <div class="col-sm-9">{$forms.importForm.xmlfile.control}</div>
    </div>

 

  </div>
</div>

<div class="row">
  <div class="col-md-12 text-center">
   {$forms.importForm.btn_submit.control}
  </div>
</div>
{$forms.importForm.close}
</div> 

<!--

{$forms.importForm.open}

<table cellspacing="0" cellpadding="7" border="0" width="720">
  <tr>
    <td align="center">
      {if $user->isAdmin()}
      <table border="0" width="60%">
        <tr><td colspan="2">{$i18n.form.import.hint}<br></td></tr>
        <tr><td colspan="2">&nbsp;</td></tr>
        <tr>
          <td align='right'>{$i18n.form.import.file}:</td>
          <td>{$forms.importForm.xmlfile.control}</td>
        </tr>
        <tr><td height="50" align="center" colspan="2">{$forms.importForm.btn_submit.control}</td></tr>
      </table>
      {/if}
    </td>
  </tr>
</table>
{$forms.importForm.close}

-->