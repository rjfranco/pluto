$.validator.addMethod 'regex', (value, element, regexp) ->
  re = new RegExp(regexp)
  @optional(element) || re.test(value)
, 'Please check your value.'
