CREATE OR REPLACE PACKAGE MSTR.PANDAS_ERROR_HANDLER
IS
   --      con_str_hostname_port   CONSTANT VARCHAR2 (1024) := 'http://eurostrategy.net:8181';
   PROCEDURE jsp (p_error_code      IN VARCHAR2 DEFAULT NULL,
                  p_error_message   IN VARCHAR2 DEFAULT NULL,
                  p_stack_trace     IN VARCHAR2 DEFAULT NULL);
--   PROCEDURE test;
--
--   PROCEDURE add_gcal_error_event (p_error_code      IN VARCHAR2 DEFAULT NULL,
--                                   p_error_message   IN VARCHAR2 DEFAULT NULL,
--                                   p_stack_trace     IN VARCHAR2 DEFAULT NULL);
END;
/
