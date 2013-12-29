window.Store = Em.Object.extend
  users: (-> @get('usersCollection.content')).property('usersCollection.content')
  products: (-> @get('productsCollection.content')).property('productsCollection.content')
  productUsers: (-> @get('productUsersCollection.content')).property('productUsersCollection.content')

  init: ->
    @_super()
    @set 'usersCollection', Ember.ResourceCollection.create({type: App.User})
    @set 'productsCollection', Ember.ResourceCollection.create({type: App.Product})
    @set 'productUsersCollection', Ember.ResourceCollection.create({type: App.ProductUser})


  load: ->
    $.when(@get('usersCollection').fetch(), @get('productsCollection').fetch())