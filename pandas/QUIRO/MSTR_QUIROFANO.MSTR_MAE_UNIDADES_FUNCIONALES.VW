CREATE OR REPLACE FORCE VIEW MSTR_QUIROFANO.MSTR_MAE_UNIDADES_FUNCIONALES
(NATID_UNIDAD_FUNCIONAL, DESCR_UNIDAD_FUNCIONAL, NATID_PADRE_UNIDAD_FUNCIONAL)
AS 
SELECT '41', 'Sevilla', NULL FROM DUAL
   UNION ALL
   SELECT '-1', 'n/a', NULL FROM DUAL
   UNION ALL
   SELECT                                                                                              --UF_AGENDAS, UF_AH_CODIGO,
         UF_CODIGO,                                                                   --   UF_DIV_CODIGO, UF_ES_CODIGO, UF_EST_ID,
                    --   UF_FECHA_ACTIVO, UF_FECHA_ALTA, UF_FECHA_MOD,
                    UF_NOMBRE,                                                                                     --UF_FECHA_PAS,
                               --UF_FINAL,
                               --   UF_OPE_CODIGO, UF_SEU_ID,
                               --UF_SITUACION,
                               --UF_TELEFONO, UF_UC_CODIGO,
                               UF_UF_CODIGO
     FROM REP_PRO_EST.UNIDADES_FUNCIONALES@DAE
    WHERE UF_AH_CODIGO IN (SELECT NATID_AREA_HOSPITALARIA FROM MSTR_UTL_CODIGOS)
/
