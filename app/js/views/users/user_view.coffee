App.UserView = Em.View.extend(
  classNames: ["col-lg-3"]
  click: -> @get('controller').transitionToRoute "order", {id: @get("content.id")}

  template: Em.Handlebars.compile """
    {{#if view.content.image}}
      <img class="img-circle" alt="140x140" style="width: 140px; height: 140px;" {{bind-attr src="view.content.image"}}>
    {{else}}
      <img class="img-circle" style="width: 140px; height: 140px; background-color: #EEE"/>
    {{/if}}
    <h4>{{view.content.name}}</h4>
  """
)