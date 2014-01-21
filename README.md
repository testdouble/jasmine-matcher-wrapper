# jasmine-matcher-wrapper

This is a Jasmine 2.0 helper for users who want to use legacy Jasmine 1.x matchers under Jasmine 2.0.

This may be particularly useful to anyone who publishes Jasmine support libraries and wants to maintain support of both Jasmine 1.x and 2.x simultaneously.

[Download the latest release here](https://github.com/testdouble/jasmine-matcher-wrapper/releases/latest)

## Usage

Usage is really easy.

Say that you have some jasmine 1.x matchers in an object:

``` javascript
var jasmine1Matchers = {
  toBeNamed: function(name) {
    var color = this.actual;
    this.message = function() {
      return "expected foo to be " + name + " but was " + color.name;
    };
    return color.name === name;
  }
};
```

And you want to use them in jasmine 2.x, which provides a `jasmine.addMatchers` function (absent from jasmine 1.x). After loading jasmine-matcher-wrapper you can:

``` javascript
jasmine.addMatchers(jasmine.matcherWrapper.wrap(jasmine1Matchers));
```

And now a failing spec like this:

```
expect(name: "yellow").toBeNamed("red")
```

Will both fail the test and print out the message you would expect:

```
expected foo to be red but was yellow
Error: expected foo to be red but was yellow
    at stack (http://localhost:7357/testem/jasmine2.js:1293:17)
    at buildExpectationResult (http://localhost:7357/testem/jasmine2.js:1270:14)
    at Spec.Env.expectationResultFactory (http://localhost:7357/testem/jasmine2.js:484:18)
    at Spec.addExpectationResult (http://localhost:7357/testem/jasmine2.js:260:46)
    at Expectation.addExpectationResult (http://localhost:7357/testem/jasmine2.js:442:21)
    at Expectation.toBeNamed (http://localhost:7357/testem/jasmine2.js:1209:12)
    at Object.<anonymous> (http://localhost:7357/generated/js/spec.js:22:10)
    at attemptSync (http://localhost:7357/testem/jasmine2.js:1510:12)
    at QueueRunner.run (http://localhost:7357/testem/jasmine2.js:1498:9)
    at QueueRunner.execute (http://localhost:7357/testem/jasmine2.js:1485:10)
```
