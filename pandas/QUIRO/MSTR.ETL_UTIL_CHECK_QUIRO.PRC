CREATE OR REPLACE procedure MSTR.ETL_UTIL_CHECK_QUIRO
AS
BEGIN
   ETL_UTIL_LISTAS_SHAREPOINT.inserta ('http://sharepoint13-pruebas/pandas/_vti_bin/listdata.svc/Alertas',
                                       'MSTR_UTL_SCHEDULER_JOB_LOG_LE1');
   ETL_UTIL_LISTAS_SHAREPOINT.inserta ('http://sharepoint13-pruebas/pandas/_vti_bin/listdata.svc/Alertas',
                                       'MSTR_UTL_SCHEDULER_JOB_LOG_LE2');
--   ETL_UTIL_LISTAS_SHAREPOINT.inserta ('http://sharepoint13-pruebas/pandas/_vti_bin/listdata.svc/Alertas',
--                                       'MSTR_UTL_SCHEDULER_JOB_LOG_LE3');
--   ETL_UTIL_LISTAS_SHAREPOINT.inserta ('http://sharepoint13-pruebas/pandas/_vti_bin/listdata.svc/Alertas',
--                                       'MSTR_UTL_SCHEDULER_JOB_LOG_LE4');
END;
/
