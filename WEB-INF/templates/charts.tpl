<div class="col-sm-8 col-sm-offset-2 text-center">
  {$forms.chartForm.open}
  <div class="row">
    <div class="col-sm-6">
      {if $on_behalf_control}
      <div class="col-sm-12">
        <div class="form-group">
          <label class="col-sm-3 control-label">{$i18n.label.user}</label>
          <div class="col-sm-9">{$forms.chartForm.onBehalfUser.control}</div>
        </div>
      </div>
      {/if}
      {if $chart_selector}
      <div class="col-sm-12">
        <div class="form-group">
          <label class="col-sm-3 control-label">{$i18n.form.charts.chart}</label>
          <div class="col-sm-9">{$forms.chartForm.type.control}</div>
        </div>
      </div>
      {/if}
      <div class="col-md-12">
        <div class="form-group">
          <label class="col-sm-3 control-label">{$i18n.form.charts.interval}</label>
          <div class="col-sm-9">{$forms.chartForm.interval.control}</div>
        </div>
      </div>
    </div>
    <div class="col-sm-6">
      <div class="form-group">
        <div class="col-sm-9 col-sm-offset-3">{$forms.chartForm.date.control}</div>
      </div>
    </div>
  </div>

  <div class="clearfix"></div>

  <div class="row">
    <div class="col-md-12">
      {section name=i loop=$totals}
      {if $smarty.section.i.index <= 12}
      <div class="col-md-12">
      <label style="color: {$totals[i].color_html}" class="h4">&#9632;</label> {$totals[i].name|escape:'html'}
      </div>
      {/if}
      {/section}<br/>
      <img src="{$img_file_name}" border="0"/>
    </div>
  </div>
  {$forms.chartForm.close}
</div> 