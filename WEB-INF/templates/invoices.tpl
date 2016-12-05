<script>
  function chLocation(newLocation) { document.location = newLocation; }
</script>
<div class="col-xs-12" style="height:30px;"></div>
<div class="col-sm-8 col-sm-offset-2">
  <div class="row">
    <div class="col-sm-12">
      {if $user->canManageTeam() || $user->isClient()}
      <table class="table table-responsive table-hover table-bordered">
        <thead>
          <tr>
            <th>{$i18n.label.invoice}</th>
            <th>{$i18n.label.client}</th>
            <th>{$i18n.label.date}</th>
            <th>{$i18n.label.view}</th>
            {if !$user->isClient()}
            <th>{$i18n.label.delete}</th>
            {/if}
          </tr>
        </thead>
        {foreach $invoices as $invoice}
        <tr valign="top" bgcolor="{cycle values="#f5f5f5,#dedee5"}">
          <td>{$invoice.name|escape:'html'}</td>
          <td>{$invoice.client_name|escape:'html'}</td>
          <td>{$invoice.date}</td>
          <td><a href="invoice_view.php?id={$invoice.id}">{$i18n.label.view}</a></td>
          {if !$user->isClient()}
          <td><a href="invoice_delete.php?id={$invoice.id}">{$i18n.label.delete}</a></td>
          {/if}
        </tr>
        {/foreach}
      </table>
      {if !$user->isClient()}
      <table width="100%">
        <tr><td align="center"><br><form><input type="button" class="btn btn-success" onclick="chLocation('invoice_add.php');" value="{$i18n.button.add_invoice}"></form></td></tr>
      </table>
      {/if}
      {/if}
    </div>
  </div>
</div>
</div>
