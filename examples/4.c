VALUE val1 = to_ruby_value("euruko2009");
VALUE val2 = to_ruby_value("euruko2008");
int res = rb_equal(val1, val2);
return res != 0;

