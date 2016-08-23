CREATE OR REPLACE PACKAGE MSTR_SIGLO.PANDAS_090_POST_TO_SHAREPOINT
AS
   const_sharepoint_server_ntus    CONSTANT VARCHAR2 (1024) := 'DMSAS\srvc_ma49spandas';
   const_sharepoint_server_ntpw    CONSTANT VARCHAR2 (1024) := '5P49anD45';
   const_sharepoint_service_meth   CONSTANT VARCHAR2 (10) := 'POST';
   const_sharepoint_service_prot   CONSTANT VARCHAR2 (10) := 'HTTP/1.1';

   FUNCTION LISTDATA (listdata_url IN VARCHAR2, listdata_payload IN VARCHAR2, listdata_charset IN VARCHAR2 DEFAULT 'iso-8859-1')
      RETURN BOOLEAN;
END;
/
