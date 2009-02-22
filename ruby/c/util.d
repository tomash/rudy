module ruby.c.util;

extern (C) {

  ulong ruby_scan_oct (const char*, int, int*);
  ulong ruby_scan_hex (const char*, int, int*);

  version(MSDOS) void ruby_add_suffix();
  version(__CYGWIN32__) void ruby_add_suffix();
  version(Windows) void ruby_add_suffix();

  void ruby_qsort (void*, const int, const int, int (*)(), void*);

  void ruby_setenv (const char*, const char*);
  void ruby_unsetenv (const char*);
  char *ruby_strdup (const char*);
  char *ruby_getcwd ();
  double ruby_strtod (const char*, char **);

}

void qsort(void* b, const int n, const int s, int function() c, void* d){
  ruby_qsort(b,n,s,c,d);
}

void setenv(const char* name, const char* val){
  ruby_setenv(name, val);
}

void unsetenv(const char* name, const char* val){
  ruby_unsetenv(name);
}

char* strdup(const char* s){
  return ruby_strdup(s);
}

char* my_getcwd(){
  return ruby_getcwd();
}

double strtod(const char* s, char ** e){
  return ruby_strtod(s,e);
}
