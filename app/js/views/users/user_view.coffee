App.UserView = Em.View.extend(
  classNameBindings: [":col-xs-3", "content.visible::hidden"]
  click: -> @get('controller').transitionToRoute "order", {id: @get("content.id")}

  template: Em.Handlebars.compile """
    {{#if view.content.image}}
      <img class="img-circle img-responsive" alt="90x90" style="width: 90px; height: 90px;" {{bind-attr src="view.content.image"}}>
    {{else}}
      <img class="img-circle img-responsive" style="width: 90px; height: 90px; background-color: #EEE"/>
    {{/if}}
    <h5>{{view.content.name}}</h5>
  """
)