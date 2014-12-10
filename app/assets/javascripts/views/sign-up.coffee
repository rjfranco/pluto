Pluto.SignUpView = Em.View.extend
  didInsertElement: ->
    @set 'controller.form', $('#signup-form')
    @get('controller.form').validate
      rules:
        'user[name]': 'required'
        'user[email]':
          required: true
          email: true
        'user[profile-url]':
          required: true
          regex: '^[a-zA-Z\d\-]+$'
      messages:
        'user[profile-url]':
          regex: 'You can only use letters, numbers, and hyphens.'
