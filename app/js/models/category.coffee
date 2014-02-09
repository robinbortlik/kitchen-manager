App.Category = Ember.Resource.define
  url: '/categories'
  schema:
    id:    Number
    name:  String


App.Category.reopen Ember.Validations,
  validations:
    name:
      presence: true