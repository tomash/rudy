module rudy.func_wrap;

//the basics: bindings
import bcd.ruby;

import rudy.exception;

// Builds a callable Ruby object from a delegate or function pointer.
void PydWrappedFunc_Ready(T)() {
    alias wrapped_class_type!(T) type;
    alias wrapped_class_object!(T) obj;
    if (!is_wrapped!(T)) {
        type.ob_type = PyType_Type_p;
        type.tp_basicsize = obj.sizeof;
        type.tp_name = "PydFunc";
        type.tp_flags = Py_TPFLAGS_DEFAULT;

        type.tp_call = &wrapped_func_call!(T).call;

        PyType_Ready(&type);
        is_wrapped!(T) = true;
        //wrapped_classes[typeid(T)] = true;
    }
}
