App.Category = Ember.Resource.define
  url: '/categories'
  schema:
    id:    Number
    name:  String
    position: Number


App.Category.reopen Ember.Validations,
  validations:
    name:
      presence: true
    position:
      presence: true
      numericality:
        onlyInteger: true
        greaterThan: 0

