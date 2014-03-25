App.FavouriteView = Em.View.extend
  template: Em.TEMPLATES['products/favourite']
  classNames: ["col-xs-2"]
  click: ->
    App.set('cart.content', @get('content.products'))

