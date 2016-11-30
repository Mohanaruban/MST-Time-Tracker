<script>
  function chLocation(newLocation) { document.location = newLocation; }
</script>
<div class="col-sm-12 text-center">
  {$forms.reportForm.open}
  <div class="row">
    <table class="table table-responsive table-hover table-bordered report-table">
      <!-- totals only report -->
      {if $bean->getAttribute('chtotalsonly')}
      <thead>
      <tr>
        <th>{$group_by_header|escape:'html'}</th>
        {if $group_by == 'user'} 
          <th>Projects</th>
        {/if}
        {if $bean->getAttribute('chduration')}
          <th>{$i18n.label.duration}</th>
        {/if}
        {if $bean->getAttribute('chcost')}
          <th>{$i18n.label.cost}</th>
        {/if}
        {if $group_by == 'user'} 
          <th>Utilization</th>
        {/if}
      </tr>
      </thead>
      {foreach $subtotals as $subtotal}
      <tr class="table-total-group">
        <td>{if $subtotal['name']}{$subtotal['name']|escape:'html'}{else}&nbsp;{/if}</td>
        {if $group_by == 'user'} 
        <td>{$subtotal['projects']}</td>
        {/if}
        {if $bean->getAttribute('chduration')}
          <td>{$subtotal['time']}</td>
        {/if}
        {if $group_by == 'user'} 
        <td>{$subtotal['util']}%</td>
        {/if}
        {if $bean->getAttribute('chcost')}<td>{if $user->canManageTeam() || $user->isClient()}{$subtotal['cost']}{else}{$subtotal['expenses']}{/if}</td>{/if}
      </tr>
      {/foreach}
      <!-- print totals -->
      {if $group_by != 'user'}
      <tr><td>&nbsp;</td></tr>
      <tr class="table-total">
        <td>{$i18n.label.total}</td>
        {if $bean->getAttribute('chduration')}<td nowrap>{$totals['time']}</td>{/if}
        {if $bean->getAttribute('chcost')}<td nowrap>{$user->currency|escape:'html'} {if $user->canManageTeam() || $user->isClient()}{$totals['cost']}{else}{$totals['expenses']}{/if}</td>{/if}
      </tr>
      {/if}
      {else}
      <!-- normal report -->
      <thead>
      <tr>
        <th>{$i18n.label.date}</th>
        {if $user->canManageTeam() || $user->isClient()}<th>{$i18n.label.user}</th>{/if}
        {if $bean->getAttribute('chclient')}<th>{$i18n.label.client}</th>{/if}
        {if $bean->getAttribute('chproject')}<th>{$i18n.label.project}</th>{/if}
        {if $bean->getAttribute('chtask')}<th>{$i18n.label.task}</th>{/if}
        {if $bean->getAttribute('chcf_1')}<th>{$custom_fields->fields[0]['label']|escape:'html'}</th>{/if}
        {if $bean->getAttribute('chstart')}<th>{$i18n.label.start}</th>{/if}
        {if $bean->getAttribute('chfinish')}<th>{$i18n.label.finish}</th>{/if}
        {if $bean->getAttribute('chduration')}<th>{$i18n.label.duration}</th>{/if}
        {if $bean->getAttribute('chnote')}<th>{$i18n.label.note}</th>{/if}
        {if $bean->getAttribute('chcost')}<th>{$i18n.label.cost}</th>{/if}
        {if $bean->getAttribute('chinvoice')}<th>{$i18n.label.invoice}</th>{/if}
      </tr>
      </thead>
      {foreach $report_items as $item}
      <!-- print subtotal for a block of grouped values -->
      {$cur_date = $item.date}
      {if $print_subtotals}
      {$cur_grouped_by = $item.grouped_by}
      {if $cur_grouped_by != $prev_grouped_by && !$first_pass}
      <tr class="warning">
        <td>{$i18n.label.subtotal}
          {if $user->canManageTeam() || $user->isClient()}<td>{if $group_by == 'user'}{$subtotals[$prev_grouped_by]['name']|escape:'html'}</td>{/if}{/if}
          {if $bean->getAttribute('chclient')}<td>{if $group_by == 'client'}{$subtotals[$prev_grouped_by]['name']|escape:'html'}</td>{/if}{/if}
          {if $bean->getAttribute('chproject')}<td>{if $group_by == 'project'}{$subtotals[$prev_grouped_by]['name']|escape:'html'}</td>{/if}{/if}
          {if $bean->getAttribute('chtask')}<td>{if $group_by == 'task'}{$subtotals[$prev_grouped_by]['name']|escape:'html'}</td>{/if}{/if}
          {if $bean->getAttribute('chcf_1')}<td>{if $group_by == 'cf_1'}{$subtotals[$prev_grouped_by]['name']|escape:'html'}</td>{/if}{/if}
          {if $bean->getAttribute('chstart')}<td></td>{/if}
          {if $bean->getAttribute('chfinish')}<td></td>{/if}
          {if $bean->getAttribute('chduration')}<td>{$subtotals[$prev_grouped_by]['time']}</td>{/if}
          {if $bean->getAttribute('chnote')}<td></td>{/if}
          {if $bean->getAttribute('chcost')}<td>{if $user->canManageTeam() || $user->isClient()}{$subtotals[$prev_grouped_by]['cost']}{else}{$subtotals[$prev_grouped_by]['expenses']}{/if}</td>{/if}
          {if $bean->getAttribute('chinvoice')}<td></td>{/if}
        </tr>
        <tr><td>&nbsp;</td></tr>
        {/if}
        {$first_pass = false}
        {/if}
        <!--  print regular row --> 
        {if $cur_date != $prev_date}
        {if $report_row_class == 'rowReportItem'} {$report_row_class = 'rowReportItemAlt'} {else} {$report_row_class = 'rowReportItem'} {/if}
        {/if}
        <tr>
          <td>{$item.date}</td>
          {if $user->canManageTeam() || $user->isClient()}<td>{$item.user|escape:'html'}</td>{/if}
          {if $bean->getAttribute('chclient')}<td>{$item.client|escape:'html'}</td>{/if}
          {if $bean->getAttribute('chproject')}<td>{$item.project|escape:'html'}</td>{/if}
          {if $bean->getAttribute('chtask')}<td>{$item.task|escape:'html'}</td>{/if}
          {if $bean->getAttribute('chcf_1')}<td>{$item.cf_1|escape:'html'}</td>{/if}
          {if $bean->getAttribute('chstart')}<td>{$item.start}</td>{/if}
          {if $bean->getAttribute('chfinish')}<td>{$item.finish}</td>{/if}
          {if $bean->getAttribute('chduration')}<td>{$item.duration}</td>{/if}
          {if $bean->getAttribute('chnote')}<td>{$item.note|escape:'html'}</td>{/if}
          {if $bean->getAttribute('chcost')}<td>{if $user->canManageTeam() || $user->isClient()}{$item.cost}{else}{$item.expense}{/if}</td>{/if}
          {if $bean->getAttribute('chinvoice')}
          <td>{$item.invoice|escape:'html'}</td>
          {if $use_checkboxes}
          {if 1 == $item.type}<td bgcolor="white"><input type="checkbox" name="log_id_{$item.id}"></td>{/if}
          {if 2 == $item.type}<td bgcolor="white"><input type="checkbox" name="item_id_{$item.id}"></td>{/if}
          {/if}
          {/if}
        </tr>
        {$prev_date = $item.date}
        {if $print_subtotals} {$prev_grouped_by = $item.grouped_by} {/if}
        {/foreach}
        <!-- print a terminating subtotal -->
        {if $print_subtotals}
        <tr class="warning">
          <td>{$i18n.label.subtotal}
            {if $user->canManageTeam() || $user->isClient()}<td>{if $group_by == 'user'}{$subtotals[$cur_grouped_by]['name']|escape:'html'}</td>{/if}{/if}
            {if $bean->getAttribute('chclient')}<td>{if $group_by == 'client'}{$subtotals[$cur_grouped_by]['name']|escape:'html'}</td>{/if}{/if}
            {if $bean->getAttribute('chproject')}<td>{if $group_by == 'project'}{$subtotals[$cur_grouped_by]['name']|escape:'html'}</td>{/if}{/if}
            {if $bean->getAttribute('chtask')}<td>{if $group_by == 'task'}{$subtotals[$cur_grouped_by]['name']|escape:'html'}</td>{/if}{/if}
            {if $bean->getAttribute('chcf_1')}<td>{if $group_by == 'cf_1'}{$subtotals[$cur_grouped_by]['name']|escape:'html'}</td>{/if}{/if}
            {if $bean->getAttribute('chstart')}<td></td>{/if}
            {if $bean->getAttribute('chfinish')}<td></td>{/if}
            {if $bean->getAttribute('chduration')}<td>{$subtotals[$cur_grouped_by]['time']}</td>{/if}
            {if $bean->getAttribute('chnote')}<td></td>{/if}
            {if $bean->getAttribute('chcost')}<td>{if $user->canManageTeam() || $user->isClient()}{$subtotals[$cur_grouped_by]['cost']}{else}{$subtotals[$cur_grouped_by]['expenses']}{/if}</td>{/if}
            {if $bean->getAttribute('chinvoice')}<td></td>{/if}
          </tr>
          {/if}
          <!-- print totals -->
          <tr><td>&nbsp;</td></tr>
          <tr class="info table-total">
            <td>{$i18n.label.total}</td>
            {if $user->canManageTeam() || $user->isClient()}<td></td>{/if}
            {if $bean->getAttribute('chclient')}<td></td>{/if}
            {if $bean->getAttribute('chproject')}<td></td>{/if}
            {if $bean->getAttribute('chtask')}<td></td>{/if}
            {if $bean->getAttribute('chcf_1')}<td></td>{/if}
            {if $bean->getAttribute('chstart')}<td></td>{/if}
            {if $bean->getAttribute('chfinish')}<td></td>{/if}
            {if $bean->getAttribute('chduration')}<td>{$totals['time']}</td>{/if}
            {if $bean->getAttribute('chnote')}<td></td>{/if}
            {if $bean->getAttribute('chcost')}<td nowrap>{$user->currency|escape:'html'} {if $user->canManageTeam() || $user->isClient()}{$totals['cost']}{else}{$totals['expenses']}{/if}</td>{/if}
            {if $bean->getAttribute('chinvoice')}<td></td>{/if}
          </tr>
          {/if}
        </table>
      </div>
      <div class="row">
        {if $use_checkboxes && $report_items}
        <table class="table table-responsive table-hover table-bordered">
          <tr>
            <td align="right">
              <table>
                <tr><td>{$forms.reportForm.recent_invoice.control} {$forms.reportForm.btn_submit.control}</td></tr>
              </table>
            </td>
          </tr>
        </table>
        {/if}
        {$forms.reportForm.close}
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-md-12 text-center">
      <input type="button" class="btn btn-success" onclick="chLocation('report_send.php');" value="{$i18n.button.send_by_email}"/>
      {if file_exists('WEB-INF/lib/tcpdf')}<a class="btn btn-info" href="topdf.php">Export as PDF</a>{/if} <a class="btn btn-warning" href="tofile.php?type=xml">Export as XML</a> <a class="btn btn-primary" href="tofile.php?type=csv">Export as CSV</a> <a class="btn btn-info" href="reports.php">Back to reports</a><br/><br/>
    </div>
  </div>
</div>
</div>