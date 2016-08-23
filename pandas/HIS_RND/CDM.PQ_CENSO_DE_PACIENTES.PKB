CREATE OR REPLACE PACKAGE BODY CDM.pq_censo_de_pacientes
IS
   PROCEDURE corte_nocturno
   IS
   BEGIN
      INSERT INTO MSTR_DET_CENSO_DE_PACIE
         SELECT TRUNC (SYSDATE - 1) NATID_DIA_CENSAL
               ,NVL (MSTR_MAE_CENTROS.SUBID_CENTRO, -1) SUBID_CENTRO
               ,NVL (UF_PACIENTE.SUBID_UNIDAD_FUNCIONAL, -1) SUBID_UNIDAD_FUNCIONAL
               ,codigo_estructura NATID_UBICACION
               ,ubi_nombre DESCR_UBICACION
               ,DECODE (NVL (UF_CAMA.SUBID_UNIDAD_FUNCIONAL, -1) - NVL (UF_PACIENTE.SUBID_UNIDAD_FUNCIONAL, -1)
                       ,0, 0
                       ,1)
                   IND_ECTOPICO
               ,EPISODIO_ID
               ,ADMISION_ID
               ,NUHSA
               , (SELECT SUBID_DIA
                    FROM MSTR_MAE_TIEMPO_03_DIAS
                   WHERE NATID_DIA = TRUNC (SYSDATE - 1))
                   SUBID_DIA_CENSAL
               ,NVL (NATID_CONTROL_ENFERMERIA, -1)
           FROM his_own.COM_UBICACION_GESTION_LOCAL@dae
                JOIN his_own.COM_M_UBICACION@dae
                   ON (CODIGO_ESTRUCTURA = UBI_CODIGO)
                LEFT JOIN MSTR_MAE_UNIDADES_FUNCIONALES UF_CAMA
                   ON (UNIDAD_FUNCIONAL = UF_CAMA.NATID_UNIDAD_FUNCIONAL)
                LEFT JOIN MSTR_MAE_CENTROS
                   ON (UBI_CAH_CODIGO = NATID_CENTRO)
                LEFT JOIN his_own.ADM_EPIS_DETALLE@dae
                   USING (EPISODIO_ID)
                JOIN his_own.ADM_ADMISION@dae D
                   ON (REFERENCIA_ID = ADMISION_ID)
                JOIN his_own.COM_USUARIO@dae U
                   ON (USUARIO = ID_USUARIO)
                LEFT JOIN MSTR_MAE_UNIDADES_FUNCIONALES UF_PACIENTE
                   ON (UNID_FUNC_RESP = UF_PACIENTE.NATID_UNIDAD_FUNCIONAL)
                LEFT JOIN his_own.ADM_EPISODIO@dae EPI
                   USING (EPISODIO_ID)
                LEFT JOIN MAPA_05_UBICACIONES_CONTR_ENFE@DAE
                   ON (codigo_estructura = NATID_UBICACION)
          WHERE activa = 1 AND UBI_ACTIVO = 0 AND UNIDAD_FUNCIONAL IS NOT NULL AND FCH_CIERRE IS NULL;

      COMMIT;
      check_censo_de_pacientes;
      DBMS_STATS.gather_table_stats ( USER, 'MSTR_DET_CENSO_DE_PACIE');
   END corte_nocturno;

   PROCEDURE corte_a_las_0800AM
   IS
   BEGIN
      INSERT INTO MSTR_DET_CENSO_DE_PACIE_0800AM
         SELECT TRUNC (SYSDATE) NATID_DIA_CENSAL
               ,NVL (MSTR_MAE_CENTROS.SUBID_CENTRO, -1) SUBID_CENTRO
               ,NVL (UF_PACIENTE.SUBID_UNIDAD_FUNCIONAL, -1) SUBID_UNIDAD_FUNCIONAL
               ,codigo_estructura NATID_UBICACION
               ,ubi_nombre DESCR_UBICACION
               ,DECODE (NVL (UF_CAMA.SUBID_UNIDAD_FUNCIONAL, -1) - NVL (UF_PACIENTE.SUBID_UNIDAD_FUNCIONAL, -1)
                       ,0, 0
                       ,1)
                   IND_ECTOPICO
               ,EPISODIO_ID
               ,ADMISION_ID
               ,NUHSA
               , (SELECT SUBID_DIA
                    FROM MSTR_MAE_TIEMPO_03_DIAS
                   WHERE NATID_DIA = TRUNC (SYSDATE))
                   SUBID_DIA_CENSAL
               ,NVL (NATID_CONTROL_ENFERMERIA, -1)
           FROM his_own.COM_UBICACION_GESTION_LOCAL@dae
                JOIN his_own.COM_M_UBICACION@dae
                   ON (CODIGO_ESTRUCTURA = UBI_CODIGO)
                LEFT JOIN MSTR_MAE_UNIDADES_FUNCIONALES UF_CAMA
                   ON (UNIDAD_FUNCIONAL = UF_CAMA.NATID_UNIDAD_FUNCIONAL)
                LEFT JOIN MSTR_MAE_CENTROS
                   ON (UBI_CAH_CODIGO = NATID_CENTRO)
                LEFT JOIN his_own.ADM_EPIS_DETALLE@dae
                   USING (EPISODIO_ID)
                JOIN his_own.ADM_ADMISION@dae D
                   ON (REFERENCIA_ID = ADMISION_ID)
                JOIN his_own.COM_USUARIO@dae U
                   ON (USUARIO = ID_USUARIO)
                LEFT JOIN MSTR_MAE_UNIDADES_FUNCIONALES UF_PACIENTE
                   ON (UNID_FUNC_RESP = UF_PACIENTE.NATID_UNIDAD_FUNCIONAL)
                LEFT JOIN his_own.ADM_EPISODIO@dae EPI
                   USING (EPISODIO_ID)
                LEFT JOIN MAPA_05_UBICACIONES_CONTR_ENFE@DAE
                   ON (codigo_estructura = NATID_UBICACION)
          WHERE activa = 1 AND UBI_ACTIVO = 0 AND UNIDAD_FUNCIONAL IS NOT NULL AND FCH_CIERRE IS NULL;

      COMMIT;
      check_censo_a_las_0800AM;
      DBMS_STATS.gather_table_stats ( USER, 'MSTR_DET_CENSO_DE_PACIE_0800AM');
   END corte_a_las_0800AM;

   PROCEDURE corte_a_las_1800PM
   IS
   BEGIN
      INSERT INTO MSTR_DET_CENSO_DE_PACIE_1800PM
         SELECT TRUNC (SYSDATE) NATID_DIA_CENSAL
               ,NVL (MSTR_MAE_CENTROS.SUBID_CENTRO, -1) SUBID_CENTRO
               ,NVL (UF_PACIENTE.SUBID_UNIDAD_FUNCIONAL, -1) SUBID_UNIDAD_FUNCIONAL
               ,codigo_estructura NATID_UBICACION
               ,ubi_nombre DESCR_UBICACION
               ,DECODE (NVL (UF_CAMA.SUBID_UNIDAD_FUNCIONAL, -1) - NVL (UF_PACIENTE.SUBID_UNIDAD_FUNCIONAL, -1)
                       ,0, 0
                       ,1)
                   IND_ECTOPICO
               ,EPISODIO_ID
               ,ADMISION_ID
               ,NUHSA
               , (SELECT SUBID_DIA
                    FROM MSTR_MAE_TIEMPO_03_DIAS
                   WHERE NATID_DIA = TRUNC (SYSDATE))
                   SUBID_DIA_CENSAL
               ,NVL (NATID_CONTROL_ENFERMERIA, -1)
           FROM his_own.COM_UBICACION_GESTION_LOCAL@dae
                JOIN his_own.COM_M_UBICACION@dae
                   ON (CODIGO_ESTRUCTURA = UBI_CODIGO)
                LEFT JOIN MSTR_MAE_UNIDADES_FUNCIONALES UF_CAMA
                   ON (UNIDAD_FUNCIONAL = UF_CAMA.NATID_UNIDAD_FUNCIONAL)
                LEFT JOIN MSTR_MAE_CENTROS
                   ON (UBI_CAH_CODIGO = NATID_CENTRO)
                LEFT JOIN his_own.ADM_EPIS_DETALLE@dae
                   USING (EPISODIO_ID)
                JOIN his_own.ADM_ADMISION@dae D
                   ON (REFERENCIA_ID = ADMISION_ID)
                JOIN his_own.COM_USUARIO@dae U
                   ON (USUARIO = ID_USUARIO)
                LEFT JOIN MSTR_MAE_UNIDADES_FUNCIONALES UF_PACIENTE
                   ON (UNID_FUNC_RESP = UF_PACIENTE.NATID_UNIDAD_FUNCIONAL)
                LEFT JOIN his_own.ADM_EPISODIO@dae EPI
                   USING (EPISODIO_ID)
                LEFT JOIN MAPA_05_UBICACIONES_CONTR_ENFE@DAE
                   ON (codigo_estructura = NATID_UBICACION)
          WHERE activa = 1 AND UBI_ACTIVO = 0 AND UNIDAD_FUNCIONAL IS NOT NULL AND FCH_CIERRE IS NULL;

      COMMIT;
      check_censo_a_las_1800PM;
      DBMS_STATS.gather_table_stats ( USER, 'MSTR_DET_CENSO_DE_PACIE_1800PM');
   END corte_a_las_1800PM;

   PROCEDURE preingresos_corte_nocturno
   IS
   BEGIN
      BEGIN
         INSERT INTO MSTR_DET_PREINGRESOS
            SELECT PREINGRESO_ID
                  ,ADMISION_ID
                  , (SELECT SUBID_DIA
                       FROM MSTR_MAE_TIEMPO_03_DIAS
                      WHERE NATID_DIA = TRUNC (SYSDATE - 1))
                      SUBID_DIA_CENSAL
                  ,FECHA_PREV_ING + (HORA_PREV_ING - TRUNC (HORA_PREV_ING)) FECHA_PREV_INGRESO
                  ,FCH_INGRESO + (HORA_INGRESO - TRUNC (HORA_INGRESO)) FCH_INGRESO
                  , (FCH_INGRESO + (HORA_INGRESO - TRUNC (HORA_INGRESO)))
                   - (FECHA_PREV_ING + (HORA_PREV_ING - TRUNC (HORA_PREV_ING)))
                      DELTA_T
                  ,NVL (MEDICO_SOLICITA, -1)
                  ,SUBID_CENTRO
                  ,SUBID_UNIDAD_FUNCIONAL
                  ,NUHSA
                  ,NVL (EPIS_PADRE_EXTERNO, -1) EPISODIO_URGENCIAS
                  ,DIAGN_LIBRE
                  , (SELECT SUBID_PROCEDENCIA
                       FROM MSTR_MAE_PROCEDENCIAS
                      WHERE NATID_PROCEDENCIA = ADM_PREINGRESO.PROCEDENCIA)
                      SUBID_PROCEDENCIA
                  , (SELECT SUBID_MOTIVO_INGRESO
                       FROM MSTR_MAE_MOTIVOS_INGRESO
                      WHERE NATID_MOTIVO_INGRESO = ADM_PREINGRESO.MOTIVO_INGRESO)
                      SUBID_MOTIVO_INGRESO
                  ,ADM_PREINGRESO.MODALIDAD_ASIST IND_MODALIDAD_ASIST
                  ,ADM_PREINGRESO.HD_QUIR_SN IND_QUIRURGICO
              FROM HIS_OWN.ADM_PREINGRESO@DAE
                   JOIN HIS_OWN.ADM_PREINGRESO_DET@DAE
                      ON (PREINGRESO = PREINGRESO_ID)
                   LEFT JOIN HIS_OWN.ADM_ADMISION@DAE
                      ON (SESION_PADRE = PREING_DET_ID)
                   JOIN HIS_OWN.COM_USUARIO@DAE
                      ON (ADM_PREINGRESO.USUARIO = ID_USUARIO)
                   JOIN MSTR_MAE_CENTROS
                      ON (ADM_PREINGRESO.CENTRO_INGRESO = NATID_CENTRO)
                   JOIN MSTR_MAE_UNIDADES_FUNCIONALES
                      ON (UNIDAD_FUNC_INGRESO = NATID_UNIDAD_FUNCIONAL)
             WHERE FECHA_PREV_ING = TRUNC (SYSDATE - 1);
      EXCEPTION
      WHEN OTHERS
      THEN
         pq_censo_de_pacientes.error_handler_twit_me_baby ( p_SQLERRM => SQLERRM, p_error_backtrace => DBMS_UTILITY.format_error_backtrace, p_nombre_carga => 'Preingresos a las 0h');
         RAISE;
      END;

      COMMIT;
      check_preingresos;
      DBMS_STATS.gather_table_stats ( USER, 'MSTR_DET_PREINGRESOS');
   END preingresos_corte_nocturno;

   PROCEDURE preingresos_corte_a_las_0800AM
   IS
   BEGIN
      BEGIN
         INSERT INTO MSTR_DET_PREINGRESOS_0800AM
