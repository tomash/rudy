module rudy.exception;

import bcd.ruby;

void handle_exception() {
    
}

/**
 * This simple exception class holds a Python exception.
 */
class RubyException : Exception {
  protected:
    VALUE m_type, m_value, m_trace;
  public:
}

