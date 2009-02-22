module ruby.c.defines;

extern (C) {
void *ruby_xmalloc ();
void *ruby_xcalloc ();
void *ruby_xrealloc ();
void ruby_xfree ();
}
