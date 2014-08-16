App.UsersRoute = Ember.Route.extend(
  setupController: (controller, model) ->
    controller.set "filteredText", ""
    orgId = localStorage.getItem("organizationUnitId") || App.get('store.organizationUnits.0.id')
    controller.set("organizationUnitId", parseInt(orgId)) if orgId

  activate: -> $(document).scrollTop(0)
)