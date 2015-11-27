# Fizz Buzz
# https://en.wikipedia.org/wiki/Fizz_buzz
# FizzBuzz.new.convert(input) #=> output
# output is input if input is not divisible by 3 and 5
# output is "Fizz" if input is divisible by 3
# output is "Buzz" if input is divisible by 5
# output is "Fizz Buzz" if input is divisible by 3 and 5

require "minitest/autorun"
require "./fizz_buzz"

class TestFizzBuzz < Minitest::Test
  def test_convert_number
    [1, 2, 101].each {|i| assert_equal i.to_s, subject.convert(i) }
  end

  def test_convert_fizz
    [3, 6, 99].each {|i| assert_equal "Fizz", subject.convert(i) }
  end

  def test_convert_buzz
    [5, 10, 100].each {|i| assert_equal "Buzz", subject.convert(i) }
  end

  def test_convert_fizz_buzz
    [15, 30, 300].each {|i| assert_equal "Fizz Buzz", subject.convert(i) }
  end

  private

  def subject
    @subject ||= FizzBuzz.new
  end
end
