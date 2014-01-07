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
    (@get('userProducts').reduce ((x,y) -> x + parseFloat(Em.get(y, 'price')) ), 0).toFixed(2)
  ).property('userProducts')

  template: Em.Handlebars.compile """
    <td>{{view.content.name}}</td>
    {{#each view.computedContent}}
      <td>{{this}}</td>
    {{/each}}
    <td class="text-danger"><strong>{{formatMoney view.total}}</strong></td>
  """