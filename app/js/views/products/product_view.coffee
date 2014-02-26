App.ProductView = Em.View.extend(
  click: -> App.addToBasket(@get("content"))
  classNames: ["col-xs-3"]
  background: (-> "background:url(#{@get('content.imageSource')})").property("content.imageSource")
  template: Em.Handlebars.compile """
    <div class="userPhoto" {{bind-attr style="view.background"}}>
    </div>
    <h4>{{unbound view.content.name}}</h4>
    {{formatMoney view.content.price}}
    <br />
  """
)