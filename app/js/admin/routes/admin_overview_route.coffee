App.AdminOverviewRoute = Ember.Route.extend(
  setupController: (controller, model) ->
    controller.setProperties
      fromDate: moment().startOf('month').format('YYYY-MM-DD')
      toDate: moment().endOf('month').format('YYYY-MM-DD')
)


