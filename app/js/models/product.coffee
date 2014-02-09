App.Product = Ember.Resource.define
  url: '/products'
  schema:
    id:    Number
    name:  String
    price:  Number
    image:  String
    deleted:  Boolean
    category_id: Number


App.Product.reopen Ember.Validations,
  validations:
    name:
      presence: true

    price:
      numericality:
        moreThan: 0

    category_id:
      presence: true


  category: (->
    return null unless @get('category_id')
    App.get('store.categories').findBy('id', @get('category_id'))
  ).property('category_id')
