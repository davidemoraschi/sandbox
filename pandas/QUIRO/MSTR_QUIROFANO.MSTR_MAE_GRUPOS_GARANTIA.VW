CREATE OR REPLACE FORCE VIEW MSTR_QUIROFANO.MSTR_MAE_GRUPOS_GARANTIA
(GG_CODIGO, GG_NOMBRE, GG_SITUACION)
AS 
SELECT GG_CODIGO, GG_NOMBRE, GG_SITUACION
     FROM REP_PRO_AGD.GRUPOS_GARANTIAS@DAE
/
