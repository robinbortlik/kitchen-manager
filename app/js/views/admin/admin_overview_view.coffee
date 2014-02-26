App.AdminOverviewView = Em.View.extend
  template: Em.TEMPLATES['admin/overview/index']
  layout: Em.TEMPLATES['admin/layouts/admin_layout']
  actions:
    export: ->
      window.location.href = "/product_users.csv?from=#{@get('controller.fromDate')}&to=#{@get('controller.toDate')}"


App.AdminOverviewRowView = Em.View.extend
  template: Em.TEMPLATES['admin/overview/row']
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