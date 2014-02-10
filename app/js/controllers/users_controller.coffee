App.UsersController = Ember.Controller.extend(
  # selectedLetters: Em.ArrayProxy.create(content: [])
  contentBinding: 'App.store.users'
  activeUsers: (-> @get("content").filter (i) -> not i.get("deleted") ).property("content.@each.deleted")
  chunkedUsers: (-> @get("selectedUsers").chunk(4) ).property("selectedUsers")

  selectedLettersLabel: (-> App.get('selectedLetters.content').join("")).property('App.selectedLetters.@each')
  selectedUsers: (->
    @get("activeUsers").filterBy("visible")
  ).property("activeUsers.@each.visible")

  availableLetters: (->
    return @get("letters") if Em.isEmpty(App.get('selectedLetters.content'))
    tmp = []
    letters = App.get('selectedLetters.content').join("")
    @get("selectedUsers").forEach (u) =>
      indexes = @lettersLocations letters, u.get("mergedName")
      for i in indexes
        tmp.push(char) if char = u.get("mergedName").charAt(i+letters.length)
    tmp.uniq()
  ).property('selectedUsers.@each')

  lettersLocations: (substring, string) ->
    a = []
    i = -1
    a.push i  while (i = string.indexOf(substring, i + 1)) >= 0
    a

  letters: (->
    String.fromCharCode(i) for i in [65..90]
  ).property("activeUsers.@each")
)