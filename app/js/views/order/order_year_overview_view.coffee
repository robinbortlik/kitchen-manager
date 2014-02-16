App.OrderYearOverviewView = Em.View.extend(
  months: (-> moment.months() ).property()
  classNameBindings: [":container"]
  template: Em.Handlebars.compile """
    <h1>
      {{App.currentUser.name}}'s overview for year {{view.controller.year}}
      {{#link-to 'order' App.currentUser.id class="btn btn-danger pull-right"}}Back{{/link-to}}
    </h1>
    <table class="table table-striped  table-hover table-bordered">
      <thead>
        <th>Month</th>
        {{#each App.store.products}}
          {{view App.YearOverviewColumnHeaderView contentBinding="this"}}
        {{/each}}
        <th>Sum</th>
      </thead>
      <tbody>
        {{#each view.months}}
          {{view App.YearOverviewRowView monthBinding="this"}}
        {{/each}}
      </tbody>
    </table>
  """
)

App.YearOverviewColumnHeaderView = Em.View.extend
  tagName: 'th'
  prices: (->
    @get('content.price')
  ).property('content')

  template: Em.Handlebars.compile """
    {{name}}
    <br />
    {{formatMoney view.prices}}
  """

App.YearOverviewRowView = Em.View.extend
  tagName: 'tr'
  classNameBindings: ["isCurrentMonth:green"]

  monthIndex: (-> moment.months().indexOf(@get("month"))).property("content")
  monthNumber: (-> @get('monthIndex') + 1).property("monthIndex")
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
    <td>{{#link-to 'order.monthOverview' App.currentUser.id view.controller.year view.monthNumber}} {{view.month}}{{/link-to}}</td>
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