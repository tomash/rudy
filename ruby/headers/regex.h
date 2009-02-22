
extern



const unsigned char *re_mbctab;

void re_mbcinit (int);
# 108 "regex.h"
typedef union
{
  unsigned char *word;
  struct {
    unsigned is_active : 1;
    unsigned matched_something : 1;
  } bits;
} register_info_type;



struct re_pattern_buffer
  {
    char *buffer;
    int allocated;
    int used;
    char *fastmap;


    char *must;

    int *must_skip;
    long options;
    long re_nsub;
    char fastmap_accurate;


    char can_be_null;
# 144 "regex.h"
    unsigned char **regstart;
    unsigned char **regend;
    unsigned char **old_regstart;
    unsigned char **old_regend;
    register_info_type *reg_info;
    unsigned char **best_regstart;
    unsigned char **best_regend;
  };

typedef struct re_pattern_buffer regex_t;
# 165 "regex.h"
struct re_registers
  {
    int allocated;
    int num_regs;
    int *beg;
    int *end;
  };


typedef size_t regoff_t;




typedef struct
{
  regoff_t rm_so;
  regoff_t rm_eo;
} regmatch_t;



extern char *re_compile_pattern (const char *, int, struct re_pattern_buffer *);
void re_free_pattern (struct re_pattern_buffer *);

extern int re_adjust_startpos (struct re_pattern_buffer *, const char*, int, int, int);
extern void re_compile_fastmap (struct re_pattern_buffer *);
extern int re_search (struct re_pattern_buffer *, const char*, int, int, int,
        struct re_registers *);
extern int re_match (struct re_pattern_buffer *, const char *, int, int,
       struct re_registers *);
extern void re_set_casetable (const char *table);
extern void re_copy_registers (struct re_registers*, struct re_registers*);
extern void re_free_registers (struct re_registers*);



extern char *re_comp (const char *);
extern int re_exec (const char *);
