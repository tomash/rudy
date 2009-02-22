module ruby.c.rubyio;

private import ruby.c.ruby;

private import std.c.stdio;

extern (C) {

  struct OpenFile {
      FILE *f;			/* stdio ptr for read/write */
      FILE *f2;			/* additional ptr for rw pipes */
      int mode;			/* mode flags */
      int pid;			/* child's pid (for pipes) */
      int lineno;			/* number of lines read */
      char *path;			/* pathname for file */
      void (*finalize) (OpenFile*,int); /* finalize proc */
  };

  FILE* GetReadFile(OpenFile* fptr) { return fptr.f; }
  FILE* GetWriteFile(OpenFile* fptr) { return fptr.f2 ? fptr.f2 : fptr.f; }

  FILE *rb_fopen ( char*,  char*);
  FILE *rb_fdopen (int,  char*);
  int rb_getc (FILE*);
  int rb_io_fread (char *, int, FILE *);
  int rb_io_fwrite ( char *, int, FILE *);
  int rb_io_mode_flags ( char*);
  int rb_io_modenum_flags (int);
  void rb_io_check_writable (OpenFile*);
  void rb_io_check_readable (OpenFile*);
  void rb_io_fptr_finalize (OpenFile*);
  void rb_io_synchronized (OpenFile*);
  void rb_io_check_initialized (OpenFile*);
  void rb_io_check_closed (OpenFile*);
  int rb_io_wait_readable (int);
  int rb_io_wait_writable (int);

  //VALUE rb_io_taint_check (VALUE);
  RBasic rb_io_taint_check (VALUE);
  void rb_eof_error ();

  void rb_read_check (FILE*);
  int rb_read_pending (FILE*);

}

enum{
  FMODE_READABLE  = 1,
  FMODE_WRITABLE  = 2,
  FMODE_READWRITE = 3,
  FMODE_APPEND    = 64,
  FMODE_CREATE    = 128,
  FMODE_BINMODE   = 4,
  FMODE_SYNC      = 8,
  FMODE_WBUF      = 16,
  FMODE_RBUF      = 32,
  FMODE_WSPLIT    = 0x200,
  FMODE_WSPLIT_INITIALIZED = 0x400
}
/*
* commented out for compiling
void GetOpenFile(VALUE obj, OpenFile* fp){
  rb_io_check_closed((fp) = RFILE(rb_io_taint_check(obj)).fptr);
}

void MakeOpenFile(VALUE obj, OpenFile* fp){
  if (RFILE(obj).fptr) {
	  rb_io_close(obj);
	  free(RFILE(obj).fptr);
	  RFILE(obj).fptr = 0;
  }
  fp = 0;
  fp = RFILE(obj).fptr = new OpenFile;
  fp.f = fp.f2 = NULL;
  fp.mode = 0;
  fp.pid = 0;
  fp.lineno = 0;
  fp.path = NULL;
  fp.finalize = 0;
}
*/
