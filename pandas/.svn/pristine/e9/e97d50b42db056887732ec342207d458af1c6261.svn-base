CREATE OR REPLACE PACKAGE BODY MSTR_QUIROFANO.ETL_LOAD_AGD
AS
   /******************************************************************************
      NAME:       ETL_LOAD_INFHOS
      PURPOSE:

      REVISIONS:
      Ver        Date        Author           Description
      ---------  ----------  ---------------  ------------------------------------
      1.0        9/17/2012      Davide       1. Created this package body.
   ******************************************************************************/

   PROCEDURE P_001 (Param1 IN NUMBER DEFAULT NULL)
   IS
      TmpVar   NUMBER;
   BEGIN
      --DBMS_SNAPSHOT.REFRESH ('MSTR_DET_LISTA_ESPERA_QUIRUR', 'C');
      EXECUTE IMMEDIATE 'TRUNCATE TABLE MSTR_DET_LISTA_ESPERA_QUIRUR';

      EXECUTE IMMEDIATE
         'INSERT INTO MSTR_DET_LISTA_ESPERA_QUIRUR 
            SELECT RDQ_CODIGO,
          NUSA NUHSA,
          RDQ_NUM_HIS_CLI,
          RDQ_MUNICIPIO,
          ES_CODIGO,
          RDQ_FX_ALTA,
          TRUNC (RDQ_FECHA_ALTA) RDQ_FX_MECANIZACION,
          RDQ_FX_BAJA,
          RDQ_FX_FACULTATIVO,
          FACU_CNP_RESPONSABLE,
          SITPAC_CODIGO_ACTUAL,
          SITGAR_CODIGO,
          MOTBAJ_CODIGO,
          RDQ.PRC_CODIGO,
          DG_CODIGO,
          TIPCIR_CODIGO,
          UF_CODIGO_ALTA,
          UF_CODIGO_INTERVENCION,
          AH_CODIGO_ALTA,
          AH_CODIGO AH_CODIGO_RESPONSABLE,
          AH_CODIGO_INTERVENCION,
          AH_CODIGO_OFERTA,
          CI_CODIGO_ALTA,
          CI_CODIGO CI_CODIGO_RESPONSABLE,
          CI_CODIGO_INTERVENCION,
          CI_CODIGO_OFERTA,
          RDQ_TIEMPO_REG,
          RDQ_TIEMPO_GAR,
          TO_DATE (1, ''J'') DIA_CUMPLE_GARANTIA,
          DECODE (MSTR_MAE_PROCEDIMIENTOS_DAE.PRC_CODIGO, NULL, ''A'', ''D'')
             IND_DAE,
          TO_DATE (1, ''J'') SEMANA_CUMPLE_GARANTIA
     FROM    REP_PRO_AGD.RDQ@DAE
          LEFT JOIN
             MSTR_MAE_PROCEDIMIENTOS_DAE
          ON (RDQ.PRC_CODIGO = MSTR_MAE_PROCEDIMIENTOS_DAE.PRC_CODIGO)';

      UPDATE MSTR_DET_LISTA_ESPERA_QUIRUR
         SET DIA_CUMPLE_GARANTIA =
                RDQ_FX_FACULTATIVO
                + ( (SELECT PRC_TIEMPO_GAR
                       FROM MSTR_MAE_PROCEDIMIENTOS
                      WHERE MSTR_MAE_PROCEDIMIENTOS.PRC_CODIGO =
                               MSTR_DET_LISTA_ESPERA_QUIRUR.PRC_CODIGO)
                   - RDQ_TIEMPO_GAR);

      UPDATE MSTR_DET_LISTA_ESPERA_QUIRUR
         SET SEMANA_CUMPLE_GARANTIA = TRUNC (DIA_CUMPLE_GARANTIA, 'DAY');

      --      UPDATE MSTR_DET_LISTA_ESPERA_QUIRUR
      --         SET DIA_CUMPLE_GARANTIA = NULL;

      DBMS_STATS.gather_table_stats ('MSTR_QUIROFANO',
                                     'MSTR_DET_LISTA_ESPERA_QUIRUR');
   END P_001;
END ETL_LOAD_AGD;
/
