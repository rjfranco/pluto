Pluto.Log = Em.Object.extend Pluto.TimeManipulation,
  # This is just here to fix a coffeescript compilation error
  # where it has decided I'm not passing an object if all I pass are computed
  # functions.
  klass: 'log'

  displayDate: Em.computed ->
    moment(@get('date')).format 'dddd, MMMM Do YYYY'
  .property('date')

  displayTime: Em.computed ->
    @formattedTime @get('time')
  .property 'time'

  location: Em.computed ->
    if @get('remote') then 'Off-site' else 'On-site'
  .property 'remote'
