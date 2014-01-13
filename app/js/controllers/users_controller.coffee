App.UsersController = Ember.ArrayController.extend(
  contentBinding: 'App.store.users'
  activeUsers: (->
    @get("content").filter (i) -> not i.get("deleted")
  ).property("content.@each.deleted")

  letters: (->
    tmp = @get("activeUsers").mapProperty("firstLetter")
    tmp.uniq().sort()
  ).property("activeUsers.@each")
)