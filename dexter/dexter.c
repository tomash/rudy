/* C prototype of Dexter - a mini-app that should be implemented and working in D */

#include "ruby.h"

static int id_push;

static VALUE t_init(VALUE self)
{
  VALUE arr;
  arr = rb_ary_new();
  rb_iv_set(self, "@arr", arr);
  return self;
}

static VALUE t_add(VALUE self, VALUE obj)
{
  VALUE arr;
  arr = rb_iv_get(self, "@arr");
  rb_funcall(arr, id_push, 1, obj);
  return arr;
}

static VALUE t_native_add(VALUE self, VALUE obj)
{
  /* conversion: */
  int val = NUM2INT(obj);
  VALUE toadd = INT2NUM(val);
  /* pushing */
  VALUE arr = rb_iv_get(self, "@arr");
  rb_funcall(arr, id_push, 1, toadd);
  return arr;
}

static VALUE t_add_string_first_letter(VALUE self, VALUE obj)
{
  /* conversion: */
  
  VALUE str = StringValue(obj);
  char *p = RSTRING(str)->ptr;
  /* p = StringValuePtr(obj) */
  VALUE toadd = rb_str_new(p, 1);
  
  VALUE arr = rb_iv_get(self, "@arr");
  rb_funcall(arr, id_push, 1, toadd);
  return toadd;
}

static VALUE t_arr(VALUE self)
{
  VALUE arr;
  arr = rb_iv_get(self, "@arr");
  return arr;
}

VALUE cTest;

void Init_dexter()
{
  cTest = rb_define_class("Dexter", rb_cObject);
  rb_define_method(cTest, "initialize", t_init, 0);
  rb_define_method(cTest, "arr", t_arr, 0);
  rb_define_method(cTest, "add", t_add, 1);
  rb_define_method(cTest, "native_add", t_native_add, 1);
  rb_define_method(cTest, "add_string_first_letter", t_add_string_first_letter, 1);
  
  id_push = rb_intern("push");
  /*id_to_s = rb_intern("to_s");*/
}
