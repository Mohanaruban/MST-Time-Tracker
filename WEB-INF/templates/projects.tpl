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
            <th>{$i18n.label.thing_name}</th>
            <th>{$i18n.label.description}</th>
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
  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-12 text-center"><form><input class="btn btn-success" type="button" onclick="chLocation('project_add.php');" value="{$i18n.button.add_project}"></form></div>
      </div>
    </div>
  </div>
</div>
<div class="col-sm-8 col-sm-offset-2">
  {if $inactive_projects}
  <div class="row">
    <div class="col-sm-12">
      <table class="table table-responsive table-striped table-hover table-bordered">
        <tr><td class="sectionHeaderNoBorder">{$i18n.form.projects.inactive_projects}</td></tr>
        <thead>
          <tr>
            <th>{$i18n.label.thing_name}</th>
            <th>{$i18n.label.description}</th>
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
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-12 text-center"><form><input type="button" onclick="chLocation('project_add.php');" value="{$i18n.button.add_project}"></form></div>
      </div>
    </div>
  </div>
  {/if}
  {else}
  <table class="table table-responsive table-striped table-hover table-bordered">
    <thead>
      <tr>
      <th>{$i18n.label.thing_name}</th>
      <th>{$i18n.label.description}</th>
      </tr>
    </thead>
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
