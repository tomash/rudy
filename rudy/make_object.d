module rudy.make_object;

//the basics: bindings
import bcd.ruby;

import rudy.exception;


VALUE to_ruby_value(T) (T t)
{
  static if (is(T : bool)) 
  {
      VALUE temp = (t) ? Qtrue : Qfalse;
      //Py_INCREF(temp); // -- we don't use it (yet)
      return temp;
  } else static if (is(T : C_long)) {
      return rb_int2inum(t);
  } else static if (is(T : C_longlong)) {
      return rb_ll2inum(t);
  } else static if (is(T : double)) {
      return rb_float_new(t);
  }/* else static if (is(T : idouble)) {
      return PyComplex_FromDoubles(0.0, t.im);
  } else static if (is(T : cdouble)) {
      return PyComplex_FromDoubles(t.re, t.im);
  }*/ else static if (is(T : char[])) {
      //return PyString_FromString((t ~ \0).ptr);
      return rb_str_new(t.ptr, t.length);
  } else static if (is(T : wchar[])) {
      //return PyUnicode_FromWideChar(t, t.length);
      return rb_str_new(t.ptr, t.length);
  }
}
