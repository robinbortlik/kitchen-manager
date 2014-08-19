App.AdminOrganizationUnitsView = Em.View.extend
  template: Em.TEMPLATES['admin/organization_units/index']
  layout: Em.TEMPLATES['admin/layouts/admin_layout']
  actions:
    openForm: (model) ->
      view = App.AdminOrganizationUnitForm.create()
      category = App.OrganizationUnit.create()
      view.set 'content', category
      view.appendTo("#ember-app")


App.AdminOrganizationUnitForm = Em.View.extend
  template: Em.TEMPLATES['admin/organization_units/form']
  layout: Em.TEMPLATES['layouts/modal_layout']
  contextBinding: 'content'
  title: (-> if @get("content.isNew") then 'Create Organization Unit' else 'Edit Organization Unit' ).property('content')

  actions:
    save: ->
      if @get("content").validate()
        isNew = @get("content.isNew")
        @get("content").save().done =>
          @destroy()
          App.get("store.organizationUnits").pushObject(@get("content")) if isNew

    cancel: ->
      unless @get("content.isNew")
        @get("content").expire()
        @get("content").fetch()
      @destroy()