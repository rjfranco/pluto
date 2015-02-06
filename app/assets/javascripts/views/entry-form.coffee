Pluto.EntryFormView = Em.View.extend
  classNames: ['full-height']
  templateName: 'entry-form'

  didInsertElement: ->
    @setupFormValidation()
    @setupDatePicker()

  setupFormValidation: ->
    @set 'controller.validator', $('.entry-form').validate
      rules:
        unformatted_time: 'required'
      messages:
        unformatted_time: 'How many hours do you need to log?'

  setupDatePicker: ->
    @set 'default_calendar_tab', $('[for="selected-date"]').html()

    controller = @get('controller')

    controller.set 'datepickerfield', $('#selected-date-input').pickadate
      hiddenName: true
      max: -3
      clear: false
      today: false

    controller.set 'datepicker', controller.get('datepickerfield').pickadate('picker')

    controller.get('datepicker').on 'close', =>
      new_value = controller.get('datepicker').get('select', 'yyyy-mm-dd')

      if new_value
        new_display_date = moment(new_value).format('MMM Do')
        $('[for="selected-date"]').text new_display_date
        $('#selected-date').val(new_value).prop('checked', true)
      else
        # This else conditional may be unceccesary when not allowing clear
        $('[for="selected-date"]').html @get('default_calendar_tab')
        $('#today').prop('checked', true)
