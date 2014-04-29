App.UsersView = Em.View.extend
  template: Em.TEMPLATES['users/list']
  didInsertElement: ->
    el = @$('#usersList')
    el.slimScroll
      height: "#{el.height() - 550}px"
      size: "25px"
      position: "left"
      color: "#AAA"
      alwaysVisible: true
      distance: "10px"
      allowPageScroll: false
      disableFadeOut: false
