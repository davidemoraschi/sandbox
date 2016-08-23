CREATE OR REPLACE FUNCTION MSTR.FUNC_DECRYPT_v2 (p_val IN VARCHAR2)
   RETURN VARCHAR2
AS
   v_key          VARCHAR2 (2000) := '101.9 Dawg Fm   ';
   v_decode_raw   RAW (2000);
BEGIN
   IF p_val = '-1' OR p_val IS NULL
   THEN
      RETURN '-1';
   ELSE
      v_decode_raw := DBMS_CRYPTO.decrypt (p_val, DBMS_CRYPTO.AES_CBC_PKCS5, UTL_I18N.STRING_TO_RAW (v_key, 'AL32UTF8'));
      RETURN UTL_I18N.raw_to_char (v_decode_raw, 'AL32UTF8');
   END IF;
END;
/
