App.ProductView = Em.View.extend(
  click: -> App.addToBasket(@get("content"))
  classNames: ["col-lg-3"]
  template: Em.Handlebars.compile """
    {{#if view.content.image}}
      <img class="img-circle" alt="140x140" style="width: 140px; height: 140px;" {{bindAttr src="view.content.image"}}>
    {{else}}
      <img class="img-circle" style="width: 140px; height: 140px; background-color: #EEE"/>
    {{/if}}
    <h4>{{view.content.name}}</h4>
    {{formatMoney view.content.price}}
    <br />
  """
)