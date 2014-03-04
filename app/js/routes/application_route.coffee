App.ApplicationRoute = Ember.Route.extend(
  model: -> App.get("store").load()
  activate: -> $(document).scrollTop(0)
)