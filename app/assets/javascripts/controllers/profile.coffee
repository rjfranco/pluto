Pluto.ProfileController = Em.Controller.extend Pluto.TimeManipulation,
  needs: ['user', 'logs']

  actions:
    triggerCalendar: (picker) ->
      unless @get(picker).get('open')
        setTimeout =>
          @get(picker).open()
        , 0

    signOut: ->
      @get('controllers.user').signOut()

  formattedStartDate: Em.computed ->
    moment(@get('start_date')).format 'MMM Do'
  .property 'start_date'

  formattedEndDate: Em.computed ->
    if @get('end_date') is moment().format('YYYY-MM-DD')
      'Today'
    else
      moment(@get('end_date')).format 'MMM Do'
  .property 'end_date'

  userLoggedIn: Em.computed ->
    !!@get('controllers.user.model')
  .property('controllers.user.model')

  totalHours: Em.computed ->
    @formattedTime @get('controllers.logs.totalTime')
  .property('controllers.logs.totalTime')

  offsiteHours: Em.computed ->
    @formattedTime @get('controllers.logs.offsiteTime')
  .property('controllers.logs.offsiteTime')

  onsiteHours: Em.computed ->
    @formattedTime @get('controllers.logs.onsiteTime')
  .property('controllers.logs.onsiteTime')
