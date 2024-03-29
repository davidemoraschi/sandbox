CREATE OR REPLACE FORCE VIEW MSTR_SIGLO.MSTR_MAE_ECONOMICA_N4
(NATID_ECONOMICA_N4, DESCR_ECONOMICA_N4, LDESC_ECONOMICA_N4, NATID_ECONOMICA_N3)
AS 
SELECT --*
   ID NATID_ECONOMICA_N4,
          DESCRIPCION DESCR_ECONOMICA_N4,
          CODIGOCONCATENADO LDESC_ECONOMICA_N4,
          VALORPADRE NATID_ECONOMICA_N3
     FROM REP_PRO_SIGLO.CAT_NIVELVALOR@SYG
    WHERE CLASIFICACION = 4 AND VALORPADRE IN (SELECT NATID_ECONOMICA_N3 FROM MSTR_MAE_ECONOMICA_N3)
       UNION ALL
   SELECT -1 NATID_ECONOMICA_N4,
          'n/a' DESCR_ECONOMICA_N4,
          'n/a' LDESC_ECONOMICA_N4,
          -1 NATID_ECONOMICA_N3
     FROM DUAL
/
