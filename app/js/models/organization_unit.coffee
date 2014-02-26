App.OrganizationUnit = Ember.Resource.define
  url: '/organization_units'
  schema:
    id:    Number
    name:  String
    position: Number


App.OrganizationUnit.reopen Ember.Validations,
  validations:
    name:
      presence: true
    position:
      presence: true
      numericality:
        onlyInteger: true
        greaterThan: 0

