#!/usr/bin/env ruby

require 'example4'
require 'test/unit'

class Example4Tester < Test::Unit::TestCase
  def test_example_module
    assert_equal(false, ExampleModule::compare_wrapped_strings("euruko2008", "euruko2009"))
    assert_equal(true, ExampleModule::compare_wrapped_strings("euruko2010", "euruko2010"))
  end
end
