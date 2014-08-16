App.AdminUsersView = Em.View.extend
  template: Em.TEMPLATES['admin/users/index']
  layout: Em.TEMPLATES['admin/layouts/admin_layout']
  actions:
    openForm: (model) ->
      view = App.AdminUserForm.create()
      user = App.User.create()
      view.set 'content', user
      view.appendTo("#ember-app")


App.AdminUserForm = Em.View.extend
  template: Em.TEMPLATES['admin/users/form']
  layout: Em.TEMPLATES['admin/layouts/modal_layout']
  contextBinding: 'content'
  title: (-> if @get("content.isNew") then 'Create User' else 'Edit User' ).property('content')
  background: (-> "background:url(#{@get('content.imageSource')})").property("content.imageSource")
  actions:
    save: ->
      if @get("content").validate()
        isNew = @get("content.isNew")
        @get("content").save().done =>
          @destroy()
          @set("content.image", null)
          App.get("store.users").pushObject(@get("content")) if isNew

    cancel: ->
      unless @get("content.isNew")
        @get("content").expire()
        @get("content").fetch()
      @destroy()

