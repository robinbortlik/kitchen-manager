App.AdminActionButtonsView = Em.View.extend
  template: Em.TEMPLATES['admin/shared/action_buttons']
  collectionName: null
  formName: null
  actions:
    openForm: (model) ->
      view = App["Admin#{@get('formName')}Form"].create()
      view.set 'content', @get("content")
      view.appendTo("#ember-app")

    destroyResource: ->
      if confirm('Are you sure')
        @get("content").destroyResource().done =>
          unless @get("content.deleted")
            collection = App.get("store.#{@get('collectionName')}")
            collection.removeObject(@get("content"))

    activateResource: ->
      @set("content.deleted", false)
      @get("content").save()