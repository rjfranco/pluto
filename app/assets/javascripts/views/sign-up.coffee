Pluto.SignUpView = Em.View.extend
  didInsertElement: ->
    @set 'controller.form', $('#signup-form')
    @get('controller.form').validate
      rules:
        'user[name]': 'required'
        'user[email]':
          required: true
          email: true
        'user[profile_url]':
          required: true
          regex: '^[a-zA-Z\d\-]+$'
        'user[password]':
          required: true
          minlength: 8
        'user[password_confirmation]':
          equalTo: '#password'
      messages:
        'user[profile_url]':
          regex: 'You can only use letters, numbers, and hyphens.'
