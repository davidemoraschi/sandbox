CREATE OR REPLACE PACKAGE BODY MSTR_SIGLO.ETL_LOAD_CN03B
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
      v_inicio_ts           DATE;
      v_fin_ts              DATE;
      v_elapsed             NUMBER;
      v_last_refresh        DATE;
      v_area_hospitalaria   VARCHAR2 (10);
   BEGIN
      v_inicio_ts := SYSDATE;

--      SELECT NATID_AREA_HOSPITALARIA INTO v_area_hospitalaria FROM MSTR_UTL_CODIGOS;

      BEGIN
         EXECUTE IMMEDIATE 'DROP TABLE TEMP_DET_CN03B';
            EXCEPTION
               WHEN OTHERS
               THEN
                  NULL;
      END;
     
      BEGIN
         EXECUTE IMMEDIATE
            'CREATE TABLE TEMP_DET_CN03B
NOLOGGING
NOMONITORING
PARALLEL AS
    WITH LIMITS AS (SELECT ADD_MONTHS (TRUNC (SYSDATE, ''YEAR''), -24) INICIO, ADD_MONTHS (TRUNC (SYSDATE, ''YEAR''), 12) - 1 FIN FROM DUAL)
        SELECT TRUNC (FECHA) NATID_DIA
                    ,ARTICULO NATID_ARTICULO
                    ,NVL (CENTROCONSUMO, -1) NATID_CENTROCONSUMO
                    ,NVL (NATID_ECONOMICA_N4, -1) NATID_ECONOMICA_N4
                    ,SUM (CANTIDADSALIDA) CN03B_CANTIDAD
                    ,SUM (IMPORTESALIDA) CN03B_IMPORTE
            FROM REP_PRO_SIGLO.ALM_SALIDAALMACEN@SYG
                     LEFT JOIN (    SELECT ARTICULO, NIVELVALOR NATID_ECONOMICA_N4
                                                    FROM (SELECT ID, ARTICULO, NIVELVALOR
                                                                    FROM REP_PRO_SIGLO.CAT_ARTICULOCLASIF@SYG
                                                                 WHERE         FECHAFINVALIDEZ IS NULL
                                                                             AND DEFECTO = ''T''
                                                                             AND NIVELVALOR IN (SELECT ID
                                                                                                                        FROM REP_PRO_SIGLO.CAT_NIVELVALOR@SYG
                                                                                                                     WHERE CLASIFICACION = 4))
                                            GROUP BY ARTICULO, NIVELVALOR)
                         USING (ARTICULO)
                     CROSS JOIN LIMITS
         WHERE FECHA BETWEEN INICIO AND FIN AND CENTROCONSUMO IS NOT NULL
    GROUP BY TRUNC (FECHA)
                    ,ARTICULO
                    ,CENTROCONSUMO
                    ,NATID_ECONOMICA_N4';
      --      EXCEPTION
      --         WHEN OTHERS
      --         THEN
      --            NULL;
      END;

      BEGIN
         EXECUTE IMMEDIATE 'ALTER TABLE MSTR_SIGLO.TEMP_DET_CN03B ADD
CONSTRAINT TEMP_DET_CN03B_PK
 PRIMARY KEY (NATID_DIA, NATID_ARTICULO, NATID_CENTROCONSUMO)
 NOLOGGING
 NOMONITORING
 PARALLEL';
      --      EXCEPTION
      --         WHEN OTHERS
      --         THEN
      --            NULL;
      END;
      
      BEGIN
         EXECUTE IMMEDIATE 'ALTER TABLE MSTR_SIGLO.TEMP_DET_CN03B ADD
CONSTRAINT TEMP_DET_CN03B_R01
 FOREIGN KEY (NATID_ARTICULO)
 REFERENCES MSTR_SIGLO.MSTR_MAE_ARTICULOS (NATID_ARTICULO)';
      --      EXCEPTION
      --         WHEN OTHERS
      --         THEN
      --            NULL;
      END;

      BEGIN
         EXECUTE IMMEDIATE
            'ALTER TABLE TEMP_DET_CN03B ADD (
 CONSTRAINT TEMP_DET_CN03B_R04
 FOREIGN KEY (NATID_CENTROCONSUMO)
 REFERENCES MSTR_MAE_CENTROSCONSUMO (NATID_CENTROCONSUMO))';
      --      EXCEPTION
      --         WHEN OTHERS
      --         THEN
      --            NULL;
      END;
