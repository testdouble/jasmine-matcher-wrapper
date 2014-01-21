((jasmine) ->
  return console?.warn("jasmine was not found. Skipping jasmine-matcher-wrapper. Verify your script load order.") unless jasmine?
  return if jasmine.matcherWrapper?

  jasmine.matcherWrapper =
    wrap: (matchers) ->
      return matchers unless jasmine.addMatchers?
      wrappedMatchers = {}
      for own name, matcher of matchers
        wrappedMatchers[name] = ->
          compare: (actual, params...) ->
            context = {actual}
            pass = matcher.apply(context, params)
            message = context.message?.apply(context, params) unless pass
            {pass, message}
      wrappedMatchers

)(jasmine || getJasmineRequireObj())
