Ember.Handlebars.helper "row", (value, options) ->
  tmp = []
  for val in value
    tmp.push "<td>#{val}</td>"
  new Handlebars.SafeString(tmp.join(""))
