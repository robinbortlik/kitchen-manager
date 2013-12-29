App.AdminOverviewRoute = Ember.Route.extend(
  model: ->
    App.get('store.productUsersCollection').expire()
    App.get('store.productUsersCollection').fetch()
)


