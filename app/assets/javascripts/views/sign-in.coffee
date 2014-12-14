Pluto.SignInView = Em.View.extend
  didInsertElement: ->
    @set 'controller.form', $('#signin-form')
    @get('controller.form').validate
      rules:
        'user[email]':
          required: true
          email: true
        'user[password]':
          required: true
          minlength: 8
