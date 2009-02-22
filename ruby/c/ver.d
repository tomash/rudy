module ruby.c.ver;

extern (C) {

char[] RUBY_VERSION = "1.8.4";
char[] RUBY_RELEASE_DATE = "2005-12-24";
char[] RUBY_VERSION_CODE = 184;
char[] RUBY_RELEASE_CODE = 20051224;

uint RUBY_VERSION_MAJOR = 1;
uint RUBY_VERSION_MINOR = 8;
uint RUBY_VERSION_TEENY = 4;
uint RUBY_RELEASE_YEAR = 2005;
uint RUBY_RELEASE_MONTH = 12;
uint RUBY_RELEASE_DAY =	24;

extern const char ruby_version[];
extern const char ruby_release_date[];
extern const char ruby_platform[];

}

