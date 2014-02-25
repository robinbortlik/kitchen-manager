App.ProductView = Em.View.extend(
  click: -> App.addToBasket(@get("content"))
  classNames: ["col-xs-3"]
  template: Em.Handlebars.compile """
    <img class="img-circle img-responsive" {{bind-attr src="view.content.image"}}>
    <h4>{{unbound view.content.name}}</h4>
    {{formatMoney view.content.price}}
    <br />
  """
)