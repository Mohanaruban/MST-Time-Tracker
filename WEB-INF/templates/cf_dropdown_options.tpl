<script>
  function chLocation(newLocation) { document.location = newLocation; }
</script>
<div class="col-sm-8 col-sm-offset-2">
  {$forms.dropdownOptionsForm.open}
  {if $user->canManageTeam()}
  <div class="row">
    <div class="col-sm-12">
      <table class="table table-responsive table-striped table-hover table-bordered">
        <thead>
          <tr>
            <th>{$i18n.label.thing_name}</th>
            <th>{$i18n.label.edit}</th>
            <th>{$i18n.label.delete}</th>
          </tr>
        </thead>
        {if $options}
        {foreach $options as $key=>$val}
        <tr>
          <td>{$val|escape:'html'}</td>
          <td><a href="cf_dropdown_option_edit.php?id={$key}">{$i18n.label.edit}</a></td>
          <td><a href="cf_dropdown_option_delete.php?id={$key}">{$i18n.label.delete}</a></td>
        </tr>
        {/foreach}
        {/if}
      </table>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div class="form-group">
        <div class="col-sm-12 text-center"><form>
          <input type="button" class="btn btn-success" onclick="chLocation('cf_dropdown_option_add.php?field_id={$field_id}');" value="{$i18n.button.add_option}">
        </form></div>
      </div>
    </div>
  </div>
  {/if}
  {$forms.dropdownOptionsForm.close}
</div>