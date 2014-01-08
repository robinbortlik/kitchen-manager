App.Cart = Em.Object.extend
  content: []

  calculatedContent: (->
    tmp = {}
    for item in @get('content')
      id = Em.get(item, "id")
      obj = tmp[id] || {count: 0, name: Em.get(item, "name"), image: Em.get(item, "image"), price: Em.get(item, "price")}
      obj.count += 1
      tmp[id] = obj
    result = []
    for k,v of tmp
      total = (parseInt(Em.get(v, 'count')) * parseFloat(Em.get(v, 'price'))).toFixed(2)
      result.push {id: k, name: Em.get(v, 'name'), count: Em.get(v, 'count'), image: Em.get(v, "image"), total: total}
    result
  ).property('content.@each')

  totalPrice: (->
    @get('content').sum("price").toFixed(2)
  ).property('content.@each')