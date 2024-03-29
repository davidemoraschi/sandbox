CREATE OR REPLACE FORCE VIEW MSTR_SIGLO.MSTR_MAE_CATALOGO_N8
(NATID_CATALOGO_N8, DESCR_CATALOGO_N8, LDESC_CATALOGO_N8, NATID_CATALOGO_N7)
AS 
SELECT ID NATID_CATALOGO_N8,
          DESCRIPCION DESCR_CATALOGO_N8,
          CODIGOCONCATENADO LDESC_CATALOGO_N8,
          VALORPADRE NATID_CATALOGO_N7
     FROM REP_PRO_SIGLO.CAT_NIVELVALOR@SYG
    WHERE CLASIFICACION = 5 AND VALORPADRE IN (SELECT NATID_CATALOGO_N7 FROM MSTR_MAE_CATALOGO_N7)
/
