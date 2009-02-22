
typedef unsigned long VALUE;
typedef unsigned long ID;



# 1 "/usr/lib/gcc/i686-pc-linux-gnu/3.4.6/include/limits.h" 1 3 4
# 11 "/usr/lib/gcc/i686-pc-linux-gnu/3.4.6/include/limits.h" 3 4
# 1 "/usr/lib/gcc/i686-pc-linux-gnu/3.4.6/include/syslimits.h" 1 3 4






# 1 "/usr/lib/gcc/i686-pc-linux-gnu/3.4.6/include/limits.h" 1 3 4
# 122 "/usr/lib/gcc/i686-pc-linux-gnu/3.4.6/include/limits.h" 3 4
# 1 "/usr/include/limits.h" 1 3 4
# 144 "/usr/include/limits.h" 3 4
# 1 "/usr/include/bits/posix1_lim.h" 1 3 4
# 153 "/usr/include/bits/posix1_lim.h" 3 4
# 1 "/usr/include/bits/local_lim.h" 1 3 4
# 36 "/usr/include/bits/local_lim.h" 3 4
# 1 "/usr/include/linux/limits.h" 1 3 4
# 37 "/usr/include/bits/local_lim.h" 2 3 4
# 154 "/usr/include/bits/posix1_lim.h" 2 3 4
# 145 "/usr/include/limits.h" 2 3 4



# 1 "/usr/include/bits/posix2_lim.h" 1 3 4
# 149 "/usr/include/limits.h" 2 3 4
# 123 "/usr/lib/gcc/i686-pc-linux-gnu/3.4.6/include/limits.h" 2 3 4
# 8 "/usr/lib/gcc/i686-pc-linux-gnu/3.4.6/include/syslimits.h" 2 3 4
# 12 "/usr/lib/gcc/i686-pc-linux-gnu/3.4.6/include/limits.h" 2 3 4
# 85 "ruby.h" 2
# 135 "ruby.h"
VALUE rb_int2inum (long);



VALUE rb_uint2inum (unsigned long);





VALUE rb_ll2inum (long long);

VALUE rb_ull2inum (unsigned long long);
# 218 "ruby.h"
void rb_check_type (VALUE,int);


VALUE rb_str_to_str (VALUE);
VALUE rb_string_value (volatile VALUE*);
char *rb_string_value_ptr (volatile VALUE*);
char *rb_string_value_cstr (volatile VALUE*);





void rb_check_safe_obj (VALUE);
void rb_check_safe_str (VALUE);







void rb_secure (int);
extern int ruby_safe_level;

void rb_set_safe_level (int);
void rb_secure_update (VALUE);

long rb_num2long (VALUE);
unsigned long rb_num2ulong (VALUE);
# 266 "ruby.h"
long long rb_num2ll (VALUE);
unsigned long long rb_num2ull (VALUE);
# 277 "ruby.h"
double rb_num2dbl (VALUE);



char *rb_str2cstr (VALUE,long*);







VALUE rb_newobj (void);
# 306 "ruby.h"
struct RBasic {
    unsigned long flags;
    VALUE klass;
};

struct RObject {
    struct RBasic basic;
    struct st_table *iv_tbl;
};

struct RClass {
    struct RBasic basic;
    struct st_table *iv_tbl;
    struct st_table *m_tbl;
    VALUE super;
};

struct RFloat {
    struct RBasic basic;
    double value;
};



struct RString {
    struct RBasic basic;
    long len;
    char *ptr;
    union {
 long capa;
 VALUE shared;
    } aux;
};

struct RArray {
    struct RBasic basic;
    long len;
    union {
 long capa;
 VALUE shared;
    } aux;
    VALUE *ptr;
};

struct RRegexp {
    struct RBasic basic;
    struct re_pattern_buffer *ptr;
    long len;
    char *str;
};

struct RHash {
    struct RBasic basic;
    struct st_table *tbl;
    int iter_lev;
    VALUE ifnone;
};

struct RFile {
    struct RBasic basic;
    struct OpenFile *fptr;
};

struct RData {
    struct RBasic basic;
    void (*dmark) (void*);
    void (*dfree) (void*);
    void *data;
};






typedef void (*RUBY_DATA_FUNC) (void*);

VALUE rb_data_object_alloc (VALUE,void*,RUBY_DATA_FUNC,RUBY_DATA_FUNC);
# 399 "ruby.h"
struct RStruct {
    struct RBasic basic;
    long len;
    VALUE *ptr;
};

struct RBignum {
    struct RBasic basic;
    char sign;
    long len;
    void *digits;
};
# 473 "ruby.h"
void rb_obj_infect (VALUE,VALUE);

