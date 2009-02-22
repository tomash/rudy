#!/usr/bin/env ruby

require 'dexter'
require 'test/unit'

class DexterTester < Test::Unit::TestCase
  def test_module_defined_properly
    assert_equal(Dexter.class, Class)
    assert_equal(Dexter.superclass, Object)
    assert_equal(Dexter.new.return_ten, 10)
  end
  
end
