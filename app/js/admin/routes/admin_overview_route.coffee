App.AdminOverviewRoute = Ember.Route.extend(
  setupController: (controller, model) ->
    controller.set 'fromDate', moment().startOf('month').format('YYYY-MM-DD')
    controller.set 'toDate', moment().endOf('month').format('YYYY-MM-DD')
    controller.send('filter')
)


