App.AdminProductsView = Em.View.extend
  layout: App.AdminLayoutView.template
  actions:
    openForm: (model) ->
      view = App.AdminProductForm.create()
      product = App.Product.create()
      view.set 'content', product
      view.appendTo("#ember-app")

  template: Em.Handlebars.compile """
    <h1>Products</h1>
    <p>
      <button type="button" class="btn btn-primary" {{action 'openForm' target='view'}}>
        <span class="glyphicon glyphicon-plus"></span> New
      </button>
    </p>
    <table class="table table-hover table-bordered">
      <thead><th>Id</th><th>Name</th><th>Price</th><th></th></thead>
      <tbody>
        {{#each view.controller.content}}
          <tr {{bind-attr class="deleted:danger"}}>
            <td>{{id}}</td>
            <td>{{name}}</td>
            <td>{{price}}</td>
            <td>{{view App.AdminProductActionButtons contentBinding="this"}}</td>
          </tr>
        {{/each}}
      </tbody>
    </table>
  """


App.AdminProductActionButtons = Em.View.extend
  actions:
    openForm: (model) ->
      view = App.AdminProductForm.create()
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

App.AdminProductForm = Em.View.extend
  layout: App.ModalLayoutView.template
  contextBinding: 'content'
  title: (-> if @get("content.isNew") then 'Create Product' else 'Edit Product' ).property('content')

  actions:
    save: ->
      isNew = @get("content.isNew")
      @get("content").save().done =>
        @destroy()
        App.get("store.products").pushObject(@get("content")) if isNew

    cancel: -> @destroy()

  template: Em.Handlebars.compile """
    <form class="form-horizontal">
      <div class="form-group">
        <label class="col-sm-2 control-label">Name</label>
        <div class="col-sm-10">{{input valueBinding="view.content.name" class="form-control" placeholder="Name"}}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-2 control-label">Price</label>
        <div class="col-sm-10">{{input valueBinding="view.content.price" class="form-control" placeholder="Price"}}</div>
      </div>
      <div class="form-group">
        <label class="col-sm-2 control-label">Image</label>
        <div class="col-sm-10">{{view App.UploadInput contentBinding="view.content"}}</div>
      </div>
    </form>
  """