/*
     BEGIN
         EXECUTE IMMEDIATE
            ' ALTER TABLE MSTR_SIGLO.MSTR_DET_GA03B ADD 
CONSTRAINT MSTR_DET_GA03B_R03
 FOREIGN KEY (NATID_ORGANOGESTOR)
 REFERENCES MSTR_SIGLO.MSTR_MAE_ORGANOSGESTORES (NATID_ORGANOGESTOR)
 ENABLE
 VALIDATE';
      --      EXCEPTION
      --         WHEN OTHERS
      --         THEN
      --            NULL;
      END;

*/
BEGIN
    SYS.DBMS_STATS.GATHER_TABLE_STATS (OwnName => 'MSTR_SIGLO'
                                                                        ,TabName => 'TEMP_DET_CN03B'
                                                                        ,Estimate_Percent => SYS.DBMS_STATS.AUTO_SAMPLE_SIZE
                                                                        ,Method_Opt => 'FOR ALL INDEXED COLUMNS SIZE AUTO '
                                                                        ,Degree => NULL
                                                                        ,Cascade => TRUE
                                                                        ,No_Invalidate => FALSE);
END;
      --     SELECT MAX (LAST_REFRESH_DATE) INTO v_last_refresh FROM MSTR_DET_CAMAS_DEL_DIA;

      BEGIN
         EXECUTE IMMEDIATE 'DROP TABLE MSTR_HLP_PORCENTAJES_CC_SV_UG';
            EXCEPTION
               WHEN OTHERS
               THEN
                  NULL;
      END;
     
      BEGIN
         EXECUTE IMMEDIATE
            'CREATE TABLE MSTR_HLP_PORCENTAJES_CC_SV_UG
