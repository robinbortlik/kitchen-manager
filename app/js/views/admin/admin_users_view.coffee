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
      <thead><th>Name</th><th></th></thead>
      <tbody>
        {{#each view.controller.content}}
          <tr {{bind-attr class="deleted:danger"}}>
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
  background: (-> "background:url(#{@get('content.imageSource')})").property("content.imageSource")
  actions:
    save: ->
      if @get("content").validate()
        isNew = @get("content.isNew")
        @get("content").save().done =>
          @destroy()
          App.get("store.users").pushObject(@get("content")) if isNew

    cancel: ->
      unless @get("content.isNew")
        @get("content").expire()
        @get("content").fetch()
      @destroy()

  template: Em.Handlebars.compile """
    <form class="form-horizontal">
      <div {{bind-attr class=":form-group view.content.validationErrors.first_name.messages:has-error"}}>
        <label class="col-sm-2 control-label">First Name</label>
        <div class="col-sm-10">{{input valueBinding="view.content.first_name" class="form-control" placeholder="First Name"}}</div>
      </div>
      <div {{bind-attr class=":form-group view.content.validationErrors.last_name.messages:has-error"}}>
        <label class="col-sm-2 control-label">Last Name</label>
        <div class="col-sm-10">{{input valueBinding="view.content.last_name" class="form-control" placeholder="Last Name"}}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-2 control-label">Image</label>
        <div class="col-sm-10">{{view App.UploadInput contentBinding="view.content"}}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-2 control-label"></label>
        <div class="col-sm-10">
          <div class="userPhoto" {{bind-attr style="view.background"}}></div>
        </div>
      </div>
    </form>
  """