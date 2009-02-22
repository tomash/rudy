module wrap_test;

import ruby.ruby;
import ruby.array;

class Test : RClass
{
public:
  static void class_info(RClassInfo info){
    info.add_method("initialize", &Test.ctor);
    info.add_method("add", &Test.add);
  }

  this(){
    instants_var("arr", new RArray());
  }

  RArray add(RObject obj){
    RArray arr = cast(RArray)instants_var("arr");
    arr << obj;
    return arr;
  }
}

extern(C)
void Init_Test()
{
  RClassInfo info = define_class!(Test);
  info.def("add", &Test.add);
}

