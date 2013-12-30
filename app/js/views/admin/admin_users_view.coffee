App.AdminUsersView = Em.View.extend
  layout: App.AdminLayoutView.template
  actions:
    openForm: (model) ->
      view = App.AdminUserForm.create()
      user = App.User.create()
      view.set 'content', user
      view.appendTo("#ember-app")

  template: Em.Handlebars.compile """
    <h1>Users</h1>
    <p>
      <button type="button" class="btn btn-primary" {{action 'openForm' target='view'}}>
        <span class="glyphicon glyphicon-plus"></span> New
      </button>
    </p>
    <table class="table table-hover table-bordered">
      <thead><th>Id</th><th>Name</th><th></th></thead>
      <tbody>
        {{#each view.controller.content}}
          <tr {{bind-attr class="deleted:danger"}}>
            <td>{{id}}</td>
            <td>{{name}}</td>
            <td>{{view App.AdminUserActionButtons contentBinding="this"}}</td>
          </tr>
        {{/each}}
      </tbody>
    </table>
  """


App.AdminUserActionButtons = Em.View.extend
  actions:
    openForm: (model) ->
      view = App.AdminUserForm.create()
      view.set 'content', @get("content")
      view.appendTo("#ember-app")

    destroyResource: ->
      @set("content.deleted", true)
      @get("content").save()

    activateResource: ->
      @set("content.deleted", false)
      @get("content").save()

  template: Em.Handlebars.compile """
    {{#if deleted}}
      <span class="glyphicon glyphicon-refresh" {{action "activateResource" target="view"}}></span>
    {{else}}
      <span class="glyphicon glyphicon-pencil" {{action "openForm" target="view"}}></span>
      <span class="glyphicon glyphicon-trash" {{action "destroyResource" target="view"}}></span>
    {{/if}}
  """

App.AdminUserForm = Em.View.extend
  layout: App.ModalLayoutView.template
  contextBinding: 'content'
  title: (-> if @get("content.isNew") then 'Create User' else 'Edit User' ).property('content')
  actions:
    save: ->
      isNew = @get("content.isNew")
      @get("content").save().done =>
        @destroy()
        App.get("store.users").pushObject(@get("content")) if isNew

    cancel: -> @destroy()

  template: Em.Handlebars.compile """
    <form class="form-horizontal">
      <div class="form-group">
        <label class="col-sm-2 control-label">Name</label>
        <div class="col-sm-10">{{input valueBinding="view.content.name" class="form-control" placeholder="Name"}}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-2 control-label">Image</label>
        <div class="col-sm-10">{{view App.UploadInput contentBinding="view.content"}}</div>
      </div>
    </form>
  """