void rb_glob (const char*,void(*)(const char*,VALUE),VALUE);
void rb_globi (const char*,void(*)(const char*,VALUE),VALUE);

VALUE rb_define_class (const char*,VALUE);
VALUE rb_define_module (const char*);
VALUE rb_define_class_under (VALUE, const char*, VALUE);
VALUE rb_define_module_under (VALUE, const char*);

void rb_include_module (VALUE,VALUE);
void rb_extend_object (VALUE,VALUE);

void rb_define_variable (const char*,VALUE*);
void rb_define_virtual_variable (const char*,VALUE(*)(),void(*)());
void rb_define_hooked_variable (const char*,VALUE*,VALUE(*)(),void(*)());
int ruby_glob (const char*,int,int(*)(const char*,VALUE),VALUE);
int ruby_globi (const char*,int,int(*)(const char*,VALUE),VALUE);
void rb_define_readonly_variable (const char*,VALUE*);
void rb_define_const (VALUE,const char*,VALUE);
void rb_define_global_const (const char*,VALUE);


void rb_define_method (VALUE,const char*,VALUE(*)(),int);
void rb_define_module_function (VALUE,const char*,VALUE(*)(),int);
void rb_define_global_function (const char*,VALUE(*)(),int);

void rb_undef_method (VALUE,const char*);
void rb_define_alias (VALUE,const char*,const char*);
void rb_define_attr (VALUE,const char*,int,int);

void rb_global_variable (VALUE*);
void rb_gc_register_address (VALUE*);
void rb_gc_unregister_address (VALUE*);

ID rb_intern (const char*);
char *rb_id2name (ID);
ID rb_to_id (VALUE);

char *rb_class2name (VALUE);
char *rb_obj_classname (VALUE);

void rb_p (VALUE);

VALUE rb_eval_string (const char*);
VALUE rb_eval_string_protect (const char*, int*);
VALUE rb_eval_string_wrap (const char*, int*);
VALUE rb_funcall (VALUE, ID, int, ...);
VALUE rb_funcall2 (VALUE, ID, int, const VALUE*);
VALUE rb_funcall3 (VALUE, ID, int, const VALUE*);
int rb_scan_args (int, const VALUE*, const char*, ...);
VALUE rb_call_super (int, const VALUE*);

VALUE rb_gv_set (const char*, VALUE);
VALUE rb_gv_get (const char*);
VALUE rb_iv_get (VALUE, const char*);
VALUE rb_iv_set (VALUE, const char*, VALUE);

VALUE rb_equal (VALUE,VALUE);

extern VALUE ruby_verbose, ruby_debug;

void rb_raise (VALUE, const char*, ...) __attribute__ ((noreturn));
void rb_fatal (const char*, ...) __attribute__ ((noreturn));
void rb_bug (const char*, ...) __attribute__ ((noreturn));
void rb_sys_fail (const char*) __attribute__ ((noreturn));
void rb_iter_break (void) __attribute__ ((noreturn));
void rb_exit (int) __attribute__ ((noreturn));
void rb_notimplement (void) __attribute__ ((noreturn));

void rb_warning (const char*, ...);
void rb_sys_warning (const char*, ...);
void rb_warn (const char*, ...);

VALUE rb_each (VALUE);
VALUE rb_yield (VALUE);
VALUE rb_yield_values (int n, ...);
VALUE rb_yield_splat (VALUE);
int rb_block_given_p (void);
void rb_need_block (void);
VALUE rb_iterate (VALUE(*)(VALUE),VALUE,VALUE(*)(),VALUE);
VALUE rb_rescue (VALUE(*)(),VALUE,VALUE(*)(),VALUE);
VALUE rb_rescue2 (VALUE(*)(),VALUE,VALUE(*)(),VALUE,...);
VALUE rb_ensure (VALUE(*)(),VALUE,VALUE(*)(),VALUE);
VALUE rb_catch (const char*,VALUE(*)(),VALUE);
void rb_throw (const char*,VALUE) __attribute__ ((noreturn));

VALUE rb_require (const char*);

void ruby_init (void);
void ruby_options (int, char**);
void ruby_run (void) __attribute__ ((noreturn));

extern VALUE rb_mKernel;
extern VALUE rb_mComparable;
extern VALUE rb_mEnumerable;
extern VALUE rb_mPrecision;
extern VALUE rb_mErrno;
extern VALUE rb_mFileTest;
extern VALUE rb_mGC;
extern VALUE rb_mMath;
extern VALUE rb_mProcess;

