App.OrderYearOverviewView = Em.View.extend(
  classNameBindings: [":container"]
  template: Em.TEMPLATES['order/year_overview']
)

App.YearOverviewColumnHeaderView = Em.View.extend
  template: Em.TEMPLATES['order/year_overview_header']
  tagName: 'th'
  monthIndex: (-> moment.months().indexOf(@get("content"))).property("content")
  monthNumber: (-> @get('monthIndex') + 1).property("monthIndex")


App.YearOverviewSumView = Em.View.extend
  template: Em.TEMPLATES['order/year_overview_sum']
  tagName: 'th'
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

  monthProducts: (->
    Em.makeArray(App.get('store.currentUserProducts')).filter (userProduct) =>
      moment(Em.get(userProduct, 'created_at')).get('month') == @get("monthIndex")
  ).property("monthIndex", "App.store.currentUserProducts")

  monthIndex: (-> moment.months().indexOf(@get("content"))).property("content")

  didInsertElement: ->
    setTimeout ->
      $("[data-toggle=tooltip]").tooltip()
    , 500


App.YearOverviewRowView = Em.View.extend
  template: Em.TEMPLATES['order/year_overview_row']
  tagName: 'tr'

  prices: (->
    @get('content.price')
  ).property('content')

  productsNumbers: (->
    @get('controller.months').map (month) =>
      monthIndex = moment.months().indexOf(month)
      items = Em.makeArray(@get('productsItems')).filter (userProduct) =>
        moment(Em.get(userProduct, 'created_at')).get('month') == monthIndex
      items.length
  ).property("productsItems")

  productsItems: (->
    Em.makeArray(App.get('store.currentUserProducts')).filter (userProduct) =>
      Em.get(userProduct, 'product_id') == @get('content.id')
  ).property("App.store.currentUserProducts")