NOLOGGING
NOMONITORING
NOPARALLEL AS
    SELECT NATID_ORGANOGESTOR
                ,NATID_CENTROCONSUMO
                ,DESCR_CENTROCONSUMO
                ,LDESC_CENTROCONSUMO
                ,ESTADO_CENTROCONSUMO
                ,TIPO
                ,NATID_SERVICIO
                ,DESCR_SERVICIO
                ,LDESC_SERVICIO
                ,ESTADO_SERVICIO
                ,PORCENTAJE
                ,DECODE (TIPO,    ''UG'', ER_ID,  ''SV'', NVL (UGCSV.UNIDADGESTIONCLINICA, -1),  ''NA'', -1) NATID_UNIDAD_GESTION_CLINICA
                ,DECODE (TIPO,    ''UG'', UG_DESCRIPCION,  ''SV'', NVL (UG2.DESCRIPCION, ''N/A''),  ''NA'', ''Sin UGC'') DESCR_UNIDAD_GESTION_CLINICA
                ,DECODE (TIPO,    ''UG'', UG_CODIGO,  ''SV'', NVL (UG2.CODIGO, ''N/A''),  ''NA'', ''N/A'') LDESC_UNIDAD_GESTION_CLINICA
                ,DECODE (TIPO,    ''UG'', UG_ESTADO,  ''SV'', NVL (UG2.ESTADO, ''N/A''),  ''NA'', ''N/A'') ESTADO_UNIDAD_GESTION_CLINICA
        FROM (SELECT CC.ORGANICA NATID_ORGANOGESTOR
                                ,CC.ID NATID_CENTROCONSUMO
                                ,CC.NOMBRE DESCR_CENTROCONSUMO
                                ,CC.CODIGO LDESC_CENTROCONSUMO
                                ,CC.ESTADO ESTADO_CENTROCONSUMO
                                ,NVL (TIPO, ''NA'') TIPO
                                ,DECODE (TIPO,    ''SV'', ER.ID,  ''UG'', ER.ID * -1,  NULL, -1) NATID_SERVICIO
                                ,DECODE (TIPO,    ''SV'', SV.DESCRIPCION,  ''UG'', ''Sin Servicio - '' || UG.DESCRIPCION,  NULL, ''Sin Servicio'') DESCR_SERVICIO
                                ,DECODE (TIPO,    ''SV'', SV.CODIGO,  ''UG'', ''N/A'',  NULL, ''N/A'') LDESC_SERVICIO
                                ,DECODE (TIPO,    ''SV'', SV.ESTADO,  ''UG'', ''N/A'',  NULL, ''N/A'') ESTADO_SERVICIO
                                -- ,DECODE (TIPO, ''UG'', ER.ID,  ''SV'', NVL(UGCSV.UNIDADGESTIONCLINICA, -1),  NULL, -1) NATID_UNIDAD_GESTION_CLINICA
                                -- ,DECODE (TIPO, ''UG'', UG.DESCRIPCION,  ''SV'', NVL(UG2.DESCRIPCION, ''N/A''),  NULL, ''Sin UGC'') DESCR_UNIDAD_GESTION_CLINICA
                                -- ,DECODE (TIPO, ''UG'', UG.CODIGO,  ''SV'', NVL(UG2.CODIGO,''N/A''),  NULL, ''N/A'') LDESC_UNIDAD_GESTION_CLINICA
                                -- ,DECODE (TIPO, ''UG'', UG.ESTADO, ''SV'', NVL(UG2.ESTADO,''N/A''),  NULL, ''N/A'') ESTADO_UNIDAD_GESTION_CLINICA
                                ,NVL ( (PORCENTAJE / 100), 1) PORCENTAJE
                                ,ER.ID ER_ID
                                ,UG.CODIGO UG_CODIGO
                                ,UG.DESCRIPCION UG_DESCRIPCION
                                ,UG.ESTADO UG_ESTADO
                        FROM REP_PRO_SIGLO.ORG_CENTROCONSUMO@SYG CC
                                 LEFT JOIN (SELECT SERVICIO ID
                                                                    ,PORCENTAJE
                                                                    ,CENTROCONSUMO
                                                                    ,''SV'' TIPO
                                                            FROM REP_PRO_SIGLO.ORG_SERVICIOCC@SYG SCC
                                                         WHERE ESTADO = ''CONFIRMADO''
                                                        UNION ALL
                                                        SELECT UNIDADGESTIONCLINICA ID
                                                                    ,PORCENTAJE
                                                                    ,CENTROCONSUMO
                                                                    ,''UG'' TIPO
                                                            FROM REP_PRO_SIGLO.ORG_UNIDADGESTIONCLINICACC@SYG UCC
                                                         WHERE ESTADO = ''CONFIRMADO'') ER
                                     ON (ER.CENTROCONSUMO = CC.ID)
                                 LEFT JOIN REP_PRO_SIGLO.ORG_SERVICIO@SYG SV
                                     ON (ER.ID = SV.ID)
                                 LEFT JOIN REP_PRO_SIGLO.ORG_UNIDADGESTIONCLINICA@SYG UG
                                     ON (ER.ID = UG.ID)
                     --  LEFT JOIN REP_PRO_SIGLO.ORG_UNIDADGESTIONCLINICASRV@SYG UGCSV
                     --  ON (UGCSV.SERVICIO = SV.ID AND UGCSV.ESTADO = ''CONFIRMADO'')
                     --  LEFT JOIN REP_PRO_SIGLO.ORG_UNIDADGESTIONCLINICA@SYG UG2
                     --  ON (UGCSV.UNIDADGESTIONCLINICA = UG2.ID)
                     WHERE CC.ESTADO <> ''PROPINICIAL'' /*AND CC.ID IN (15311, 15312)*/
                                                                                     ) T1
                 LEFT JOIN REP_PRO_SIGLO.ORG_UNIDADGESTIONCLINICASRV@SYG UGCSV
                     ON (UGCSV.SERVICIO = NATID_SERVICIO AND UGCSV.ESTADO = ''CONFIRMADO'')
                 LEFT JOIN REP_PRO_SIGLO.ORG_UNIDADGESTIONCLINICA@SYG UG2
                     ON (UGCSV.UNIDADGESTIONCLINICA = UG2.ID)';
      --      EXCEPTION
      --         WHEN OTHERS
      --         THEN
      --            NULL;
      END;

      BEGIN
         EXECUTE IMMEDIATE 'ALTER TABLE MSTR_SIGLO.MSTR_HLP_PORCENTAJES_CC_SV_UG ADD
CONSTRAINT MSTR_HLP_PORCENT_CC_SV_UG_PK
 PRIMARY KEY (NATID_CENTROCONSUMO, NATID_SERVICIO, NATID_UNIDAD_GESTION_CLINICA)
 NOLOGGING 
 NOMONITORING';
      --      EXCEPTION
      --         WHEN OTHERS
      --         THEN
      --            NULL;
      END;
      
      BEGIN
         EXECUTE IMMEDIATE 'ALTER TABLE MSTR_SIGLO.MSTR_HLP_PORCENTAJES_CC_SV_UG ADD
