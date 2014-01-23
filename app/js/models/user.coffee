App.User = Ember.Resource.define
  url: '/users'
  schema:
    id:    Number
    name:  String
    image:  String
    deleted:  Boolean

App.User.reopen Ember.Validations,
  validations:
    name:
      presence: true

  firstLetter:(->
    name_array = (@get("name") || "").split(" ")
    (name_array[name_array.length - 1]).charAt(0).toUpperCase()
  ).property("name")

  mergedName: (-> @get("name").replace(" ","").removeDiacritics().toUpperCase()).property("name")