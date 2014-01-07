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
    <div class="modal fade in" style="display:block;" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" aria-hidden="true" {{action "cancel" target="view"}}>&times;</button>
            <h4 class="modal-title">{{view.title}}</h4>
          </div>
          <div class="modal-body">
            {{yield}}
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" {{action "cancel" target="view"}}>Close</button>
            <button type="button" class="btn btn-primary" {{action "save" target="view"}}>Save changes</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <div class="modal-backdrop fade in"></div>
  """

App.LargeModalLayoutView =
  template: Em.Handlebars.compile """
    <div class="modal fade in" style="display:block;" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog large">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" aria-hidden="true" {{action "cancel" target="view"}}>&times;</button>
            <h4 class="modal-title">{{view.title}}</h4>
          </div>
          <div class="modal-body">
            {{yield}}
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <div class="modal-backdrop fade in"></div>
  """