CONSTRAINT MSTR_HLP_PORCENT_CC_SV_UG_R03
 FOREIGN KEY (NATID_ORGANOGESTOR)
 REFERENCES MSTR_SIGLO.MSTR_MAE_ORGANOSGESTORES (NATID_ORGANOGESTOR)
 ENABLE
 VALIDATE';
      --      EXCEPTION
      --         WHEN OTHERS
      --         THEN
      --            NULL;
      END;

      BEGIN
         EXECUTE IMMEDIATE
            'CREATE INDEX MSTR_SIGLO.MSTR_HLP_PORCENT_CC_SV_UG_IX01
    ON MSTR_SIGLO.MSTR_HLP_PORCENTAJES_CC_SV_UG (NATID_ORGANOGESTOR)
    NOLOGGING
    NOPARALLEL';
      --      EXCEPTION
      --         WHEN OTHERS
      --         THEN
      --            NULL;
      END;

BEGIN
    SYS.DBMS_STATS.GATHER_TABLE_STATS (OwnName => 'MSTR_SIGLO'
                                                                        ,TabName => 'MSTR_HLP_PORCENTAJES_CC_SV_UG'
                                                                        ,Estimate_Percent => 0
                                                                        ,Method_Opt => 'FOR ALL COLUMNS SIZE 1'
                                                                        ,Degree => 4
                                                                        ,Cascade => FALSE
                                                                        ,No_Invalidate => FALSE);
END;

      BEGIN
         EXECUTE IMMEDIATE 'DROP TABLE MSTR_DET_CN03B';
            EXCEPTION
               WHEN OTHERS
               THEN
                  NULL;
      END;
     
      BEGIN
         EXECUTE IMMEDIATE
            'CREATE TABLE MSTR_DET_CN03B
NOLOGGING
NOMONITORING
PARALLEL AS
    --SELECT SUM(IMPORTE_REPARTIDO)
    --FROM (
    SELECT CN03B.NATID_DIA
                ,CN03B.NATID_ARTICULO
                ,NATID_CENTROCONSUMO
                ,CN03B.NATID_ECONOMICA_N4
                ,CN03B.CN03B_CANTIDAD * HLP.PORCENTAJE CN03B_CANTIDAD
                ,CN03B.CN03B_IMPORTE * HLP.PORCENTAJE CN03B_IMPORTE
                ,HLP.PORCENTAJE
                --,CN03B.CN03B_CANTIDAD * HLP.PORCENTAJE CANTIDAD_REPARTIDA
                --,CN03B.CN03B_IMPORTE * HLP.PORCENTAJE IMPORTE_REPARTIDO
                --,HLP.NATID_ORGANOGESTOR
                --,NATID_CENTROCONSUMO
                --,HLP.DESCR_CENTROCONSUMO
                --,HLP.LDESC_CENTROCONSUMO
                --,HLP.ESTADO_CENTROCONSUMO
                ,HLP.TIPO TIPO_ER
                ,HLP.NATID_SERVICIO
                --,HLP.DESCR_SERVICIO
                --,HLP.LDESC_SERVICIO
                --,HLP.ESTADO_SERVICIO
                --,HLP.PORCENTAJE
                ,HLP.NATID_UNIDAD_GESTION_CLINICA
        --,HLP.DESCR_UNIDAD_GESTION_CLINICA
        --,HLP.LDESC_UNIDAD_GESTION_CLINICA
        --,HLP.ESTADO_UNIDAD_GESTION_CLINICA
        FROM TEMP_DET_CN03B CN03B LEFT JOIN MSTR_HLP_PORCENTAJES_CC_SV_UG HLP USING (NATID_CENTROCONSUMO)
     WHERE HLP.ESTADO_SERVICIO NOT IN (''BORRADO'', ''RECHAZADO'') AND HLP.ESTADO_UNIDAD_GESTION_CLINICA NOT IN (''BORRADO'', ''RECHAZADO'')
--AND NATID_CENTROCONSUMO IN (63366) --14169--13153
--)';
      --      EXCEPTION
      --         WHEN OTHERS
      --         THEN
      --            NULL;
      END;
     BEGIN
         EXECUTE IMMEDIATE 'ALTER TABLE MSTR_SIGLO.MSTR_DET_CN03B ADD
CONSTRAINT MSTR_DET_CN03B_PK
 PRIMARY KEY (NATID_DIA, NATID_ARTICULO, NATID_CENTROCONSUMO, NATID_SERVICIO, NATID_UNIDAD_GESTION_CLINICA)
NOLOGGING
 NOMONITORING
 PARALLEL';
      --      EXCEPTION
      --         WHEN OTHERS
      --         THEN
      --            NULL;
      END;
      BEGIN
         EXECUTE IMMEDIATE 'ALTER TABLE MSTR_SIGLO.MSTR_DET_CN03B ADD
