App.ProductUser = Ember.Resource.define
  url: '/product_users'
  schema:
    id:    Number
    product_id: Number
    user_id: Number
    name:  String
    price:  Number