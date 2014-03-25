App.OrderRoute = Ember.Route.extend(
  setupController: (controller, model) ->
    App.set "currentUser", App.get('store.usersCollection.content').findBy('id', parseInt(model.id))
    App.get("currentUser").loadFavourites()
    App.set("cart.content", [])
    controller.set "cart", App.get("cart")

  activate: -> $(document).scrollTop(0)
)

App.OrderYearOverviewRoute = Ember.Route.extend(
  setupController: (controller, model) ->
    App.set "currentUser", App.get('store.usersCollection.content').findBy('id', parseInt(model.id))
    controller.set 'year', parseInt(model.year)

    ajax = $.ajax
      url: '/product_users/user_overview'
      data:
        user_id: App.get('currentUser.id')
        year: model.year

    ajax.done (response) ->
      App.set 'store.currentUserProducts', response

  activate: -> $(document).scrollTop(0)
)


App.OrderMonthOverviewRoute = Ember.Route.extend(
  setupController: (controller, model) ->
    App.set "currentUser", App.get('store.usersCollection.content').findBy('id', parseInt(model.id))
    controller.set 'year', parseInt(model.year)
    controller.set 'monthNumber', parseInt(model.month)

    if Em.isEmpty(App.get('store.currentUserProducts'))
      ajax = $.ajax
        url: '/product_users/user_overview'
        data:
          user_id: App.get('currentUser.id')
          year: model.year

      ajax.done (response) ->
        App.set 'store.currentUserProducts', response

  activate: -> $(document).scrollTop(0)
)

