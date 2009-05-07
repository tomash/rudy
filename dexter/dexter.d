module rudy.dexter;

import bcd.ruby;
import rudy.rudy;

//only for debugging messages
import std.stdio;

/* make D's GC work with C-oriented functions
 * straight from PyD:
 * http://dsource.org/projects/pyd/browser/trunk/infrastructure/d/python_so_linux_boilerplate.d
 */
extern(C) {
  void gc_init();
  void gc_term();
  
  void _init() {
    gc_init();
  }
  
  void _fini() {
    gc_term();
}

} /* extern(C) */

alias VALUE(*func_type)();
extern (C) VALUE method_return_ten();
extern (C) VALUE class_init();
extern (C) VALUE class_arr();
extern (C) VALUE class_add();
extern (C) VALUE class_native_add();
extern (C) VALUE class_add_strings_first_letter();
extern (C) VALUE class_duplicate_a_string_and_add_it_two_times();
extern (C) VALUE class_str_cat();
extern (C) VALUE module_throw_an_exception();
extern (C) VALUE module_throw_a_fatal();
extern (C) VALUE get_arr_first_and_add_ten();
extern (C) VALUE get_arr_first_and_square();
extern (C) VALUE create_and_compare_two_equal_ruby_integers();
extern (C) VALUE create_and_compare_two_not_equal_ruby_integers();
extern (C) VALUE class_add_integer();
extern (C) VALUE class_add_float();
extern (C) VALUE class_add_string();
extern (C) VALUE class_add_complex();
extern (C) VALUE class_add_array();
extern (C) VALUE class_add_hash();
extern (C) VALUE the_new_fifteen();
extern (C) VALUE convert_integer_two_ways();
extern (C) VALUE convert_float_two_ways();
extern (C) VALUE convert_string_two_ways();
extern (C) VALUE convert_bool_two_ways();
extern (C) VALUE DexterClass = 0;
extern (C) VALUE DexterModule = 0;

//toStringz from phobos - where is this in Tango?
//DO NOT pass strings to C functions without calling this function on passed D string

//goddamit, Im confused:
//http://www.digitalmars.com/d/1.0/interfaceToC.html
//ruby api functions operating on C strings segfault when passing a (pointer to) string with ~ \0
extern (C) char* cstr(string input)
{
  return input.ptr;
}
/* NOTE: below in function calls untouched D string (wchar[]) literals
are passed to C functions; this is because string literals (i.e. declared fully in code)
are 0-terminated and are therefore "safe"; this is NOT a practice to follow, so code refactoring
may be appropiate */

int id_push;

// Our 'test1' method.. it simply returns a value of '10' for now.
extern (C) VALUE method_return_ten(VALUE self) {
  int x = 10;
  //return INT2NUM(x);
  return rb_int2inum(x);
}

extern (C) VALUE class_init(VALUE self)
{
  VALUE arr;
  arr = rb_ary_new();
  rb_iv_set(self, "@arr", arr);
  return self;
}

extern (C) VALUE class_arr(VALUE self)
{
  VALUE arr;
  arr = rb_iv_get(self, "@arr");
  return arr;
}

extern (C) VALUE class_add(VALUE self, VALUE obj)
{
  VALUE arr;
  arr = rb_iv_get(self, "@arr");
  rb_funcall(arr, id_push, 1, obj);
  return arr;
}

extern (C) VALUE class_native_add(VALUE self, VALUE obj)
{
  // convert to native type:
  VALUE val = rb_num2long(obj);
  // convert back to ruby-type
  VALUE toadd = rb_int2inum(val);
  // and push ruby type
  VALUE arr = rb_iv_get(self, "@arr");
  rb_funcall(arr, id_push, 1, toadd);
  return arr;
}

