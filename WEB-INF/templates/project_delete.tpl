<div class="col-sm-6 col-sm-offset-3 text-center">
{$forms.projectDeleteForm.open}
  <div class="row">
    <div class="col-sm-12">

<div class="form-group">
        <div class="col-md-12 text-center">
        <b>{$project_to_delete|escape:'html'}</b>
    </div>

    <div class="form-group">
      <div class="col-md-12 text-center">
        &nbsp; &nbsp;
    </div>

<div class="form-group">
      <div class="col-md-12 text-center">
        {$forms.projectDeleteForm.btn_delete.control}&nbsp; &nbsp;{$forms.projectDeleteForm.btn_cancel.control}
    </div>

      </div>
    </div>
    {$forms.projectDeleteForm.close}
  </div>

<!--
{$forms.projectDeleteForm.open}
<table cellspacing="4" cellpadding="7" border="0">
  <tr>
    <td>
      <table cellspacing="0" cellpadding="0" border="0">
        <tr>
          <td colspan="2" align="center"><b>{$project_to_delete|escape:'html'}</b></td>
        </tr>
        <tr><td colspan="2" align="center">&nbsp;</td></tr>
        <tr>
          <td align="right">{$forms.projectDeleteForm.btn_delete.control}&nbsp;</td>
          <td align="left">&nbsp;{$forms.projectDeleteForm.btn_cancel.control}</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
-->