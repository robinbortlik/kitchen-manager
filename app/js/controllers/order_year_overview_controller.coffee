App.OrderYearOverviewController = Ember.Controller.extend(
  months: (-> moment.months() ).property()

  monthProducts: (->
    Em.makeArray(App.get('store.currentUserProducts')).filter (userProduct) =>
      moment(Em.get(userProduct, 'created_at')).get('month') == @get("monthIndex")
  ).property("monthIndex", "App.store.currentUserProducts")

)