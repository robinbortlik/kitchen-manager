get = Ember.get
set = Ember.set
EmberHandlebars = Ember.Handlebars
EmberHandlebars.registerHelper "group", (options) ->
  data = options.data
  fn = options.fn
  view = data.view
  childView = undefined
  childView = view.createChildView(Ember._MetamorphView,
    context: get(view, "context")
    template: (context, options) ->
      options.data.insideGroup = true
      fn context, options
  )
  view.appendChild childView
  return
