App.OrderMonthOverviewView = Em.View.extend(

  template: Em.Handlebars.compile """
    <h1>
      {{App.currentUser.name}}'s report {{view.controller.month}} {{view.controller.year}}
      {{#link-to 'order.yearOverview' App.currentUser.id view.controller.year class="btn btn-danger pull-right"}}Back{{/link-to}}
    </h1>
    <table class="table table-striped  table-hover table-bordered">
      <tbody>
        {{#each dayNumbers}}
          {{view App.RowOrderMonthOverviewView contentBinding="this"}}
        {{/each}}
      </tbody>
    </table>
  """
)

App.RowOrderMonthOverviewView = Em.View.extend(
  tagName: "tr"
  orderedProducts: (->
    Em.makeArray(@get('controller.monthProducts')).filter (userProduct) =>
      moment(Em.get(userProduct, 'created_at')).get('date') == @get("content")
  ).property('controller.monthProducts')

  template: Em.Handlebars.compile """
    <td>{{unbound view.content}}</td>
    <td>
      {{#each view.orderedProducts}}
        <span class="pill">{{unbound name}} {{formatMoney price}}</span>
      {{/each}}
    </td>
  """
)
