App.ProductView = Em.View.extend(
  click: -> App.addToBasket(@get("content"))
  classNames: ["col-xs-3"]
  template: Em.Handlebars.compile """
    {{#if view.content.image}}
      <img class="img-circle img-responsive" alt="140x140" style="width: 90px; height: 90px;" {{bind-attr src="view.content.image"}}>
    {{else}}
      <img class="img-circle img-responsive" style="width: 90px; height: 90px; background-color: #EEE"/>
    {{/if}}
    <h4>{{view.content.name}}</h4>
    {{formatMoney view.content.price}}
    <br />
  """
)