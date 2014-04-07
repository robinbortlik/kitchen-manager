App.FavouriteView = Em.View.extend
  template: Em.TEMPLATES['products/favourite']
  classNames: ["col-md-3"]
  click: ->
    @$().addClass("bounceIn animated")
    App.get('cart.content').pushObjects(@get('content.products'))
    setTimeout =>
      @$().removeClass("bounceIn animated")
    , 500
