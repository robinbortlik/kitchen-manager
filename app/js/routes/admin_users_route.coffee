App.AdminUsersRoute = Ember.Route.extend(SimpleAuth,
  setupController: (controller, model) ->
    App.get('store.usersCollection').expire()
    Em.run.next =>
      App.get('store.usersCollection').fetch()
)