CONSTRAINT MSTR_DET_CN03B_R01
 FOREIGN KEY (NATID_ARTICULO)
 REFERENCES MSTR_SIGLO.MSTR_MAE_ARTICULOS (NATID_ARTICULO)';
      --      EXCEPTION
      --         WHEN OTHERS
      --         THEN
      --            NULL;
      END;

      BEGIN
         EXECUTE IMMEDIATE
            'ALTER TABLE MSTR_DET_CN03B ADD (
 CONSTRAINT MSTR_DET_CN03B_R04
 FOREIGN KEY (NATID_CENTROCONSUMO)
 REFERENCES MSTR_MAE_CENTROSCONSUMO (NATID_CENTROCONSUMO))';
      --      EXCEPTION
      --         WHEN OTHERS
      --         THEN
      --            NULL;
      END;
/*
     BEGIN
         EXECUTE IMMEDIATE
            ' ALTER TABLE MSTR_SIGLO.MSTR_DET_GA03B ADD 
CONSTRAINT MSTR_DET_GA03B_R03
 FOREIGN KEY (NATID_ORGANOGESTOR)
 REFERENCES MSTR_SIGLO.MSTR_MAE_ORGANOSGESTORES (NATID_ORGANOGESTOR)
 ENABLE
 VALIDATE';
      --      EXCEPTION
      --         WHEN OTHERS
      --         THEN
      --            NULL;
      END;

*/
   /*   
      BEGIN
         EXECUTE IMMEDIATE 'ALTER TABLE MSTR_SIGLO.TEMP_DET_CN03B ADD
CONSTRAINT TEMP_DET_CN03B_R01
 FOREIGN KEY (NATID_ARTICULO)
 REFERENCES MSTR_SIGLO.MSTR_MAE_ARTICULOS (NATID_ARTICULO)';
      --      EXCEPTION
      --         WHEN OTHERS
      --         THEN
      --            NULL;
      END;
*/
BEGIN
    SYS.DBMS_STATS.GATHER_TABLE_STATS (OwnName => 'MSTR_SIGLO'
                                                                        ,TabName => 'MSTR_DET_CN03B'
                                                                        ,Estimate_Percent => SYS.DBMS_STATS.AUTO_SAMPLE_SIZE
                                                                        ,Method_Opt => 'FOR ALL INDEXED COLUMNS SIZE AUTO '
                                                                        ,Degree => NULL
                                                                        ,Cascade => TRUE
                                                                        ,No_Invalidate => FALSE);
END;
      v_fin_ts := SYSDATE;
      v_elapsed := (v_fin_ts - v_inicio_ts) * 24 * 60;
   --      MSTR.PANDAS_090_POST_TO_SHAREP_v3.RETRY_N_TIMES (
   --         3,
   --         '{ Title: "Carga Censo de Camas", Content: "'
   --         || '<table border=''1'' cellpadding=''3''><tr><td bgcolor=''#CEA539''>Última Ejecución</td><td bgcolor=''#CEA539''>Duración (min.)</td><td bgcolor=''#CEA539''>Fecha Replica</td></tr><tr><td bgcolor=''#232325''>'
   --         || TO_CHAR (SYSDATE, 'dd-mon hh24:mi')
   --         || '</td><td>'
   --         || ROUND (v_elapsed, 2)
   --         || '</td><td>'
   --         || TO_CHAR (v_last_refresh, 'dd-mon hh24:mi')
   --         || '</td></tr></table> '
   --         || '", Result: "SUCCESS"  }');
   --      MSTR.PANDAS_093_TWIT.POST_STATUS (
   --         TO_CHAR (SYSDATE, 'hh24"h"mi') || '+' || v_area_hospitalaria || '+Carga+Censo+de+Camas+completada+#ProyectoPandas',
   --         'PANDAS_HOSPI');
   --EXCEPTION
     -- WHEN OTHERS
     -- THEN
         --         BEGIN
         --            MSTR.PANDAS_093_TWIT.POST_STATUS (
         --                  'Camas+'
         --               || TO_CHAR (SYSDATE, 'hh24"h"mi')
         --               || '+'
         --               || v_area_hospitalaria
         --               || '+'
         --               || SUBSTR (REPLACE (REPLACE (REPLACE (SQLERRM, ' ', '+'), ',', ''), CHR (10), '+'), 1, 90)
         --               || '...#ProyectoPandas',
         --               'PANDAS_ERROR');
         --         END;

         --RAISE;
     BEGIN
         EXECUTE IMMEDIATE 'DROP TABLE TEMP_DET_CN03B';
            EXCEPTION
               WHEN OTHERS
               THEN
                  NULL;
      END;
     
         
         EXECUTE IMMEDIATE 'PURGE RECYCLEBIN';
   END P_001;
END;
/
