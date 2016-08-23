CREATE OR REPLACE FUNCTION MSTR.FUNC_ENCRYPT_v2 (p_val IN VARCHAR2)
   RETURN VARCHAR2
AS
   v_key             VARCHAR2 (2000) := '101.9 Dawg Fm   ';
   v_encoded         VARCHAR2 (64);
   encryption_type   PLS_INTEGER := DBMS_CRYPTO.ENCRYPT_AES256 + DBMS_CRYPTO.CHAIN_CBC + DBMS_CRYPTO.PAD_PKCS5;
BEGIN
   IF p_val = '-1' OR p_val IS NULL
   THEN
      RETURN '-1';
   ELSE
      v_encoded :=
         DBMS_CRYPTO.encrypt (UTL_I18N.STRING_TO_RAW (p_val, 'AL32UTF8'),
                              DBMS_CRYPTO.AES_CBC_PKCS5,
                              UTL_I18N.STRING_TO_RAW (v_key, 'AL32UTF8'));
      RETURN v_encoded;
   END IF;
END;
/
