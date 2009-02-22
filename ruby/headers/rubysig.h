typedef int rb_atomic_t;
# 65 "rubysig.h"
RUBY_EXTERN rb_atomic_t rb_trap_immediate;

RUBY_EXTERN int rb_prohibit_interrupt;







VALUE rb_with_disable_interrupt _((VALUE(*)(ANYARGS),VALUE));

RUBY_EXTERN rb_atomic_t rb_trap_pending;
void rb_trap_restore_mask _((void));

RUBY_EXTERN int rb_thread_critical;
void rb_thread_schedule _((void));
# 92 "rubysig.h"
RUBY_EXTERN int rb_thread_tick;
