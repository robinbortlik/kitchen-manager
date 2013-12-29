App.AdminLayoutView =
  template: Em.Handlebars.compile """
    <ol class="breadcrumb">
      <li>{{#link-to 'users'}}Home{{/link-to}}</li>
      <li>{{#link-to 'adminOverview'}}Overview{{/link-to}}</li>
      <li>{{#link-to 'adminUsers'}}Users{{/link-to}}</li>
      <li>{{#link-to 'adminProducts'}}Products{{/link-to}}</li>
    </ol>
    {{yield}}
  """

App.ModalLayoutView =
  template: Em.Handlebars.compile """
    <div class="modal fade in" style="display:block;" aria-hidden="false">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" aria-hidden="true" {{action "destroy" target="view"}}>&times;</button>
            <h4 class="modal-title">Modal title</h4>
          </div>
          <div class="modal-body">
            {{yield}}
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" {{action "destroy" target="view"}}>Close</button>
            <button type="button" class="btn btn-primary" {{action "save" target="view"}}>Save changes</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

  """