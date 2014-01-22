App.UsersController = Ember.Controller.extend(
  selectedLetter: null
  contentBinding: 'App.store.users'
  activeUsers: (->
    @get("content").filter (i) -> not i.get("deleted")
  ).property("content.@each.deleted")

  selectedUsers: (->
    @get('activeUsers').filterProperty("firstLetter", @get("selectedLetter"))
  ).property("activeUsers.@each", "selectedLetter")

  letters: (->
    tmp = @get("activeUsers").mapProperty("firstLetter")
    tmp.uniq().sort()
  ).property("activeUsers.@each")
)