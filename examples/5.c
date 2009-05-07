VALUE c = rb_const_get(rb_cObject, rb_intern("SomeClass"));
rb_define_method(c, "my_method", &my_method, 0);
VALUE m = rb_const_get(rb_cObject, rb_intern("SomeModule"));
rb_define_module_function(m, "my_method", &my_method, 0);

