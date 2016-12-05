<div class="col-sm-8 col-sm-offset-2">
{$forms.notificationsForm.open}
{if $user->canManageTeam()}
<div class="row">
    <div class="col-sm-12">
      <table class="table table-responsive table-hover table-bordered">
        <thead>
        <tr>
          <th>{$i18n.label.thing_name}</th>
          <th>{$i18n.label.cron_schedule}</th>
          <th>{$i18n.label.email}</th>
          <th>{$i18n.label.edit}</th>
          <th>{$i18n.label.delete}</th>
        </tr>
        </thead>
  {if $notifications}
    {foreach $notifications as $notification}
        <tr>
          <td>{$notification['name']|escape:'html'}</td>
          <td>{$notification['cron_spec']|escape:'html'}</td>
          <td>{$notification['email']|escape:'html'}</td>
          <td><a href="notification_edit.php?id={$notification['id']}">{$i18n.label.edit}</a></td>
          <td><a href="notification_delete.php?id={$notification['id']}">{$i18n.label.delete}</a></td>
        </tr>
    {/foreach}
  {/if}
      </table>
      </div>
      </div>
        <div class="row">
    <div class="col-md-12 text-center">
      <div class="form-group">
        <div class="col-sm-12">{$forms.notificationsForm.btn_add.control}</div>
      </div>
    </div>
  </div>
{/if}
{$forms.notificationsForm.close}