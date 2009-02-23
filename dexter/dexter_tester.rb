#!/usr/bin/env ruby

require 'dexter'
require 'test/unit'

class DexterTester < Test::Unit::TestCase
  def test_module_defined_properly
    assert_equal(DexterClass.class, Class)
    assert_equal(DexterClass.superclass, Object)
    assert_equal(DexterClass.new.return_ten, 10)
    
    assert_equal(DexterModule.class, Module)
    assert_equal(DexterModule::return_ten, 10)
  end
  
end
