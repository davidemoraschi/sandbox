CREATE OR REPLACE FORCE VIEW MSTR_SIGLO.MSTR_MAE_ORGANOSGESTORES
(NATID_ORGANOGESTOR, DESCR_ORGANOGESTOR)
AS 
SELECT ID NATID_ORGANOGESTOR, DESCRIPCION DESCR_ORGANOGESTOR FROM REP_PRO_SIGLO.ORG_ORGANOGESTOR@SYG
/
