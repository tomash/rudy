# 1 "env.h"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "env.h"
# 16 "env.h"
extern struct FRAME {
    VALUE self;
    int argc;
    VALUE *argv;
    ID last_func;
    ID orig_func;
    VALUE last_class;
    struct FRAME *prev;
    struct FRAME *tmp;
    struct RNode *node;
    int iter;
    int flags;
    unsigned long uniq;
} *ruby_frame;

void rb_gc_mark_frame _((struct FRAME *));




extern struct SCOPE {
    struct RBasic super;
    ID *local_tbl;
    VALUE *local_vars;
    int flags;
} *ruby_scope;






extern int ruby_in_eval;

extern VALUE ruby_class;

struct RVarmap {
    struct RBasic super;
    ID id;
    VALUE val;
    struct RVarmap *next;
};
extern struct RVarmap *ruby_dyna_vars;
