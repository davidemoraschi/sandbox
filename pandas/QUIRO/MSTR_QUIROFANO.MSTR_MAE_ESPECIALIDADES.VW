CREATE OR REPLACE FORCE VIEW MSTR_QUIROFANO.MSTR_MAE_ESPECIALIDADES
(ES_CODIGO, ES_DECRETO, ES_DESCRIPCION, ES_PRIMARIA)
AS 
SELECT 
ES_CODIGO, ES_DECRETO, ES_DESCRIPCION, 
   ES_PRIMARIA
FROM REP_PRO_EST.ESPECIALIDADES@dae
/
