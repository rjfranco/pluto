Pluto.IndexView = Em.View.extend
  classNames: ['full-height']
  didInsertElement: ->
    $('.entry-form').validate
      rules:
        time: 'required'
      messages:
        time: 'How many hours do you need to log?'
