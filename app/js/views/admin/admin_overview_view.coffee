App.AdminOverviewView = Em.View.extend
  layout: App.AdminLayoutView.template

  template: Em.Handlebars.compile """
    <h1>Overview</h1>
    <p>
      <form class="form-inline">
        <div class="form-group">
          <label class="control-label">From</label>
          {{view App.DateInput valueBinding='controller.fromDate'}}
          <label class="control-label">To</label>
          {{view App.DateInput valueBinding='controller.toDate'}}
          <button type="button" class="btn btn-primary" {{action 'filter' target='view.controller'}}>
            <span class="glyphicon glyphicon-retweet"></span> Filter
          </button>
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
    not @get('userProducts').find((up) -> not Em.get(up,'isPaid') )
  ).property("userProducts")

  notPaid: (->
    @get('userProducts').filter((up) -> not Em.get(up,'isPaid') ).sum('price').toFixed(2)
  ).property("userProducts")

  paid: (->
    @get('userProducts').filterProperty('isPaid').sum('price').toFixed(2)
  ).property("userProducts")

  template: Em.Handlebars.compile """
    <td>{{view.content.name}}</td>
    {{#each view.computedContent}}
      <td>{{this}}</td>
    {{/each}}
    {{#if view.isPaid}}
      <td><strong class="text-success">{{formatMoney view.total}}</strong></td>
    {{else}}
      <td><strong class="text-danger">{{formatMoney view.total}}</strong>&nbsp;<small>({{view.notPaid}}/{{view.paid}})</small></td>
    {{/if}}
  """