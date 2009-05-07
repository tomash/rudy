module rudy.make_object;

//the basics: bindings
import bcd.ruby;

import rudy.exception;
import rudy.rudyobject;

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
  // Converts any array (static or dynamic) to a Ruby Array
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
      //screw Array#push -- it's slower
      VALUE id_set_element_at = rb_intern("[]=");
      rb_funcall(ruby_array, id_set_element_at, 2, to_ruby_value(i), temp);
    }
    return ruby_array;
  }
  // Converts any associative array to a Ruby Hash
  else static if (isAA!(T)) {
    VALUE ruby_hash = rb_hash_new();
    VALUE ktemp, vtemp;
    int result;
    if (ruby_hash == Qnil) return Qnil;
    foreach(key, val; t) {
      ktemp = to_ruby_value(key);
      vtemp = to_ruby_value(val);
      VALUE id_set_element_at = rb_intern("[]=");
      rb_funcall(ruby_hash, id_set_element_at, 2, ktemp, vtemp);
      
      //reference mangling -- TODO at later time
      /*
      if (ktemp is null || vtemp is null) {
        if (ktemp !is null) Py_DECREF(ktemp);
        if (vtemp !is null) Py_DECREF(vtemp);
        Py_DECREF(dict);
        return null;
      }
      */
      /*
      Py_DECREF(ktemp);
      Py_DECREF(vtemp);
      if (result == -1) {
        Py_DECREF(dict);
        return null;
      }
      */
    }
    return ruby_hash;
  }
  
  //for future
  /*
  else static if (is(T == delegate) || is(T == function)) 
  {
    RudyWrappedFunc_Ready!(T)();
    return WrapVALUE_FromObject(t);
  }
  */
  
  //if everything fails, we return Ruby nil
  return Qnil;
}


/*
 * Constructs an RudyObject based on the type of the argument passed in.
 *
 * For example, calling ru(10) would return a RudyPbject holding the value (real Ruby VALUE) 10.
 *
 * Calling this with a RudyObject will return back a reference to the very same
 * RudyObject.
 */
RudyObject ru(T) (T t) 
{
  static if(is(T : RudyObject)) { return t; } 
  else { return new RudyObject(to_ruby_value(t)); }
}


/**
 * An exception class used by d_type.
 */
class RudyConversionException : Exception {
    this(char[] msg) { super(msg); }
}

/*
 * This converts a Ruby VALUE to a D type. The template argument is the type to
 * convert to. The function argument is the VALUE to convert. For instance:
 *
 *$(D_CODE VALUE i = to_ruby_value(20);
 *int n = _d_type!(int)(i);
 *assert(n == 20);)
 *
 * This WILL THROW a RudyConversionException if the VALUE can't be converted to
 * the given D type.
 */

T d_type(T) (VALUE val) {
    // This ordering is very important. If the check for bool came first,
    // then all integral types would be converted to bools (they would be
    // 0 or 1), because bool can be implicitly converted to any integral
    // type.
    //
    // This also means that:
    //  (1) Conversion to RudyObject will construct an object and return that.
    //  (2) Any integral type smaller than a C_long (which is usually just
    //      an int, meaning short and byte) will use the bool conversion.
    //  (3) Conversion to a float shouldn't work.
    static if (is(T == void)) {
        //if (o != Py_None) could_not_convert!(T)(o);
        //Py_INCREF(Py_None);
        return Qnil;
    }

    //unicode strings  -- later
    /*
    else static if (is(wchar[] : T)) {
        wchar[] temp;
        temp.length = PyUnicode_GetSize(o);
        PyUnicode_AsWideChar(cast(PyUnicodeObject*)o, temp, temp.length);
        return temp;
    
    }*/
    //normal string
    else static if (is(char[] : T)) {
        char* c_str = StringValuePtr(val);
        char[] result = c_str[0..c_str.length-1];
        return result.dup;
    }
    //complex numbers -- later
    /*
    else static if (is(cdouble : T)) {
        double real_ = PyComplex_RealAsDouble(o);
        handle_exception();
        double imag = PyComplex_ImagAsDouble(o);
        handle_exception();
        return real_ + imag * 1i;
    }
    */
    else static if (is(double : T)) {
      int id_to_f = rb_intern("to_f");
      int result = rb_funcall(val, id_to_f, 0);
      return RFLOAT(result).value;
    } 
    else static if (is(C_longlong : T)) {
      int id_to_i = rb_intern("to_i");
      int result = rb_funcall(val, id_to_i, 0);
      return rb_num2long(result); 
    } 
    else static if (is(C_long : T)) {
      int id_to_i = rb_intern("to_i");
      int result = rb_funcall(val, id_to_i, 0);
      return rb_num2long(result); 
    } 
    else static if (is(bool : T)) {
      return val == Qnil;
    } 
    else {
      // some error handling please?
    }
}

//alias d_type!(Object) d_type_Object;
