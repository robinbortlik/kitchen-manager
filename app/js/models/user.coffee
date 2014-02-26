App.User = Ember.Resource.define
  url: '/users'
  schema:
    id:    Number
    first_name: String
    last_name: String
    image:  String
    deleted:  Boolean
    organization_unit_id: Number

App.User.reopen Ember.Validations,
  validations:
    first_name:
      presence: true

    last_name:
      presence: true

    organization_unit_id:
      presence: true


  name: (-> "#{@get('last_name')} #{@get('first_name')}").property("first_name", "last_name")
  mergedName: (-> @get("name").replace(" ","").removeDiacritics().toUpperCase()).property("name")
  imageSource: (-> @get('image') || App.get('defaultImage')).property("image")
  organizationUnit: (->
    return null unless @get('organization_unit_id')
    App.get('store.organizationUnits').findBy('id', @get('organization_unit_id'))
  ).property('organization_unit_id')

  visible: (->
    return true unless App.get('filteredText')
    @get("mergedName").match(App.get('filteredText'))
  ).property('App.filteredText')