extern VALUE rb_cObject;
extern VALUE rb_cArray;
extern VALUE rb_cBignum;
extern VALUE rb_cClass;
extern VALUE rb_cDir;
extern VALUE rb_cData;
extern VALUE rb_cFalseClass;
extern VALUE rb_cFile;
extern VALUE rb_cFixnum;
extern VALUE rb_cFloat;
extern VALUE rb_cHash;
extern VALUE rb_cInteger;
extern VALUE rb_cIO;
extern VALUE rb_cModule;
extern VALUE rb_cNilClass;
extern VALUE rb_cNumeric;
extern VALUE rb_cProc;
extern VALUE rb_cRange;
extern VALUE rb_cRegexp;
extern VALUE rb_cString;
extern VALUE rb_cSymbol;
extern VALUE rb_cThread;
extern VALUE rb_cTime;
extern VALUE rb_cTrueClass;
extern VALUE rb_cStruct;

extern VALUE rb_eException;
extern VALUE rb_eStandardError;
extern VALUE rb_eSystemExit;
extern VALUE rb_eInterrupt;
extern VALUE rb_eSignal;
extern VALUE rb_eFatal;
extern VALUE rb_eArgError;
extern VALUE rb_eEOFError;
extern VALUE rb_eIndexError;
extern VALUE rb_eRangeError;
extern VALUE rb_eIOError;
extern VALUE rb_eRuntimeError;
extern VALUE rb_eSecurityError;
extern VALUE rb_eSystemCallError;
extern VALUE rb_eTypeError;
extern VALUE rb_eZeroDivError;
extern VALUE rb_eNotImpError;
extern VALUE rb_eNoMemError;
extern VALUE rb_eNoMethodError;
extern VALUE rb_eFloatDomainError;

extern VALUE rb_eScriptError;
extern VALUE rb_eNameError;
extern VALUE rb_eSyntaxError;
extern VALUE rb_eLoadError;

extern VALUE rb_stdin, rb_stdout, rb_stderr;
extern VALUE ruby_errinfo;

static inline VALUE

rb_class_of(VALUE obj)




{
    if ((((long)(obj))&0x01)) return rb_cFixnum;
    if (obj == ((VALUE)4)) return rb_cNilClass;
    if (obj == ((VALUE)0)) return rb_cFalseClass;
    if (obj == ((VALUE)2)) return rb_cTrueClass;
    if ((((VALUE)(obj)&0xff)==0x0e)) return rb_cSymbol;

    return ((struct RBasic*)(obj))->klass;
}

static inline int

rb_type(VALUE obj)




{
    if ((((long)(obj))&0x01)) return 0x0a;
    if (obj == ((VALUE)4)) return 0x01;
    if (obj == ((VALUE)0)) return 0x21;
    if (obj == ((VALUE)2)) return 0x20;
    if (obj == ((VALUE)6)) return 0x3c;
    if ((((VALUE)(obj)&0xff)==0x0e)) return 0x24;
    return (((struct RBasic*)(obj))->flags & 0x3f);
}

static inline int

rb_special_const_p(VALUE obj)




{
    if ((((VALUE)(obj) & 0x03) || !(((VALUE)(obj) & ~((VALUE)4)) != 0))) return ((VALUE)2);
    return ((VALUE)0);
}

# 1 "missing.h" 1
# 16 "missing.h"
# 1 "/usr/include/sys/time.h" 1 3 4
# 26 "/usr/include/sys/time.h" 3 4
# 1 "/usr/include/time.h" 1 3 4
# 27 "/usr/include/sys/time.h" 2 3 4

# 1 "/usr/include/bits/time.h" 1 3 4
# 29 "/usr/include/sys/time.h" 2 3 4
# 38 "/usr/include/sys/time.h" 3 4

# 56 "/usr/include/sys/time.h" 3 4
struct timezone
  {
    int tz_minuteswest;
    int tz_dsttime;
  };

typedef struct timezone *__restrict __timezone_ptr_t;
# 72 "/usr/include/sys/time.h" 3 4
extern int gettimeofday (struct timeval *__restrict __tv,
    __timezone_ptr_t __tz) __attribute__ ((__nothrow__));




extern int settimeofday (__const struct timeval *__tv,
    __const struct timezone *__tz) __attribute__ ((__nothrow__));





extern int adjtime (__const struct timeval *__delta,
      struct timeval *__olddelta) __attribute__ ((__nothrow__));




enum __itimer_which
  {

    ITIMER_REAL = 0,


    ITIMER_VIRTUAL = 1,



    ITIMER_PROF = 2

  };



struct itimerval
  {

    struct timeval it_interval;

    struct timeval it_value;
  };






typedef int __itimer_which_t;




extern int getitimer (__itimer_which_t __which,
        struct itimerval *__value) __attribute__ ((__nothrow__));




