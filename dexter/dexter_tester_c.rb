require 'dexter'
require 'test/unit'

class MyTestTester < Test::Unit::TestCase
  def test_object_and_add
    assert_equal(Object, MyTest.superclass)
    t = MyTest.new
    assert_equal(MyTest, t.class)
    assert_equal([], t.arr)
    t.add(1)
    t.add(2)
    assert_equal([1,2], t.arr)
  end
  
  def test_native_add
    t = MyTest.new
    assert_equal([], t.arr)
    t.native_add(3)
    t.native_add(4)
    assert_equal([3,4], t.arr)
  end
  
  def test_add_string_first_letter
    t = MyTest.new
    assert_equal([], t.arr)
    t.add_string_first_letter("showtime!")
    t.add_string_first_letter("tratatata")
    assert_equal(["s","t"], t.arr)
  end
end
