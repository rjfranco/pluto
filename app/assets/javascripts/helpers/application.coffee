Em.Handlebars.helper 'svg', (value, options) ->
  new Em.Handlebars.SafeString """
    <svg viewBox="0 0 8 8">
      <use xlink:href="/assets/open-iconic.min.svg##{value}"></use>
    </svg>
  """
