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
  
  def test_string_duplication
    d = DexterClass.new
    str = "somestring"
    d.duplicate_a_string_and_add_it_two_times(str)
    assert_equal([str, str], d.arr)
    #first is without modification (plain dup), second is after rb_str_modify
    assert_not_same(str, d.arr[0])
    assert_not_same(str, d.arr[1])
  end
  
  def test_string_concatenation
    d = DexterClass.new
    str = "I haz bin catted!"
    str2 = d.str_cat(str)
    assert(str2.index(str))
  end
  
  def test_rudyobject
    d = DexterClass.new
    d.add(44)
    d.add(15.5)
    f = d.get_arr_first_and_add_ten
    assert_equal(f, 54)
    d.arr.shift
    puts d.inspect
    f = d.get_arr_first_and_square
    assert_equal(240.25, f)
  end
  
  def test_module_and_its_methods
    assert_equal(DexterModule.class, Module)
    assert_equal(DexterModule::return_ten, 10)
    assert_raise ArgumentError do 
      DexterModule::throw_an_exception
    end
  end
  
end
