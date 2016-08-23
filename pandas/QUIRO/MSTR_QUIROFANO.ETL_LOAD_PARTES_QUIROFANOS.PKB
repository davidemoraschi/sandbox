CREATE OR REPLACE PACKAGE BODY MSTR_QUIROFANO.ETL_LOAD_PARTES_QUIROFANOS
AS
   PROCEDURE P_001 (Param1 IN NUMBER DEFAULT NULL)
   IS
      TmpVar   NUMBER;
   BEGIN
      --      DBMS_SNAPSHOT.REFRESH ('MSTR_DET_PARTES_QUIRURGICOS', 'C');
      EXECUTE IMMEDIATE 'TRUNCATE TABLE MSTR_DET_PARTES_QUIRURGICOS';

      INSERT INTO MSTR_DET_PARTES_QUIRURGICOS
         SELECT -1 NATID_CENTRO,
                '-1' NATID_UNIDAD_FUNCIONAL,
                -1 NATID_CABECERA_PARTE_QUIRU,
                -1 NATID_DETALLE_PARTE_QUIRU,
                -1 ORDEN_DETALLE_PARTE_QUIRU,
                -1 NATID_TURNO_QUIROFANO,
                NULL FHORA_INICIO_PARTE_QUIRU,
                NULL FHORA_FIN_PARTE_QUIRU,
                -1 NATID_JORNADA_LABORAL,
                -1 ESTADO_PARTE_QUIRU,
                -1 VALIDACION_PARTE_QUIRU,
                -1 NATID_QUIROFANO,
                NULL NATID_MOTIV_DESPROGRAMACION,
                -1 NATID_POST_INTERVENCION,
                -1 NATID_PRE_INTERVENCION,
                -1 NATID_PREINGRESO,
                -1 NATID_TIPO_PLANIFICACION,
                -1 NATID_ADMISION,
                -1 NATID_ANESTESIA,
                NULL DURACION_PREVISTA_INTERVENCION,
                -1 NATID_EPISODIO,
                -1 NATID_ESTADO_INTERVENCION,
                -1 NATID_PACIENTE,
                NULL NUHSA,
                NULL NATID_CODIGO_RDQ_PRE,
                -1 IND_MAYOR_MENOR,
                -1 NATID_MODAL_ASISTENCIAL,
                -1 IND_QUIRURGICA,
                -1 IND_URGENCIA_DIFERIDA,
                NULL NATID_DIAGNOSTICO_CIE_PRE,
                NULL TEXTO_DIAGNOSTICO_PRE,
                NULL NATID_PROCEDIMIENTO_CIE_PRE,
                NULL TEXTO_PROCEDIMIENTO_PRE,
                -1 IND_DESPROGRAMACION,
                '-1' NATID_CIRUJANO_PRINCIPAL,
                '--' DESCR_CIRUJANO_PRINCIPAL,
                '-1' NATID_CIRUJANO,
                '--' DESCR_CIRUJANO,
                NULL LAST_REFRESH_DATE
           FROM DUAL
         UNION ALL
         SELECT CENTRO_ID NATID_CENTRO,
                UNI_FUNCIONAL_ID NATID_UNIDAD_FUNCIONAL,
                PQ_CAB_ID NATID_CABECERA_PARTE_QUIRU,
                PQ_DET_ID NATID_DETALLE_PARTE_QUIRU,
                ORDEN ORDEN_DETALLE_PARTE_QUIRU,
                TURNO_ID NATID_TURNO_QUIROFANO,
                FECHA_HORA_INICIO FHORA_INICIO_PARTE_QUIRU,
                FECHA_HORA_FIN FHORA_FIN_PARTE_QUIRU,
                CARAC_ECONOM_ID NATID_JORNADA_LABORAL,
                ESTADO ESTADO_PARTE_QUIRU,
                ESTADO_VALIDACION VALIDACION_PARTE_QUIRU,
                QUIROFANO NATID_QUIROFANO,
                MOT_DESPROG_ID NATID_MOTIV_DESPROGRAMACION,
                IQ_POST_ID NATID_POST_INTERVENCION,
                IQ_PRE_ID NATID_PRE_INTERVENCION,
                PREING_DET_ID NATID_PREINGRESO,
                TPLANIFICAC_PRE_ID NATID_TIPO_PLANIFICACION,
                ADMISION_ID NATID_ADMISION,
                ANESTESIA_ID NATID_ANESTESIA,
                DURACION_PREVISTA DURACION_PREVISTA_INTERVENCION,
                NVL (EPISODIO_ID, -1) NATID_EPISODIO,
                ESTADO_ID NATID_ESTADO_INTERVENCION,
                ADM_QRF_IQ_PRE.ID_USUARIO NATID_PACIENTE,
                NUHSA NUHSA,
                RDQ_CODIGO NATID_CODIGO_RDQ_PRE,
                IQ_TIPO_ID IND_MAYOR_MENOR,
                MODAL_ASIST_ID NATID_MODAL_ASISTENCIAL,
                QUIRURGICA IND_QUIRURGICA,
                TIPO_PROGRAMACION IND_URGENCIA_DIFERIDA,
                DIAGN_PRINC.CODIGO_ICD9 NATID_DIAGNOSTICO_CIE_PRE,
                DIAGN_PRINC.TEXTO_LIBRE TEXTO_DIAGNOSTICO_PRE,
                PROCE_PRINC.CODIGO_PROC NATID_PROCEDIMIENTO_CIE_PRE,
                PROCE_PRINC.TEXTO_LIBRE TEXTO_PROCEDIMIENTO_PRE,
                DECODE (IQ_DESPR_ID, NULL, 0, 1) IND_DESPROGRAMACION,
                NVL (CIRUJANO_PRINCIPAL.NATID_CIRUJANO_PRINCIPAL, -1) NATID_CIRUJANO_PRINCIPAL,
                NVL (CIRUJANO_PRINCIPAL.DESCR_CIRUJANO_PRINCIPAL, '--') DESCR_CIRUJANO_PRINCIPAL,
                NVL (CIRUJANO.NATID_CIRUJANO, -1) NATID_CIRUJANO,
                NVL (CIRUJANO.DESCR_CIRUJANO, '--') DESCR_CIRUJANO,
                LAST_REFRESH_DATE
           FROM HIS_OWN.ADM_QRF_PQ_CAB@DAE
                JOIN HIS_OWN.ADM_QRF_PQ_DET@DAE
                   USING (PQ_CAB_ID)
                JOIN HIS_OWN.ADM_QRF_IQ_PRE@DAE
                   USING (IQ_PRE_ID)
                JOIN (SELECT IQ_PRE_ID, CODIGO_ICD9, TEXTO_LIBRE
                        FROM HIS_OWN.ADM_QRF_IQ_ICD_PRE@DAE
                       WHERE DIAGN_PROCE = 'D' AND PRINCIPAL = 1) DIAGN_PRINC
                   USING (IQ_PRE_ID)
                JOIN (SELECT IQ_PRE_ID, CODIGO_PROC, TEXTO_LIBRE
                        FROM HIS_OWN.ADM_QRF_IQ_ICD_PRE@DAE
                       WHERE DIAGN_PROCE = 'P' AND PRINCIPAL = 1) PROCE_PRINC
                   USING (IQ_PRE_ID)
                LEFT JOIN HIS_OWN.ADM_QRF_IQ_DESPR@DAE
                   USING (IQ_DESPR_ID, IQ_PRE_ID)
                LEFT JOIN HIS_OWN.ADM_QRF_IQ_X_LEQ@DAE
                   USING (IQ_PRE_ID)
                JOIN HIS_OWN.COM_USUARIO@DAE
                   ON (ADM_QRF_IQ_PRE.ID_USUARIO = COM_USUARIO.ID_USUARIO)
                LEFT JOIN (SELECT IQ_PRE_ID,
                                  PER_CODIGO NATID_CIRUJANO_PRINCIPAL,
                                  PER_APELLIDO1 || ' ' || PER_APELLIDO2 || ', ' || PER_NOMBRE DESCR_CIRUJANO_PRINCIPAL
                             FROM HIS_OWN.ADM_QRF_IQ_RECURSOS_PRE@DAE JOIN REP_PRO_MAC.PERSONAS@DAE ON (RECURSO_ID = PER_CODIGO)
                            WHERE IQ_RECURSOS_PRE IN (  SELECT MIN (IQ_RECURSOS_PRE) IQ_RECURSOS_PRE
                                                          FROM HIS_OWN.ADM_QRF_IQ_RECURSOS_PRE@DAE
                                                         WHERE FUNCION_REC_ID = 1
                                                      GROUP BY IQ_PRE_ID)) CIRUJANO_PRINCIPAL
                   USING (IQ_PRE_ID)
                LEFT JOIN (SELECT IQ_PRE_ID,
                                  PER_CODIGO NATID_CIRUJANO,
                                  PER_APELLIDO1 || ' ' || PER_APELLIDO2 || ', ' || PER_NOMBRE DESCR_CIRUJANO
                             FROM HIS_OWN.ADM_QRF_IQ_RECURSOS_PRE@DAE JOIN REP_PRO_MAC.PERSONAS@DAE ON (RECURSO_ID = PER_CODIGO)
                            WHERE IQ_RECURSOS_PRE IN (  SELECT MIN (IQ_RECURSOS_PRE) IQ_RECURSOS_PRE
                                                          FROM HIS_OWN.ADM_QRF_IQ_RECURSOS_PRE@DAE
                                                         WHERE FUNCION_REC_ID = 2
                                                      GROUP BY IQ_PRE_ID)) CIRUJANO
                   USING (IQ_PRE_ID)
                CROSS JOIN (SELECT SYSDATE last_refresh_date FROM DUAL                  --                SELECT last_refresh_date
                                                                           --                              FROM sys.all_mviews@EXP
                                                                --                             WHERE mview_name = 'ADM_QRF_PQ_CAB'
                           )
          WHERE     FECHA_HORA_INICIO >= ADD_MONTHS (TRUNC (SYSDATE, 'YEAR'), -12)
                AND FECHA_HORA_INICIO <= ADD_MONTHS (TRUNC (SYSDATE, 'YEAR'), 12)
                AND ADM_QRF_IQ_PRE.ACTIVO = 1;

      DBMS_STATS.gather_table_stats ('MSTR_QUIROFANO', 'MSTR_DET_PARTES_QUIRURGICOS');
   END;
END;
/
