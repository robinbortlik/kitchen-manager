App.UserView = Em.View.extend(
  classNameBindings: [":col-xs-3", "content.visible::hidden"]
  click: -> @get('controller').transitionToRoute "order", {id: @get("content.id")}

  template: Em.Handlebars.compile """
    <div class="userPhoto">
       <img {{bind-attr src="view.content.image"}} />
    </div>
    <h5>{{unbound view.content.name}}</h5>
  """
)
