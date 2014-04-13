App.FavouriteView = Em.View.extend
  template: Em.TEMPLATES['products/favourite']
  classNames: ["col-md-3"]


  actions:
    add: ->
      @$().addClass("bounceIn animated")
      App.get('cart.content').pushObjects(@get('content.products'))
      setTimeout =>
        @$().removeClass("bounceIn animated")
      , 500

    remove: ->
      if confirm('Are you sure?')
        favourite = @get("content")
        favourite.destroyResource().done =>
          App.currentUser.get('favourites').removeObject(favourite)
          @destroy()