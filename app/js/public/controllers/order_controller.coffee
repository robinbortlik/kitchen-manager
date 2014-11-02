App.OrderController = Em.ArrayController.extend(
  contentBinding: 'App.store.products'
  favouritesBinding: 'App.currentUser.favourites'
  activeProducts: (->
    @get("content").filter (i) -> not i.get("deleted")
  ).property("content.@each.deleted")

  actions:
    useLastCombination: ->
      ajax = $.ajax
        url: "product_users/#{App.get('currentUser.id')}/last_order"
        method: "GET"

      ajax.done (response) =>
        Em.makeArray(response).forEach (product) =>
          product = @get('activeProducts').findProperty("id", Em.get(product, 'product_id'))
          App.addToBasket(product) if product
)

App.OrderYearOverviewController = Em.Controller.extend(
 year: null
)

App.OrderMonthOverviewController = Em.Controller.extend(
  monthNumber: null
  year: null

  actions:
    remove: (itemId) ->
      if confirm('Are you sure')
        obj = App.get('store.currentUserProducts').findBy('id', parseInt(itemId))
        App.ProductUser.create(obj).destroyResource().done =>
          App.get('store.currentUserProducts').removeObject(obj)
          App.get('store').propertyDidChange('currentUserProducts')

  month: (->
    moment.months()[@get('monthIndex')]
  ).property('monthIndex')

  monthIndex: (-> @get('monthNumber') - 1).property('monthNumber')

  dayNumbers: (->
    days = new Date(@get("year"), @get("monthNumber"), 0).getDate()
    num for num in [1..days]
  ).property('year', 'monthIndex')

  monthProducts: (->
    Em.makeArray(App.get('store.currentUserProducts')).filter (userProduct) =>
      moment(Em.get(userProduct, 'created_at')).get('month') == @get("monthIndex")
  ).property("monthIndex", "App.store.currentUserProducts")

)
