VALUE rb_str_to_str _((VALUE));
VALUE rb_string_value _((volatile VALUE*));
char *rb_string_value_ptr _((volatile VALUE*));
char *rb_string_value_cstr _((volatile VALUE*));
#define StringValue(v) rb_string_value(&(v))
#define StringValuePtr(v) rb_string_value_ptr(&(v))
#define StringValueCStr(v) rb_string_value_cstr(&(v))
...
#define R_CAST(st)   (struct st*)
#define RBASIC(obj)  (R_CAST(RBasic)(obj))
#define ROBJECT(obj) (R_CAST(RObject)(obj))
#define RCLASS(obj)  (R_CAST(RClass)(obj))
#define RMODULE(obj) RCLASS(obj)
#define RFLOAT(obj)  (R_CAST(RFloat)(obj))
#define RSTRING(obj) (R_CAST(RString)(obj))
...
long rb_num2long _((VALUE));
unsigned long rb_num2ulong _((VALUE));
long rb_num2int _((VALUE));
long rb_fix2int _((VALUE));
#define FIX2INT(x) rb_fix2int((VALUE)x)
unsigned long rb_num2uint _((VALUE));
#define NUM2UINT(x) rb_num2uint(x)
unsigned long rb_fix2uint _((VALUE));

