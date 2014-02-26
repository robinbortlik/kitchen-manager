App.OrderYearOverviewView = Em.View.extend(
  months: (-> moment.months() ).property()
  classNameBindings: [":container"]
  template: Em.TEMPLATES['order/year_overview']
)

App.YearOverviewColumnHeaderView = Em.View.extend
  template: Em.TEMPLATES['order/year_overview_header']
  tagName: 'th'
  prices: (->
    @get('content.price')
  ).property('content')


App.YearOverviewRowView = Em.View.extend
  template: Em.TEMPLATES['order/year_overview_row']
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

