CREATE OR REPLACE FORCE VIEW MSTR_SIGLO.MSTR_MAE_CATALOGO_N6
(NATID_CATALOGO_N6, DESCR_CATALOGO_N6, LDESC_CATALOGO_N6, NATID_CATALOGO_N5)
AS 
SELECT ID NATID_CATALOGO_N6,
          DESCRIPCION DESCR_CATALOGO_N6,
          CODIGOCONCATENADO LDESC_CATALOGO_N6,
          VALORPADRE NATID_CATALOGO_N5
     FROM REP_PRO_SIGLO.CAT_NIVELVALOR@SYG
    WHERE CLASIFICACION = 5 AND VALORPADRE IN (SELECT NATID_CATALOGO_N5 FROM MSTR_MAE_CATALOGO_N5)
/
