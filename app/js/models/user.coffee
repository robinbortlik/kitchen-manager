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