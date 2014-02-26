App.OrderMonthOverviewView = Em.View.extend(
  template: Em.TEMPLATES['order/month_overview']
)

App.RowOrderMonthOverviewView = Em.View.extend(
  tagName: "tr"
  orderedProducts: (->
    Em.makeArray(@get('controller.monthProducts')).filter (userProduct) =>
      moment(Em.get(userProduct, 'created_at')).get('date') == @get("content")
  ).property('controller.monthProducts')

  template: Em.TEMPLATES['order/month_overview_row']
)
