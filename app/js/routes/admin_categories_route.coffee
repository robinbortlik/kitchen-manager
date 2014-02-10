App.AdminCategoriesRoute = Ember.Route.extend(SimpleAuth,
  setupController: (controller, model) ->
    App.get('store.categoriesCollection').expire()
    Em.run.next =>
      App.get('store.categoriesCollection').fetch()
)


