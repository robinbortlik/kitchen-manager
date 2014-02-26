App.UserView = Em.View.extend(
  classNameBindings: [":col-xs-3", "content.visible::hidden"]
  click: -> @get('controller').transitionToRoute "order", {id: @get("content.id")}
  background: (-> "background:url(#{@get('content.imageSource')})").property("content.imageSource")
  template: Em.Handlebars.compile """
    <div class="userPhoto" {{bind-attr style="view.background"}}></div>
    <h5>{{unbound view.content.name}}</h5>
  """
)
