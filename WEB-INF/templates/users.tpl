<script>
  function chLocation(newLocation) { document.location = newLocation; }
</script>
<div class="col-sm-8 col-sm-offset-2">
  <div class="row">
    <div class="col-sm-12">
      {if $user->canManageTeam() && $user->isAdmin()}
       <table class="table table-responsive table-striped table-hover table-bordered">
        {if $inactive_users}
        <tr><td class="sectionHeaderNoBorder">{$i18n.form.users.active_users}</td></tr>
        {/if}
        <thead>
          <tr>
            <th>{$i18n.label.person_name}</th>
            <th>{$i18n.label.login}</th>
            <th>{$i18n.form.users.role}</th>
            <th>{$i18n.label.edit}</th>
            <th>{$i18n.label.delete}</th>
          </tr>
        </thead>
        {if $active_users}
        {foreach $active_users as $u}
        <tr>
          <td>
            {if $smarty.const.UNCOMPLETED_INDICATORS == $user->uncompleted_indicators}
            <span class="uncompleted-entry{if $u.has_uncompleted_entry} active{/if}"{if $u.has_uncompleted_entry} title="{$i18n.form.users.uncompleted_entry}"{/if}></span>
            {/if}
            {$u.name|escape:'html'}
          </td>
          <td>{$u.login|escape:'html'}</td>
          {if $smarty.const.ROLE_SITE_ADMIN == $u.role}
          <td>{$i18n.form.users.admin}</td>
          {elseif $smarty.const.ROLE_MANAGER == $u.role}
          <td>{$i18n.form.users.manager}</td>
          {elseif $smarty.const.ROLE_COMANAGER == $u.role}
          <td>{$i18n.form.users.comanager}</td>
          {elseif $smarty.const.ROLE_CLIENT == $u.role}
          <td>{$i18n.label.client}</td>
          {elseif $smarty.const.ROLE_USER == $u.role}
          <td>{$i18n.label.user}</td>
          {/if}
          {if $user->isAdmin()}
          <!-- Manager can edit everybody. -->
          <td><a href="user_edit.php?id={$u.id}">{$i18n.label.edit}</a></td>
          <td><a href="user_delete.php?id={$u.id}">{$i18n.label.delete}</a></td>
          {else}
          <!--  Comanager can edit self and clients or users but not manager and other comanagers. -->
          <td>{if ($user->id == $u.id) || ($smarty.const.ROLE_CLIENT == $u.role) || ($smarty.const.ROLE_USER == $u.role)}<a href="user_edit.php?id={$u.id}">{$i18n.label.edit}</a>{/if}</td>
          <td>{if ($user->id == $u.id) || ($smarty.const.ROLE_CLIENT == $u.role) || ($smarty.const.ROLE_USER == $u.role)}<a href="user_delete.php?id={$u.id}">{$i18n.label.delete}</a>{/if}</td>
          {/if}
        </tr>
        {/foreach}
        {/if}
      </table>
      <div class="row">
        <div class="col-md-12 text-center">
          <div class="form-group">
          <div class="col-sm-12"><form><input class="btn btn-success" " type="button" onclick="chLocation('user_add.php');" value="{$i18n.button.add_user}"></form></div>
          </div>
        </div>
      </div>




      {else}
      {if $user->canManageTeam() && !$user->isAdmin()}
      <table class="table table-responsive table-striped table-hover table-bordered">
        {if $inactive_users}
        <tr><td class="sectionHeaderNoBorder">{$i18n.form.users.active_users}</td></tr>
        {/if}
        <thead>
          <tr>
            <th>{$i18n.label.person_name}</th>
            <th>{$i18n.label.login}</th>
            <th>{$i18n.form.users.role}</th>
            {if $user->isManager()}
            <th>{$i18n.label.projectview}</th>
            {/if}
            <!-- <th>{$i18n.label.delete}</th> -->
          </tr>
        </thead>
        {if $active_users}
        {foreach $active_users as $u}
        <tr>
          <td>
            {if $smarty.const.UNCOMPLETED_INDICATORS == $user->uncompleted_indicators}
            <span class="uncompleted-entry{if $u.has_uncompleted_entry} active{/if}"{if $u.has_uncompleted_entry} title="{$i18n.form.users.uncompleted_entry}"{/if}></span>
            {/if}
            {$u.name|escape:'html'}
          </td>
          <td>{$u.login|escape:'html'}</td>
          {if $smarty.const.ROLE_MANAGER == $u.role}
          <td>{$i18n.form.users.manager}</td>
          {elseif $smarty.const.ROLE_COMANAGER == $u.role}
          <td>{$i18n.form.users.comanager}</td>
          {elseif $smarty.const.ROLE_CLIENT == $u.role}
          <td>{$i18n.label.client}</td>
          {elseif $smarty.const.ROLE_USER == $u.role}
          <td>{$i18n.label.user}</td>
          {/if}
          {if $user->isManager()} 
          <!-- Manager can edit everybody. -->
          <!-- <td><a href="user_edit.php?id={$u.id}">{$i18n.label.view}</a></td> -->
          <td>{$u.projects}</td>
          {/if}
          <!-- {if $user->isManager()} -->
          <!-- Manager can edit everybody. -->
         <!--  <td><a href="user_edit.php?id={$u.id}">{$i18n.label.edit}</a></td>
          <td>{if $smarty.const.ROLE_MANAGER != $u.role || $can_delete_manager}<a href="user_delete.php?id={$u.id}">{$i18n.label.delete}</a>{/if}</td>
          {else} -->
          <!--  Comanager can edit self and clients or users but not manager and other comanagers. -->
          <!-- <td>{if ($user->id == $u.id) || ($smarty.const.ROLE_CLIENT == $u.role) || ($smarty.const.ROLE_USER == $u.role)}<a href="user_edit.php?id={$u.id}">{$i18n.label.edit}</a>{/if}</td>
          <td>{if ($user->id == $u.id) || ($smarty.const.ROLE_CLIENT == $u.role) || ($smarty.const.ROLE_USER == $u.role)}<a href="user_delete.php?id={$u.id}">{$i18n.label.delete}</a>{/if}</td>
          {/if} -->
        </tr>
        {/foreach}
        {/if}
      </table>
