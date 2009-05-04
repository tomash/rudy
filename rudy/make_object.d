module rudy.make_object;

//the basics: bindings
import bcd.ruby;

import rudy.exception;

// blatantly sto... borrowed from PyD
package template isArray(T) {
    const bool isArray = is(typeof(T.init[0])[] == T);
}

// This relies on the fact that, for a static array type T,
//      typeof(T.init) != T
// But, rather, T.init is the type it is an array of. (For the dynamic array
// template above, this type is extracted with typeof(T.init[0])).
// Because this is only true for static arrays, it would work just as well to
// say "!is(typeof(T.init) == T)"; however, this template has the advantage of
// being easily fixable should this behavior for static arrays change.
package template isStaticArray(T) {
    const bool isStaticArray = is(typeof(T.init)[(T).sizeof / typeof(T.init).sizeof] == T);
}

package template isAA(T) {
    const bool isAA = is(typeof(T.init.values[0])[typeof(T.init.keys[0])] == T);
}



VALUE to_ruby_value(T) (T t)
{
  static if (is(T : bool)) 
  {
      VALUE temp = (t) ? Qtrue : Qfalse;
      //Py_INCREF(temp); // -- we don't use it (yet)
      return temp;
  }
  else static if (is(T : C_long)) {
      return rb_int2inum(t);
  }
  else static if (is(T : C_longlong)) {
      return rb_ll2inum(t);
  }
  else static if (is(T : double)) {
      return rb_float_new(t);
  }  
  else static if (is(T : idouble)) 
  {
    return to_ruby_value(0.0 + t);
  } 
  else static if (is(T : cdouble)) {
    rb_require("complex");
    VALUE complex_class = rb_const_get(rb_cObject, rb_intern("Complex"));
    VALUE id_method_new = rb_intern("new");
    VALUE cmplx = rb_funcall(complex_class, id_method_new, 2, to_ruby_value(t.re), to_ruby_value(t.im));
    return cmplx;
  } 
  else static if (is(T : char[])) {
      //return PyString_FromString((t ~ \0).ptr);
      //to add or not to add \0 ?
      return rb_str_new(t.ptr, t.length);
  } 
  else static if (is(T : wchar[])) {
      //return PyUnicode_FromWideChar(t, t.length);
      return rb_str_new(t.ptr, t.length);
  }
  else static if (isArray!(T) || isStaticArray!(T)) {
    VALUE ruby_array = rb_ary_new2(t.length);
    VALUE temp;
    if (ruby_array == Qnil) return Qnil;
    for(int i=0; i<t.length; ++i)
    {
      temp = to_ruby_value(t[i]);
      if (temp == Qnil) {
          //Py_DECREF(lst);
          return Qnil;
      }
      //id_push = rb_intern("push");
      //rb_funcall(ruby_array, id_push, 1, temp);
      VALUE id_set_element_at = rb_intern("[]=");
      rb_funcall(ruby_array, id_set_element_at, 2, to_ruby_value(i), temp);
    }
    return ruby_array;
  }
  
  //if everything fails, we return Ruby nil
  return Qnil;
}
