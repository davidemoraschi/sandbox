CREATE OR REPLACE PACKAGE MSTR.PANDAS_091_UPLOAD_TO_SHAREP
AS
   const_sharepoint_server_ntus    CONSTANT VARCHAR2 (1024) := 'VALME\aaaaaaaa';
   const_sharepoint_server_ntpw    CONSTANT VARCHAR2 (1024) := '*********';
   const_sharepoint_service_meth   CONSTANT VARCHAR2 (10) := 'POST';
   const_sharepoint_service_prot   CONSTANT VARCHAR2 (10) := 'HTTP/1.1';
   con_str_http_proxy              CONSTANT VARCHAR2 (50) := '10.136.0.13:8080';
   con_str_wallet_path             CONSTANT VARCHAR2 (50) := 'file:/u01/app/oracle/wallet';
   con_str_wallet_pass             CONSTANT VARCHAR2 (50) := 'Lepanto1571';
   con_str_sharepoint_user         CONSTANT VARCHAR2 (500) := 'apisa@proyectopandas.onmicrosoft.com';
   con_str_sharepoint_pass         CONSTANT VARCHAR2 (500) := 'Sharepoint$10.25';
   con_str_sharepoint_domain       CONSTANT VARCHAR2 (500) := 'proyectopandas';
   con_str_sharepoint_list         CONSTANT VARCHAR2 (2500) := 'SiteAssets';

   PROCEDURE RETRY_N_TIMES (p_retries_number   IN NUMBER DEFAULT 3,
                            p_payload          IN VARCHAR2 DEFAULT '<h1>Hello World</h1>',
                            p_user             IN VARCHAR2 DEFAULT con_str_sharepoint_user,
                            p_password         IN VARCHAR2 DEFAULT con_str_sharepoint_pass,
                            p_domain           IN VARCHAR2 DEFAULT con_str_sharepoint_domain,
                            p_list             IN VARCHAR2 DEFAULT con_str_sharepoint_list,
                            p_filename         IN VARCHAR2 DEFAULT 'test',
                            p_fileext          IN VARCHAR2 DEFAULT '.html',
                            p_mimetype         IN VARCHAR2 DEFAULT 'text/html');

   FUNCTION TEXT_FILE (p_payload    IN VARCHAR2 DEFAULT '<h1>Hello World</h1>',
                       p_user       IN VARCHAR2 DEFAULT con_str_sharepoint_user,
                       p_password   IN VARCHAR2 DEFAULT con_str_sharepoint_pass,
                       p_domain     IN VARCHAR2 DEFAULT con_str_sharepoint_domain,
                       p_list       IN VARCHAR2 DEFAULT con_str_sharepoint_list,
                       p_filename   IN VARCHAR2 DEFAULT 'test',
                       p_fileext    IN VARCHAR2 DEFAULT '.html',
                       p_mimetype   IN VARCHAR2 DEFAULT 'text/html')
      RETURN VARCHAR2;
--   FUNCTION LISTDATA (listdata_url IN VARCHAR2, listdata_payload IN VARCHAR2, listdata_charset IN VARCHAR2 DEFAULT 'iso-8859-1')
--      RETURN BOOLEAN;
END;
/
