
typedef struct OpenFile {
    FILE *f;
    FILE *f2;
    int mode;
    int pid;
    int lineno;
    char *path;
    void (*finalize) _((struct OpenFile*,int));
} OpenFile;
# 66 "rubyio.h"
FILE *rb_fopen _((const char*, const char*));
FILE *rb_fdopen _((int, const char*));
int rb_getc _((FILE*));
long rb_io_fread _((char *, long, FILE *));
long rb_io_fwrite _((const char *, long, FILE *));
int rb_io_mode_flags _((const char*));
int rb_io_modenum_flags _((int));
void rb_io_check_writable _((OpenFile*));
void rb_io_check_readable _((OpenFile*));
void rb_io_fptr_finalize _((OpenFile*));
void rb_io_synchronized _((OpenFile*));
void rb_io_check_initialized _((OpenFile*));
void rb_io_check_closed _((OpenFile*));
int rb_io_wait_readable _((int));
int rb_io_wait_writable _((int));

VALUE rb_io_taint_check _((VALUE));
NORETURN(void rb_eof_error _((void)));

void rb_read_check _((FILE*));
int rb_read_pending _((FILE*));
