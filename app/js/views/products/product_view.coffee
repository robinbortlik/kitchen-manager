App.ProductView = Em.View.extend
  template: Em.TEMPLATES['products/item']
  click: ->
    @$().addClass("bounceIn animated")
    App.addToBasket(@get("content"))
    setTimeout =>
      @$().removeClass("bounceIn animated")
    , 500
  classNames: ["col-xs-3"]
  background: (-> "background:url(#{@get('content.imageSource')})").property("content.imageSource")