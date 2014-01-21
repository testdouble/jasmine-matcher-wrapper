require('coffee-script');
if(!global.jasmine) { require('minijasminenode') }
require('./app/js/jasmine-matcher-wrapper');
module.exports = jasmine.matcherWrapper;
