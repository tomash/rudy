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
    VALUE ref;
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
        if (v is null) handle_exception();
        // RudyObject will own its references
        // if (borrowed) Py_INCREF(o);
        ref = V;
    }

    /// The default constructor constructs an instance of the NilClass.
    this() { this(rb_cNilClass, true); }

    /// Destructor. Left for later
    ~this() {
        //Py_DECREF(m_ptr);
    }

