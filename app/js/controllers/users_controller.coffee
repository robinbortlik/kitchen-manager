App.UsersController = Ember.ArrayController.extend(
  contentBinding: 'App.store.users'
  activeUsers: (->
    @get("content").filter (i) -> not i.get("deleted")
  ).property("content.@each.deleted")
)