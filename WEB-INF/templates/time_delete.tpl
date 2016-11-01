<div class="col-sm-8 col-sm-offset-2">
  <div class="row">
    <div class="col-sm-12">
      {$forms.timeRecordForm.open}
      <table class="table table-responsive table-striped table-hover table-bordered">
        <thead>
          <tr>
            {if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
            <th align="center">{$i18n.label.project}</th>
            {/if}
            {if ($smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
            <th align="center">{$i18n.label.task}</th>
            {/if}
            {if (($smarty.const.TYPE_START_FINISH == $user->record_type) || ($smarty.const.TYPE_ALL == $user->record_type))}
            <th align="center">{$i18n.label.start}</th>
            <th align="center">{$i18n.label.finish}</th>
            {/if}
            {if (($smarty.const.TYPE_DURATION == $user->record_type) || ($smarty.const.TYPE_ALL == $user->record_type))}
            <th align="center">{$i18n.label.duration}</th>
            {/if}
            <th align="center">{$i18n.label.note}</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            {if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
            <td>{$time_rec.project_name|escape:'html'}</td>
            {/if}
            {if ($smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
            <td>{$time_rec.task_name|escape:'html'}</td>
            {/if}
            {if (($smarty.const.TYPE_START_FINISH == $user->record_type) || ($smarty.const.TYPE_ALL == $user->record_type))}
            <td>{if $time_rec.start}{$time_rec.start}{else}&nbsp;{/if}</td>
            <td>{if $time_rec.finish<>$time_rec.start}{$time_rec.finish}{else}&nbsp;{/if}</td>
            {/if}
            {if (($smarty.const.TYPE_DURATION == $user->record_type) || ($smarty.const.TYPE_ALL == $user->record_type))}
            <td>{if ($time_rec.duration == '0:00' && $time_rec.start <> '')}<font color="#ff0000">{$i18n.form.time.uncompleted}</font>{else}{$time_rec.duration}{/if}</td>
            {/if}
            <td>{if $time_rec.comment}{$time_rec.comment|escape:'html'}{else}&nbsp;{/if}</td>
          </tr>
        </tbody>
      </table>
      <table width="100%">
        <tr>
          <td align="center">&nbsp;</td>
        </tr>
        <tr>
          <td align="center">{$forms.timeRecordForm.delete_button.control}&nbsp;&nbsp;{$forms.timeRecordForm.cancel_button.control}</td>
        </tr>
      </table>
      {$forms.timeRecordForm.close}
    </div>
  </div>
</div>