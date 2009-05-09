import bcd.ruby;
import rudy.rudy;

extern (C) VALUE compare_wrapped_strings();
extern (C) VALUE compare_wrapped_strings(VALUE self, VALUE obj1, VALUE obj2)
{
  char[] s1 = d_type!(char[])(obj1);
  char[] s2 = d_type!(char[])(obj2);
  auto val1 = new RudyObject(to_ruby_value(s1)); // or: new RudyObject(val1)
  auto val2 = new RudyObject(to_ruby_value(s2));
  return to_ruby_value(val1 == val2);
}


// The initialization method for this module
extern (C) void Init_example4() {
  extern (C) VALUE ExampleModule = rb_define_module("ExampleModule");
  
  rb_define_module_function(ExampleModule, "compare_wrapped_strings", &compare_wrapped_strings, 2);
}
