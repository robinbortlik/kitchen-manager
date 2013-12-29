App.User = Ember.Resource.define
  url: '/users'
  schema:
    id:    Number
    name:  String
    image:  String