App.ProductsView = Em.View.extend(
  contentBinding: 'controller.activeProducts'
  actions:
    filter: (category) -> @set "selectedCategoryId", category.get("id")

  filteredProducts: (->
    if @get("selectedCategoryId")
      @get("controller.activeProducts").filterBy('category_id', @get("selectedCategoryId"))
    else
      if cat = App.get("store.categories")[0]
        @get("controller.activeProducts").filterBy('category_id', cat.get("id"))
      else
        @get("controller.activeProducts")
  ).property('content', 'selectedCategoryId')

  chunkedProducts:(-> @get("filteredProducts").chunk(4)).property("filteredProducts")

  template: Em.TEMPLATES['products/list']

  didInsertElement: ->
    $(".nav-tabs li:first").addClass("active")
)