<script>
  function chLocation(newLocation) { document.location = newLocation; }
</script>



<div class="col-sm-8 col-sm-offset-2">
  <div class="row">
    <div class="col-sm-12">

      <table class="table">
  <tr><td valign="top">{$i18n.form.teams.hint}</td></tr>
</table>


<table class="table table-responsive table-striped table-hover table-bordered">
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
  <tr bgcolor="{cycle values="#f5f5f5,#dedee5"}">
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

<table width="100%">
  <tr>
    <td align="center">
      <br>
      <form>
        <input class="btn btn-success" type="button" onclick="chLocation('admin_team_add.php');" value="{$i18n.button.create_team}">&nbsp;{$i18n.label.or}&nbsp;
        <input class="btn btn-info" type="button" onclick="chLocation('import.php');" value="{$i18n.button.import}">
      </form>
    </td>
  </tr>
</table>
    </div>
  </div>
</div>

