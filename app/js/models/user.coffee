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


  name: (-> "#{@get('first_name')} #{@get('last_name')}").property("first_name", "last_name")
  mergedName: (-> @get("name").replace(" ","").removeDiacritics().toUpperCase()).property("name")