<script>
  function chLocation(newLocation) { document.location = newLocation; }
</script>
<div class="col-sm-8 col-sm-offset-2">
  <div class="row">
    <div class="col-sm-12">
      {if $user->canManageTeam()}
      <table class="table table-responsive table-striped table-hover table-bordered">
        {if $inactive_projects}
        <tr><td class="sectionHeaderNoBorder">{$i18n.form.projects.active_projects}</td></tr>
        {/if}
        <thead>
          <tr>
            <th width="35%" >{$i18n.label.thing_name}</th>
            <th width="35%" >{$i18n.label.description}</th>
            <th>{$i18n.label.edit}</th>
            <th>{$i18n.label.delete}</th>
          </tr>
        </thead>
        {if $active_projects}
        {foreach $active_projects as $project}
        <tr>
          <td>{$project.name|escape:'html'}</td>
          <td>{$project.description|escape:'html'}</td>
          <td><a href="project_edit.php?id={$project.id}">{$i18n.label.edit}</a></td>
          <td><a href="project_delete.php?id={$project.id}">{$i18n.label.delete}</a></td>
        </tr>
        {/foreach}
        {/if}
      </table>
    </div>
  </div>
</div>


<table width="100%">
  <tr>
    <td align="center"><br>
      <form><input class="btn btn-success" type="button" onclick="chLocation('project_add.php');" value="{$i18n.button.add_project}"></form>
    </td>
  </tr>
</table>


<div class="col-sm-8 col-sm-offset-2">
  <div class="row">
    <div class="col-sm-12">
{if $inactive_projects}
<table class="table table-responsive table-striped table-hover table-bordered">
  <tr><td class="sectionHeaderNoBorder">{$i18n.form.projects.inactive_projects}</td></tr>
  <thead>
  <tr>
    <th width="35%">{$i18n.label.thing_name}</th>
    <th width="35%">{$i18n.label.description}</th>
    <th>{$i18n.label.edit}</th>
    <th>{$i18n.label.delete}</th>
  </tr>
  </thead>
  {foreach $inactive_projects as $project}
  <tr>
    <td>{$project.name|escape:'html'}</td>
    <td>{$project.description|escape:'html'}</td>
    <td><a href="project_edit.php?id={$project.id}">{$i18n.label.edit}</a></td>
    <td><a href="project_delete.php?id={$project.id}">{$i18n.label.delete}</a></td>
  </tr>
  {/foreach}
</table>

<table width="100%">
  <tr>
    <td align="center"><br>
      <form><input type="button" onclick="chLocation('project_add.php');" value="{$i18n.button.add_project}"></form>
    </td>
  </tr>
</table>
{/if}
{else}
<table class="table">
  <tr>
    <td class="tableHeader">{$i18n.label.thing_name}</td>
    <td class="tableHeader">{$i18n.label.description}</td>
  </tr>
  {if $active_projects}
  {foreach $active_projects as $project}
  <tr>
    <td>{$project.name|escape:'html'}</td>
    <td>{$project.description|escape:'html'}</td>
  </tr>
  {/foreach}
  {/if}
</table>
{/if}
</td>
</tr>
</table>
    </div>
  </div>
</div>
