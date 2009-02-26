#!/usr/bin/env ruby

require 'dexter'
require 'test/unit'

class DexterTester < Test::Unit::TestCase
  def test_class_and_its_methods
    assert_equal(DexterClass.class, Class)
    assert_equal(DexterClass.superclass, Object)
    d = DexterClass.new
    assert_equal(d.return_ten, 10)
    assert_equal(d.arr, [])
    d.add(1)
    d.add(2)
    assert_equal(d.arr, [1,2])
    d.native_add(22)
    assert_equal(d.arr, [1,2, 22])
    d.add_strings_first_letter("showtime!")
    d.add_strings_first_letter("tratatata")
    assert_equal([1,2, 22,"s","t"], d.arr)
  end
  
  def test_module_and_its_methods
    assert_equal(DexterModule.class, Module)
    assert_equal(DexterModule::return_ten, 10)
    assert_raise ArgumentError do 
      DexterModule::throw_an_exception
    end
  end
  
end