extern int setitimer (__itimer_which_t __which,
        __const struct itimerval *__restrict __new,
        struct itimerval *__restrict __old) __attribute__ ((__nothrow__));




extern int utimes (__const char *__file, __const struct timeval __tvp[2])
     __attribute__ ((__nothrow__));



extern int lutimes (__const char *__file, __const struct timeval __tvp[2])
     __attribute__ ((__nothrow__));


extern int futimes (int __fd, __const struct timeval __tvp[2]) __attribute__ ((__nothrow__));
# 181 "/usr/include/sys/time.h" 3 4

# 17 "missing.h" 2
# 678 "ruby.h" 2
# 1 "intern.h" 1
# 23 "intern.h"
void rb_mem_clear (register VALUE*, register long);
VALUE rb_assoc_new (VALUE, VALUE);
VALUE rb_check_array_type (VALUE);
VALUE rb_ary_new (void);
VALUE rb_ary_new2 (long);
VALUE rb_ary_new3 (long,...);
VALUE rb_ary_new4 (long, const VALUE *);
VALUE rb_ary_freeze (VALUE);
VALUE rb_ary_aref (int, VALUE*, VALUE);
void rb_ary_store (VALUE, long, VALUE);
VALUE rb_ary_dup (VALUE);
VALUE rb_ary_to_ary (VALUE);
VALUE rb_ary_to_s (VALUE);
VALUE rb_ary_push (VALUE, VALUE);
VALUE rb_ary_pop (VALUE);
VALUE rb_ary_shift (VALUE);
VALUE rb_ary_unshift (VALUE, VALUE);
VALUE rb_ary_entry (VALUE, long);
VALUE rb_ary_each (VALUE);
VALUE rb_ary_join (VALUE, VALUE);
VALUE rb_ary_print_on (VALUE, VALUE);
VALUE rb_ary_reverse (VALUE);
VALUE rb_ary_sort (VALUE);
VALUE rb_ary_sort_bang (VALUE);
VALUE rb_ary_delete (VALUE, VALUE);
VALUE rb_ary_delete_at (VALUE, long);
VALUE rb_ary_clear (VALUE);
VALUE rb_ary_plus (VALUE, VALUE);
VALUE rb_ary_concat (VALUE, VALUE);
VALUE rb_ary_assoc (VALUE, VALUE);
VALUE rb_ary_rassoc (VALUE, VALUE);
VALUE rb_ary_includes (VALUE, VALUE);
VALUE rb_ary_cmp (VALUE, VALUE);
VALUE rb_protect_inspect (VALUE(*)(),VALUE,VALUE);
VALUE rb_inspecting_p (VALUE);
VALUE rb_check_array_value (VALUE);
VALUE rb_values_at (VALUE, long, int, VALUE*, VALUE(*) (VALUE,long));

VALUE rb_big_clone (VALUE);
void rb_big_2comp (VALUE);
VALUE rb_big_norm (VALUE);
VALUE rb_uint2big (unsigned long);
VALUE rb_int2big (long);
VALUE rb_uint2inum (unsigned long);
VALUE rb_int2inum (long);
VALUE rb_cstr_to_inum (const char*, int, int);
VALUE rb_str_to_inum (VALUE, int, int);
VALUE rb_cstr2inum (const char*, int);
VALUE rb_str2inum (VALUE, int);
VALUE rb_big2str (VALUE, int);
long rb_big2long (VALUE);

unsigned long rb_big2ulong (VALUE);


VALUE rb_ll2inum (long long);
VALUE rb_ull2inum (unsigned long long);
long long rb_big2ll (VALUE);
unsigned long long rb_big2ull (VALUE);

void rb_quad_pack (char*,VALUE);
VALUE rb_quad_unpack (const char*,int);
VALUE rb_dbl2big (double);
double rb_big2dbl (VALUE);
VALUE rb_big_plus (VALUE, VALUE);
VALUE rb_big_minus (VALUE, VALUE);
VALUE rb_big_mul (VALUE, VALUE);
VALUE rb_big_divmod (VALUE, VALUE);
VALUE rb_big_pow (VALUE, VALUE);
VALUE rb_big_and (VALUE, VALUE);
VALUE rb_big_or (VALUE, VALUE);
VALUE rb_big_xor (VALUE, VALUE);
VALUE rb_big_lshift (VALUE, VALUE);
VALUE rb_big_rand (VALUE, double*);

