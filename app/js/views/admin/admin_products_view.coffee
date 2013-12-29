App.AdminProductsView = Em.View.extend
  layout: App.AdminLayoutView.template
  openForm: (model) ->
    view = App.AdminProductForm.create()
    product = App.Product.create()
    view.set 'content', product
    view.appendTo("#ember-app")

  template: Em.Handlebars.compile """
    <h1>Products</h1>
    <button type="button" class="btn btn-primary" {{action 'openForm' target='view'}}>New</button>
    <table class="table table-striped">
      <thead><th>Id</th><th>Name</th><th>Price</th></thead>
      <tbody>
        {{#each view.controller.content}}
          <tr>
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
  openForm: (model) ->
    view = App.AdminProductForm.create()
    view.set 'content', @get("content")
    view.appendTo("#ember-app")

  destroyResource: ->
    @get("content").destroyResource()
    App.get("store.products").removeObject(@get("content"))

  template: Em.Handlebars.compile """
    <span class="glyphicon glyphicon-pencil" {{action "openForm" target="view"}}></span>
    <span class="glyphicon glyphicon-trash" {{action "destroyResource" target="view"}}></span>
  """

App.AdminProductForm = Em.View.extend
  layout: App.ModalLayoutView.template
  contextBinding: 'content'
  save: ->
    isNew = @get("content.isNew")
    @get("content").save().done =>
      @destroy()
      App.get("store.products").pushObject(@get("content")) if isNew

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