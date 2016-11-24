<script>
  function chLocation(newLocation) { document.location = newLocation; }
</script>
{if $user->canManageTeam()}
<div class="col-sm-8 col-sm-offset-2">
  <div class="row">
    <div class="col-sm-12">
      <table class="table table-responsive table-striped table-hover table-bordered">
        <thead>
          {if $inactive_tasks}
          <tr><td class="sectionHeaderNoBorder">{$i18n.form.tasks.active_tasks}</td></tr>
          {/if}
          <tr>
            <th>{$i18n.label.thing_name}</th>
            <th>{$i18n.label.description}</th>
            <th>{$i18n.label.edit}</th>
            <th>{$i18n.label.delete}</th>
          </tr>
        </thead>
        {if $active_tasks}
        {foreach $active_tasks as $task}
        <tr>
          <td>{$task.name|escape:'html'}</td>
          <td>{$task.description|escape:'html'}</td>
          <td><a href="task_edit.php?id={$task.id}">{$i18n.label.edit}</a></td>
          <td><a href="task_delete.php?id={$task.id}">{$i18n.label.delete}</a></td>
        </tr>
        {/foreach}
        {/if}
      </table>
    </div>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-12 text-center"><form><input type="button" class="btn btn-success" onclick="chLocation('task_add.php');" value="{$i18n.button.add_task}"></form></div>
      </div>
    </div>
  </div>
</div>

{if $inactive_tasks}
<div class="col-sm-8 col-sm-offset-2">
  <div class="row">
    <div class="col-sm-12">
      <table class="table table-responsive table-striped table-hover table-bordered">
        <thead>
          <tr><th class="sectionHeaderNoBorder">{$i18n.form.tasks.inactive_tasks}</th></tr>
          <tr>
            <th>{$i18n.label.thing_name}</th>
            <th>{$i18n.label.description}</th>
            <th>{$i18n.label.edit}</th>
            <th>{$i18n.label.delete}</th>
          </tr>
        </thead>
        {foreach $inactive_tasks as $task}
        <tr>
          <td>{$task.name|escape:'html'}</td>
          <td>{$task.description|escape:'html'}</td>
          <td><a href="task_edit.php?id={$task.id}">{$i18n.label.edit}</a></td>
          <td><a href="task_delete.php?id={$task.id}">{$i18n.label.delete}</a></td>
        </tr>
        {/foreach}
      </table>
    </div>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-12 text-center"><form><input type="button" onclick="chLocation('task_add.php');" value="{$i18n.button.add_task}"></form></div>
      </div>
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
  {if $active_tasks}
  {foreach $active_tasks as $task}
  <tr>
    <td>{$task.name|escape:'html'}</td>
    <td>{$task.description|escape:'html'}</td>
  </tr>
  {/foreach}
  {/if}
</table>
{/if}
