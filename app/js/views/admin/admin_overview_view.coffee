App.AdminOverviewView = Em.View.extend
  layout: App.AdminLayoutView.template

  template: Em.Handlebars.compile """
    <h1>Overview</h1>
    <p>
      <form class="form-inline">
        <div class="form-group">
          <label class="control-label">From
            {{view App.DatePicker valueBinding='controller.fromDate'}}
          </label>
          <label class="control-label">To
            {{view App.DatePicker valueBinding='controller.toDate'}}
          </label>
        </div>
      </form>
    </p>
    <table class="table table-striped  table-hover table-bordered">
      <thead>
        <th>Name</th>
        {{#each App.store.products}}
          <th>{{name}}<br/>{{formatMoney price}}</th>
        {{/each}}
        <th>Sum</th>
        <th></th>
      </thead>
      <tbody>
        {{#each App.store.users}}
          {{view App.AdminOverviewRowView contentBinding="this"}}
        {{/each}}
      </tbody>
    </table>
  """

App.AdminOverviewRowView = Em.View.extend
  tagName: 'tr'
  userProducts: (-> Em.makeArray(@get('controller.content')).filterProperty 'user_id', @get('content.id')).property('controller.content')

  computedContent: (->
    tmp = []
    for product in App.get('store.products')
      tmp.push @get('userProducts').filterProperty('product_id', product.get('id')).length
    tmp
  ).property('userProducts')

  total: (->
    @get('userProducts').sum('price').toFixed(2)
  ).property('userProducts')

  isPaid: (->
    not @get('userProducts').find((up) -> not Em.get(up,'is_paid') )
  ).property("userProducts")

  notPaid: (->
    @get('userProducts').filter((up) -> not Em.get(up,'is_paid') ).sum('price').toFixed(2)
  ).property("userProducts")

  paid: (->
    @get('userProducts').filterProperty('is_paid').sum('price').toFixed(2)
  ).property("userProducts")

  actions:
    togglePay: ->
      if confirm("Are you sure?")
        is_paid = not @get('isPaid')
        $.ajax(
          type: "PUT"
          url: 'product_users/update_is_paid'
          data: {ids: @get("userProducts").mapProperty("id"), is_paid: is_paid}
          success: (response) =>
            @get("userProducts").setEach("is_paid", is_paid)
            App.FlashMessageView.createMessage("Paid status was set to #{is_paid}", 'success')
            @propertyDidChange("userProducts")

          error: (response) ->
            App.FlashMessageView.createMessage("We are sorry but something were wrong. Try it again later.", 'danger')
        )

  didInsertElement: ->
    setTimeout ->
      $("[data-toggle=tooltip]").tooltip()
    , 500

  template: Em.Handlebars.compile """
    <td>{{view.content.name}}</td>
    {{#each view.computedContent}}
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
    <td {{bind-attr class="view.isPaid:text-success"}}><i {{action "togglePay" target="view"}} class="glyphicon glyphicon-check"></i></td>
  """