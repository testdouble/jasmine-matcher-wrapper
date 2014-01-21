((jasmine) ->
  return console?.warn("jasmine was not found. Skipping jasmine-matcher-wrapper. Verify your script load order.") unless jasmine?
  return if jasmine.matcherWrapper?

  comparatorFor = (matcher, isNot) ->
    (actual, params...) ->
      context = {actual, isNot}
      pass = matcher.apply(context, params)
      pass = !pass if isNot
      message = context.message?.apply(context, params) unless pass
      {pass, message}

  jasmine.matcherWrapper =
    wrap: (matchers) ->
      return matchers unless jasmine.addMatchers?
      wrappedMatchers = {}
      for own name, matcher of matchers
        wrappedMatchers[name] = ->
          compare: comparatorFor(matcher, false)
          negativeCompare: comparatorFor(matcher, true)
      wrappedMatchers

)(jasmine || getJasmineRequireObj())
