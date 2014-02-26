App.AdminCategoriesView = Em.View.extend
  layout: Em.TEMPLATES['admin/layouts/admin_layout']
  actions:
    openForm: (model) ->
      view = App.AdminCategoryForm.create()
      category = App.Category.create()
      view.set 'content', category
      view.appendTo("#ember-app")

  template: Em.TEMPLATES['admin/categories/index']


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

  template: Em.TEMPLATES['admin/categories/action_buttons']


App.AdminCategoryForm = Em.View.extend
  layout: Em.TEMPLATES['admin/layouts/modal_layout']
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

  template: Em.TEMPLATES['admin/categories/form']