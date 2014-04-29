App.UsersView = Em.View.extend
  template: Em.TEMPLATES['users/list']
  didInsertElement: ->
    debugger
    @$('#usersList').slimScroll
      height: "#{$(window).height() - 150}px"
      size: "25px"
      position: "left"
      color: "#AAA"
      alwaysVisible: true
      distance: "10px"
      allowPageScroll: false
      disableFadeOut: false
