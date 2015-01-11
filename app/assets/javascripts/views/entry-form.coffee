Pluto.EntryFormView = Em.View.extend
  classNames: ['full-height']
  templateName: 'entry-form'

  didInsertElement: ->
    @setupFormValidation()
    @setupDatePicker()

  setupFormValidation: ->
    $('.entry-form').validate
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

    controller.set 'datepicker', controller.get('datepickerfield').pickadate('picker')

    controller.get('datepicker').on 'close', =>
      new_value = controller.get('datepicker').get('select', 'mm/dd/yyyy')

      if new_value
        new_display_date = moment(new_value, 'L').format('MMM Do')
        $('[for="selected-date"]').text new_display_date
        $('#selected-date').val(new_value).prop('checked', true)
      else
        $('[for="selected-date"]').html @get('default_calendar_tab')
        $('#today').prop('checked', true)
