CREATE OR REPLACE PACKAGE MSTR.PANDAS_093_TWIT AS
	const_sharepoint_service_prot CONSTANT VARCHAR2 (10) := 'HTTP/1.1';
	con_str_http_proxy CONSTANT VARCHAR2 (50) := 'proxy-hospitales.sas.junta-andalucia.es:8080';
	con_str_wallet_path CONSTANT VARCHAR2 (50) := 'file:/u01/app/oracle/wallet';
	con_str_wallet_pass CONSTANT VARCHAR2 (50) := 'Lepanto1571';

	PROCEDURE POST_STATUS (p_status IN VARCHAR2 DEFAULT 'ok', p_account IN VARCHAR2 DEFAULT NULL);
--RETURN VARCHAR2;
END;
/
