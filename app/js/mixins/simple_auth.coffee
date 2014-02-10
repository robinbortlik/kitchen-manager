window.SimpleAuth = Em.Mixin.create
  beforeModel: (transition) ->
    unless window.password
      window.password = prompt("Admin password")
    unless CryptoJS.MD5("#{window.password}").toString() == "06c1653a2fea476a1966f3052c40b14d"
      transition.abort()