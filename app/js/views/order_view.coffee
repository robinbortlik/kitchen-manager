App.OrderView = Em.View.extend(
  template: Em.Handlebars.compile """
    <h1>So {{App.currentUser.name}}, what will be your oder?</h1>
    <div class="row">
      {{view App.ProductsView contentBinding='controller.content'}}
      {{view App.CartView contentBinding='controller.cart.calculatedContent'}}
    </div>
  """
)

App.OrderUserOverviewView = Em.View.extend(
  title: "Overview"
  layout: App.LargeModalLayoutView.template
  year: (-> moment().get('year') ).property()
  months: (-> moment.months() ).property()
  actions:
    cancel: -> @destroy()

  template: Em.Handlebars.compile """
    <table class="table table-striped  table-hover table-bordered">
      <thead>
        <th>Month</th>
        {{#each App.store.products}}
          {{view App.UserOverviewColumnHeaderView contentBinding="this"}}
        {{/each}}
        <th>Sum</th>
      </thead>
      <tbody>
        {{#each view.months}}
          {{view App.UserOverviewRowView monthBinding="this"}}
        {{/each}}
      </tbody>
    </table>
  """

  didInsertElement: ->
    @loadData()

  loadData: ->
    ajax = $.ajax
      url: '/product_users/user_overview'
      data:
        user_id: App.get('currentUser.id')
        year: @get("year")

    ajax.done (response) =>
      App.set 'store.currentUserProducts', response
)

App.UserOverviewColumnHeaderView = Em.View.extend
  tagName: 'th'
  prices: (->
    @get('content.price')
  ).property('content')

  template: Em.Handlebars.compile """
    {{name}}
    <br />
    {{formatMoney view.prices}}
  """

App.UserOverviewRowView = Em.View.extend
  tagName: 'tr'
  classNameBindings: ["isCurrentMonth:green"]

  monthIndex: (-> moment.months().indexOf(@get("month"))).property("content")
  isCurrentMonth: (-> @get("monthIndex") == moment().get("month") ).property("monthIndex")
  monthProducts: (->
    Em.makeArray(App.get('store.currentUserProducts')).filter (userProduct) =>
      moment(Em.get(userProduct, 'created_at')).get('month') == @get("monthIndex")
  ).property("monthIndex", "App.store.currentUserProducts")

  productsPerMonth: (->
    tmp = []
    for product in App.get('store.products')
      monthProducts = @get("monthProducts").filter (userProduct) => Em.get(userProduct, 'product_id') == product.get('id')
      tmp.push monthProducts.length
    tmp
  ).property('monthProducts')

  total: (->
    @get('monthProducts').sum('price').toFixed(2)
  ).property('monthProducts')

  isPaid: (->
    not @get('monthProducts').find((up) -> not Em.get(up,'is_paid') )
  ).property("monthProducts")

  notPaid: (->
    @get('monthProducts').filter((up) -> not Em.get(up,'is_paid') ).sum('price').toFixed(2)
  ).property("monthProducts")

  paid: (->
    @get('monthProducts').filterProperty('is_paid').sum('price').toFixed(2)
  ).property("monthProducts")

  didInsertElement: ->
    setTimeout ->
      $("[data-toggle=tooltip]").tooltip()
    , 500

  template: Em.Handlebars.compile """
    <td>{{view.month}}</td>
    {{#each view.productsPerMonth}}
      <td>{{this}}</td>
    {{/each}}
    {{#if view.isPaid}}
      <td><strong class="text-success">{{formatMoney view.total}}</strong></td>
    {{else}}
      <td>
        <strong class="text-danger">{{formatMoney view.total}}</strong>&nbsp;
        (
          <small data-toggle="tooltip" title="Is missing to pay">{{view.notPaid}}</small>
          /
          <small data-toggle="tooltip" title="Was already paid">{{view.paid}}</small>
        )
      </td>
    {{/if}}
  """