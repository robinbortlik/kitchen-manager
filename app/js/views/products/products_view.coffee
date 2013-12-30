App.ProductsView = Em.View.extend(
  contentBinding: 'controller.activeProducts'
  template: Em.Handlebars.compile """
    <div class="col-md-9">
      {{#each controller.activeProducts}}
        {{view App.ProductView contentBinding="this"}}
      {{/each}}
    </div>
  """
)