CREATE OR REPLACE PACKAGE BODY MSTR_SIGLO.ETL_LOAD_GA03B
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
         EXECUTE IMMEDIATE 'DROP TABLE MSTR_DET_GA03B';
      --      EXCEPTION
      --         WHEN OTHERS
      --         THEN
      --            NULL;
      END;
     
      BEGIN
         EXECUTE IMMEDIATE
            'CREATE TABLE MSTR_DET_GA03B
NOLOGGING
NOMONITORING
PARALLEL AS
    SELECT NATID_DIA
                ,NATID_ORGANOGESTOR
                ,NATID_ECONOMICA_N4
                ,NATID_ARTICULO
                ,NVL (VALOR_FACTURAS, 0) - NVL (VALOR_FACTURAS_ABONO, 0) GA03B
        FROM     (    SELECT TRUNC (FA.FECHAFACTURA) NATID_DIA
                                        ,NVL (FA.ORGANOGESTOR, -1) NATID_ORGANOGESTOR
                                        ,NVL (FAL.CLASIFECONOMICADIRECTA, -1) NATID_ECONOMICA_N4
                                        ,NVL (FAL.GCDIRECTA, -1) NATID_ARTICULO
                                        ,SUM (NVL (FAL.BASEIMPONIBLE, 0) + NVL (FAL.IMPORTE, 0)) VALOR_FACTURAS
                                FROM REP_PRO_SIGLO.FAC_FACTURA@SYG FA JOIN REP_PRO_SIGLO.FAC_FACTURALINEA@SYG FAL ON (FAL.FACTURA = FA.ID)
                             WHERE         FA.ESTADO IN (''CONCILIADA'', ''PENDCONCILIAR'', ''PENDREGISTRAR'', ''REGISTRADA'', ''TRAMITADA'')
                                         AND FAL.TIPODESCUENTO IS NULL
                                         AND FA.TIPO NOT IN (6, 7, 8)
                        GROUP BY TRUNC (FA.FECHAFACTURA)
                                        ,FA.ORGANOGESTOR
                                        ,FAL.CLASIFECONOMICADIRECTA
                                        ,FAL.GCDIRECTA)
                 FULL OUTER JOIN
                     (    SELECT TRUNC (FA.FECHAFACTURA) NATID_DIA
                                        ,NVL (FA.ORGANOGESTOR, -1) NATID_ORGANOGESTOR
                                        ,NVL (FAL.CLASIFECONOMICADIRECTA, -1) NATID_ECONOMICA_N4
                                        ,NVL (FAL.GCDIRECTA, -1) NATID_ARTICULO
                                        ,SUM (NVL (FAL.BASEIMPONIBLE, 0) + NVL (FAL.IMPORTE, 0)) VALOR_FACTURAS_ABONO
                                FROM REP_PRO_SIGLO.FAC_FACTURA@SYG FA JOIN REP_PRO_SIGLO.FAC_FACTURALINEA@SYG FAL ON (FAL.FACTURA = FA.ID)
                             WHERE         FA.ESTADO IN (''CONCILIADA'', ''PENDCONCILIAR'', ''PENDREGISTRAR'', ''REGISTRADA'', ''TRAMITADA'')
                                         AND FAL.TIPODESCUENTO IS NULL
                                         AND FA.TIPO IN (6, 7, 8)
                        GROUP BY TRUNC (FA.FECHAFACTURA)
                                        ,FA.ORGANOGESTOR
                                        ,FAL.CLASIFECONOMICADIRECTA
                                        ,FAL.GCDIRECTA)
                 USING (NATID_DIA, NATID_ORGANOGESTOR, NATID_ECONOMICA_N4, NATID_ARTICULO)';
      --      EXCEPTION
      --         WHEN OTHERS
      --         THEN
      --            NULL;
      END;

      BEGIN
         EXECUTE IMMEDIATE 'ALTER TABLE MSTR_SIGLO.MSTR_DET_GA03B ADD
CONSTRAINT MSTR_DET_GA03B_PK
 PRIMARY KEY (NATID_DIA, NATID_ORGANOGESTOR, NATID_ECONOMICA_N4, NATID_ARTICULO)
 ENABLE
 VALIDATE';
      --      EXCEPTION
      --         WHEN OTHERS
      --         THEN
      --            NULL;
      END;
      
      BEGIN
         EXECUTE IMMEDIATE 'ALTER TABLE MSTR_SIGLO.MSTR_DET_GA03B ADD
CONSTRAINT MSTR_DET_GA03B_R01
 FOREIGN KEY (NATID_ARTICULO)
 REFERENCES MSTR_SIGLO.MSTR_MAE_ARTICULOS (NATID_ARTICULO)
 ENABLE
 VALIDATE';
      --      EXCEPTION
      --         WHEN OTHERS
      --         THEN
      --            NULL;
      END;

      BEGIN
         EXECUTE IMMEDIATE
            'ALTER TABLE MSTR_SIGLO.MSTR_DET_GA03B ADD
CONSTRAINT MSTR_DET_GA03B_R02
 FOREIGN KEY (NATID_ECONOMICA_N4)
 REFERENCES MSTR_SIGLO.MSTR_MAE_ECONOMICA_N4 (NATID_ECONOMICA_N4)
 ENABLE
 VALIDATE';
      --      EXCEPTION
      --         WHEN OTHERS
      --         THEN
      --            NULL;
      END;

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


BEGIN
    SYS.DBMS_STATS.GATHER_TABLE_STATS (OwnName => 'MSTR_SIGLO',
                                                                         TabName => 'MSTR_DET_GA03B',
                                                                         Estimate_Percent => SYS.DBMS_STATS.AUTO_SAMPLE_SIZE,
                                                                         Method_Opt => 'FOR ALL INDEXED COLUMNS SIZE AUTO ',
                                                                         Degree => NULL,
                                                                         Cascade => TRUE,
                                                                         No_Invalidate => FALSE);
END;

      --     SELECT MAX (LAST_REFRESH_DATE) INTO v_last_refresh FROM MSTR_DET_CAMAS_DEL_DIA;

      v_fin_ts := SYSDATE;
      v_elapsed := (v_fin_ts - v_inicio_ts) * 24 * 60;
   --      MSTR.PANDAS_090_POST_TO_SHAREP_v3.RETRY_N_TIMES (
   --         3,
   --         '{ Title: "Carga Censo de Camas", Content: "'
   --         || '<table border=''1'' cellpadding=''3''><tr><td bgcolor=''#CEA539''>�ltima Ejecuci�n</td><td bgcolor=''#CEA539''>Duraci�n (min.)</td><td bgcolor=''#CEA539''>Fecha Replica</td></tr><tr><td bgcolor=''#232325''>'
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
   END P_001;
END;
/
