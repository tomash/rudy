module ruby.c.regex;

extern (C) {

extern
const ubyte *re_mbctab;

void re_mbcinit (int);
union register_info_type {
  ubyte *word;
  struct bits_struct  {
    bit is_active; //uint is_active : 1;
    bit matched_something; //uint matched_something : 1;
  } 
  bits_struct bits;
};




struct re_pattern_buffer {
    char *buffer;
    int allocated;
    int used;
    char *fastmap;


    char *must;

    int *must_skip;
    int options;
    int re_nsub;
    char fastmap_accurate;


    char can_be_null;
    ubyte **regstart;
    ubyte **regend;
    ubyte **old_regstart;
    ubyte **old_regend;
    register_info_type *reg_info;
    ubyte **best_regstart;
    ubyte **best_regend;
  }

alias re_pattern_buffer regex_t;

struct re_registers {
    int allocated;
    int num_regs;
    int *beg;
    int *end;
}

alias size_t regoff_t;

struct regmatch_t {
  regoff_t rm_so;
  regoff_t rm_eo;
};

extern char *re_compile_pattern ( char *, int, re_pattern_buffer *);
void re_free_pattern (re_pattern_buffer *);

extern int re_adjust_startpos (re_pattern_buffer *,  char*, int, int, int);
extern void re_compile_fastmap (re_pattern_buffer *);
extern int re_search (re_pattern_buffer *,  char*, int, int, int,
        re_registers *);
extern int re_match (re_pattern_buffer *,  char *, int, int,
       re_registers *);
extern void re_set_casetable ( char *table);
extern void re_copy_registers (re_registers*, re_registers*);
extern void re_free_registers (re_registers*);

extern char *re_comp ( char *);
extern int re_exec ( char *);
}
