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
extern (C) VALUE DexterClass = 0;
extern (C) VALUE DexterModule = 0;

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


// The initialization method for this module
extern (C) void Init_dexter() {
  DexterClass = rb_define_class("DexterClass", rb_cObject);
  rb_define_method(DexterClass, "return_ten".ptr, &method_return_ten, 0);
  rb_define_method(DexterClass, "initialize".ptr, &class_init, 0);
  rb_define_method(DexterClass, "arr".ptr, &class_arr, 0);
  rb_define_method(DexterClass, "add".ptr, &class_add, 1);
  rb_define_method(DexterClass, "native_add".ptr, &class_native_add, 1);
  
  id_push = rb_intern("push");
  
  DexterModule = rb_define_module("DexterModule");
  rb_define_module_function(DexterModule, "return_ten".ptr, &method_return_ten, 0);
}