<!--   <div class="row">
    <div class="col-md-12 text-center">
      <div class="form-group">
      <div class="col-sm-12"><form><input class="btn btn-success" " type="button" onclick="chLocation('user_add.php');" value="{$i18n.button.add_user}"></form></div>
      </div>
    </div>
  </div> -->


{if $inactive_users}
<table class="table table-responsive table-striped table-hover table-bordered">
  <tr><td class="sectionHeaderNoBorder">{$i18n.form.users.inactive_users}</td></tr>
  <thead>
    <tr>
      <th>{$i18n.label.person_name}</th>
      <th>{$i18n.label.login}</th>
      <th>{$i18n.form.users.role}</th>
      <th>{$i18n.label.edit}</th>
      <th>{$i18n.label.delete}</th>
    </tr>
  </thead>
  {foreach $inactive_users as $u}
  <tr>
    <td>{$u.name|escape:'html'}</td>
    <td>{$u.login|escape:'html'}</td>
    {if $smarty.const.ROLE_MANAGER == $u.role}
    <td>{$i18n.form.users.manager}</td>
    {elseif $smarty.const.ROLE_COMANAGER == $u.role}
    <td>{$i18n.form.users.comanager}</td>
    {elseif $smarty.const.ROLE_CLIENT == $u.role}
    <td>{$i18n.label.client}</td>
    {elseif $smarty.const.ROLE_USER == $u.role}
    <td>{$i18n.label.user}</td>
    {/if}
    {if $user->isManager()}
    <!-- Manager can edit everybody. -->
    <td><a href="user_edit.php?id={$u.id}">{$i18n.label.edit}</a></td>
    <td>{if $smarty.const.ROLE_MANAGER != $u.role || $can_delete_manager}<a href="user_delete.php?id={$u.id}">{$i18n.label.delete}</a>{/if}</td>
    {else}
    <!--  Comanager can edit self and clients or users but not manager and other comanagers. -->
    <td>{if ($user->id == $u.id) || ($smarty.const.ROLE_CLIENT == $u.role) || ($smarty.const.ROLE_USER == $u.role)}<a href="user_edit.php?id={$u.id}">{$i18n.label.edit}</a>{/if}</td>
    <td>{if ($user->id == $u.id) || ($smarty.const.ROLE_CLIENT == $u.role) || ($smarty.const.ROLE_USER == $u.role)}<a href="user_delete.php?id={$u.id}">{$i18n.label.delete}</a>{/if}</td>
    {/if}
  </tr>
  {/foreach}
</table>

  <div class="row">
    <div class="col-md-12 text-center">
      <div class="form-group">
      <div class="col-sm-12"><form><input type="button" onclick="chLocation('user_add.php');" value="{$i18n.button.add_user}"></form></div>
      </div>
    </div>
  </div>

{/if}
{else}
<table class="table table-responsive table-striped table-hover table-bordered">
  <thead>
  <tr>
    <th>{$i18n.label.person_name}</th>
    <th>{$i18n.label.login}</th>
    <th>{$i18n.form.users.role}</th>
  </tr>
  </thead>
  {foreach $active_users as $u}
  <tr>
    <td>{$u.name|escape:'html'}</td>
    <td>{$u.login|escape:'html'}</td>
    {if $smarty.const.ROLE_MANAGER == $u.role}
    <td>{$i18n.form.users.manager}</td>
    {elseif $smarty.const.ROLE_COMANAGER == $u.role}
    <td>{$i18n.form.users.comanager}</td>
    {elseif $smarty.const.ROLE_CLIENT == $u.role}
    <td>{$i18n.label.client}</td>
    {elseif $smarty.const.ROLE_USER == $u.role}
    <td>{$i18n.label.user}</td>
    {/if}
  </tr>
  {/foreach}
</table>
{/if}
{/if}
    </div>
  </div>
</div>
