App.AdminCategoriesRoute = Ember.Route.extend(
  setupController: (controller, model) ->
    App.get('store.categoriesCollection').expire()
    Em.run.next =>
      App.get('store.categoriesCollection').fetch()
)


