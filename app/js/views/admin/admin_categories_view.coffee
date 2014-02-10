App.AdminCategoriesView = Em.View.extend
  layout: App.AdminLayoutView.template
  actions:
    openForm: (model) ->
      view = App.AdminCategoryForm.create()
      category = App.Category.create()
      view.set 'content', category
      view.appendTo("#ember-app")

  template: Em.Handlebars.compile """
    <h1>Categories</h1>
    <p>
      <button type="button" class="btn btn-primary" {{action 'openForm' target='view'}}>
        <span class="glyphicon glyphicon-plus"></span> New
      </button>
    </p>
    <table class="table table-hover table-bordered">
      <thead><th>Position</th><th>Name</th><th></th></thead>
      <tbody>
        {{#each view.controller.content}}
          <tr {{bind-attr class="deleted:danger"}}>
            <td>{{position}}</td>
            <td>{{name}}</td>
            <td>{{view App.AdminCategoryActionButtons contentBinding="this"}}</td>
          </tr>
        {{/each}}
      </tbody>
    </table>
  """


App.AdminCategoryActionButtons = Em.View.extend
  actions:
    openForm: (model) ->
      view = App.AdminCategoryForm.create()
      view.set 'content', @get("content")
      view.appendTo("#ember-app")

    destroyResource: ->
      if confirm('Are you sure')
        @get("content").destroyResource().done =>
          App.get('store.categories').removeObject(@get("content"))


  template: Em.Handlebars.compile """
    {{#if deleted}}
      <span class="glyphicon glyphicon-refresh" {{action "activateResource" target="view"}}></span>
    {{else}}
      <span class="glyphicon glyphicon-pencil" {{action "openForm" target="view"}}></span>
      <span class="glyphicon glyphicon-trash" {{action "destroyResource" target="view"}}></span>
    {{/if}}
  """

App.AdminCategoryForm = Em.View.extend
  layout: App.ModalLayoutView.template
  contextBinding: 'content'
  title: (-> if @get("content.isNew") then 'Create Category' else 'Edit Category' ).property('content')

  actions:
    save: ->
      if @get("content").validate()
        isNew = @get("content.isNew")
        @get("content").save().done =>
          @destroy()
          App.get("store.categories").pushObject(@get("content")) if isNew

    cancel: ->
      unless @get("content.isNew")
        @get("content").expire()
        @get("content").fetch()
      @destroy()

  template: Em.Handlebars.compile """
    <form class="form-horizontal">
      <div {{bind-attr class=":form-group view.content.validationErrors.name.messages:has-error"}}>
        <label class="col-sm-2 control-label">Name</label>
        <div class="col-sm-10">{{input valueBinding="view.content.name" class="form-control" placeholder="Name"}}</div>
      </div>
      <div {{bind-attr class=":form-group view.content.validationErrors.position.messages:has-error"}}>
        <label class="col-sm-2 control-label">Position</label>
        <div class="col-sm-10">{{input valueBinding="view.content.position" class="form-control" placeholder="Position (number)"}}</div>
      </div>
    </form>
  """