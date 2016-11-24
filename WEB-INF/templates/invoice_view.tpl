<script>
  function chLocation(newLocation) { document.location = newLocation; }
</script>
 
 
<div class="col-sm-8 col-sm-offset-2">
  <div class="row">
    <div class="col-sm-12">
<table cellspacing="0" cellpadding="7" border="0" width="720">
  <tr>
    <td>
      <table class="table table-responsive table-striped table-hover table-bordered">
        <tr><td align="center"><b style="font-size: 15pt; font-family: Arial, Helvetica, sans-serif;">{$i18n.title.invoice} {$invoice_name|escape:'html'} </b></td></tr>
        <tr><td align='left'><b>{$i18n.label.date}:</b> {$invoice_date}</td></tr>
        <tr><td align='left'><b>{$i18n.label.client}:</b> {$client_name|escape:'html'}</td></tr>
        <tr><td align='left'><b>{$i18n.label.client_address}:</b> {$client_address|escape:'html'}</td></tr>
      </table>
    </td>
  </tr>
  <tr>
    <td valign="top">
      {if $invoice_items}
      <table class="table table-responsive table-striped table-hover table-bordered">
      <thead>
        <tr>
          <th >{$i18n.label.date}</th>
          <th >{$i18n.form.invoice.person}</th>
          {if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
          <th >{$i18n.label.project}</th>
          {/if}
          {if ($smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
          <th >{$i18n.label.task}</th>
          {/if}
          <th >{$i18n.label.note}</th>
          <th width="5%">{$i18n.label.duration}</th>
          <th width="5%">{$i18n.label.cost}</th>
        </tr>
      </thead>
        {foreach $invoice_items as $invoice_item}
        <tr bgcolor="{cycle values="#f5f5f5,#ccccce"}">
          <td valign='top'>{$invoice_item.date}</td>
          <td valign='top'>{$invoice_item.user_name|escape:'html'}</td>
          {if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
          <td valign='top'>{$invoice_item.project_name|escape:'html'}</td>
          {/if}
          {if ($smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
          <td valign='top'>{$invoice_item.task_name|escape:'html'}</td>
          {/if}
          <td valign='top'>{$invoice_item.note|escape:'html'}</td>
          <td align='right' valign='top'>{$invoice_item.duration}</td>
          <td align='right' valign='top'>{$invoice_item.cost}</td>
        </tr>
        {/foreach}
        <tr><td>&nbsp;</td></tr>
        {if $tax}
        <tr>
          <td align="right" colspan="{$colspan}"><b>{$i18n.label.subtotal}:</b></td>
          <td align="right"><nobr>{$subtotal|escape:'html'}</nobr></td>
        </tr>
        <tr>
          <td align="right" colspan="{$colspan}"><b>{$i18n.label.tax}:</b></td>
          <td align="right"><nobr>{$tax|escape:'html'}</nobr></td>
        </tr>
        {/if}
        <tr>
          <td align="right" colspan="{$colspan}"><b>{$i18n.label.total}:</b></td>
          <td align="right"><nobr>{$total|escape:'html'}</nobr></td>
        </tr>
      </table>
      {/if}
    </td>
  </tr>
 
</table>
</div>
</div>
</div>
<div class="col-sm-8 col-sm-offset-2">
  <div class="row text-center">
    <div class="col-sm-12">
      <input class="btn btn-success" type="button" onclick="chLocation('invoice_send.php?id={$invoice_id}');" value="{$i18n.button.send_by_email}">
    
    </div><br/><br/>
  </div>
</div>