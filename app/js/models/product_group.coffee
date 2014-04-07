App.ProductGroupsProduct = Ember.Resource.define
  schema:
    id:    Number
    product_id: Number
    product_group_id: Number



App.ProductGroup = Ember.Resource.define
  url: '/product_groups'
  schema:
    id:    Number
    user_id: Number
    name: String
    position: Number


App.ProductGroup.reopen Ember.Validations,
  validations:
    name:
      presence: true
    position:
      presence: true
      numericality:
        onlyInteger: true
        greaterThan: 0

  toJSON: ->
    json = @_super()
    json['product_groups_products'] = @get('product_groups_products')
    json

  productsIds: (->
    @get('product_groups_products').mapProperty('product_id')
  ).property("product_groups_products")

  products: (->
    tmp = []
    @get('productsIds').forEach (productId) ->
      tmp.push App.get('store.products').findProperty('id', productId)
    tmp.compact()
  ).property('productsIds')