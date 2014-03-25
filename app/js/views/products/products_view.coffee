App.ProductsView = Em.View.extend
  template: Em.TEMPLATES['products/list']
  contentBinding: 'controller.activeProducts'
  actions:
    filter: (category) ->
      @set 'displayFavourites', false
      @set "selectedCategoryId", category.get("id")

    favourites: ->
      @set 'displayFavourites', true

  filteredProducts: (->
    if @get("selectedCategoryId")
      @get("controller.activeProducts").filterBy('category_id', @get("selectedCategoryId"))
    else
      if cat = App.get("store.categories")[0]
        @get("controller.activeProducts").filterBy('category_id', cat.get("id"))
      else
        @get("controller.activeProducts")
  ).property('content', 'selectedCategoryId')

  chunkedProducts:(-> @get("filteredProducts").chunk(6)).property("filteredProducts")

  didInsertElement: ->
    $(".nav-tabs li:first").addClass("active")
