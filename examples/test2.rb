#!/usr/bin/env ruby

require 'example2'
require 'test/unit'

class Example2Tester < Test::Unit::TestCase
  def test_example_module
    assert_equal(true, ExampleModule::return_bool)
    assert_equal(nil, ExampleModule::return_null)
    assert_equal(2009, ExampleModule::return_integer)
    assert_equal(20.09, ExampleModule::return_float)
    assert_equal(["array", "of", "strings"], ExampleModule::return_array_of_strings)
    assert_equal({"registry" => 30.0, "plane" => 165.5, "hotel" => 59.90}, ExampleModule::return_hash_of_floats)
  end


end
