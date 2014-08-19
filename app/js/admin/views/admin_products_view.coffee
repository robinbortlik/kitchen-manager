App.AdminProductsView = Em.View.extend
  template: Em.TEMPLATES['admin/products/index']
  layout: Em.TEMPLATES['admin/layouts/admin_layout']
  actions:
    openForm: (model) ->
      view = App.AdminProductForm.create()
      product = App.Product.create()
      view.set 'content', product
      view.appendTo("#ember-app")


App.AdminProductForm = Em.View.extend
  template: Em.TEMPLATES['admin/products/form']
  layout: Em.TEMPLATES['layouts/modal_layout']
  contextBinding: 'content'
  background: (-> "background:url(#{@get('content.imageSource')})").property("content.imageSource")
  title: (-> if @get("content.isNew") then 'Create Product' else 'Edit Product' ).property('content')

  actions:
    save: ->
      if @get("content").validate()
        isNew = @get("content.isNew")
        @get("content").save().done =>
          @destroy()
          @set("content.image", null)
          App.get("store.products").pushObject(@get("content")) if isNew

    cancel: ->
      unless @get("content.isNew")
        @get("content").expire()
        @get("content").fetch()
      @destroy()