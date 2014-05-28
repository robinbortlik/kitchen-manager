App.Product = Ember.Resource.define
  url: '/products'
  schema:
    id:    Number
    name:  String
    price:  Number
    image:  String
    image_url:  String
    deleted:  Boolean
    category_id: Number
    position: Number


App.Product.reopen Ember.Validations,
  validations:
    name:
      presence: true

    price:
      numericality:
        moreThan: 0

    category_id:
      presence: true

    position:
      presence: true
      numericality:
        onlyInteger: true
        greaterThan: 0


  category: (->
    return null unless @get('category_id')
    App.get('store.categories').findBy('id', @get('category_id'))
  ).property('category_id')

  imageSource: (-> @get('image') || @get('image_url')).property("image", "image_url")

  destroyResource: ->
    @set 'deleted', true
    @save()
