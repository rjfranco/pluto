Pluto.SignUpView = Em.View.extend
  didInsertElement: ->
    @set 'controller.form', $('#signup-form')
    @get('controller.form').validate
      rules:
        name: 'required'
        email:
          required: true
          email: true
        'profile-url':
          required: true
          regex: '^[a-zA-Z\d\-]+$'
      messages:
        'profile-url':
          regex: 'You can only use letters, numbers, and hyphens.'
