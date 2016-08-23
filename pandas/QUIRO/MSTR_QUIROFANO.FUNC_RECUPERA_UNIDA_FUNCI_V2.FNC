CREATE OR REPLACE FUNCTION MSTR_QUIROFANO.FUNC_RECUPERA_UNIDA_FUNCI_v2 (NEPISODIO IN VARCHAR2, P_NUHSA IN VARCHAR2)
   RETURN VARCHAR2
AS
   V_UF_PARTE        VARCHAR2 (10);
   V_REFERENCIA_ID   VARCHAR2 (10);
BEGIN
   SELECT NATID_UNIDAD_FUNCIONAL
     INTO V_UF_PARTE
     FROM MSTR_MAE_EPISODIOS
    WHERE NATID_EPISODIO = NEPISODIO AND NUHSA = P_NUHSA;

RETURN V_UF_PARTE;
/*
   -- Si el episodio no existe.
   IF NEPISODIO IN ('NO_INFORMADO', '0')
   THEN
      RETURN '-1';
   ELSE
      -- Si el episodio es de urgencias
      BEGIN
         SELECT AU_CENTRO
           INTO V_UF_PARTE
           FROM CAE_OWN.ADMISION@DAE
          WHERE AU_EPISODIO = TO_NUMBER (NEPISODIO);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            -- Si no hay episodio de urgencias busca en hpospitalización
            BEGIN
               SELECT REFERENCIA_ID
                 INTO V_REFERENCIA_ID
                 FROM HIS_OWN.ADM_EPIS_DETALLE@DAE
                WHERE EPISODIO_ID = TO_NUMBER (NEPISODIO);
            EXCEPTION
               WHEN OTHERS
               THEN
                  DBMS_OUTPUT.put_line ('[' || NEPISODIO || '] ' || DBMS_UTILITY.format_error_backtrace);
            END;

            BEGIN
               IF V_REFERENCIA_ID IS NOT NULL
               THEN
                  SELECT (UNID_FUNC_INGRESO)
                    INTO V_UF_PARTE
                    FROM HIS_OWN.ADM_ADMISION@DAE
                   WHERE ADMISION_ID = V_REFERENCIA_ID;
               ELSE
                  V_UF_PARTE := '-1';
               END IF;
            EXCEPTION
               WHEN OTHERS
               THEN
                  DBMS_OUTPUT.put_line ('[' || NEPISODIO || '] ' || DBMS_UTILITY.format_error_backtrace);
            END;
         WHEN OTHERS
         THEN
            DBMS_OUTPUT.put_line ('[' || NEPISODIO || '] ' || DBMS_UTILITY.format_error_backtrace);
      END;
      RETURN (V_UF_PARTE);
   END IF;

*/
--   RETURN CASE
--             WHEN NVL (UF_PARTE, -1) = -1 AND NEPISODIO NOT IN ('NO_INFORMADO', '0')
--             THEN
--                NVL ( (SELECT UNID_FUNC_INGRESO
--                         FROM HIS_OWN.ADM_ADMISION@DAE
--                        WHERE ADMISION_ID = (SELECT REFERENCIA_ID
--                                               FROM HIS_OWN.ADM_EPIS_DETALLE@DAE
--                                              WHERE EPISODIO_ID = NEPISODIO)),
--                     '-1')
--             WHEN NVL (UF_PARTE, -1) > '0'
--             THEN
--                UF_PARTE
--             ELSE
--                '-1'
--          END;
END;
/