VALUE rb_class_boot (VALUE);
VALUE rb_class_new (VALUE);
VALUE rb_mod_init_copy (VALUE, VALUE);
VALUE rb_class_init_copy (VALUE, VALUE);
VALUE rb_singleton_class_clone (VALUE);
void rb_singleton_class_attached (VALUE,VALUE);
VALUE rb_make_metaclass (VALUE, VALUE);
void rb_check_inheritable (VALUE);
VALUE rb_class_inherited (VALUE, VALUE);
VALUE rb_define_class_id (ID, VALUE);
VALUE rb_module_new (void);
VALUE rb_define_module_id (ID);
VALUE rb_mod_included_modules (VALUE);
VALUE rb_mod_include_p (VALUE, VALUE);
VALUE rb_mod_ancestors (VALUE);
VALUE rb_class_instance_methods (int, VALUE*, VALUE);
VALUE rb_class_public_instance_methods (int, VALUE*, VALUE);
VALUE rb_class_protected_instance_methods (int, VALUE*, VALUE);
VALUE rb_class_private_instance_methods (int, VALUE*, VALUE);
VALUE rb_obj_singleton_methods (int, VALUE*, VALUE);
void rb_define_method_id (VALUE, ID, VALUE (*)(), int);
void rb_frozen_class_p (VALUE);
void rb_undef (VALUE, ID);
void rb_define_protected_method (VALUE, const char*, VALUE (*)(), int);
void rb_define_private_method (VALUE, const char*, VALUE (*)(), int);
void rb_define_singleton_method (VALUE, const char*, VALUE(*)(), int);
VALUE rb_singleton_class (VALUE);

int rb_cmpint (VALUE, VALUE, VALUE);
void rb_cmperr (VALUE, VALUE) __attribute__ ((noreturn));


extern int ruby_nerrs;
VALUE rb_exc_new (VALUE, const char*, long);
VALUE rb_exc_new2 (VALUE, const char*);
VALUE rb_exc_new3 (VALUE, VALUE);
void rb_loaderror (const char*, ...) __attribute__ ((noreturn));
void rb_name_error (ID, const char*, ...) __attribute__ ((noreturn));
void rb_invalid_str (const char*, const char*) __attribute__ ((noreturn));
void rb_compile_error (const char*, ...);
void rb_compile_error_append (const char*, ...);
void rb_load_fail (const char*) __attribute__ ((noreturn));
void rb_error_frozen (const char*) __attribute__ ((noreturn));
void rb_check_frozen (VALUE);

extern struct RNode *ruby_current_node;
void ruby_set_current_source (void);
void rb_exc_raise (VALUE) __attribute__ ((noreturn));
void rb_exc_fatal (VALUE) __attribute__ ((noreturn));
VALUE rb_f_exit (int,VALUE*);
VALUE rb_f_abort (int,VALUE*);
void rb_remove_method (VALUE, const char*);



void rb_define_alloc_func (VALUE, VALUE (*)(VALUE));
void rb_undef_alloc_func (VALUE);
void rb_clear_cache (void);
void rb_clear_cache_by_class (VALUE);
void rb_alias (VALUE, ID, ID);
void rb_attr (VALUE,ID,int,int,int);
int rb_method_boundp (VALUE, ID, int);
VALUE rb_dvar_defined (ID);
VALUE rb_dvar_curr (ID);
VALUE rb_dvar_ref (ID);
void rb_dvar_asgn (ID, VALUE);
void rb_dvar_push (ID, VALUE);
VALUE *rb_svar (int);
VALUE rb_eval_cmd (VALUE, VALUE, int);
int rb_obj_respond_to (VALUE, ID, int);
int rb_respond_to (VALUE, ID);
void rb_interrupt (void);
VALUE rb_apply (VALUE, ID, VALUE);
void rb_backtrace (void);
ID rb_frame_last_func (void);
VALUE rb_obj_instance_eval (int, VALUE*, VALUE);
VALUE rb_mod_module_eval (int, VALUE*, VALUE);
void rb_load (VALUE, int);
void rb_load_protect (VALUE, int, int*);
void rb_jump_tag (int) __attribute__ ((noreturn));
int rb_provided (const char*);
void rb_provide (const char*);
VALUE rb_f_require (VALUE, VALUE);
VALUE rb_require_safe (VALUE, int);
void rb_obj_call_init (VALUE, int, VALUE*);
VALUE rb_class_new_instance (int, VALUE*, VALUE);
VALUE rb_block_proc (void);
VALUE rb_f_lambda (void);
VALUE rb_proc_new (VALUE (*)( ), VALUE);
VALUE rb_protect (VALUE (*)(VALUE), VALUE, int*);
void rb_set_end_proc (void (*)(VALUE), VALUE);
void rb_mark_end_proc (void);
void rb_exec_end_proc (void);
void ruby_finalize (void);
void ruby_stop (int) __attribute__ ((noreturn));
int ruby_cleanup (int);
int ruby_exec (void);
void rb_gc_mark_threads (void);
void rb_thread_start_timer (void);
void rb_thread_stop_timer (void);
void rb_thread_schedule (void);
void rb_thread_wait_fd (int);
int rb_thread_fd_writable (int);
void rb_thread_fd_close (int);
int rb_thread_alone (void);
void rb_thread_polling (void);
void rb_thread_sleep (int);
void rb_thread_sleep_forever (void);
VALUE rb_thread_stop (void);
VALUE rb_thread_wakeup (VALUE);
VALUE rb_thread_run (VALUE);
VALUE rb_thread_kill (VALUE);
VALUE rb_thread_create (VALUE (*)(), void*);
void rb_thread_interrupt (void);
void rb_thread_trap_eval (VALUE, int, int);
void rb_thread_signal_raise (char*);
void rb_thread_signal_exit (void);
int rb_thread_select (int, fd_set *, fd_set *, fd_set *, struct timeval *);
void rb_thread_wait_for (struct timeval);
VALUE rb_thread_current (void);
VALUE rb_thread_main (void);
VALUE rb_thread_local_aref (VALUE, ID);
VALUE rb_thread_local_aset (VALUE, ID, VALUE);
void rb_thread_atfork (void);
VALUE rb_funcall_rescue (VALUE, ID, int, ...);

