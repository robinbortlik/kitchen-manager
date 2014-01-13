App.AdminOverviewController = Ember.ArrayController.extend(
  fromDate: null
  toDate: null
  contentBinding: 'App.store.productUsers'
  actions:
    filter: ->
      App.get('store.productUsersCollection').expire()
      Em.run.next =>
        App.get('store.productUsersCollection').fetch({data: {from: @get('fromDate'), to: @get('toDate')}})

  fromToDateObserver: (->
    @send("filter")
  ).observes("fromDate", "toDate")
)