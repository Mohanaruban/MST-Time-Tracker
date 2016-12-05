<div class="col-sm-8 col-sm-offset-2">
  {$forms.customFieldsForm.open}
  {if $user->canManageTeam()}
  <div class="row">
    <div class="col-sm-12">
      <table class="table table-responsive table-hover table-bordered">
        <thead>
          <tr>
            <th>{$i18n.label.thing_name}</th>
            <th>{$i18n.label.type}</th>
            <th>{$i18n.menu.options}</th>
            <th>{$i18n.label.edit}</th>
            <th>{$i18n.label.delete}</th>
          </tr>
        </thead>
        {if $custom_fields}
        {foreach $custom_fields as $field}
        <tr>
          <td>{$field['label']|escape:'html'}</td>
          {if CustomFields::TYPE_TEXT == $field['type']}
          <td>{$i18n.label.type_text}</td>
          <td></td>
          {elseif CustomFields::TYPE_DROPDOWN == $field['type']}
          <td>{$i18n.label.type_dropdown}</td>
          <td><a href="cf_dropdown_options.php?field_id={$field['id']}">{$i18n.label.configure}</a></td>
          {/if}
          <td><a href="cf_custom_field_edit.php?id={$field['id']}">{$i18n.label.edit}</a></td>
          <td><a href="cf_custom_field_delete.php?id={$field['id']}">{$i18n.label.delete}</a></td>
        </tr>
        {/foreach}
        {/if}
      </table>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12 text-center">
      <div class="form-group">
        <div class="col-sm-12">{$forms.customFieldsForm.btn_add.control}</div>
      </div>
    </div>
  </div>
  {/if}
  {$forms.customFieldsForm.close}
</div>