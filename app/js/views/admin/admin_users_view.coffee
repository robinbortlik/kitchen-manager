App.AdminUsersView = Em.View.extend
  layout: Em.TEMPLATES['admin/layouts/admin_layout']
  actions:
    openForm: (model) ->
      view = App.AdminUserForm.create()
      user = App.User.create()
      view.set 'content', user
      view.appendTo("#ember-app")

  template: Em.TEMPLATES['admin/users/index']


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

  template: Em.TEMPLATES['admin/users/action_buttons']

App.AdminUserForm = Em.View.extend
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
          App.get("store.users").pushObject(@get("content")) if isNew

    cancel: ->
      unless @get("content.isNew")
        @get("content").expire()
        @get("content").fetch()
      @destroy()

  template: Em.TEMPLATES['admin/users/form']