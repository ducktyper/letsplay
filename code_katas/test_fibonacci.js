// Fibonacci
// https://en.wikipedia.org/wiki/Fibonacci_number
// calculate(input) #=> output
// input(Fn)  -8  -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7  8
// output     −21 13 −8  5 −3  2 −1  1 0 1 1 2 3 5 8 13 21

var assert = require('assert');
var fibonacci = require('./fibonacci.js');

// zero to one
assert.equal(0, fibonacci.calculate(0));
assert.equal(1, fibonacci.calculate(1));

// two to four
assert.equal(1, fibonacci.calculate(2));
assert.equal(2, fibonacci.calculate(3));
assert.equal(3, fibonacci.calculate(4));

// large
assert.equal(5, fibonacci.calculate(5));
assert.equal(144, fibonacci.calculate(12));

// negative one to negative four
assert.equal(1, fibonacci.calculate(-1));
assert.equal(-1, fibonacci.calculate(-2));
assert.equal(2, fibonacci.calculate(-3));
assert.equal(-3, fibonacci.calculate(-4));
