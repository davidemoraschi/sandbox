CREATE OR REPLACE PACKAGE BODY CDM.pq_censo_de_camas
IS
   PROCEDURE corte_nocturno
   IS
   BEGIN
      INSERT INTO MSTR_DET_CENSO_DE_CAMAS
         SELECT TRUNC (SYSDATE - 1) NATID_DIA_CENSAL,
                NVL (MSTR_MAE_CENTROS.SUBID_CENTRO, -1) SUBID_CENTRO,
                NVL (SUBID_UNIDAD_FUNCIONAL, -1) SUBID_UNIDAD_FUNCIONAL,
                codigo_estructura NATID_UBICACION,
                TUBI_DESCRIPCION DESCR_TIPO_UBICACION,
                ubi_nombre DESCR_UBICACION,
                DECODE (AISLADA,  0, NULL,  1, A.NOMBRE) IND_AISLAMIENTO_UBICACION,
                E.NOMBRE IND_ESTADO_UBICACION,
                (SELECT SUBID_DIA
                   FROM MSTR_MAE_TIEMPO_03_DIAS
                  WHERE NATID_DIA = TRUNC (SYSDATE - 1)),
                NVL (NATID_CONTROL_ENFERMERIA, -1)
           FROM his_own.COM_UBICACION_GESTION_LOCAL@dae
                JOIN his_own.COM_M_UBICACION@dae
                   ON (CODIGO_ESTRUCTURA = UBI_CODIGO)
                LEFT JOIN his_own.com_m_tipo_aislamiento@dae A
                   ON (TIPO_AISLAMIENTO = A.CODIGO)
                JOIN his_own.com_m_estado_ubicacion@dae E
                   ON (ESTADO = E.CODIGO)
                JOIN HIS_OWN.COM_M_TIPO_UBICACION@dae
                   ON (UBI_TIP_UBICACION = TUBI_CODIGO)
                LEFT JOIN MSTR_MAE_UNIDADES_FUNCIONALES
                   ON (UNIDAD_FUNCIONAL = NATID_UNIDAD_FUNCIONAL)
                LEFT JOIN MSTR_MAE_CENTROS
                   ON (UBI_CAH_CODIGO = NATID_CENTRO)
                LEFT JOIN MAPA_05_UBICACIONES_CONTR_ENFE@DAE
                   ON (codigo_estructura = NATID_UBICACION)
          WHERE activa = 1 AND UBI_ACTIVO = 0 AND UNIDAD_FUNCIONAL IS NOT NULL;

      COMMIT;
      check_censo_de_camas;
      DBMS_STATS.gather_table_stats (USER, 'MSTR_DET_CENSO_DE_CAMAS');
   END corte_nocturno;

   PROCEDURE corte_a_las_0800AM
   IS
   BEGIN
      INSERT INTO MSTR_DET_CENSO_DE_CAMAS_0800AM
         SELECT TRUNC (SYSDATE) NATID_DIA_CENSAL,
                NVL (MSTR_MAE_CENTROS.SUBID_CENTRO, -1) SUBID_CENTRO,
                NVL (SUBID_UNIDAD_FUNCIONAL, -1) SUBID_UNIDAD_FUNCIONAL,
                codigo_estructura NATID_UBICACION,
                TUBI_DESCRIPCION DESCR_TIPO_UBICACION,
                ubi_nombre DESCR_UBICACION,
                DECODE (AISLADA,  0, NULL,  1, A.NOMBRE) IND_AISLAMIENTO_UBICACION,
                E.NOMBRE IND_ESTADO_UBICACION,
                (SELECT SUBID_DIA
                   FROM MSTR_MAE_TIEMPO_03_DIAS
                  WHERE NATID_DIA = TRUNC (SYSDATE)),
                NVL (NATID_CONTROL_ENFERMERIA, -1)
           FROM his_own.COM_UBICACION_GESTION_LOCAL@dae
                JOIN his_own.COM_M_UBICACION@dae
                   ON (CODIGO_ESTRUCTURA = UBI_CODIGO)
                LEFT JOIN his_own.com_m_tipo_aislamiento@dae A
                   ON (TIPO_AISLAMIENTO = A.CODIGO)
                JOIN his_own.com_m_estado_ubicacion@dae E
                   ON (ESTADO = E.CODIGO)
                JOIN HIS_OWN.COM_M_TIPO_UBICACION@dae
                   ON (UBI_TIP_UBICACION = TUBI_CODIGO)
                LEFT JOIN MSTR_MAE_UNIDADES_FUNCIONALES
                   ON (UNIDAD_FUNCIONAL = NATID_UNIDAD_FUNCIONAL)
                LEFT JOIN MSTR_MAE_CENTROS
                   ON (UBI_CAH_CODIGO = NATID_CENTRO)
                LEFT JOIN MAPA_05_UBICACIONES_CONTR_ENFE@DAE
                   ON (codigo_estructura = NATID_UBICACION)
          WHERE activa = 1 AND UBI_ACTIVO = 0 AND UNIDAD_FUNCIONAL IS NOT NULL;

      COMMIT;
      check_censo_a_las_0800AM;
      DBMS_STATS.gather_table_stats (USER, 'MSTR_DET_CENSO_DE_CAMAS_0800AM');
   END corte_a_las_0800AM;

   PROCEDURE corte_a_las_1800PM
   IS
   BEGIN
      INSERT INTO MSTR_DET_CENSO_DE_CAMAS_1800PM
         SELECT TRUNC (SYSDATE) NATID_DIA_CENSAL,
                NVL (MSTR_MAE_CENTROS.SUBID_CENTRO, -1) SUBID_CENTRO,
                NVL (SUBID_UNIDAD_FUNCIONAL, -1) SUBID_UNIDAD_FUNCIONAL,
                codigo_estructura NATID_UBICACION,
                TUBI_DESCRIPCION DESCR_TIPO_UBICACION,
                ubi_nombre DESCR_UBICACION,
                DECODE (AISLADA,  0, NULL,  1, A.NOMBRE) IND_AISLAMIENTO_UBICACION,
                E.NOMBRE IND_ESTADO_UBICACION,
                (SELECT SUBID_DIA
                   FROM MSTR_MAE_TIEMPO_03_DIAS
                  WHERE NATID_DIA = TRUNC (SYSDATE)),
                NVL (NATID_CONTROL_ENFERMERIA, -1)
           FROM his_own.COM_UBICACION_GESTION_LOCAL@dae
                JOIN his_own.COM_M_UBICACION@dae
                   ON (CODIGO_ESTRUCTURA = UBI_CODIGO)
                LEFT JOIN his_own.com_m_tipo_aislamiento@dae A
                   ON (TIPO_AISLAMIENTO = A.CODIGO)
                JOIN his_own.com_m_estado_ubicacion@dae E
                   ON (ESTADO = E.CODIGO)
                JOIN HIS_OWN.COM_M_TIPO_UBICACION@dae
                   ON (UBI_TIP_UBICACION = TUBI_CODIGO)
                LEFT JOIN MSTR_MAE_UNIDADES_FUNCIONALES
                   ON (UNIDAD_FUNCIONAL = NATID_UNIDAD_FUNCIONAL)
                LEFT JOIN MSTR_MAE_CENTROS
                   ON (UBI_CAH_CODIGO = NATID_CENTRO)
                LEFT JOIN MAPA_05_UBICACIONES_CONTR_ENFE@DAE
                   ON (codigo_estructura = NATID_UBICACION)
          WHERE activa = 1 AND UBI_ACTIVO = 0 AND UNIDAD_FUNCIONAL IS NOT NULL;

      COMMIT;
      check_censo_a_las_1800PM;
      DBMS_STATS.gather_table_stats (USER, 'MSTR_DET_CENSO_DE_CAMAS_1800PM');
   END corte_a_las_1800PM;

   PROCEDURE media_mensual
   IS
   BEGIN
      DELETE FROM MSTR_AGR_CENSO_DE_CAMAS_MES;

      DELETE FROM MSTR_AGR_CENSO_DE_CAMAS_MES@DAE;

      INSERT INTO MSTR_AGR_CENSO_DE_CAMAS_MES
           SELECT (SELECT SUBID_MES
                     FROM MSTR_MAE_TIEMPO_02_MESES
                    WHERE NATID_MES = TRUNC (natid_dia_censal, 'month'))
                     SUBID_MES                                                     --,TRUNC ( natid_dia_censal, 'month') NATID_MES
                              ,
                  SUBID_CENTRO,
                  SUBID_UNIDAD_FUNCIONAL,
                  descr_tipo_ubicacion,
                  COUNT (
                     CASE
                        WHEN IND_ESTADO_UBICACION = 'Libre' AND IND_AISLAMIENTO_UBICACION IS NULL THEN natid_ubicacion
                        ELSE NULL
                     END)
                  / COUNT (DISTINCT natid_dia_censal)
                     IND_MEDIA_CAMAS_LIBRES,
                  COUNT (CASE WHEN IND_ESTADO_UBICACION = 'Ocupada' THEN natid_ubicacion ELSE NULL END)
                  / COUNT (DISTINCT natid_dia_censal)
                     IND_MEDIA_CAMAS_OCUPADAS,
                  COUNT (
                     CASE
                        WHEN IND_ESTADO_UBICACION = 'Libre' AND IND_AISLAMIENTO_UBICACION IS NOT NULL THEN natid_ubicacion
                        ELSE NULL
                     END)
                  / COUNT (DISTINCT natid_dia_censal)
                     IND_MEDIA_CAMAS_AISLADAS,
                  COUNT (natid_ubicacion) / COUNT (DISTINCT natid_dia_censal) IND_MEDIA_CAMAS_FUNCIONANTES
             /*        ,COUNT (natid_ubicacion) NUM_CAMAS
                     ,COUNT (DISTINCT natid_dia_censal) NUM_DIAS
                     ,COUNT (CASE WHEN IND_ESTADO_UBICACION = 'Ocupada' THEN natid_ubicacion ELSE NULL END) NUM_OCUPADAS
                     ,COUNT (
                         CASE
                            WHEN IND_ESTADO_UBICACION = 'Libre' AND IND_AISLAMIENTO_UBICACION IS NULL THEN natid_ubicacion
                            ELSE NULL
                         END)
                         NUM_LIBRES
                     ,COUNT (
                         CASE
                            WHEN IND_ESTADO_UBICACION = 'Libre' AND IND_AISLAMIENTO_UBICACION IS NOT NULL THEN natid_ubicacion
                            ELSE NULL
                         END)
                         NUM_AISLADAS*/
             FROM MSTR_DET_CENSO_DE_CAMAS DET
         -- WHERE DET.SUBID_CENTRO = 11 AND DET.SUBID_UNIDAD_FUNCIONAL = 46
         GROUP BY TRUNC (natid_dia_censal, 'month'),
                  SUBID_CENTRO,
                  SUBID_UNIDAD_FUNCIONAL,
                  descr_tipo_ubicacion
         ORDER BY TRUNC (natid_dia_censal, 'month'), SUBID_CENTRO, SUBID_UNIDAD_FUNCIONAL;

      IF SQL%ROWCOUNT > 0
      THEN
         PQ_OAUTH.TWITTER_003_UPDATE_STATUS ('Media de camas completada a las ' || TO_CHAR (SYSDATE, 'fmHH24:MI:SS'),
                                             'valme_twit_07');

         INSERT INTO MSTR_AGR_CENSO_DE_CAMAS_MES@DAE
            SELECT DESCR_TIPO_UBICACION,
                   IND_MEDIA_CAMAS_AISLADAS,
                   IND_MEDIA_CAMAS_FUNCIONANTES,
                   IND_MEDIA_CAMAS_LIBRES,
                   IND_MEDIA_CAMAS_OCUPADAS                                                                        --,SUBID_CENTRO
                                           ,
                   NATID_CENTRO CENTRO_ID,
                   SUBID_MES                                                                             --,SUBID_UNIDAD_FUNCIONAL
                            ,
                   NATID_UNIDAD_FUNCIONAL UNID_FUNC_ID
              FROM MSTR_AGR_CENSO_DE_CAMAS_MES
                   JOIN MSTR_MAE_UNIDADES_FUNCIONALES
                      USING (SUBID_UNIDAD_FUNCIONAL)
                   JOIN MSTR_MAE_CENTROS
                      USING (SUBID_CENTRO);
      ELSE
         PQ_OAUTH.TWITTER_004_UPDATE_STATUS ('Error en la media de camas', 'valme_twit_08');
      END IF;

      COMMIT;
      DBMS_STATS.gather_table_stats (USER, 'MSTR_AGR_CENSO_DE_CAMAS_MES');
   END media_mensual;

   PROCEDURE check_censo_de_camas
   IS
      lrec_count   NUMBER;
   BEGIN
      SELECT COUNT (NATID_UBICACION)
        INTO lrec_count
        FROM MSTR_DET_CENSO_DE_CAMAS
       WHERE NATID_DIA_CENSAL = TRUNC (SYSDATE - 1);

      IF lrec_count <= 0
      THEN
         PQ_OAUTH.TWITTER_004_UPDATE_STATUS ('Error en el censo de camas', 'valme_twit_08');
      ELSE
         PQ_OAUTH.TWITTER_004_UPDATE_STATUS ('Censo de camas completado a las ' || TO_CHAR (SYSDATE, 'fmHH24:MI'),
                                             'valme_twit_05');
      END IF;
   END check_censo_de_camas;

   PROCEDURE check_censo_a_las_0800AM
   IS
      lrec_count   NUMBER;
   BEGIN
      SELECT COUNT (NATID_UBICACION)
        INTO lrec_count
        FROM MSTR_DET_CENSO_DE_CAMAS_0800AM
       WHERE NATID_DIA_CENSAL_0800AM = TRUNC (SYSDATE);

      IF lrec_count <= 0
      THEN
         PQ_OAUTH.TWITTER_004_UPDATE_STATUS ('Error en el censo de camas (08:00AM)', 'valme_twit_08');
      ELSE
         PQ_OAUTH.TWITTER_004_UPDATE_STATUS (
               TO_CHAR (SYSDATE, 'fmDy,DD - ', 'nls_date_language = spanish')
            || 'Censo de camas a las 8AM completado a las '
            || TO_CHAR (SYSDATE, 'fmHH24:MI'),
            'valme_twit_05');
      END IF;
   END check_censo_a_las_0800AM;

   PROCEDURE check_censo_a_las_1800PM
   IS
      lrec_count   NUMBER;
   BEGIN
      SELECT COUNT (NATID_UBICACION)
        INTO lrec_count
        FROM MSTR_DET_CENSO_DE_CAMAS_1800PM
       WHERE NATID_DIA_CENSAL_1800PM = TRUNC (SYSDATE);

      IF lrec_count <= 0
      THEN
         PQ_OAUTH.TWITTER_004_UPDATE_STATUS ('Error en el censo de camas (18:00PM)', 'valme_twit_08');
      ELSE
         PQ_OAUTH.TWITTER_004_UPDATE_STATUS (
               TO_CHAR (SYSDATE, 'fmDy,DD - ', 'nls_date_language = spanish')
            || 'Censo de camas a las 18PM completado a las '
            || TO_CHAR (SYSDATE, 'fmHH24:MI'),
            'valme_twit_05');
      END IF;
   END check_censo_a_las_1800PM;
END pq_censo_de_camas;
/
