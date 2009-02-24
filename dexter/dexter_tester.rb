#!/usr/bin/env ruby

require 'dexter'
require 'test/unit'

class DexterTester < Test::Unit::TestCase
  def test_module_defined_properly
    assert_equal(DexterClass.class, Class)
    assert_equal(DexterClass.superclass, Object)
    d = DexterClass.new
    assert_equal(d.return_ten, 10)
    assert_equal(d.arr, [])
    d.add(1)
    d.add(2)
    assert_equal(d.arr, [1,2])
    
    assert_equal(DexterModule.class, Module)
    assert_equal(DexterModule::return_ten, 10)
  end
  
end