extern (C) VALUE class_add_strings_first_letter(VALUE self, VALUE obj)
{
  // conversion:
  //obsolete - use convenient and implemented StringValue
  //VALUE str = rb_string_value(&obj);
  //RString* str_struct = cast(RString*)str; // where str is a VALUE
  VALUE str = StringValue(obj); 
  RString* str_struct = RSTRING(str);
  VALUE toadd = rb_str_new(str_struct.ptr, 1);
  
  VALUE arr = rb_iv_get(self, "@arr");
  rb_funcall(arr, id_push, 1, toadd);
  
  return toadd;
}

extern (C) VALUE class_duplicate_a_string_and_add_it_two_times(VALUE self, VALUE obj)
{
  //check duplication (rb_str_dup) and separating data (rb_str_modify)
  VALUE arr = rb_iv_get(self, "@arr");
  VALUE toadd = rb_str_dup(obj);
  rb_funcall(arr, id_push, 1, toadd);
  toadd = rb_str_dup(obj);
  rb_str_modify(toadd);
  rb_funcall(arr, id_push, 1, toadd);
  return toadd;
}

extern (C) VALUE class_str_cat(VALUE self, VALUE obj)
{
  string tocat = "I haz bin catted!";
  tocat ~= "xxx";
  VALUE catted = rb_str_buf_cat(obj, tocat.ptr, tocat.length);
  return catted;
}

extern (C) VALUE module_throw_an_exception(VALUE self)
{
  rb_raise(rb_eArgError, "ArgumentError exception raised by Dexter.");
  return self;
}

// not covered with unit tests for obvious reason, works though
extern (C) VALUE module_throw_a_fatal(VALUE self)
{
  rb_fatal("Fatal Error caused by Dexter.");
  return self;
}


extern (C) VALUE get_arr_first_and_add_ten(VALUE self)
{
  RArray* ary = RARRAY(rb_iv_get(self, "@arr")); 
  RudyObject rudy_el = new RudyObject(ary.ptr[0]);
  return rb_int2inum(rudy_el.to_i + 10);
}

extern (C) VALUE get_arr_first_and_square(VALUE self)
{
  RArray* ary = RARRAY(rb_iv_get(self, "@arr"));
  RudyObject rudy_el = new RudyObject(ary.ptr[0]);
  return to_ruby_value(rudy_el.to_f * rudy_el.to_f);
}

extern (C) VALUE create_and_compare_two_equal_ruby_integers(VALUE self)
{
  RudyObject int1 = new RudyObject(rb_int2inum(10));
  RudyObject int2 = new RudyObject(rb_int2inum(10));
  if(int1 == int2)
    return Qtrue;
  else
    return Qfalse;
}

extern (C) VALUE create_and_compare_two_not_equal_ruby_integers(VALUE self)
{
  RudyObject int1 = new RudyObject(rb_int2inum(10));
  RudyObject int2 = new RudyObject(rb_int2inum(11));
  if(int1 == int2)
    return Qtrue;
  else
    return Qfalse;
}

extern (C) VALUE class_add_integer(VALUE self)
{
  class_add(self, to_ruby_value(99));
  return self;
}

extern (C) VALUE class_add_float(VALUE self)
{
  class_add(self, to_ruby_value(99.99));
  return self;
}

extern (C) VALUE class_add_string(VALUE self)
{
  class_add(self, to_ruby_value("hello there"));
  return self;
}


extern (C) VALUE class_add_complex(VALUE self)
{
  idouble imag = 1.3i;
  class_add(self, to_ruby_value(imag));
  cdouble cmplx = 2.6 + 3.9i;
  class_add(self, to_ruby_value(cmplx));
  return self;
}

extern (C) VALUE class_add_array(VALUE self)
{
  int[] a;
  a.length = 5;
  for(int i=0; i<a.length; ++i)
    a[i] = i*i;
  VALUE ruby_array = to_ruby_value(a);
  class_add(self, ruby_array);
  return ruby_array;
}

extern (C) VALUE class_add_hash(VALUE self)
{
  int[char[]] h;  //hash of integers adressed by strings
  h["three"] = 3;
  h["six"] = 6;
  h["fourteen"] = 14;
  VALUE ruby_hash = to_ruby_value(h);
  class_add(self, ruby_hash);
  return ruby_hash;
}

