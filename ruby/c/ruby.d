module ruby.c.ruby;

private import ruby.c.common;
private import ruby.c.st;
private import ruby.c.regex;
private import ruby.c.rubyio;
private import ruby.c.node;


extern (C) {

alias ulong VALUE;
alias ulong ID;

void rb_check_type (VALUE,int);


VALUE rb_str_to_str (VALUE);
VALUE rb_string_value (VALUE*);
char *rb_string_value_ptr (VALUE*);
char *rb_string_value_cstr (VALUE*);

void rb_check_safe_obj (VALUE);
void rb_check_safe_str (VALUE);

void rb_secure (int);
extern int ruby_safe_level;

void rb_set_safe_level (int);
void rb_secure_update (VALUE);

int rb_num2long (VALUE);
uint rb_num2ulong (VALUE);
long rb_num2ll (VALUE);
ulong rb_num2ull (VALUE);
double rb_num2dbl (VALUE);

char *rb_str2cstr (VALUE,int*);

VALUE rb_newobj ();
struct RBasic {
   uint flags;
   VALUE klass;
}

struct RObject {
   RBasic basic;
   st_table *iv_tbl;
}

struct RClass {
   RBasic basic;
   st_table *iv_tbl;
   st_table *m_tbl;
   VALUE _super;
}

struct RFloat {
   RBasic basic;
   double value;
}

struct RString {
 RBasic basic;
 int len;
 char *ptr;
 union aux_union  {
   int capa;
   VALUE shared;
 } 
 aux_union aux;
}

struct RArray {
 RBasic basic;
 int len;
 union aux_union  {
   int capa;
   VALUE shared;
 } 
 aux_union aux;
 VALUE *ptr;
}

struct RRegexp {
   RBasic basic;
   re_pattern_buffer *ptr;
   int len;
   char *str;
}

struct RHash {
   RBasic basic;
   st_table *tbl;
   int iter_lev;
   VALUE ifnone;
}

struct RFile {
   RBasic basic;
   OpenFile *fptr;
}

struct RFILE {
   RBasic basic;
   OpenFile *fptr;
}

struct RData {
   RBasic basic;
   void (*dmark) (void*);
   void (*dfree) (void*);
   void *data;
}

alias void (*RUBY_DATA_FUNC) (void*);

VALUE rb_data_object_alloc (VALUE,void*,RUBY_DATA_FUNC,RUBY_DATA_FUNC);
struct RStruct {
   RBasic basic;
   int len;
   VALUE *ptr;
}

struct RBignum {
   RBasic basic;
   char sign;
   int len;
   void *digits;
}
void rb_obj_infect (VALUE,VALUE);

void rb_glob ( char*,void(*)( char*,VALUE),VALUE);
void rb_globi ( char*,void(*)( char*,VALUE),VALUE);

VALUE rb_define_class ( char*,VALUE);
VALUE rb_define_module ( char*);
VALUE rb_define_class_under (VALUE,  char*, VALUE);
VALUE rb_define_module_under (VALUE,  char*);

void rb_include_module (VALUE,VALUE);
void rb_extend_object (VALUE,VALUE);

void rb_define_variable ( char*,VALUE*);
void rb_define_virtual_variable ( char*,VALUE(*)(),void(*)());
void rb_define_hooked_variable ( char*,VALUE*,VALUE(*)(),void(*)());
int ruby_glob ( char*,int,int(*)( char*,VALUE),VALUE);
int ruby_globi ( char*,int,int(*)( char*,VALUE),VALUE);
void rb_define_readonly_variable ( char*,VALUE*);
void rb_define_const (VALUE, char*,VALUE);
void rb_define_global_const ( char*,VALUE);


void rb_define_method (VALUE, char*,VALUE(*)(),int);
void rb_define_module_function (VALUE, char*,VALUE(*)(),int);
void rb_define_global_function ( char*,VALUE(*)(),int);

void rb_undef_method (VALUE, char*);
void rb_define_alias (VALUE, char*, char*);
void rb_define_attr (VALUE, char*,int,int);

void rb_global_variable (VALUE*);
void rb_gc_register_address (VALUE*);
void rb_gc_unregister_address (VALUE*);

ID rb_intern ( char*);
char *rb_id2name (ID);
ID rb_to_id (VALUE);

char *rb_class2name (VALUE);
char *rb_obj_classname (VALUE);

void rb_p (VALUE);

VALUE rb_eval_string ( char*);
VALUE rb_eval_string_protect ( char*, int*);
VALUE rb_eval_string_wrap ( char*, int*);
VALUE rb_funcall (VALUE, ID, int, ...);
VALUE rb_funcall2 (VALUE, ID, int,  VALUE*);
VALUE rb_funcall3 (VALUE, ID, int,  VALUE*);
int rb_scan_args (int,  VALUE*,  char*, ...);
VALUE rb_call_super (int,  VALUE*);

VALUE rb_gv_set ( char*, VALUE);
VALUE rb_gv_get ( char*);

VALUE rb_equal (VALUE,VALUE);

extern VALUE ruby_verbose, ruby_debug;

void rb_raise (VALUE,  char*, ...) ;
void rb_fatal ( char*, ...) ;
void rb_bug ( char*, ...) ;
void rb_sys_fail ( char*) ;
void rb_iter_break () ;
void rb_exit (int) ;
void rb_notimplement () ;

void rb_warning ( char*, ...);
void rb_sys_warning ( char*, ...);
void rb_warn ( char*, ...);

VALUE rb_each (VALUE);
VALUE rb_yield (VALUE);
VALUE rb_yield_values (int n, ...);
VALUE rb_yield_splat (VALUE);
int rb_block_given_p ();
void rb_need_block ();
VALUE rb_iterate (VALUE(*)(VALUE),VALUE,VALUE(*)(),VALUE);
VALUE rb_rescue (VALUE(*)(),VALUE,VALUE(*)(),VALUE);
VALUE rb_rescue2 (VALUE(*)(),VALUE,VALUE(*)(),VALUE,...);
VALUE rb_ensure (VALUE(*)(),VALUE,VALUE(*)(),VALUE);
VALUE rb_catch ( char*,VALUE(*)(),VALUE);
void rb_throw ( char*,VALUE) ;

VALUE rb_require ( char*);

void ruby_init ();
void ruby_options (int, char**);
void ruby_run () ;

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

static VALUE
rb_class_of(VALUE obj)
{
   if (((cast(int)(obj))&0x01)) return rb_cFixnum;
   if (obj == (cast(VALUE)4)) return rb_cNilClass;
   if (obj == (cast(VALUE)0)) return rb_cFalseClass;
   if (obj == (cast(VALUE)2)) return rb_cTrueClass;
   if (((cast(VALUE)(obj)&0xff)==0x0e)) return rb_cSymbol;

   return (cast(RBasic*)(obj)).klass;
}

static int
rb_type(VALUE obj)
{
   if (((cast(int)(obj))&0x01)) return 0x0a;
   if (obj == (cast(VALUE)4)) return 0x01;
   if (obj == (cast(VALUE)0)) return 0x21;
   if (obj == (cast(VALUE)2)) return 0x20;
   if (obj == (cast(VALUE)6)) return 0x3c;
   if (((cast(VALUE)(obj)&0xff)==0x0e)) return 0x24;
   return ((cast(RBasic*)(obj)).flags & 0x3f);
}

static int
rb_special_const_p(VALUE obj)
{
   if (((cast(VALUE)(obj) & 0x03) || !((cast(VALUE)(obj) & ~(cast(VALUE)4)) != 0))) return (cast(VALUE)2);
   return (cast(VALUE)0);
}

struct timezone {
   int tz_minuteswest;
   int tz_dsttime;
}

alias timezone * __timezone_ptr_t;
extern int gettimeofday (timeval * __tv,
   __timezone_ptr_t __tz) ;

extern int settimeofday ( timeval *__tv,
    timezone *__tz) ;

extern int adjtime ( timeval *__delta,
     timeval *__olddelta) ;

enum __itimer_which
{
   ITIMER_REAL = 0,
   ITIMER_VIRTUAL = 1,
   ITIMER_PROF = 2
};

struct itimerval {
   timeval it_interval;
   timeval it_value;
}

alias int __itimer_which_t;

extern int getitimer (__itimer_which_t __which,
       itimerval *__value) ;

extern int setitimer (__itimer_which_t __which,
        itimerval * __new,
       itimerval * __old) ;

extern int utimes ( char *__file,  timeval __tvp[2]);

extern int lutimes ( char *__file,  timeval __tvp[2]);

extern int futimes (int __fd,  timeval __tvp[2]) ;

void rb_mem_clear (VALUE*, int);
VALUE rb_assoc_new (VALUE, VALUE);
VALUE rb_check_array_type (VALUE);
VALUE rb_ary_new ();
VALUE rb_ary_new2 (int);
VALUE rb_ary_new3 (int,...);
VALUE rb_ary_new4 (int,  VALUE *);
VALUE rb_ary_freeze (VALUE);
VALUE rb_ary_aref (int, VALUE*, VALUE);
void rb_ary_store (VALUE, int, VALUE);
VALUE rb_ary_dup (VALUE);
VALUE rb_ary_to_ary (VALUE);
VALUE rb_ary_to_s (VALUE);
VALUE rb_ary_push (VALUE, VALUE);
VALUE rb_ary_pop (VALUE);
VALUE rb_ary_shift (VALUE);
VALUE rb_ary_unshift (VALUE, VALUE);
VALUE rb_ary_entry (VALUE, int);
VALUE rb_ary_each (VALUE);
VALUE rb_ary_join (VALUE, VALUE);
VALUE rb_ary_print_on (VALUE, VALUE);
VALUE rb_ary_reverse (VALUE);
VALUE rb_ary_sort (VALUE);
VALUE rb_ary_sort_bang (VALUE);
VALUE rb_ary_delete (VALUE, VALUE);
VALUE rb_ary_delete_at (VALUE, int);
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
VALUE rb_values_at (VALUE, int, int, VALUE*, VALUE(*) (VALUE,int));

VALUE rb_big_clone (VALUE);
void rb_big_2comp (VALUE);
VALUE rb_big_norm (VALUE);
VALUE rb_uint2big (uint);
VALUE rb_int2big (int);
VALUE rb_uint2inum (uint);
VALUE rb_int2inum (int);
VALUE rb_cstr_to_inum ( char*, int, int);
VALUE rb_str_to_inum (VALUE, int, int);
VALUE rb_cstr2inum ( char*, int);
VALUE rb_str2inum (VALUE, int);
VALUE rb_big2str (VALUE, int);
int rb_big2long (VALUE);

uint rb_big2ulong (VALUE);


VALUE rb_ll2inum (long);
VALUE rb_ull2inum (ulong);
long rb_big2ll (VALUE);
ulong rb_big2ull (VALUE);

void rb_quad_pack (char*,VALUE);
VALUE rb_quad_unpack ( char*,int);
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
VALUE rb_module_new ();
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
void rb_define_protected_method (VALUE,  char*, VALUE (*)(), int);
void rb_define_private_method (VALUE,  char*, VALUE (*)(), int);
void rb_define_singleton_method (VALUE,  char*, VALUE(*)(), int);
VALUE rb_singleton_class (VALUE);

int rb_cmpint (VALUE, VALUE, VALUE);
void rb_cmperr (VALUE, VALUE) ;

extern int ruby_nerrs;
VALUE rb_exc_new (VALUE,  char*, int);
VALUE rb_exc_new2 (VALUE,  char*);
VALUE rb_exc_new3 (VALUE, VALUE);
void rb_loaderror ( char*, ...) ;
void rb_name_error (ID,  char*, ...) ;
void rb_invalid_str ( char*,  char*) ;
void rb_compile_error ( char*, ...);
void rb_compile_error_append ( char*, ...);
void rb_load_fail ( char*) ;
void rb_error_frozen ( char*) ;
void rb_check_frozen (VALUE);

extern RNode *ruby_current_node;
void ruby_set_current_source ();
void rb_exc_raise (VALUE) ;
void rb_exc_fatal (VALUE) ;
VALUE rb_f_exit (int,VALUE*);
VALUE rb_f_abort (int,VALUE*);
void rb_remove_method (VALUE,  char*);

void rb_define_alloc_func (VALUE, VALUE (*)(VALUE));
void rb_undef_alloc_func (VALUE);
void rb_clear_cache ();
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
void rb_interrupt ();
VALUE rb_apply (VALUE, ID, VALUE);
void rb_backtrace ();
ID rb_frame_last_func ();
VALUE rb_obj_instance_eval (int, VALUE*, VALUE);
VALUE rb_mod_module_eval (int, VALUE*, VALUE);
void rb_load (VALUE, int);
void rb_load_protect (VALUE, int, int*);
void rb_jump_tag (int) ;
int rb_provided ( char*);
void rb_provide ( char*);
VALUE rb_f_require (VALUE, VALUE);
VALUE rb_require_safe (VALUE, int);
void rb_obj_call_init (VALUE, int, VALUE*);
VALUE rb_class_new_instance (int, VALUE*, VALUE);
VALUE rb_block_proc ();
VALUE rb_f_lambda ();
VALUE rb_proc_new (VALUE (*)( ), VALUE);
VALUE rb_protect (VALUE (*)(VALUE), VALUE, int*);
void rb_set_end_proc (void (*)(VALUE), VALUE);
void rb_mark_end_proc ();
void rb_exec_end_proc ();
void ruby_finalize ();
void ruby_stop (int) ;
int ruby_cleanup (int);
int ruby_exec ();
void rb_gc_mark_threads ();
void rb_thread_start_timer ();
void rb_thread_stop_timer ();
void rb_thread_schedule ();
void rb_thread_wait_fd (int);
int rb_thread_fd_writable (int);
void rb_thread_fd_close (int);
int rb_thread_alone ();
void rb_thread_polling ();
void rb_thread_sleep (int);
void rb_thread_sleep_forever ();
VALUE rb_thread_stop ();
VALUE rb_thread_wakeup (VALUE);
VALUE rb_thread_run (VALUE);
VALUE rb_thread_kill (VALUE);
VALUE rb_thread_create (VALUE (*)(), void*);
void rb_thread_interrupt ();
void rb_thread_trap_eval (VALUE, int, int);
void rb_thread_signal_raise (char*);
void rb_thread_signal_exit ();
int rb_thread_select (int, fd_set *, fd_set *, fd_set *, timeval *);
void rb_thread_wait_for (timeval);
VALUE rb_thread_current ();
VALUE rb_thread_main ();
VALUE rb_thread_local_aref (VALUE, ID);
VALUE rb_thread_local_aset (VALUE, ID, VALUE);
void rb_thread_atfork ();
VALUE rb_funcall_rescue (VALUE, ID, int, ...);

int eaccess ( char*, int);
VALUE rb_file_s_expand_path (int, VALUE *);
VALUE rb_file_expand_path (VALUE, VALUE);
void rb_file_const ( char*, VALUE);
int rb_find_file_ext (VALUE*,  char* *);
VALUE rb_find_file (VALUE);
char *rb_path_next ( char *);
char *rb_path_skip_prefix ( char *);
char *rb_path_last_separator ( char *);
char *rb_path_end ( char *);

void rb_memerror () ;
int ruby_stack_check ();
int ruby_stack_length (VALUE**);
char *rb_source_filename ( char*);
void rb_gc_mark_locations (VALUE*, VALUE*);
void rb_mark_tbl (st_table*);
void rb_mark_hash (st_table*);
void rb_gc_mark_maybe (VALUE);
void rb_gc_mark (VALUE);
void rb_gc_force_recycle (VALUE);
void rb_gc ();
void rb_gc_copy_finalizer (VALUE,VALUE);
void rb_gc_finalize_deferred ();
void rb_gc_call_finalizer_at_exit ();
VALUE rb_gc_enable ();
VALUE rb_gc_disable ();
VALUE rb_gc_start ();

void st_foreach_safe (st_table *, int (*)(), uint);
void rb_hash_foreach (VALUE, int (*)(), VALUE);
VALUE rb_hash (VALUE);
VALUE rb_hash_new ();
VALUE rb_hash_freeze (VALUE);
VALUE rb_hash_aref (VALUE, VALUE);
VALUE rb_hash_aset (VALUE, VALUE, VALUE);
VALUE rb_hash_delete_if (VALUE);
VALUE rb_hash_delete (VALUE,VALUE);
int rb_path_check (char*);
int rb_env_path_tainted ();

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
VALUE rb_file_open ( char*,  char*);
VALUE rb_gets ();
void rb_write_error ( char*);
void rb_write_error2 ( char*, int);

VALUE rb_marshal_dump (VALUE, VALUE);
VALUE rb_marshal_load (VALUE);

void rb_num_zerodiv ();
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
VALUE rb_convert_type (VALUE,int, char*, char*);
VALUE rb_check_convert_type (VALUE,int, char*, char*);
VALUE rb_to_int (VALUE);
VALUE rb_Integer (VALUE);
VALUE rb_Float (VALUE);
VALUE rb_String (VALUE);
VALUE rb_Array (VALUE);
double rb_cstr_to_dbl ( char*, int);
double rb_str_to_dbl (VALUE, int);

extern int ruby_sourceline;
extern char *ruby_sourcefile;
int ruby_yyparse ();
ID rb_id_attrset (ID);
void rb_parser_append_print ();
void rb_parser_while_loop (int, int);
int ruby_parser_stack_on_heap ();
void rb_gc_mark_parser ();
int rb_is_const_id (ID);
int rb_is_instance_id (ID);
int rb_is_class_id (ID);
int rb_is_local_id (ID);
int rb_is_junk_id (ID);
int rb_symname_p ( char*);
VALUE rb_backref_get ();
void rb_backref_set (VALUE);
VALUE rb_lastline_get ();
void rb_lastline_set (VALUE);
VALUE rb_sym_all_symbols ();

int rb_proc_exec ( char*);
VALUE rb_f_exec (int,VALUE*);
int rb_waitpid (int,int*,int);
void rb_syswait (int);
VALUE rb_proc_times (VALUE);
VALUE rb_detach_process (int);

VALUE rb_range_new (VALUE, VALUE, int);
VALUE rb_range_beg_len (VALUE, int*, int*, int, int);
VALUE rb_length_by_each (VALUE);

int rb_memcmp (char*,char*,int);
int rb_memcicmp (char*,char*,int);
int rb_memsearch (char*,int,char*,int);
VALUE rb_reg_nth_defined (int, VALUE);
VALUE rb_reg_nth_match (int, VALUE);
VALUE rb_reg_last_match (VALUE);
VALUE rb_reg_match_pre (VALUE);
VALUE rb_reg_match_post (VALUE);
VALUE rb_reg_match_last (VALUE);
VALUE rb_reg_new ( char*, int, int);
VALUE rb_reg_match (VALUE, VALUE);
VALUE rb_reg_match2 (VALUE);
int rb_reg_options (VALUE);
void rb_set_kcode ( char*);
char* rb_get_kcode ();

extern VALUE rb_argv;
extern VALUE rb_argv0;
void rb_load_file ( char*);
void ruby_script ( char*);
void ruby_prog_init ();
void ruby_set_argv (int, char**);
void ruby_process_options (int, char**);
void ruby_load_script ();
void ruby_init_loadpath ();
void ruby_incpush ( char*);

VALUE rb_f_kill (int, VALUE*);
void rb_gc_mark_trap_list ();

void ruby_posix_signal (int, void (*)(int));

void rb_trap_exit ();
void rb_trap_exec ();
char *ruby_signal_name (int);

VALUE rb_f_sprintf (int, VALUE*);

VALUE rb_str_new ( char*, int);
VALUE rb_str_new2 ( char*);
VALUE rb_str_new3 (VALUE);
VALUE rb_str_new4 (VALUE);
VALUE rb_str_new5 (VALUE,  char*, int);
VALUE rb_tainted_str_new ( char*, int);
VALUE rb_tainted_str_new2 ( char*);
VALUE rb_str_buf_new (int);
VALUE rb_str_buf_new2 ( char*);
VALUE rb_str_buf_append (VALUE, VALUE);
VALUE rb_str_buf_cat (VALUE,  char*, int);
VALUE rb_str_buf_cat2 (VALUE,  char*);
VALUE rb_obj_as_string (VALUE);
VALUE rb_check_string_type (VALUE);
VALUE rb_str_dup (VALUE);
VALUE rb_str_locktmp (VALUE);
VALUE rb_str_unlocktmp (VALUE);
VALUE rb_str_dup_frozen (VALUE);
VALUE rb_str_plus (VALUE, VALUE);
VALUE rb_str_times (VALUE, VALUE);
VALUE rb_str_substr (VALUE, int, int);
void rb_str_modify (VALUE);
VALUE rb_str_freeze (VALUE);
VALUE rb_str_resize (VALUE, int);
VALUE rb_str_cat (VALUE,  char*, int);
VALUE rb_str_cat2 (VALUE,  char*);
VALUE rb_str_append (VALUE, VALUE);
VALUE rb_str_concat (VALUE, VALUE);
int rb_str_hash (VALUE);
int rb_str_cmp (VALUE, VALUE);
VALUE rb_str_upto (VALUE, VALUE, int);
void rb_str_update (VALUE, int, int, VALUE);
VALUE rb_str_inspect (VALUE);
VALUE rb_str_dump (VALUE);
VALUE rb_str_split (VALUE,  char*);
void rb_str_associate (VALUE, VALUE);
VALUE rb_str_associated (VALUE);
void rb_str_setter (VALUE, ID, VALUE*);
VALUE rb_str_intern (VALUE);

VALUE rb_struct_new (VALUE, ...);
VALUE rb_struct_define ( char*, ...);
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
void rb_set_class_path (VALUE, VALUE,  char*);
VALUE rb_path2class ( char*);
void rb_name_class (VALUE, ID);
VALUE rb_class_name (VALUE);
void rb_autoload (VALUE, ID,  char*);
VALUE rb_autoload_load (VALUE, ID);
VALUE rb_autoload_p (VALUE, ID);
void rb_gc_mark_global_tbl ();
VALUE rb_f_trace_var (int, VALUE*);
VALUE rb_f_untrace_var (int, VALUE*);
VALUE rb_f_global_variables ();
void rb_alias_variable (ID, ID);
st_table* rb_generic_ivar_table (VALUE);
void rb_copy_generic_ivar (VALUE,VALUE);
void rb_mark_generic_ivar (VALUE);
void rb_mark_generic_ivar_tbl ();
void rb_free_generic_ivar (VALUE);
VALUE rb_ivar_get (VALUE, ID);
VALUE rb_ivar_set (VALUE, ID, VALUE);
VALUE rb_ivar_defined (VALUE, ID);
VALUE rb_iv_set (VALUE,  char*, VALUE);
VALUE rb_iv_get (VALUE,  char*);
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
void rb_cv_set (VALUE,  char*, VALUE);
VALUE rb_cv_get (VALUE,  char*);
void rb_define_class_variable (VALUE,  char*, VALUE);
VALUE rb_mod_class_variables (VALUE);
VALUE rb_mod_remove_cvar (VALUE, VALUE);

void ruby_show_version ();
void ruby_show_copyright ();


}

