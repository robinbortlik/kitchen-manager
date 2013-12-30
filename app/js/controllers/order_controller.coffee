App.OrderController = Em.ArrayController.extend(
  contentBinding: 'App.store.products'
  activeProducts: (->
    @get("content").filter (i) -> not i.get("deleted")
  ).property("content.@each.deleted")
)