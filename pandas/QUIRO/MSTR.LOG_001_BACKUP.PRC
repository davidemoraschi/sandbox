CREATE OR REPLACE PROCEDURE MSTR.log_001_backup
AS
   v_status    VARCHAR2 (32767);
   v_content   VARCHAR2 (32767);
   v_endtime   VARCHAR2 (32767);
BEGIN
   ETL_UTIL_CHECK_BACKUP;

   SELECT TO_CHAR (end_time, 'dd-mon hh24:mi'), ROUND ( (end_time - start_time) * 24, 2)
     INTO v_endtime, v_content
     FROM UTL_RMAN_STATUS
    WHERE operation = 'BACKUP'
          AND end_time = (SELECT MAX (end_time)
                            FROM UTL_RMAN_STATUS
                           WHERE operation = 'BACKUP');

   SELECT STATUS
     INTO v_status
     FROM UTL_RMAN_STATUS
    WHERE operation = 'BACKUP'
          AND end_time = (SELECT MAX (end_time)
                            FROM UTL_RMAN_STATUS
                           WHERE operation = 'BACKUP');

   --   PANDAS_090_POST_TO_SHAREP_v2.RETRY_N_TIMES (
   --      3,
   --      '{ Title: "Copia de seguridad BD Oracle", Content: "' || v_content || '", Result: "' || v_status || '"  }');
   MSTR.PANDAS_090_POST_TO_SHAREP_v3.RETRY_N_TIMES (
      3,
      '{ Title: "Copia de seguridad BD Oracle", Content: "'
      || '<table border=''1'' cellpadding=''3''><tr><td bgcolor=''#691BB8''>Última Ejecución</td><td bgcolor=''#691BB8''>Duración (min.)</td></td></tr><tr><td bgcolor=''#232325''>'
      || v_endtime
      || '</td><td>'
      || v_content
      || '</td></tr></table> '
      --||
      --         || ', duración m '
      --         || ROUND (v_elapsed, 2)
      || '", Result: "'
      || v_status
      || '"  }');
END;
/
