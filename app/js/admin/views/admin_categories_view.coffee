App.AdminCategoriesView = Em.View.extend
  template: Em.TEMPLATES['admin/categories/index']
  layout: Em.TEMPLATES['admin/layouts/admin_layout']
  actions:
    openForm: (model) ->
      view = App.AdminCategoryForm.create()
      category = App.Category.create()
      view.set 'content', category
      view.appendTo("#ember-app")


App.AdminCategoryForm = Em.View.extend
  template: Em.TEMPLATES['admin/categories/form']
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