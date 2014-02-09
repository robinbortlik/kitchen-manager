window.Store = Em.Object.extend
  users: (-> @get('usersCollection.content')).property('usersCollection.content')
  products: (-> @get('productsCollection.content')).property('productsCollection.content')
  productUsers: (-> @get('productUsersCollection.content')).property('productUsersCollection.content')
  categories: (-> @get('categoriesCollection.content')).property('categoriesCollection.content')
  currentUserProducts: []

  init: ->
    @_super()
    @set 'usersCollection', Ember.ResourceCollection.create({type: App.User})
    @set 'productsCollection', Ember.ResourceCollection.create({type: App.Product})
    @set 'productUsersCollection', Ember.ResourceCollection.create({type: App.ProductUser})
    @set 'categoriesCollection', Ember.ResourceCollection.create({type: App.Category})


  load: ->
    $.when(@get('usersCollection').fetch(), @get('productsCollection').fetch(), @get('categoriesCollection').fetch())