int eaccess (const char*, int);
VALUE rb_file_s_expand_path (int, VALUE *);
VALUE rb_file_expand_path (VALUE, VALUE);
void rb_file_const (const char*, VALUE);
int rb_find_file_ext (VALUE*, const char* const*);
VALUE rb_find_file (VALUE);
char *rb_path_next (const char *);
char *rb_path_skip_prefix (const char *);
char *rb_path_last_separator (const char *);
char *rb_path_end (const char *);

void rb_memerror (void) __attribute__ ((noreturn));
int ruby_stack_check (void);
int ruby_stack_length (VALUE**);
char *rb_source_filename (const char*);
void rb_gc_mark_locations (VALUE*, VALUE*);
void rb_mark_tbl (struct st_table*);
void rb_mark_hash (struct st_table*);
void rb_gc_mark_maybe (VALUE);
void rb_gc_mark (VALUE);
void rb_gc_force_recycle (VALUE);
void rb_gc (void);
void rb_gc_copy_finalizer (VALUE,VALUE);
void rb_gc_finalize_deferred (void);
void rb_gc_call_finalizer_at_exit (void);
VALUE rb_gc_enable (void);
VALUE rb_gc_disable (void);
VALUE rb_gc_start (void);

void st_foreach_safe (struct st_table *, int (*)(), unsigned long);
void rb_hash_foreach (VALUE, int (*)(), VALUE);
VALUE rb_hash (VALUE);
VALUE rb_hash_new (void);
VALUE rb_hash_freeze (VALUE);
VALUE rb_hash_aref (VALUE, VALUE);
VALUE rb_hash_aset (VALUE, VALUE, VALUE);
VALUE rb_hash_delete_if (VALUE);
VALUE rb_hash_delete (VALUE,VALUE);
int rb_path_check (char*);
int rb_env_path_tainted (void);


extern VALUE rb_fs;
extern VALUE rb_output_fs;
extern VALUE rb_rs;
extern VALUE rb_default_rs;
extern VALUE rb_output_rs;
VALUE rb_io_write (VALUE, VALUE);
VALUE rb_io_gets (VALUE);
VALUE rb_io_getc (VALUE);
VALUE rb_io_ungetc (VALUE, VALUE);
VALUE rb_io_close (VALUE);
VALUE rb_io_eof (VALUE);
VALUE rb_io_binmode (VALUE);
VALUE rb_io_addstr (VALUE, VALUE);
VALUE rb_io_printf (int, VALUE*, VALUE);
VALUE rb_io_print (int, VALUE*, VALUE);
VALUE rb_io_puts (int, VALUE*, VALUE);
VALUE rb_file_open (const char*, const char*);
VALUE rb_gets (void);
void rb_write_error (const char*);
void rb_write_error2 (const char*, long);

VALUE rb_marshal_dump (VALUE, VALUE);
VALUE rb_marshal_load (VALUE);

void rb_num_zerodiv (void);
VALUE rb_num_coerce_bin (VALUE, VALUE);
VALUE rb_num_coerce_cmp (VALUE, VALUE);
VALUE rb_num_coerce_relop (VALUE, VALUE);
VALUE rb_float_new (double);
VALUE rb_num2fix (VALUE);
VALUE rb_fix2str (VALUE, int);
VALUE rb_dbl_cmp (double, double);

