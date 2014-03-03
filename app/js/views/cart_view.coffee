App.CartView = Em.View.extend(
  template: Em.TEMPLATES['cart/list']
  totalPrice:(-> App.get('cart.totalPrice') ).property('App.cart.totalPrice')
  year: (-> moment().get('year') ).property()
  actions:
    cancel: -> @get('controller').transitionToRoute "users"

    submit: ->
      products = []
      for cartItem in App.get('cart.content')
        products.push {id: Em.get(cartItem, 'id'), price: Em.get(cartItem, 'price'), name: Em.get(cartItem, 'name')}
      $.ajax(
        type: 'POST'
        url: 'product_users'
        data: {products: products, user_id: App.get('currentUser.id')}
        success: (response) =>
          App.FlashMessageView.createMessage("Order was successfully created", 'success')
          @send('cancel')

        error: (response) ->
          App.FlashMessageView.createMessage("We are sorry but something were wrong. Try it again later.", 'danger')
      )
)

App.CartItemView = Em.View.extend(
  template: Em.TEMPLATES['cart/item']
  classNames: ["row"]
  background: (-> "background:url(#{@get('content.imageSource')})").property("content.imageSource")
  click: ->
    @$().addClass("fadeOut animated")
    setTimeout =>
      App.removeFromBasket(@get("content.id"))
    , 1000
)