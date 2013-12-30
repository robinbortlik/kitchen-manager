Ember.Handlebars.helper "formatMoney", (value, options) ->
  new Handlebars.SafeString("#{value} #{App.get('currency')}")