int rb_eql (VALUE, VALUE);
VALUE rb_any_to_s (VALUE);
VALUE rb_inspect (VALUE);
VALUE rb_obj_is_instance_of (VALUE, VALUE);
VALUE rb_obj_is_kind_of (VALUE, VALUE);
VALUE rb_obj_alloc (VALUE);
VALUE rb_obj_clone (VALUE);
VALUE rb_obj_dup (VALUE);
VALUE rb_obj_init_copy (VALUE,VALUE);
VALUE rb_obj_taint (VALUE);
VALUE rb_obj_tainted (VALUE);
VALUE rb_obj_untaint (VALUE);
VALUE rb_obj_freeze (VALUE);
VALUE rb_obj_id (VALUE);
VALUE rb_obj_class (VALUE);
VALUE rb_class_real (VALUE);
VALUE rb_class_inherited_p (VALUE, VALUE);
VALUE rb_convert_type (VALUE,int,const char*,const char*);
VALUE rb_check_convert_type (VALUE,int,const char*,const char*);
VALUE rb_to_int (VALUE);
VALUE rb_Integer (VALUE);
VALUE rb_Float (VALUE);
VALUE rb_String (VALUE);
VALUE rb_Array (VALUE);
double rb_cstr_to_dbl (const char*, int);
double rb_str_to_dbl (VALUE, int);

extern int ruby_sourceline;
extern char *ruby_sourcefile;
int ruby_yyparse (void);
ID rb_id_attrset (ID);
void rb_parser_append_print (void);
void rb_parser_while_loop (int, int);
int ruby_parser_stack_on_heap (void);
void rb_gc_mark_parser (void);
int rb_is_const_id (ID);
int rb_is_instance_id (ID);
int rb_is_class_id (ID);
int rb_is_local_id (ID);
int rb_is_junk_id (ID);
int rb_symname_p (const char*);
VALUE rb_backref_get (void);
void rb_backref_set (VALUE);
VALUE rb_lastline_get (void);
void rb_lastline_set (VALUE);
VALUE rb_sym_all_symbols (void);

int rb_proc_exec (const char*);
VALUE rb_f_exec (int,VALUE*);
int rb_waitpid (int,int*,int);
void rb_syswait (int);
VALUE rb_proc_times (VALUE);
VALUE rb_detach_process (int);

VALUE rb_range_new (VALUE, VALUE, int);
VALUE rb_range_beg_len (VALUE, long*, long*, long, int);
VALUE rb_length_by_each (VALUE);

int rb_memcmp (char*,char*,long);
int rb_memcicmp (char*,char*,long);
long rb_memsearch (char*,long,char*,long);
VALUE rb_reg_nth_defined (int, VALUE);
VALUE rb_reg_nth_match (int, VALUE);
VALUE rb_reg_last_match (VALUE);
VALUE rb_reg_match_pre (VALUE);
VALUE rb_reg_match_post (VALUE);
VALUE rb_reg_match_last (VALUE);
VALUE rb_reg_new (const char*, long, int);
VALUE rb_reg_match (VALUE, VALUE);
VALUE rb_reg_match2 (VALUE);
int rb_reg_options (VALUE);
void rb_set_kcode (const char*);
const char* rb_get_kcode (void);

extern VALUE rb_argv;
extern VALUE rb_argv0;
void rb_load_file (const char*);
void ruby_script (const char*);
void ruby_prog_init (void);
void ruby_set_argv (int, char**);
void ruby_process_options (int, char**);
void ruby_load_script (void);
void ruby_init_loadpath (void);
void ruby_incpush (const char*);

VALUE rb_f_kill (int, VALUE*);
void rb_gc_mark_trap_list (void);


void ruby_posix_signal (int, void (*)(int));

void rb_trap_exit (void);
void rb_trap_exec (void);
const char *ruby_signal_name (int);

VALUE rb_f_sprintf (int, VALUE*);

