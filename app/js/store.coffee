window.Store = Em.Object.extend
  users: (-> @get('usersCollection.content')).property('usersCollection.content')
  products: (-> @get('productsCollection.content')).property('productsCollection.content')
  productUsers: (-> @get('productUsersCollection.content')).property('productUsersCollection.content')
  categories: (-> @get('categoriesCollection.content')).property('categoriesCollection.content')
  organizationUnits: (-> @get('organizationUnitsCollection.content')).property('organizationUnitsCollection.content')
  currentUserProducts: []

  init: ->
    @_super()
    @set 'usersCollection', Ember.ResourceCollection.create({type: App.User})
    @set 'productsCollection', Ember.ResourceCollection.create({type: App.Product})
    @set 'productUsersCollection', Ember.ResourceCollection.create({type: App.ProductUser})
    @set 'categoriesCollection', Ember.ResourceCollection.create({type: App.Category})
    @set 'organizationUnitsCollection', Ember.ResourceCollection.create({type: App.OrganizationUnit})


  load: ->
    $.when(
      @get('usersCollection').fetch(),
      @get('productsCollection').fetch(),
      @get('categoriesCollection').fetch(),
      @get('organizationUnitsCollection').fetch()
    )