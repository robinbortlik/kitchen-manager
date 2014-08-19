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

    openProductGroupForm: ->
      view = App.ProductGroupForm.create()
      product_group = App.ProductGroup.create(name: App.get("cart").computeGroupName(), position: App.get('currentUser.favourites').length + 1)
      view.set 'content', product_group
      view.appendTo("#ember-app")
)

App.CartItemView = Em.View.extend(
  template: Em.TEMPLATES['cart/item']
  classNames: ["row"]
  background: (-> "background:url(#{@get('content.imageSource')})").property("content.imageSource")
  click: ->
    @$().addClass("fadeOut animated")
    setTimeout =>
      App.removeFromBasket(@get("content.id"))
    , 500
)


App.ProductGroupForm = Em.View.extend
  template: Em.TEMPLATES['product_groups/form']
  layout: Em.TEMPLATES['layouts/modal_layout']
  contextBinding: 'content'
  title: (-> if @get("content.isNew") then 'Create Favourite Combination' else 'Edit Favourite Combination' ).property('content')

  actions:
    save: ->
      if @get("content").validate()
        if isNew = @get("content.isNew")
          @set("content.user_id", App.get("currentUser.id"))
          @set("content.product_groups_products", App.get("cart").serializedProducts())
        @get("content").save().done =>
          App.get('currentUser').loadFavourites()
          @destroy()


    cancel: ->
      unless @get("content.isNew")
        @get("content").expire()
        @get("content").fetch()
      @destroy()