App.UsersController = Ember.Controller.extend(
  contentBinding: 'App.store.users'
  organizationUnitId: null
  filteredText: null
  organizationsBinding: 'App.store.organizationUnits'

  actions:
    changeOrganization: (e) ->
      localStorage.setItem("organizationUnitId", e.data.id)
      @set 'organizationUnitId', e.data.id

  activeUsers: (->
    @get("content").filter (i) => (@get('organizationUnitId') == i.get('organization_unit_id')) && not i.get("deleted")
  ).property("content.@each.deleted", "organizationUnitId")

  chunkedUsers: (-> @get("selectedUsers").chunk(6) ).property("selectedUsers")

  filteredTextObserver: (->
    App.set 'filteredText', @get('filteredText').replace(" ","").removeDiacritics().toUpperCase()
  ).observes('filteredText')

  selectedUsers: (->
    @get("activeUsers").filterBy("visible")
  ).property("activeUsers.@each.visible")

  organizationUnit: (->
    App.get('store.organizationUnits').findProperty('id', @get('organizationUnitId'))
  ).property('organizationUnitId')

)
