Pluto.IndexController = Em.Controller.extend
  needs: ['user']

  actions:
    submitEntry: ->
      form_data = @getEntryFormData()
      # Pretend to submit the form then show success ->
      @submitEntryRequest(form_data).then =>
        @showNewLog form_data.unformatted_time
        @clearForm()

    triggerCalendar: ->
      unless @get('datepicker').get('open')
        setTimeout =>
          @get('datepicker').open()
        , 0

    signOut: ->
      @get('controllers.user').signOut()

  userLoggedIn: Em.computed ->
    !!@get('controllers.user.model')
  .property('controllers.user.model')

  dayBefore: moment().subtract(2, 'days').format('MMM Do')

  dayBeforeValue: moment().subtract(2, 'days').format('L')

  yesterday: moment().subtract(1, 'days').format('MMM Do')

  yesterdayValue: moment().subtract(1, 'days').format('L')

  todayValue: moment().format('L')

  profileURL: Em.computed ->
    user = @get('controllers.user.model')
    user.get('profile_url')
  .property('controllers.user.model.profile_url')

  submitEntryRequest: (form_data) ->
    $.ajax
      url: '/logs'
      type: 'post'
      dataType: 'json'
      data:
        authenticity_token: $('meta[name="csrf-token"]').attr('content')
        log: form_data

  getEntryFormData: ->
    form_data = {}
    for field in $('.entry-form').serializeArray()
      form_data[field.name] = field.value
    form_data.time = @getMinutes form_data.unformatted_time
    form_data

  showNewLog: (time) ->
    hours = @parseHours time
    minutes = @parseMinutes time
    # insert dom element

    $('.entry-form').after """<p class="log-notice">You have logged #{hours.toWord().toLowerCase()} hours and #{minutes.toWord().toLowerCase()} minutes.</p>"""

    $log = $('.log-notice')

    # fade in log notice
    $log.transition
      y: 0
      opacity: 1

    setTimeout =>
      $log.transition
        y: '100%'
        opacity: 0
      , ->
        $log.remove()
    , 2300

  clearForm: ->
    $('.entry-form .time input[type=text]').val('')

  getMinutes: (time) ->
    (@parseHours(time) * 60) + @parseMinutes(time)

  parseHours: (time) ->
    parseInt time.match(/^\d+/)[0]

  parseMinutes: (time) ->
    parseInt time.match(/\d+$/)[0]
