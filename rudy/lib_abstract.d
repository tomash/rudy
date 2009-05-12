// This module abstracts out all of the uses of Phobos, Tango, and meta, easing
// the ability to switch between Phobos and Tango arbitrarily.
module rudy.lib_abstract;

version (Rudy_with_Tango) {
    import tango.stdc.string : strlen;
    //import tango.text.convert.Integer : qadut;
    char[] toString(char* s) {
        return s[0 .. strlen(s)];
    }
    /*char[] toString(uint i) {
        char[64] tmp;
        return qadut(tmp, i);
    }*/

    //public import tango.util.meta.Nameof : symbolnameof, prettytypeof, prettynameof;
    //
    public import meta.Nameof : symbolnameof, prettytypeof, prettynameof;
    public import meta.Default : minArgs, ParameterTypeTuple, ReturnType;
    char[] objToStr(Object o) {
        return o.toUtf8();
    }
} else {
    char[] objToStr(Object o) {
        return o.toString();
    }
    public import meta.Nameof : symbolnameof, prettytypeof, prettynameof;

    public import std.string : toString;
    public import std.traits : ParameterTypeTuple, ReturnType;
    public import std.bind : minArgs = minNumArgs;
}
