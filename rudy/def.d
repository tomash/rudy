module rudy.def;

import bcd.ruby;

/*
import rudy.lib_abstract :
  symbolnameof,
  minArgs
;
*/
import meta.Default;
import meta.Nameof;

/*
 * Wraps a D function, making it callable from Ruby.
 *
 * Params:
 *      name = The name of the function as it will appear in Ruby.
 *      fn   = The function to wrap.
 *      MIN_ARGS = The minimum number of arguments this function can accept.
 *                 For use with functions with default arguments. Defaults to
 *                 the maximum number of arguments this function supports.
 *      fn_t = The function type of the function to wrap. This must be
 *             specified if more than one function shares the same name,
 *             otherwise the first one defined lexically will be used.
 *
 */
 
void def(alias fn, char[] name = symbolnameof!(fn), fn_t=typeof(&fn), uint MIN_ARGS = minArgs!(fn, fn_t)) (char[] docstring="") 
{
    def!("Object", fn, name, fn_t, MIN_ARGS)(docstring);
}


/* currently does it the "dumb" way, without wrapping/unwrapping arguments and return values! */

void def(char[] modulename, alias fn, char[] name = symbolnameof!(fn), fn_t=typeof(&fn), uint MIN_ARGS = minArgs!(fn, fn_t)) (char[] docstring="") 
{
    pragma(msg, "def: " ~ name ~ " in " ~ modulename);
    
    VALUE parent_context = rb_const_get(rb_cObject, rb_intern((modulename ~ \0).ptr));
    
    if(rb_type(parent_context) == T_CLASS)
    {
      rb_define_method(parent_context, (name ~ \0).ptr, &fn, MIN_ARGS);
    }
    else if(rb_type(parent_context) == T_MODULE)
    {
      rb_define_module_function(parent_context, (name ~ \0).ptr, &fn, MIN_ARGS);
    }
    else  //no scope given or scope sucks: define a global (Object scope)
    {
      rb_define_method(rb_cObject, (name ~ \0).ptr, &fn, MIN_ARGS);
    }
    
}