extern (C) VALUE the_new_fifteen(VALUE self) {
  int x = 15;
  //return INT2NUM(x);
  return to_ruby_value(15);
}

extern (C) VALUE convert_integer_two_ways(VALUE self, VALUE obj)
{
  int n = d_type!(int)(obj);
  return to_ruby_value(n);
}

extern (C) VALUE convert_float_two_ways(VALUE self, VALUE obj)
{
  double f = d_type!(double)(obj);
  return to_ruby_value(f);
}

extern (C) VALUE convert_string_two_ways(VALUE self, VALUE obj)
{
  char[] s = d_type!(char[])(obj);
  return to_ruby_value(s);
}

extern (C) VALUE convert_bool_two_ways(VALUE self, VALUE obj)
{
  bool b = d_type!(bool)(obj);
  return to_ruby_value(b);
}


// The initialization method for this module
extern (C) void Init_dexter() {
  DexterClass = rb_define_class("DexterClass", rb_cObject);
  rb_define_method(DexterClass, "return_ten", &method_return_ten, 0);
  rb_define_method(DexterClass, "initialize", &class_init, 0);
  rb_define_method(DexterClass, "arr", &class_arr, 0);
  rb_define_method(DexterClass, "add", &class_add, 1);
  rb_define_method(DexterClass, "native_add", &class_native_add, 1);
  rb_define_method(DexterClass, "add_strings_first_letter", &class_add_strings_first_letter, 1);
  rb_define_method(DexterClass, "duplicate_a_string_and_add_it_two_times", &class_duplicate_a_string_and_add_it_two_times, 1);
  rb_define_method(DexterClass, "str_cat", &class_str_cat, 1);
  rb_define_method(DexterClass, "get_arr_first_and_add_ten", &get_arr_first_and_add_ten, 0);
  rb_define_method(DexterClass, "get_arr_first_and_square", &get_arr_first_and_square, 0);
  rb_define_method(DexterClass, "create_and_compare_two_equal_ruby_integers", &create_and_compare_two_equal_ruby_integers, 0);
  rb_define_method(DexterClass, "create_and_compare_two_not_equal_ruby_integers", &create_and_compare_two_not_equal_ruby_integers, 0);
  
  rb_define_method(DexterClass, "add_integer", &class_add_integer, 0);
  rb_define_method(DexterClass, "add_float", &class_add_float, 0);
  rb_define_method(DexterClass, "add_string", &class_add_string, 0);
  rb_define_method(DexterClass, "add_complex", &class_add_complex, 0);
  rb_define_method(DexterClass, "add_array", &class_add_array, 0);
  rb_define_method(DexterClass, "add_hash", &class_add_hash, 0);
  
  id_push = rb_intern("push");
  
  DexterModule = rb_define_module("DexterModule");
  rb_define_module_function(DexterModule, "return_ten", &method_return_ten, 0);
  rb_define_module_function(DexterModule, "throw_an_exception", &module_throw_an_exception, 0);
  rb_define_module_function(DexterModule, "throw_a_fatal", &module_throw_a_fatal, 0);
  
  def!("DexterClass", the_new_fifteen);
  def!("DexterModule", the_new_fifteen);
  def!(the_new_fifteen);
  
  rb_define_module_function(DexterModule, "convert_integer_two_ways", &convert_integer_two_ways, 1);
  rb_define_module_function(DexterModule, "convert_float_two_ways", &convert_float_two_ways, 1);
  rb_define_module_function(DexterModule, "convert_string_two_ways", &convert_string_two_ways, 1);
  rb_define_module_function(DexterModule, "convert_bool_two_ways", &convert_bool_two_ways, 1);
  
  //def!("DexterModule", convert_integer_two_ways);
  //def!("DexterModule", convert_float_two_ways);
  //def!("DexterModule", convert_string_two_ways);
}
