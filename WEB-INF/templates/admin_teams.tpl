<script>
  function chLocation(newLocation) { document.location = newLocation; }
</script>

<div class="col-sm-8 col-sm-offset-2">
  <div class="row text-center">
    <div class="col-sm-12">
      <input class="btn btn-success" type="button" onclick="chLocation('admin_team_add.php');" value="{$i18n.button.create_team}">&nbsp; &nbsp;
      <input class="btn btn-info" type="button" onclick="chLocation('import.php');" value="{$i18n.button.import}">
    </div><br/><br/>
  </div>
</div>

<div class="col-sm-8 col-sm-offset-2">
  <div class="row">
    <div class="col-sm-12">
     <table class="table table-responsive table-hover table-bordered">
      <thead>
        <tr>
          <th width="3%" >{$i18n.label.id}</th>
          <th width="70%" >{$i18n.label.thing_name}</th>
          <th>{$i18n.label.date}</th>
          <th>{$i18n.label.language}</th>
          <th>{$i18n.label.edit}</th>
          <th>{$i18n.label.delete}</th>
        </tr>
      </thead>
      {if $teams}
      {foreach $teams as $team}
      <tr>
        <td>{$team.id}</td>
        <td>{$team.name|escape:'html'}</td>
        <td nowrap>{$team.date}</td>
        <td align="center">{$team.lang}</td>
        <td><a href="admin_team_edit.php?id={$team.id}">{$i18n.label.edit}</a></td>
        <td><a href="admin_team_delete.php?id={$team.id}">{$i18n.label.delete}</a></td>
      </tr>
      {/foreach}
      {/if}
    </table>
  </div>
</div>
</div>

