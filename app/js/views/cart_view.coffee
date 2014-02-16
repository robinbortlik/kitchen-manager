App.CartView = Em.View.extend(
  totalPrice:(-> App.get('cart.totalPrice') ).property('App.cart.totalPrice')
  year: (-> moment().get('year') ).property()
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

    openUserOverview: ->
      view = App.OrderUserOverviewView.create()
      view.appendTo("#ember-app")

  template: Em.Handlebars.compile """
    <div class="col-xs-3"">
      <p>
        <button type="button" class="btn btn-danger" {{action "cancel" target="view"}}>Cancel</button>
        <button type="button" class="btn btn-success" {{action "submit" target="view"}}>I'm done</button>
      </p>
      <div class="panel panel-default">
        <div class="panel-heading"><strong>{{formatMoney view.totalPrice}}</strong> {{#link-to 'order.yearOverview' App.currentUser.id view.year}}Overview{{/link-to}}</div>
        <div class="panel-body">
          {{#if view.content}}
            {{#each view.content}}
              {{view App.CartItemView contentBinding="this"}}
              <br />
            {{/each}}
          {{else}}
            Start by selecting some product
          {{/if}}
        </div>
    </div>
  </div>
  """
)

App.CartItemView = Em.View.extend(
  classNames: ["row"]
  template: Em.Handlebars.compile """
    {{#if view.content.image}}
      <img class="img-circle" alt="140x140" style="width: 60px; height: 60px;" {{bind-attr src="view.content.image"}}>
    {{else}}
      <img class="img-circle" style="width: 60px; height: 60px; background-color: #EEE"/>
    {{/if}}
    {{view.content.name}}
    <div>{{view.content.count}}x ({{formatMoney view.content.total}})</div>
  """

  click: -> App.removeFromBasket(@get("content.id"))
)