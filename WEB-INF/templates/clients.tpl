<script>
  function chLocation(newLocation) { document.location = newLocation; }
</script>

<table class="table">
  <tr>
    <td valign="top">
{if ($user->canManageTeam())}
      <table class="table">
  {if $inactive_clients}
        <tr><td class="sectionHeaderNoBorder">{$i18n.form.clients.active_clients}</td></tr>
  {/if}
        <tr>
          <td width="40%" class="tableHeader">{$i18n.label.person_name}</td>
          <td width="40%" class="tableHeader">{$i18n.label.address}</td>
          <td class="tableHeader">{$i18n.label.edit}</td>
          <td class="tableHeader">{$i18n.label.delete}</td>
        </tr>
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
      <table class="table">
        <tr><td class="sectionHeaderNoBorder">{$i18n.form.clients.inactive_clients}</td></tr>
        <tr>
          <td width="40%" class="tableHeader">{$i18n.label.person_name}</td>
          <td width="40%" class="tableHeader">{$i18n.label.address}</td>
          <td class="tableHeader">{$i18n.label.edit}</td>
          <td class="tableHeader">{$i18n.label.delete}</td>
        </tr>
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
