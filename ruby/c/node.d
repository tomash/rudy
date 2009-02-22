module ruby.c.node;

private import ruby.c.ruby;

extern (C) {
enum node_type {
    NODE_METHOD,
    NODE_FBODY,
    NODE_CFUNC,
    NODE_SCOPE,
    NODE_BLOCK,
    NODE_IF,
    NODE_CASE,
    NODE_WHEN,
    NODE_OPT_N,
    NODE_WHILE,
    NODE_UNTIL,
    NODE_ITER,
    NODE_FOR,
    NODE_BREAK,
    NODE_NEXT,
    NODE_REDO,
    NODE_RETRY,
    NODE_BEGIN,
    NODE_RESCUE,
    NODE_RESBODY,
    NODE_ENSURE,
    NODE_AND,
    NODE_OR,
    NODE_NOT,
    NODE_MASGN,
    NODE_LASGN,
    NODE_DASGN,
    NODE_DASGN_CURR,
    NODE_GASGN,
    NODE_IASGN,
    NODE_CDECL,
    NODE_CVASGN,
    NODE_CVDECL,
    NODE_OP_ASGN1,
    NODE_OP_ASGN2,
    NODE_OP_ASGN_AND,
    NODE_OP_ASGN_OR,
    NODE_CALL,
    NODE_FCALL,
    NODE_VCALL,
    NODE_SUPER,
    NODE_ZSUPER,
    NODE_ARRAY,
    NODE_ZARRAY,
    NODE_HASH,
    NODE_RETURN,
    NODE_YIELD,
    NODE_LVAR,
    NODE_DVAR,
    NODE_GVAR,
    NODE_IVAR,
    NODE_CONST,
    NODE_CVAR,
    NODE_NTH_REF,
    NODE_BACK_REF,
    NODE_MATCH,
    NODE_MATCH2,
    NODE_MATCH3,
    NODE_LIT,
    NODE_STR,
    NODE_DSTR,
    NODE_XSTR,
    NODE_DXSTR,
    NODE_EVSTR,
    NODE_DREGX,
    NODE_DREGX_ONCE,
    NODE_ARGS,
    NODE_ARGSCAT,
    NODE_ARGSPUSH,
    NODE_SPLAT,
    NODE_TO_ARY,
    NODE_SVALUE,
    NODE_BLOCK_ARG,
    NODE_BLOCK_PASS,
    NODE_DEFN,
    NODE_DEFS,
    NODE_ALIAS,
    NODE_VALIAS,
    NODE_UNDEF,
    NODE_CLASS,
    NODE_MODULE,
    NODE_SCLASS,
    NODE_COLON2,
    NODE_COLON3,
    NODE_CREF,
    NODE_DOT2,
    NODE_DOT3,
    NODE_FLIP2,
    NODE_FLIP3,
    NODE_ATTRSET,
    NODE_SELF,
    NODE_NIL,
    NODE_TRUE,
    NODE_FALSE,
    NODE_DEFINED,
    NODE_NEWLINE,
    NODE_POSTEXE,
    NODE_ALLOCA,
    NODE_DMETHOD,
    NODE_BMETHOD,
    NODE_MEMO,
    NODE_IFUNC,
    NODE_DSYM,
    NODE_ATTRASGN,
    NODE_LAST
};

struct global_entry {}

struct RNode {
  uint flags;
  char *nd_file;
  union u1_union  {
    RNode *node;
    ID id;
    VALUE value;
    VALUE (*cfunc)();
    ID *tbl;
  } 
  u1_union u1;
  union u2_union  {
    RNode *node;
    ID id;
    int argc;
    VALUE value;
  } 
  u2_union u2;
  union u3_union  {
    RNode *node;
    ID id;
    int state;
    global_entry *entry;
    int cnt;
    VALUE value;
  } 
  u3_union u3;
};

alias RNode NODE;

NODE *rb_compile_cstr ( char*,  char*, int, int);
NODE *rb_compile_string ( char*, VALUE, int);
NODE *rb_compile_file ( char*, VALUE, int);

void rb_add_method (VALUE, ID, NODE *, int);
NODE *rb_node_newnode (node_type,VALUE,VALUE,VALUE);

NODE* rb_method_node (VALUE klass, ID id);

global_entry *rb_global_entry (ID);
VALUE rb_gvar_get (global_entry *);
VALUE rb_gvar_set (global_entry *, VALUE);
VALUE rb_gvar_defined (global_entry *);

alias uint rb_event_t;
alias void (*rb_event_hook_func_t) (rb_event_t,NODE*,VALUE,ID,VALUE);
void rb_add_event_hook (rb_event_hook_func_t,rb_event_t);
int rb_remove_event_hook (rb_event_hook_func_t);
}


