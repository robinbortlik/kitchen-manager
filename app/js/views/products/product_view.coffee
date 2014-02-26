App.ProductView = Em.View.extend(
  click: -> App.addToBasket(@get("content"))
  classNames: ["col-xs-3"]
  template: Em.Handlebars.compile """
    <div class="userPhoto">
      <img {{bind-attr src="view.content.image"}}/>
    </div>
    <h4>{{unbound view.content.name}}</h4>
    {{formatMoney view.content.price}}
    <br />
  """
)