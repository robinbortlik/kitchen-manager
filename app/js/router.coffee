App.Router.map ->
  @route("users", path: "/" )
  @route("order", path: ":id/order")
  @route('order.yearOverview', path: ":id/order/:year/overview")
  @route('order.monthOverview', path: ":id/order/:year/:month/overview")
  @route("adminOverview", path: "admin")
  @route("adminUsers", path: "admin/users")
  @route("adminProducts", path: "admin/products" )
  @route("adminCategories", path: "admin/categories" )