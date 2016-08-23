CREATE OR REPLACE FORCE VIEW MSTR_SIGLO.MSTR_MAE_ECONOMICA_N0
(NATID_ECONOMICA_N0, DESCR_ECONOMICA_N0)
AS 
SELECT ID NATID_ECONOMICA_N0, DESCRIPCION DESCR_ECONOMICA_N0                                                                  --,
     --CODIGO CODE1_CAPITULO_N0--,
     --NIVEL NIVEL,
     --VALORPADRE                                                                                                           --,
     FROM REP_PRO_SIGLO.CAT_NIVELVALOR@SYG
    WHERE CLASIFICACION = 4 AND VALORPADRE IS NULL
    UNION ALL
    SELECT -1 NATID_ECONOMICA_N0, 'n/a' DESCR_ECONOMICA_N0
    FROM DUAL
/
