Pluto.IndexController = Em.Controller.extend
  needs: ['user']

  actions:
    submitEntry: ->
      formData = @getEntryFormData()
      # Pretend to submit the form then show success ->
      @showNewLog formData.time

    signOut: ->
      @get('controllers.user').signOut()

  userLoggedIn: Em.computed ->
    !!@get('controllers.user.content')
  .property('controllers.user.content')

  dayBefore: moment().subtract(2, 'days').format('MMM Do')

  dayBeforeValue: moment().subtract(2, 'days').format('L')

  yesterday: moment().subtract(1, 'days').format('MMM Do')

  yesterdayValue: moment().subtract(1, 'days').format('L')

  todayValue: moment().format('L')

  getEntryFormData: ->
    formData = {}
    for field in $('.entry-form').serializeArray()
      formData[field.name] = field.value
    formData

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


  parseHours: (time) ->
    parseInt time.match(/^\d+/)[0]

  parseMinutes: (time) ->
    parseInt time.match(/\d+$/)[0]
