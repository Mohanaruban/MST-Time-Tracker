<script>
  function chLocation(newLocation) { document.location = newLocation; }
</script>
<div class="col-sm-12">
  <div class="row">
    <div class="col-sm-12">
      {if $user->canManageTeam() && $user->isAdmin()}
      {if $inactive_projects}
      <div class="text-center h4">
        {$i18n.form.projects.active_projects}
      </div>
      {/if}
      <table class="table table-responsive table-hover table-bordered">
        <thead>
          <tr>
            <th>{$i18n.label.thing_name}</th>
            <th>{$i18n.label.description}</th>
            <th style="width: 200px">Actions</th>
          </tr>
        </thead>
        {if $active_projects}
        {foreach $active_projects as $project}
        <tr>
          <td>{$project.name|escape:'html'}</td>
          <td>{$project.description|escape:'html'}</td>
          <td class="text-center">
            <a class="btn btn-info btn-xs" href="project_edit.php?id={$project.id}">{$i18n.label.edit}</a>
            <a class="btn btn-info btn-xs"  href="project_delete.php?id={$project.id}">{$i18n.label.delete}</a>
          </td>
        </tr>
        {/foreach}
        {/if}
      </table>
    </div>
  </div>
</div>
<div class="col-sm-12">
  {if $inactive_projects}
  <div class="row">
    <div class="col-sm-12">
      <div class="text-center h4">
        {$i18n.form.projects.inactive_projects}
      </div>
      <table class="table table-responsive table-hover table-bordered">
        <thead>
          <tr>
            <th>{$i18n.label.thing_name}</th>
            <th>{$i18n.label.description}</th>
            <th style="width: 200px">Actions</th>
          </tr>
        </thead>
        {foreach $inactive_projects as $project}
        <tr>
          <td>{$project.name|escape:'html'}</td>
          <td>{$project.description|escape:'html'}</td>
          <td class="text-center">
            <a class="btn btn-info btn-xs" href="project_edit.php?id={$project.id}">{$i18n.label.edit}</a>
            <a class="btn btn-info btn-xs"  href="project_delete.php?id={$project.id}">{$i18n.label.delete}</a>
          </td>
        </tr>
        {/foreach}
      </table>
    </div>
  </div>
  {/if}
  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-12 text-center"><form><input class="btn btn-success" type="button" onclick="chLocation('project_add.php');" value="{$i18n.button.add_project}"></form></div>
      </div>
    </div>
  </div>
  {else}
  <table class="table table-responsive table-hover table-bordered">
    {if $inactive_projects}
    <tr><td class="sectionHeaderNoBorder">{$i18n.form.projects.active_projects}</td></tr>
    {/if}
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
</div>
</div>
</div>
<div class="col-sm-12">
  {if $inactive_projects}
  <div class="row">
    <div class="col-sm-12">
      <table class="table table-responsive table-hover table-bordered">
        <tr><td class="sectionHeaderNoBorder">{$i18n.form.projects.inactive_projects}</td></tr>
        <thead>
          <tr>
            <th>{$i18n.label.thing_name}</th>
            <th>{$i18n.label.description}</th>
          </tr>
        </thead>
        {foreach $inactive_projects as $project}
        <tr>
          <td>{$project.name|escape:'html'}</td>
          <td>{$project.description|escape:'html'}</td>
        </tr>
        {/foreach}
      </table>
    </div>
  </div>
  {/if}
  {/if}

</div>
</div>
</div>

