App.UserView = Em.View.extend(
  classNameBindings: [":col-xs-3", "content.visible::hidden"]
  click: -> @get('controller').transitionToRoute "order", {id: @get("content.id")}

  template: Em.Handlebars.compile """
    <img class="img-circle img-responsive" {{bind-attr src="view.content.image"}}>
    <h5>{{unbound view.content.name}}</h5>
  """
)