/*            SELECT PREINGRESO_ID
                  ,ADMISION_ID
                  , (SELECT SUBID_DIA
                       FROM MSTR_MAE_TIEMPO_03_DIAS
                      WHERE NATID_DIA = TRUNC (SYSDATE) - 1)
                      SUBID_DIA_CENSAL_0800AM
                  ,FECHA_PREV_ING + (HORA_PREV_ING - TRUNC (HORA_PREV_ING)) FECHA_PREV_INGRESO
                  ,FCH_INGRESO + (HORA_INGRESO - TRUNC (HORA_INGRESO)) FCH_INGRESO
                  , (FCH_INGRESO + (HORA_INGRESO - TRUNC (HORA_INGRESO)))
                   - (FECHA_PREV_ING + (HORA_PREV_ING - TRUNC (HORA_PREV_ING)))
                      DELTA_T
                  ,NVL (MEDICO_SOLICITA, -1)
                  ,SUBID_CENTRO
                  ,SUBID_UNIDAD_FUNCIONAL
                  ,NUHSA
                  ,NVL (EPIS_PADRE_EXTERNO, -1) EPISODIO_URGENCIAS
                  ,DIAGN_LIBRE
                  , (SELECT SUBID_PROCEDENCIA
                       FROM MSTR_MAE_PROCEDENCIAS
                      WHERE NATID_PROCEDENCIA = ADM_PREINGRESO.PROCEDENCIA)
                      SUBID_PROCEDENCIA
                  , (SELECT SUBID_MOTIVO_INGRESO
                       FROM MSTR_MAE_MOTIVOS_INGRESO
                      WHERE NATID_MOTIVO_INGRESO = ADM_PREINGRESO.MOTIVO_INGRESO)
                      SUBID_MOTIVO_INGRESO
                  ,ADM_PREINGRESO.MODALIDAD_ASIST IND_MODALIDAD_ASIST
                  ,ADM_PREINGRESO.HD_QUIR_SN IND_QUIRURGICO
              FROM HIS_OWN.ADM_PREINGRESO@DAE
                   JOIN HIS_OWN.ADM_PREINGRESO_DET@DAE
                      ON (PREINGRESO = PREINGRESO_ID)
                   LEFT JOIN HIS_OWN.ADM_ADMISION@DAE
                      ON (SESION_PADRE = PREING_DET_ID)
                   JOIN HIS_OWN.COM_USUARIO@DAE
                      ON (ADM_PREINGRESO.USUARIO = ID_USUARIO)
                   JOIN MSTR_MAE_CENTROS
                      ON (ADM_PREINGRESO.CENTRO_INGRESO = NATID_CENTRO)
                   JOIN MSTR_MAE_UNIDADES_FUNCIONALES
                      ON (UNIDAD_FUNC_INGRESO = NATID_UNIDAD_FUNCIONAL)
             WHERE FECHA_PREV_ING + (HORA_PREV_ING - TRUNC (HORA_PREV_ING)) BETWEEN (TRUNC (SYSDATE) - 1)
                                                                                    + INTERVAL '8' HOUR
                                                                                AND (TRUNC (SYSDATE))
                                                                                    + INTERVAL '8' HOUR;*/
     SELECT distinct
     preingreso_id,
            NULL admision_id,
            (SELECT SUBID_DIA
               FROM MSTR_MAE_TIEMPO_03_DIAS
              WHERE NATID_DIA = TRUNC (SYSDATE))
               SUBID_DIA_CENSAL_0800AM,
            FECHA_PREV_ING + (HORA_PREV_ING - TRUNC (HORA_PREV_ING))
               FECHA_PREV_INGRESO,
            NULL FCH_INGRESO,
            NULL DELTA_T,
            NVL (MEDICO_SOLICITA, -1),
            (SELECT SUBID_CENTRO
               FROM MSTR_MAE_CENTROS
              WHERE NATID_CENTRO = ADM_PREINGRESO.CENTRO_INGRESO)
               SUBID_CENTRO,
            (SELECT SUBID_UNIDAD_FUNCIONAL
               FROM MSTR_MAE_UNIDADES_FUNCIONALES
              WHERE NATID_UNIDAD_FUNCIONAL = ADM_PREINGRESO.UNIDAD_FUNC_INGRESO)
               SUBID_UNIDAD_FUNCIONAL,
            NUHSA,
            NVL (EPIS_PADRE_EXTERNO, -1) EPISODIO_URGENCIAS,
            DIAGN_LIBRE,
            (SELECT SUBID_PROCEDENCIA
               FROM MSTR_MAE_PROCEDENCIAS
              WHERE NATID_PROCEDENCIA = ADM_PREINGRESO.PROCEDENCIA)
               SUBID_PROCEDENCIA,
            (SELECT SUBID_MOTIVO_INGRESO
               FROM MSTR_MAE_MOTIVOS_INGRESO
              WHERE NATID_MOTIVO_INGRESO = ADM_PREINGRESO.MOTIVO_INGRESO)
               SUBID_MOTIVO_INGRESO,
            ADM_PREINGRESO.MODALIDAD_ASIST IND_MODALIDAD_ASIST,
            ADM_PREINGRESO.HD_QUIR_SN IND_QUIRURGICO
       FROM his_own.adm_preingreso_det@DAE
            JOIN his_own.adm_preingreso@DAE
               ON (preingreso_id = preingreso)
            JOIN HIS_OWN.COM_USUARIO@DAE
               ON (ADM_PREINGRESO.USUARIO = ID_USUARIO)
      WHERE     FCH_REG_PREI > TRUNC (SYSDATE) - 7
            AND adm_preingreso.procedencia IS NOT NULL
            --AND adm_preingreso.motivo_ingreso = 1
            AND adm_preingreso_det.estado = 1
   ORDER BY preingreso_id;

      EXCEPTION
      WHEN OTHERS
      THEN
         pq_censo_de_pacientes.error_handler_twit_me_baby ( p_SQLERRM => SQLERRM, p_error_backtrace => DBMS_UTILITY.format_error_backtrace, p_nombre_carga => 'Preingresos a las 8h');
         RAISE;

      END;

      COMMIT;
      check_preingreso_a_las_0800AM;
      DBMS_STATS.gather_table_stats ( USER, 'MSTR_DET_PREINGRESOS_0800AM');
   END preingresos_corte_a_las_0800AM;

   PROCEDURE seguimiento_de_urgencias
   IS
   BEGIN
      DBMS_SNAPSHOT.refresh ( 'MSTR_DET_SEGUI_ALTAS_URGENCIAS', 'C');
      PQ_OAUTH.TWITTER_004_UPDATE_STATUS ( 'Seguimiento de Urgencias completado a las ' || TO_CHAR ( SYSDATE, 'fmHH24:fmMI'), 'valme_twit_09');
   EXCEPTION
      WHEN OTHERS
      THEN
         pq_censo_de_pacientes.error_handler_twit_me_baby ( p_SQLERRM => SQLERRM, p_error_backtrace => DBMS_UTILITY.format_error_backtrace, p_nombre_carga => 'Seguimiento de Urgencias');
         RAISE;
   END;

   PROCEDURE check_censo_de_pacientes
   IS
      lrec_count                         NUMBER;
   BEGIN
      SELECT COUNT (NUHSA)
        INTO lrec_count
        FROM MSTR_DET_CENSO_DE_PACIE
       WHERE NATID_DIA_CENSAL = TRUNC (SYSDATE - 1);

      IF lrec_count <= 0
      THEN
         PQ_OAUTH.TWITTER_004_UPDATE_STATUS ( 'Error en el censo de pacientes', 'valme_twit_08');
      ELSE
         PQ_OAUTH.TWITTER_004_UPDATE_STATUS ( 'Censo de pacientes completado a las ' || TO_CHAR ( SYSDATE, 'fmHH24:fmMI'), 'valme_twit_06');

         /*Actualiza las estancias en el proyecto MicroStrategy de DAE*/
         INSERT INTO FACT_ADM_ESTANCIAS@DAE
              SELECT COUNT (NUHSA) ESTANCIAS
                    ,SUBID_DIA_CENSAL ESTANCIAS_DAY_ID
                    ,SUBID_MES ESTANCIAS_MONTH_ID
                    ,SUBID_AÑO ESTANCIAS_YEAR_ID
                    ,NATID_CENTRO CENTRO_INGRESO_ID
                    ,NATID_UNIDAD_FUNCIONAL UNID_FUNC_ESTANCIA_ID
                    ,NATID_CONTROL_ENFERMERIA CONTR_ENFERMERIA_ID
                    ,UBI_TIP_UBICACION TIPO_UBIC_ID
                FROM MSTR_DET_CENSO_DE_PACIE
                     JOIN MSTR_MAE_TIEMPO_DIAS
                        ON (SUBID_DIA_CENSAL = SUBID_DIA)
                     JOIN MSTR_MAE_UNIDADES_FUNCIONALES
                        USING (SUBID_UNIDAD_FUNCIONAL)
                     LEFT JOIN REP_PRO_EST.UBICACIONES@DAE
                        ON (NATID_UBICACION = UBI_CODIGO)
                     JOIN MSTR_MAE_CENTROS
                        USING (SUBID_CENTRO)
                     JOIN LU_MAPA_08_CONTR_ENFERMERIA@DAE
                        ON (NATID_CONTROL_ENFERMERIA = CONTR_ENFERMERIA_ID)
               WHERE NATID_DIA_CENSAL = TRUNC (SYSDATE - 1)
            /* el join con controles de enfermer?a es por si hay errores en las camas*/
            --SUBID_MES = 1343
            /*si hay estancias en HD*/
            --AND  NATID_CONTROL_ENFERMERIA NOT IN (47836)
            /*si hay estancias en HD*/
            GROUP BY SUBID_DIA_CENSAL
                    ,SUBID_MES
                    ,SUBID_AÑO
                    ,NATID_CENTRO
                    ,NATID_UNIDAD_FUNCIONAL
                    ,NATID_CONTROL_ENFERMERIA
                    ,UBI_TIP_UBICACION;
      END IF;
   END check_censo_de_pacientes;

   PROCEDURE check_censo_a_las_0800AM
   IS
      lrec_count                         NUMBER;
   BEGIN
      SELECT COUNT (NUHSA)
        INTO lrec_count
        FROM MSTR_DET_CENSO_DE_PACIE_0800AM
       WHERE NATID_DIA_CENSAL_0800AM = TRUNC (SYSDATE);

      IF lrec_count <= 0
      THEN
         PQ_OAUTH.TWITTER_004_UPDATE_STATUS ( 'Error en el censo de pacientes (08:00AM)', 'valme_twit_08');
      ELSE
         PQ_OAUTH.TWITTER_004_UPDATE_STATUS ( TO_CHAR ( SYSDATE, 'fmDy,DD - ', 'nls_date_language = spanish') || 'Censo de pacientes a las 8AM  completado a las ' || TO_CHAR ( SYSDATE, 'fmHH24:fmMI'), 'valme_twit_06');
      END IF;
   END check_censo_a_las_0800AM;

   PROCEDURE check_censo_a_las_1800PM
   IS
      lrec_count                         NUMBER;
   BEGIN
      SELECT COUNT (NUHSA)
        INTO lrec_count
        FROM MSTR_DET_CENSO_DE_PACIE_1800PM
       WHERE NATID_DIA_CENSAL_1800PM = TRUNC (SYSDATE);

      IF lrec_count <= 0
      THEN
         PQ_OAUTH.TWITTER_004_UPDATE_STATUS ( 'Error en el censo de pacientes (18:00PM)', 'valme_twit_08');
      ELSE
         PQ_OAUTH.TWITTER_004_UPDATE_STATUS ( TO_CHAR ( SYSDATE, 'fmDy,DD - ', 'nls_date_language = spanish') || 'Censo de pacientes a las 18PM  completado a las ' || TO_CHAR ( SYSDATE, 'fmHH24:fmMI'), 'valme_twit_06');
      END IF;
   END check_censo_a_las_1800PM;

   PROCEDURE check_preingresos
   IS
      lrec_count                         NUMBER;
   BEGIN
      SELECT COUNT (PREINGRESO_ID)
        INTO lrec_count
        FROM MSTR_DET_PREINGRESOS
       WHERE SUBID_DIA_CENSAL = (SELECT SUBID_DIA
                                   FROM MSTR_MODULO_COMUN.MSTR_MAE_TIEMPO_03_DIAS
                                  WHERE NATID_DIA = TRUNC (SYSDATE) - 1);

      IF lrec_count <= 0
      THEN
         PQ_OAUTH.TWITTER_004_UPDATE_STATUS ( 'Error en la carga de preingresos', 'valme_twit_08');
      ELSE
         PQ_OAUTH.TWITTER_004_UPDATE_STATUS ( TO_CHAR ( SYSDATE, 'fmDy,DD - ', 'nls_date_language = spanish') || 'Carga de preingresos completada a las ' || TO_CHAR ( SYSDATE, 'fmHH24:fmMI'), 'valme_twit_02');
      END IF;
   END check_preingresos;

   PROCEDURE check_preingreso_a_las_0800AM
   IS
      lrec_count                         NUMBER;
   BEGIN
      SELECT COUNT (PREINGRESO_ID)
        INTO lrec_count
        FROM MSTR_DET_PREINGRESOS_0800AM
       WHERE SUBID_DIA_CENSAL_0800AM = (SELECT SUBID_DIA
                                          FROM MSTR_MODULO_COMUN.MSTR_MAE_TIEMPO_03_DIAS
                                         WHERE NATID_DIA = TRUNC (SYSDATE));

      IF lrec_count <= 0
      THEN
         PQ_OAUTH.TWITTER_004_UPDATE_STATUS ( 'Error en la carga de preingresos (08:00AM)', 'valme_twit_08');
      ELSE
         PQ_OAUTH.TWITTER_004_UPDATE_STATUS ( TO_CHAR ( SYSDATE, 'fmDy,DD - ', 'nls_date_language = spanish') || 'Carga de preingresos a las 8AM completada a las ' || TO_CHAR ( SYSDATE, 'fmHH24:fmMI'), 'valme_twit_02');
      END IF;
   END check_preingreso_a_las_0800AM;

   PROCEDURE error_handler_twit_me_baby ( p_SQLERRM IN VARCHAR2, p_error_backtrace IN VARCHAR2, p_nombre_carga IN VARCHAR2)
   IS
   BEGIN
      PQ_OAUTH.TWITTER_004_UPDATE_STATUS ( TO_CHAR ( SYSDATE, 'fmHH24:fmMI:SS') || ' ' || p_nombre_carga || ': ' || SQLERRM, 'valme_twit_08');
   END error_handler_twit_me_baby;
END pq_censo_de_pacientes;
/
