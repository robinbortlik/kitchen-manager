App.Product = Ember.Resource.define
  url: '/products'
  schema:
    id:    Number
    name:  String
    price:  Number
    image:  String
    deleted:  Boolean
