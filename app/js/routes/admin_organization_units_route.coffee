App.AdminOrganizationUnitsRoute = Ember.Route.extend(SimpleAuth,
  setupController: (controller, model) ->
    App.get('store.organizationUnitsCollection').expire()
    Em.run.next =>
      App.get('store.organizationUnitsCollection').fetch()
)


