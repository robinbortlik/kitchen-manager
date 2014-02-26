App.UserView = Em.View.extend(
  template: Em.TEMPLATES['users/item']
  classNameBindings: [":col-xs-3", "content.visible::hidden"]
  click: -> @get('controller').transitionToRoute "order", {id: @get("content.id")}
  background: (-> "background:url(#{@get('content.imageSource')})").property("content.imageSource")
)
