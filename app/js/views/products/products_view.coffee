App.ProductsView = Em.View.extend(
  contentBinding: 'controller.activeProducts'
  actions:
    filter: (category) -> @set "selectedCategoryId", category.get("id")

  filteredProducts: (->
    if @get("selectedCategoryId")
      @get("controller.activeProducts").filterBy('category_id', @get("selectedCategoryId"))
    else
      if cat = App.get("store.categories")[0]
        @get("controller.activeProducts").filterBy('category_id', cat.get("id"))
      else
        @get("controller.activeProducts")
  ).property('content', 'selectedCategoryId')

  chunkedProducts:(-> @get("filteredProducts").chunk(4)).property("filteredProducts")

  template: Em.Handlebars.compile """
    <div class="col-xs-9">
      <ul class="nav nav-tabs">
        {{#each App.store.categories}}
          <li><a {{action 'filter' this target='view'}} data-category-id="{{unbound id}}" data-toggle="tab">{{unbound name}}</a></li>
        {{/each}}
      </ul>

      <div class="tab-content">
        <br/ >
        {{#each products in view.chunkedProducts}}
          <div class="row">
            {{#each products}}
              {{view App.ProductView contentBinding="this"}}
            {{/each}}
          <br/>
          </div>
        {{/each}}
      </div>
    </div>
  """

  didInsertElement: ->
    $(".nav-tabs li:first").addClass("active")
)