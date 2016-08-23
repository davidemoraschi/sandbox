CREATE OR REPLACE FORCE VIEW MSTR.MSTR_UTL_SCHEDULER_JOB_LOG_LE1
("Title", "Fecha_inicio_tarea", "Duracion", "Carga", "Resultado", 
 "Informacion", "Clave_log")
AS 
SELECT 'Copia de Seguridad Oracle' "Title",
          ST "Fecha_inicio_tarea",
          SUBSTR(DX,12,8) "Duracion",
          NULL "Carga",
          STATUS "Resultado",
          NULL "Informacion",
          RECID "Clave_log"
     FROM (  SELECT TO_CHAR (start_time, 'DD/MM/YYYY HH24:MI') ST,
     NUMTODSINTERVAL((end_time - start_time) , 'day') DX,
                    ROUND ( (end_time - start_time) * 24, 2) DU,
                    STATUS,
                    RECID,
                    RANK () OVER (ORDER BY MAX (END_TIME) DESC NULLS LAST) WJXBFS2                                             --,
               FROM v$rman_status
              WHERE OPERATION = 'BACKUP'
           GROUP BY TO_CHAR (start_time, 'DD/MM/YYYY HH24:MI'),NUMTODSINTERVAL((end_time - start_time) , 'day'),
                    ROUND ( (end_time - start_time) * 24, 2),
                    STATUS,
                    RECID)
    WHERE WJXBFS2 = 1
/
