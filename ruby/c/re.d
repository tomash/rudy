module ruby.c.re;

private import ruby.c.ruby;
private import ruby.c.regex;

extern (C) {
alias re_pattern_buffer Regexp;

struct RMatch {
    RBasic basic;
    VALUE str;
    re_registers *regs;
}

VALUE rb_reg_regcomp (VALUE);
int rb_reg_search (VALUE, VALUE, int, int);
VALUE rb_reg_regsub (VALUE, VALUE, re_registers *);
int rb_reg_adjust_startpos (VALUE, VALUE, int, int);
void rb_match_busy (VALUE);
VALUE rb_reg_quote (VALUE);

extern int ruby_ignorecase;

int rb_reg_mbclen2 (uint, VALUE);
}

