Array::sum = (prop) ->
  @reduce (x,y)->
    x + Em.get(y, prop)
  , 0