#!/usr/bin/env ruby

require 'example3'
require 'test/unit'

class Example3Tester < Test::Unit::TestCase
  def test_example_module
    assert_equal(1.3, ExampleModule::sqrt_the_float(1.69))
    assert_equal(144, ExampleModule::square_the_integer(12))
    assert_equal("cat cat cat ", ExampleModule::cat_the_string("cat "))
    #D casting magic!
    assert_equal(144, ExampleModule::square_the_integer(12.5))
  end
end