VALUE rb_str_new (const char*, long);
VALUE rb_str_new2 (const char*);
VALUE rb_str_new3 (VALUE);
VALUE rb_str_new4 (VALUE);
VALUE rb_str_new5 (VALUE, const char*, long);
VALUE rb_tainted_str_new (const char*, long);
VALUE rb_tainted_str_new2 (const char*);
VALUE rb_str_buf_new (long);
VALUE rb_str_buf_new2 (const char*);
VALUE rb_str_buf_append (VALUE, VALUE);
VALUE rb_str_buf_cat (VALUE, const char*, long);
VALUE rb_str_buf_cat2 (VALUE, const char*);
VALUE rb_obj_as_string (VALUE);
VALUE rb_check_string_type (VALUE);
VALUE rb_str_dup (VALUE);
VALUE rb_str_locktmp (VALUE);
VALUE rb_str_unlocktmp (VALUE);
VALUE rb_str_dup_frozen (VALUE);
VALUE rb_str_plus (VALUE, VALUE);
VALUE rb_str_times (VALUE, VALUE);
VALUE rb_str_substr (VALUE, long, long);
void rb_str_modify (VALUE);
VALUE rb_str_freeze (VALUE);
VALUE rb_str_resize (VALUE, long);
VALUE rb_str_cat (VALUE, const char*, long);
VALUE rb_str_cat2 (VALUE, const char*);
VALUE rb_str_append (VALUE, VALUE);
VALUE rb_str_concat (VALUE, VALUE);
int rb_str_hash (VALUE);
int rb_str_cmp (VALUE, VALUE);
VALUE rb_str_upto (VALUE, VALUE, int);
void rb_str_update (VALUE, long, long, VALUE);
VALUE rb_str_inspect (VALUE);
VALUE rb_str_dump (VALUE);
VALUE rb_str_split (VALUE, const char*);
void rb_str_associate (VALUE, VALUE);
VALUE rb_str_associated (VALUE);
void rb_str_setter (VALUE, ID, VALUE*);
VALUE rb_str_intern (VALUE);

VALUE rb_struct_new (VALUE, ...);
VALUE rb_struct_define (const char*, ...);
VALUE rb_struct_alloc (VALUE, VALUE);
VALUE rb_struct_aref (VALUE, VALUE);
VALUE rb_struct_aset (VALUE, VALUE, VALUE);
VALUE rb_struct_getmember (VALUE, ID);
VALUE rb_struct_iv_get (VALUE, char*);
VALUE rb_struct_s_members (VALUE);
VALUE rb_struct_members (VALUE);

VALUE rb_time_new (time_t, time_t);

VALUE rb_mod_name (VALUE);
VALUE rb_class_path (VALUE);
void rb_set_class_path (VALUE, VALUE, const char*);
VALUE rb_path2class (const char*);
void rb_name_class (VALUE, ID);
VALUE rb_class_name (VALUE);
void rb_autoload (VALUE, ID, const char*);
VALUE rb_autoload_load (VALUE, ID);
VALUE rb_autoload_p (VALUE, ID);
void rb_gc_mark_global_tbl (void);
VALUE rb_f_trace_var (int, VALUE*);
VALUE rb_f_untrace_var (int, VALUE*);
VALUE rb_f_global_variables (void);
void rb_alias_variable (ID, ID);
struct st_table* rb_generic_ivar_table (VALUE);
void rb_copy_generic_ivar (VALUE,VALUE);
void rb_mark_generic_ivar (VALUE);
void rb_mark_generic_ivar_tbl (void);
void rb_free_generic_ivar (VALUE);
VALUE rb_ivar_get (VALUE, ID);
VALUE rb_ivar_set (VALUE, ID, VALUE);
VALUE rb_ivar_defined (VALUE, ID);
VALUE rb_iv_set (VALUE, const char*, VALUE);
VALUE rb_iv_get (VALUE, const char*);
VALUE rb_attr_get (VALUE, ID);
VALUE rb_obj_instance_variables (VALUE);
VALUE rb_obj_remove_instance_variable (VALUE, VALUE);
void *rb_mod_const_at (VALUE, void*);
void *rb_mod_const_of (VALUE, void*);
VALUE rb_const_list (void*);
VALUE rb_mod_constants (VALUE);
VALUE rb_mod_remove_const (VALUE, VALUE);
int rb_const_defined (VALUE, ID);
int rb_const_defined_at (VALUE, ID);
int rb_const_defined_from (VALUE, ID);
VALUE rb_const_get (VALUE, ID);
VALUE rb_const_get_at (VALUE, ID);
VALUE rb_const_get_from (VALUE, ID);
void rb_const_set (VALUE, ID, VALUE);
VALUE rb_mod_constants (VALUE);
VALUE rb_mod_const_missing (VALUE,VALUE);
VALUE rb_cvar_defined (VALUE, ID);

void rb_cvar_set (VALUE, ID, VALUE, int);
VALUE rb_cvar_get (VALUE, ID);
void rb_cv_set (VALUE, const char*, VALUE);
VALUE rb_cv_get (VALUE, const char*);
void rb_define_class_variable (VALUE, const char*, VALUE);
VALUE rb_mod_class_variables (VALUE);
VALUE rb_mod_remove_cvar (VALUE, VALUE);

void ruby_show_version (void);
void ruby_show_copyright (void);
# 679 "ruby.h" 2
