App.CartView = Em.View.extend(

  actions:
    cancel: -> @get('controller').transitionToRoute "users"

    submit: ->
      products = []
      for cartItem in App.get('cart.content')
        products.push {id: Em.get(cartItem, 'id'), price: Em.get(cartItem, 'price'), name: Em.get(cartItem, 'name')}
      $.ajax(
        type: 'POST'
        url: 'product_users'
        data: {products: products, user_id: App.get('currentUser.id')}
        success: (response) =>
          App.FlashMessageView.createMessage("Order was successfully created", 'success')
          @send('cancel')

        error: (response) ->
          App.FlashMessageView.createMessage("We are sorry but something were wrong. Try it again later.", 'danger')
      )

  template: Em.Handlebars.compile """
    <div class="col-md-3"">
      <button type="button" class="btn btn-danger" {{action "cancel" target="view"}}>Cancel</button>
      <button type="button" class="btn btn-success" {{action "submit" target="view"}}>I'm done</button>
      {{#each view.content}}
        {{view App.CartItemView contentBinding="this"}}
      {{/each}}
    </div>
  """
)

App.CartItemView = Em.View.extend(
  classNames: ["col-lg-9"]
  template: Em.Handlebars.compile """
    {{#if view.content.image}}
      <img class="img-circle" alt="140x140" style="width: 60px; height: 60px;" {{bindAttr src="view.content.image"}}>
    {{else}}
      <img class="img-circle" style="width: 60px; height: 60px; background-color: #EEE"/>
    {{/if}}
    <strong>{{view.content.name}}&nbsp;{{view.content.count}}x ({{formatMoney view.content.total}})</strong>
  """

  click: -> App.removeFromBasket(@get("content.id"))
)