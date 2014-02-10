App.AdminProductsRoute = Ember.Route.extend(SimpleAuth,
  setupController: (controller, model) ->
    App.get('store.productsCollection').expire()
    Em.run.next =>
      App.get('store.productsCollection').fetch()
)


