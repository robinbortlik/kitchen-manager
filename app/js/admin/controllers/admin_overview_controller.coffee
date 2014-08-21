App.AdminOverviewController = Ember.ArrayController.extend(
  fromDate: null
  toDate: null
  loadingData: false
  contentBinding: 'App.store.productUsers'
  actions:
    filter: ->
      return if @get("loadingData")
      @set 'loadingData', true

      App.get('store.productUsersCollection').expire()
      Em.run.next =>
        App.get('store.productUsersCollection').fetch({data: {from: @get('fromDate'), to: @get('toDate')}}).done =>
          @set 'loadingData', false

  fromToDateObserver: (->
    @send("filter")
  ).observes("fromDate", "toDate")
)