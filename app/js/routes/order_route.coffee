App.OrderRoute = Ember.Route.extend(
  setupController: (controller, model) ->
    App.set "currentUser", App.get('store.usersCollection.content').findBy('id', parseInt(model.id))
    App.set("cart.content", [])
    controller.set "cart", App.get("cart")
)