App.Product = Ember.Resource.define
  url: '/products'
  schema:
    id:    Number
    name:  String
    price:  Number
    image:  String
    deleted:  Boolean


App.Product.reopen Ember.Validations,
  validations:
    name:
      presence: true

    price:
      numericality:
        moreThan: 0