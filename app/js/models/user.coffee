App.User = Ember.Resource.define
  url: '/users'
  schema:
    id:    Number
    first_name: String
    last_name: String
    image:  String
    deleted:  Boolean

App.User.reopen Ember.Validations,
  validations:
    first_name:
      presence: true

    last_name:
      presence: true


  name: (-> "#{@get('last_name')} #{@get('first_name')}").property("first_name", "last_name")
  mergedName: (-> @get("name").replace(" ","").removeDiacritics().toUpperCase()).property("name")
  imageSource: (-> @get('image') || App.get('defaultImage')).property("image")
  visible: (->
    return true if App.get('selectedLetters.content').length == 0
    @get("mergedName").match(App.get('selectedLetters.content').join(""))
  ).property('App.selectedLetters.@each')