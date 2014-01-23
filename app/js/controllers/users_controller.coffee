App.UsersController = Ember.Controller.extend(
  selectedLetters: Em.ArrayProxy.create(content: [])
  contentBinding: 'App.store.users'
  activeUsers: (->
    @get("content").filter (i) -> not i.get("deleted")
  ).property("content.@each.deleted")

  selectedLettersLabel: (-> @get('selectedLetters.content').join("")).property('selectedLetters.@each')
  selectedUsers: (->
    return @get('activeUsers') if Em.isEmpty(@get('selectedLetters.content'))
    tmp = @get('activeUsers').filter (u) =>
      u.get("mergedName").match(@get('selectedLetters.content').join(""))
    tmp
  ).property("activeUsers.@each", "selectedLetters.content.@each")

  availableLetters: (->
    return @get("letters") if Em.isEmpty(@get('selectedLetters.content'))
    tmp = []
    letters = @get('selectedLetters.content').join("")
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