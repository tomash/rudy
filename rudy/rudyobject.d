module rudy.rudyobject;

//the basics: bindings
import bcd.ruby;

import rudy.exception;



/* Wrapper class for Ruby/C API VALUE universal reference
 * 
 * TODO: exceptions
 * TODO: full implementation of converters etc.
 */
class RudyObject {
  protected:
    VALUE rubyval;
  public:
  /*
   * Wrap around a passed Ruby VALUE
   * Params:
   *      v = The VALUE to wrap (and reference).
   *      borrowed = Whether o is a _borrowed reference. This one comes 
   *      straight from PyD and will be left for future reference hash
   *      (that'll be there to satisfy the GC)
   */
    this(VALUE v, bool borrowed=false) 
    {
      if (v == 0) handle_exception();
      // RudyObject will own its references
      // if (borrowed) Py_INCREF(o);
      rubyval = v;
    }

    /// The default constructor constructs an instance of the NilClass.
    this() { this(rb_cNilClass, true); }

    /// Destructor. Left for later
    ~this() {
        //Py_DECREF(m_ptr);
    }
    
    VALUE ptr() { return rubyval; }
    
    /* D operator overloading */
    bool opEquals(RudyObject other) {
        int res = rb_equal(rubyval, other.rubyval);
        //handle_exception();
        return res != 0;
    }
    
    
    /* conversions */
    RudyObject to_s()
    {
      VALUE stringed = rb_any_to_s(rubyval);
      return new RudyObject(stringed);
    }
    
    long to_i()
    {
      int id_to_i = rb_intern("to_i");
      int result = rb_funcall(rubyval, id_to_i, 0);
      return rb_num2long(result); 
    }
    
    double to_f()
    {
      return RFLOAT(rubyval).value;
    }
}
