App.Router.map ->
  @route("users", path: "/" )
  @route("order", path: ":id/order")
  @route("adminOverview", path: "admin")
  @route("adminUsers", path: "admin/users")
  @route("adminProducts", path: "admin/products" )