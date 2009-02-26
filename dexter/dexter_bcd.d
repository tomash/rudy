module rubyd.dexter;

import bcd.Ruby.ruby;
//import ruby.c.ruby;

alias VALUE(*func_type)();
// Prototype for our method 'test1' - methods are prefixed by 'method_' here
extern (C) VALUE method_return_ten();
extern (C) VALUE class_init();
extern (C) VALUE class_arr();
extern (C) VALUE class_add();
extern (C) VALUE class_native_add();
extern (C) VALUE class_add_strings_first_letter();
extern (C) VALUE class_duplicate_a_string_and_add_it_two_times();
extern (C) VALUE module_throw_an_exception();
extern (C) VALUE module_throw_a_fatal();
extern (C) VALUE DexterClass = 0;
extern (C) VALUE DexterModule = 0;

//toStringz from phobos - where is this in Tango?
//DO NOT pass strings to C functions without calling this function on passed D string
char* cstr(string input)
{
  return (input ~ \0).ptr;
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
  ulong val = rb_num2long(obj);
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

extern (C) VALUE module_throw_an_exception(VALUE self)
{
  rb_raise(rb_eArgError, "ArgumentError exception raised by Dexter.");
  return self;
}

extern (C) VALUE module_throw_a_fatal(VALUE self)
{
  rb_fatal("Fatal Error caused by Dexter.");
  return self;
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
  
  id_push = rb_intern("push");
  
  DexterModule = rb_define_module("DexterModule");
  rb_define_module_function(DexterModule, "return_ten", &method_return_ten, 0);
  rb_define_module_function(DexterModule, "throw_an_exception", &module_throw_an_exception, 0);
  rb_define_module_function(DexterModule, "throw_a_fatal", &module_throw_a_fatal, 0);
}
