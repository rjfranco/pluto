Pluto.IndexView = Em.View.extend
  classNames: ['full-height']
  didInsertElement: ->
    @setupFormValidation()
    @setupDatePicker()

  setupFormValidation: ->
    $('.entry-form').validate
      rules:
        time: 'required'
      messages:
        time: 'How many hours do you need to log?'

  setupDatePicker: ->
    @controller.set 'datepickerfield', $('#selected-date-input').pickadate
      hiddenName: true
      max: -3
    @controller.set 'datepicker', @controller.get('datepickerfield').pickadate('picker')

    @controller.get('datepicker').on 'close', =>
      new_value = @controller.get('datepicker').get('value', 'mm/dd/yyyy')
      $('#selected-date').val(new_value).prop('checked', true) if new_value
