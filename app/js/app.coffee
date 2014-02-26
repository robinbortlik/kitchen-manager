window.App = Ember.Application.create(
  rootElement: '#ember-app'
  LOG_TRANSITIONS: false
  defaultImage: '/images/noimage.jpg'
  currency: "Kč"
  currentUser: null
  cart: null
  store: null
  selectedLetters: Em.ArrayProxy.create(content: [])
  initialize: (container, application) ->
    Ember.SimpleAuth.setup(application)


  addToBasket: (item) -> @get("cart.content").pushObject(item)

  removeFromBasket: (itemId) ->
    obj = @get("cart.content").findBy('id', parseInt(itemId))
    index = @get("cart.content").indexOf(obj)
    @get("cart.content").removeAt index


  ready: ->
    @set 'cart', new App.Cart(content: [])
    @set 'store', new Store
    $("#ember-app .spinner").remove()

)




