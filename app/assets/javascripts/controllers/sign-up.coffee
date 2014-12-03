Pluto.SignUpController = Em.Controller.extend
  actions:
    signUp: ->
      console.log @get('form').valid()
