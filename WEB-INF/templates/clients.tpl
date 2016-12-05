<script>
  function chLocation(newLocation) { document.location = newLocation; }
</script>
<div class="col-sm-8 col-sm-offset-2">
  {if ($user->canManageTeam())}
  <div class="row">
    <div class="col-sm-12">
      <table class="table table-responsive table-hover table-bordered">
        {if $inactive_clients}
        <tr><td class="sectionHeaderNoBorder">{$i18n.form.clients.active_clients}</td></tr>
        {/if}
        <thead>
          <tr>
            <th>{$i18n.label.person_name}</th>
            <th>{$i18n.label.address}</th>
            <th>{$i18n.label.edit}</th>
            <th >{$i18n.label.delete}</th>
          </tr>
        </thead>
        {foreach $active_clients as $client}
        <tr>
          <td>{$client.name|escape:'html'}</td>
          <td>{$client.address|escape:'html'}</td>
          <td><a href="client_edit.php?id={$client.id}">{$i18n.label.edit}</a></td>
          <td><a href="client_delete.php?id={$client.id}">{$i18n.label.delete}</a></td>
        </tr>
        {/foreach}
      </table>
    </div>
    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-12 text-center"><form><input class="btn btn-success" type="button" onclick="chLocation('client_add.php');" value="{$i18n.button.add_client}"></form></div>
      </div>
    </div>
  </div>
  {if $inactive_clients}
  <div class="row">
    <div class="col-sm-12">
      <table class="table table-responsive table-hover table-bordered">
        <tr><td class="sectionHeaderNoBorder">{$i18n.form.clients.inactive_clients}</td></tr>
        <thead>
          <tr>
            <th>{$i18n.label.person_name}</th>
            <th>{$i18n.label.address}</th>
            <th>{$i18n.label.edit}</th>
            <th>{$i18n.label.delete}</th>
          </tr>
        </thead>
        {foreach $inactive_clients as $client}
        <tr>
          <td>{$client.name|escape:'html'}</td>
          <td>{$client.address|escape:'html'}</td>
          <td><a href="client_edit.php?id={$client.id}">{$i18n.label.edit}</a></td>
          <td><a href="client_delete.php?id={$client.id}">{$i18n.label.delete}</a></td>
        </tr>
        {/foreach}
      </table>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="form-group">
          <div class="col-sm-12 text-center"><form><input type="button" onclick="chLocation('client_add.php');" value="{$i18n.button.add_client}"></form></div>
        </div>
      </div>
    </div>
  </div>
  {/if}
  {/if}
</div>

