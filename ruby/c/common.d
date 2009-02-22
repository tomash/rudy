module ruby.c.common;

version (linux)
{
  version(DigitalMars){
    public import std.c.time;
  }
  public import std.c.linux.linux;
}

version (Windows)
{
  public import std.c.time;
  public import std.c.windows.winsock;
}