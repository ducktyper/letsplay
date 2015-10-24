# Fibonacci
# https://en.wikipedia.org/wiki/Fibonacci_number
# Fibonacci.new.calculate(input) #=> output
# input(Fn)  -8  -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7  8
# output     −21 13 −8  5 −3  2 −1  1 0 1 1 2 3 5 8 13 21

require "minitest/autorun"
require "./fibonacci"

class TestFibonacci < Minitest::Test

  def test_zero_to_one
    assert_equal 0,   subject.calculate(0)
    assert_equal 1,   subject.calculate(1)
  end

  def test_two_to_four
    assert_equal 1,   subject.calculate(2)
    assert_equal 2,   subject.calculate(3)
    assert_equal 3,   subject.calculate(4)
  end

  def test_large
    assert_equal 5,   subject.calculate(5)
    assert_equal 144, subject.calculate(12)
  end

  def test_negative_one_to_negative_four
    assert_equal 1,   subject.calculate(-1)
    assert_equal -1,  subject.calculate(-2)
    assert_equal 2,   subject.calculate(-3)
    assert_equal -3,  subject.calculate(-4)
  end

  def test_large_negative
    assert_equal 5,   subject.calculate(-5)
    assert_equal -21, subject.calculate(-8)
  end

  private

  def subject
    @subject ||= Fibonacci.new
  end

end
