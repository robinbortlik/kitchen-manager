App.OrderView = Em.View.extend(
  template: Em.Handlebars.compile """
    <h1>So {{App.currentUser.name}}, what will be your oder?</h1>
    <div class="row">
      {{view App.ProductsView contentBinding='controller.content'}}
      {{view App.CartView contentBinding='controller.cart.calculatedContent'}}
    </div>
  """
)