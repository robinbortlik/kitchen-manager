App.ProductView = Em.View.extend(
  click: -> App.addToBasket(@get("content"))
  classNames: ["col-xs-3"]
  background: (-> "background:url(#{@get('content.imageSource')})").property("content.imageSource")
  template: Em.TEMPLATES['products/item']
)