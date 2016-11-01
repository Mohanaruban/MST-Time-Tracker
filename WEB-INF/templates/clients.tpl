<script>
  function chLocation(newLocation) { document.location = newLocation; }
</script>
<div class="col-sm-8 col-sm-offset-2">
  <div class="row">
    <div class="col-sm-12">
<table class="table">
  <tr>
    <td valign="top">
{if ($user->canManageTeam())}
      <table class="table table-responsive table-striped table-hover table-bordered">
  {if $inactive_clients}
        <tr><td class="sectionHeaderNoBorder">{$i18n.form.clients.active_clients}</td></tr>
  {/if}
  <thead>
        <tr>
          <th width="40%">{$i18n.label.person_name}</th>
          <th width="40%">{$i18n.label.address}</th>
          <th>{$i18n.label.edit}</th>
          <th >{$i18n.label.delete}</th>
        </tr>
  </thead>
  {foreach $active_clients as $client}
        <tr valign="top" bgcolor="{cycle values="#f5f5f5,#dedee5"}">
          <td>{$client.name|escape:'html'}</td>
          <td>{$client.address|escape:'html'}</td>
          <td><a href="client_edit.php?id={$client.id}">{$i18n.label.edit}</a></td>
          <td><a href="client_delete.php?id={$client.id}">{$i18n.label.delete}</a></td>
        </tr>
  {/foreach}
      </table>

      <table width="100%">
        <tr><td align="center"><br><form><input class="btn btn-success" type="button" onclick="chLocation('client_add.php');" value="{$i18n.button.add_client}"></form></td></tr>
      </table>

  {if $inactive_clients}
      <table class="table table-responsive table-striped table-hover table-bordered">
        <tr><td class="sectionHeaderNoBorder">{$i18n.form.clients.inactive_clients}</td></tr>
        <thead>
        <tr>
          <th width="40%" class="tableHeader">{$i18n.label.person_name}</th>
          <th width="40%" class="tableHeader">{$i18n.label.address}</th>
          <th class="tableHeader">{$i18n.label.edit}</th>
          <th class="tableHeader">{$i18n.label.delete}</th>
        </tr>
        </thead>
    {foreach $inactive_clients as $client}
        <tr valign="top" bgcolor="{cycle values="#f5f5f5,#dedee5"}">
          <td>{$client.name|escape:'html'}</td>
          <td>{$client.address|escape:'html'}</td>
          <td><a href="client_edit.php?id={$client.id}">{$i18n.label.edit}</a></td>
          <td><a href="client_delete.php?id={$client.id}">{$i18n.label.delete}</a></td>
        </tr>
    {/foreach}
      </table>

      <table width="100%">
        <tr><td align="center"><br><form><input type="button" onclick="chLocation('client_add.php');" value="{$i18n.button.add_client}"></form></td></tr>
      </table>
  {/if}
{/if}
    </td>
  </tr>
</table>
    </div>
    </div>
    </div>

