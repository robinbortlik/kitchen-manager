App.UserView = Em.View.extend(
  template: Em.TEMPLATES['users/item']
  classNameBindings: [":col-xs-2", "content.visible::hidden"]
  click: -> @get('controller').transitionToRoute "order", {id: @get("content.id")}
  background: (-> "background:url(#{@get('content.imageSource')})").property("content.imageSource")
)

App.UsersListView = Em.CollectionView.extend
  itemViewClass: 'App.UserView'

App.SmallUserView = Em.View.extend
  style: (-> "background:url(#{@get('content.imageSource')})").property("content.imageSource")
  classNames: ["userPhoto", "userSmallPhoto"]
  attributeBindings: ["style"]
