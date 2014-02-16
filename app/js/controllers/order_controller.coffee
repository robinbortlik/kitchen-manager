App.OrderController = Em.ArrayController.extend(
  contentBinding: 'App.store.products'
  activeProducts: (->
    @get("content").filter (i) -> not i.get("deleted")
  ).property("content.@each.deleted")
)

App.OrderYearOverviewController = Em.Controller.extend(
 year: null
)

App.OrderMonthOverviewController = Em.Controller.extend(
  monthNumber: null
  year: null

  month: (->
    moment.months()[@get('monthIndex')]
  ).property('monthIndex')

  monthIndex: (-> @get('monthNumber') - 1).property('monthNumber')

  dayNumbers: (->
    days = new Date(@get("year"), @get("monthNumber"), 0).getDate()
    num for num in [1..days]
  ).property('year', 'monthIndex')

  monthProducts: (->
    Em.makeArray(App.get('store.currentUserProducts')).filter (userProduct) =>
      moment(Em.get(userProduct, 'created_at')).get('month') == @get("monthIndex")
  ).property("monthIndex", "App.store.currentUserProducts")

)