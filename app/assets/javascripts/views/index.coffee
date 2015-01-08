Pluto.IndexView = Em.View.extend
  didInsertElement: ->
    $('.entry-form').validate
      rules:
        time: 'required'
      messages:
        time: 'How many hours do you need to log?'
