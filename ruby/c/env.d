module ruby.c.env;

private import ruby.c.ruby;
private import ruby.c.node;

extern (C) {
extern struct FRAME {
    VALUE self;
    int argc;
    VALUE *argv;
    ID last_func;
    ID orig_func;
    VALUE last_class;
    FRAME *prev;
    FRAME *tmp;
    RNode *node;
    int iter;
    int flags;
    uint uniq;
}

extern FRAME *ruby_frame;
void rb_gc_mark_frame (FRAME *);

extern struct SCOPE {
    RBasic _super;
    ID *local_tbl;
    VALUE *local_vars;
    int flags;
}

extern SCOPE *ruby_scope;

extern int ruby_in_eval;

extern VALUE ruby_class;

struct RVarmap {
    RBasic _super;
    ID id;
    VALUE val;
    RVarmap *next;
}

extern RVarmap *ruby_dyna_vars;

}

