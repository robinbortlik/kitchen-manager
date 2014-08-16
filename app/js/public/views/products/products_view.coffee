App.ProductsView = Em.View.extend
  template: Em.TEMPLATES['products/list']
  actions:
    filter: (category) ->
      catId = Em.get(category,"id")
      @set 'displayFavourites', !catId
      @set "selectedCategoryId", catId


  filteredProducts: (->
    if @get("selectedCategoryId")
      @get("controller.activeProducts").filterBy('category_id', @get("selectedCategoryId"))
    else
      if cat = App.get("store.categories")[0]
        @get("controller.activeProducts").filterBy('category_id', cat.get("id"))
      else
        @get("controller.activeProducts")
  ).property('controller.activeProducts', 'selectedCategoryId')

  popular:(->
    Em.makeArray(App.get('currentUser.popular')).map((productId) =>
      @get("controller.activeProducts").findProperty('id', productId)
    ).compact()
  ).property("App.currentUser.popular")

  categories: (->
    favourites = Em.Object.create(name: 'Favourites', id: null, position: 1)
    [favourites].concat(App.store.get('categories'))
  ).property('App.store.categories')

  didInsertElement: ->
    $(".nav-tabs li:first").addClass("active")
    @set 'displayFavourites', true
