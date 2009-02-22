typedef struct re_pattern_buffer Regexp;

struct RMatch {
    struct RBasic basic;
    VALUE str;
    struct re_registers *regs;
};



VALUE rb_reg_regcomp _((VALUE));
long rb_reg_search _((VALUE, VALUE, long, long));
VALUE rb_reg_regsub _((VALUE, VALUE, struct re_registers *));
long rb_reg_adjust_startpos _((VALUE, VALUE, long, long));
void rb_match_busy _((VALUE));
VALUE rb_reg_quote _((VALUE));

RUBY_EXTERN int ruby_ignorecase;

int rb_reg_mbclen2 _((unsigned int, VALUE));
