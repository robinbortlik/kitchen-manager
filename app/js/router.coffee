App.Router.map ->
  @route("users", path: "/" )
  @route("order", path: ":id/order")
  @route('order.userOverview', path: ":id/order/overview")
  @route("adminOverview", path: "admin")
  @route("adminUsers", path: "admin/users")
  @route("adminProducts", path: "admin/products" )
  @route("adminCategories", path: "admin/categories" )