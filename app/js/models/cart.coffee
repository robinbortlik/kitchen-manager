App.Cart = Em.Object.extend
  content: []

  calculatedContent: (->
    tmp = {}
    for item in @get('content')
      id = Em.get(item, "id")
      obj = tmp[id] || {count: 0, name: Em.get(item, "name"), imageSource: Em.get(item, "imageSource"), price: Em.get(item, "price")}
      obj.count += 1
      tmp[id] = obj
    result = []
    for k,v of tmp
      total = (parseInt(Em.get(v, 'count')) * parseFloat(Em.get(v, 'price'))).toFixed(2)
      result.push {id: k, name: Em.get(v, 'name'), count: Em.get(v, 'count'), imageSource: Em.get(v, "imageSource"), total: total}
    result
  ).property('content.@each')

  totalPrice: (->
    @get('content').sum("price").toFixed(2)
  ).property('content.@each')

  serializedProducts: ->
    tmp = []
    @get('content').forEach (i) ->
      tmp.push {product_id: Em.get(i, 'id')}
    tmp

  computeGroupName: ->
    names = @get('content').map (item) -> Em.get(item, 'name').slice(0,3)
    names.join("-").slice(0,11)