App.AdminProductsView = Em.View.extend
  layout: Em.TEMPLATES['admin/layouts/admin_layout']
  actions:
    openForm: (model) ->
      view = App.AdminProductForm.create()
      product = App.Product.create()
      view.set 'content', product
      view.appendTo("#ember-app")

  template: Em.TEMPLATES['admin/products/index']


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

  template: Em.TEMPLATES['admin/products/action_buttons']

App.AdminProductForm = Em.View.extend
  layout: Em.TEMPLATES['admin/layouts/modal_layout']
  contextBinding: 'content'
  background: (-> "background:url(#{@get('content.imageSource')})").property("content.imageSource")
  title: (-> if @get("content.isNew") then 'Create Product' else 'Edit Product' ).property('content')

  actions:
    save: ->
      if @get("content").validate()
        isNew = @get("content.isNew")
        @get("content").save().done =>
          @destroy()
          App.get("store.products").pushObject(@get("content")) if isNew

    cancel: ->
      unless @get("content.isNew")
        @get("content").expire()
        @get("content").fetch()
      @destroy()

  template: Em.TEMPLATES['admin/products/form']