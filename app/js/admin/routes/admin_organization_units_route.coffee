App.AdminOrganizationUnitsRoute = Ember.Route.extend(
  setupController: (controller, model) ->
    App.get('store.organizationUnitsCollection').expire()
    Em.run.next =>
      App.get('store.organizationUnitsCollection').fetch()
)


