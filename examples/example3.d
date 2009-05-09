import bcd.ruby;
import rudy.rudy;

import math = std.math;

extern (C) VALUE square_the_integer();
extern (C) VALUE square_the_integer(VALUE self, VALUE obj)
{
  int n = d_type!(int)(obj);
  return to_ruby_value(n*n);
}

extern (C) VALUE sqrt_the_float();
extern (C) VALUE sqrt_the_float(VALUE self, VALUE obj)
{
  double f = d_type!(double)(obj);
  return to_ruby_value(math.sqrt(f));
}

extern (C) VALUE cat_the_string();
extern (C) VALUE cat_the_string(VALUE self, VALUE obj)
{
  char[] s = d_type!(char[])(obj);
  return to_ruby_value(s ~ s ~ s);
}

// The initialization method for this module
extern (C) void Init_example3() {
  extern (C) VALUE ExampleModule = rb_define_module("ExampleModule");
  
  rb_define_module_function(ExampleModule, "sqrt_the_float", &sqrt_the_float, 1);
  rb_define_module_function(ExampleModule, "square_the_integer", &square_the_integer, 1);
  rb_define_module_function(ExampleModule, "cat_the_string", &cat_the_string, 1);
}
