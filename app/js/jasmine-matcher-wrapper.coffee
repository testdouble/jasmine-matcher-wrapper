((jasmine) ->
  return console?.warn("jasmine was not found. Skipping jasmine-matcher-wrapper. Verify your script load order.") unless jasmine?
  return if jasmine.matcherWrapper?

  jasmine.matcherWrapper =
    wrap: (matchers) ->
      return matchers unless jasmine.addMatchers?
      wrappedMatchers = {}
      for own name, matcher of matchers
        wrappedMatchers[name] = createMatcher(name, matcher)

      wrappedMatchers

  createMatcher = (name, matcher)  ->
    ->
      compare: comparatorFor(matcher, false)
      negativeCompare: comparatorFor(matcher, true)

  comparatorFor = (matcher, isNot) ->
    (actual, params...) ->
      context = {actual, isNot}
      pass = matcher.apply(context, params)
      pass = !pass if isNot
      message = context.message?.apply(context, params) unless pass
      {pass, message}

)(jasmine || getJasmineRequireObj())
