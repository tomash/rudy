module ruby.c.rubysig;

private import ruby.c.ruby;

version(Windows){
  private import std.c.windows.windows;
  extern(C) alias int rb_atomic_t;
  int ATOMIC_TEST(rb_atomic_t var){
    return InterlockedExchange(&(var), 0);
  }
  rb_atomic_t ATOMIC_SET(rb_atomic_t var, int val){
    return InterlockedExchange(&(var), (val));
  }
  rb_atomic_t ATOMIC_INC(rb_atomic_t var){
    return InterlockedIncrement(&(var));
  }
  rb_atomic_t ATOMIC_DEC(rb_atomic_t var){
    return InterlockedDecrement(&(var));
  }
  void TRAP(void delegate() statements){
    int saved_errno = 0;
    rb_atomic_t trap_immediate = ATOMIC_SET(rb_trap_immediate, 1);
    statements();
    ATOMIC_SET(rb_trap_immediate, trap_immediate);
    saved_errno = errno;
    mixin CHECK_INTS;
    errno = saved_errno;
  }
  void RUBY_CRITICAL(void delegate() statements){
    rb_w32_enter_critical();
    statements();
    rb_w32_leave_critical();
  }
}else{
  extern(C) alias int rb_atomic_t;
  int ATOMIC_TEST(rb_atomic_t var){
    return (var) ? ((var) = 0, 1) : 0;
  }
  rb_atomic_t ATOMIC_SET(rb_atomic_t var, int val){
    return var = val;
  }
  rb_atomic_t ATOMIC_INC(rb_atomic_t var){
    return ++(var);
  }
  rb_atomic_t ATOMIC_DEC(rb_atomic_t var){
    return --(var);
  }
  void TRAP(void delegate() statements){
    int saved_errno = 0;
    int trap_immediate = rb_trap_immediate;
    rb_trap_immediate = 1;
    statements();
    saved_errno = errno;
    mixin CHECK_INTS;
    errno = saved_errno;
  }
  void RUBY_CRITICAL(void delegate() statements){
    int trap_immediate = rb_trap_immediate;
    rb_trap_immediate = 0;
    statements();
    rb_trap_immediate = trap_immediate;
  }
}

extern(C){
  rb_atomic_t rb_trap_immediate;
  int rb_prohibit_interrupt;

  VALUE rb_with_disable_interrupt (VALUE(*)(/* ANYARGS */),VALUE);

  extern rb_atomic_t rb_trap_pending;
  void rb_trap_restore_mask ();

  extern int rb_thread_critical;
  void rb_thread_schedule ();
  extern int rb_thread_tick;

}

template DEFER_INTS(){
  rb_prohibit_interrupt++;
}
template ALLOW_INTS(){
  do{
    rb_prohibit_interrupt--;
    mixin CHECK_INTS;
  }while(0)
}
template ENABLE_INTS(){
  rb_prohibit_interrupt--;
}

version (HAVE_SETITIMER){
  version = _HAVE_THREAD;
}
version (_THREAD_SAFE){
  version = _HAVE_THREAD;
}

version(_HAVE_THREAD){
  extern(C) int rb_thread_pending;
  template CHECK_INTS(){
    if (!(rb_prohibit_interrupt || rb_thread_critical)) {
      if (rb_thread_pending) rb_thread_schedule();
      if (rb_trap_pending) rb_trap_exec();
    }
  }
}else{
  /* pseudo preemptive thread switching */
  extern(C) int rb_thread_tick;
  int THREAD_TICK = 500;
  template CHECK_INTS(){
    if (!(rb_prohibit_interrupt || rb_thread_critical)) {
      if (rb_thread_tick-- <= 0) {
        rb_thread_tick = THREAD_TICK;
        rb_thread_schedule();
      }
    }
    if (rb_trap_pending) rb_trap_exec();  
  }
}
