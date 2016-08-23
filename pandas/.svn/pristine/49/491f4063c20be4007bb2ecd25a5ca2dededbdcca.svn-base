CREATE OR REPLACE PACKAGE MSTR.PANDAS_096_IMPOSSIBLE
AS
   con_str_http_proxy              CONSTANT VARCHAR2 (50) := '10.136.0.13:8080';
   const_host_port                 CONSTANT VARCHAR2 (1024) := 'http://10.136.0.126';
   const_intelligent_server_name   CONSTANT VARCHAR2 (1024) := 'PANDAS';
   const_intelligent_server_wurl   CONSTANT VARCHAR2 (1024) := '/MicroStrategy/servlet/taskProc?';
   const_intelligent_server_user   CONSTANT VARCHAR2 (1024) := 'Emeishan';
   const_intelligent_server_pass   CONSTANT VARCHAR2 (1024) := 'from300($48)to500yuan';
   con_str_wallet_path             CONSTANT VARCHAR2 (50) := 'file:/u01/app/oracle/wallet';
   con_str_wallet_pass             CONSTANT VARCHAR2 (50) := 'Lepanto1571';

   PROCEDURE CREATE_PROJECT (p_projectname IN VARCHAR2);

   PROCEDURE UPLOAD_MOVIE (p_sdljson IN VARCHAR2);

   PROCEDURE UPLOAD_IMAGE (p_projectname   IN VARCHAR2,
                           p_reportid      IN VARCHAR2,
                           rWidth          IN NUMBER DEFAULT 750,
                           rHeight         IN NUMBER DEFAULT 400);
END PANDAS_096_IMPOSSIBLE;
/
