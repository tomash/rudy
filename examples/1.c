#include "ruby.h"
VALUE t_init(VALUE self)
{
  VALUE arr;
  arr = rb_ary_new();
  rb_iv_set(self, "@arr", arr);
  return self;
}

void Init_1()
{
  VALUE klass = rb_define_class("SomeClass", rb_cObject);
  rb_define_method(klass, "initialize", t_init, 0);
}
