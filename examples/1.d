module rudy.test1;
import bcd.ruby;

extern (C) VALUE t_init();
extern (C) VALUE t_init(VALUE self)
{
  VALUE arr;
  arr = rb_ary_new();
  rb_iv_set(self, "@arr", arr);
  return self;
}

extern (C) void Init_1()
{
  VALUE klass = rb_define_class("SomeClass", rb_cObject);
  rb_define_method(klass, "initialize", &t_init, 0);
}
