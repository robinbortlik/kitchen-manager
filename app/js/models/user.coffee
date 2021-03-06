App.User = Ember.Resource.define
  url: '/users'
  schema:
    id:    Number
    first_name: String
    last_name: String
    image:  String
    image_url:  String
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

  favourites: []
  popular: []

  name: (-> "#{@get('last_name')} #{@get('first_name')}").property("first_name", "last_name")
  mergedName: (-> @get("name").replace(" ","").removeDiacritics().toUpperCase()).property("name")
  imageSource: (-> @get('image') || @get('image_url') ).property("image", "image_url")

  organizationUnit: (->
    return null unless @get('organization_unit_id')
    App.get('store.organizationUnits').findBy('id', @get('organization_unit_id'))
  ).property('organization_unit_id')

  visible: (->
    return true unless App.get('filteredText')
    @get("mergedName").match(App.get('filteredText'))
  ).property('App.filteredText')

  loadFavourites: ->
    ajax = $.ajax "/product_groups/#{@get('id')}"
    ajax.done (response) =>
      tmp = []
      response.map (i) ->
        tmp.push App.ProductGroup.create(i)
      @set 'favourites', tmp

  loadPopular: ->
    ajax = $.ajax "/product_users/#{@get('id')}/popular"
    ajax.done (response) =>
      @set 'popular', response

  destroyResource: ->
    @set 'deleted', true
    @save()
