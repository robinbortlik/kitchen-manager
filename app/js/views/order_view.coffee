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
  year: 2014
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

  monthIndex: (-> moment.months().indexOf(@get("month"))).property("content")

  monthProducts: (->
    Em.makeArray(App.get('store.currentUserProducts')).filter (userProduct) =>
      moment(Em.get(userProduct, 'created_at')).get('month') == @get("monthIndex")
  ).property("monthIndex", "App.store.currentUserProducts")

  computedContent: (->
    tmp = []
    for product in App.get('store.products')
      monthProducts = @get("monthProducts").filter (userProduct) => Em.get(userProduct, 'product_id') == product.get('id')
      tmp.push monthProducts.length
    tmp
  ).property('monthProducts')

  total: (->
    (@get("monthProducts").reduce ((x,y) -> x + parseFloat(Em.get(y, 'price')) ), 0).toFixed(2)
  ).property('monthProducts')

  template: Em.Handlebars.compile """
    <td>{{view.month}}</td>
    {{#each view.computedContent}}
      <td>{{this}}</td>
    {{/each}}
    <td class="text-danger"><strong>{{formatMoney view.total}}</strong></td>
  """