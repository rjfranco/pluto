Pluto.IndexController = Em.Controller.extend
  needs: ['user']

  actions:
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
