<div class="col-sm-8 col-sm-offset-2">
{$forms.expenseItemForm.open}
  <div class="row">
    <div class="col-sm-12">
  <table class="table table-responsive table-striped table-hover table-bordered">
  <tr>
  <thead>
{if $user->isPluginEnabled('cl')}
    <th>{$i18n.label.client}</th>
{/if}

{if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
    <th>{$i18n.label.project}</th>
{/if}
    <th>{$i18n.label.item}</th>
    <th>{$i18n.label.cost}</th>
  </tr>
  </thead>
  <tr>
{if $user->isPluginEnabled('cl')}
  <td>{$expense_item.client_name|escape:'html'}</td>
{/if}
{if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
    <td>{$expense_item.project_name|escape:'html'}</td>
{/if}
    <td>{$expense_item.name|escape:'html'}</td>
    <td align="right">{$expense_item.cost}</td>
  </tr>
  </table>
  
  </div>
  </div>
    <div class="row">
    <div class="col-sm-12">
  <table width="100%">
  <tr>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">{$forms.expenseItemForm.delete_button.control}&nbsp;&nbsp;{$forms.expenseItemForm.cancel_button.control}</td>
  </tr>
  </table>
  </div>
  </div>
{$forms.expenseItemForm.close}
</div>