/*
 * This module simply publicly imports all of the other components of the Rudy
 * package, making them all available from a single point.
 */
module rudy.rudy;

public {
    //import pyd.class_wrap;
    import rudy.lib_abstract;
    import rudy.def;
    import rudy.exception;
    //import rudy.func_wrap;
    import rudy.make_object;
    import rudy.rudyobject;
    //import pyd.struct_wrap;

}

/* make D's GC work with C-oriented functions
 * straight from PyD:
 * http://dsource.org/projects/pyd/browser/trunk/infrastructure/d/python_so_linux_boilerplate.d
 */
extern(C) {
  void gc_init();
  void gc_term();
  
  void _init() {
    gc_init();
  }
  
  void _fini() {
    gc_term();
}

} /* extern(C) */
