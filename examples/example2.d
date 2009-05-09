import bcd.ruby;
import rudy.rudy;

extern (C) VALUE return_bool();
extern (C) VALUE return_bool(VALUE self)
{
  return to_ruby_value(true);
}

extern (C) VALUE return_null();
extern (C) VALUE return_null(VALUE self)
{
  return to_ruby_value(null);
}

extern (C) VALUE return_integer();
extern (C) VALUE return_integer(VALUE self)
{
  return to_ruby_value(2009);
}

extern (C) VALUE return_float();
extern (C) VALUE return_float(VALUE self)
{
  return to_ruby_value(20.09);
}

extern (C) VALUE return_string();
extern (C) VALUE return_string(VALUE self)
{
  return to_ruby_value("euruko");
}

extern (C) VALUE return_array_of_strings();
extern (C) VALUE return_array_of_strings(VALUE self)
{
  return to_ruby_value(["array", "of", "strings"]);
}

extern (C) VALUE return_hash_of_floats();
extern (C) VALUE return_hash_of_floats(VALUE self)
{
  double[char[]] h;
  h["registry"] = 30.0;
  h["plane"] = 165.5;
  h["hotel"] = 59.90;
  return to_ruby_value(h);
}

// The initialization method for this module
extern (C) void Init_example2() {
  extern (C) VALUE ExampleModule = rb_define_module("ExampleModule");
  
  rb_define_module_function(ExampleModule, "return_bool", &return_bool, 0);
  rb_define_module_function(ExampleModule, "return_null", &return_null, 0);
  rb_define_module_function(ExampleModule, "return_integer", &return_integer, 0);
  rb_define_module_function(ExampleModule, "return_float", &return_float, 0);
  rb_define_module_function(ExampleModule, "return_string", &return_string, 0);
  rb_define_module_function(ExampleModule, "return_array_of_strings", &return_array_of_strings, 0);
  rb_define_module_function(ExampleModule, "return_hash_of_floats", &return_hash_of_floats, 0);
}
