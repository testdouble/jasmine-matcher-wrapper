# This is obviously *not* actually a test, just used it to manually
#   interrogate the test runner.

describe "jasmine.matcherWrapper", ->
  it 'wraps', ->
    jasmine1Matchers =
      toBeNamed: (name) ->
        color = @actual
        @message = ->
          "expected foo to be #{name} but was #{color.name}"
        color.name == name

    jasmine.addMatchers(jasmine.matcherWrapper.wrap(jasmine1Matchers))

    expect(name: "yellow").toBeNamed("yellow")


