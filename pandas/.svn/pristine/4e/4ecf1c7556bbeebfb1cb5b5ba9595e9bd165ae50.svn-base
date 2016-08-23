CREATE OR REPLACE PACKAGE MSTR.PANDAS_002_DOCUMENT_EXECUTE
AS
   --   const_host_port                 CONSTANT VARCHAR2 (1024) := 'http://fraterno:8080';
   --const_host_port                 CONSTANT VARCHAR2 (1024) := 'http://fraterno';
   const_host_port                 CONSTANT VARCHAR2 (1024) := 'https://pandas:8443';
   --   const_host_port                 CONSTANT VARCHAR2 (1024) := 'http://eurostrategy.net';
   const_intelligent_server_name   CONSTANT VARCHAR2 (1024) := 'PANDAS';
   --const_intelligent_server_name   CONSTANT VARCHAR2 (1024) := 'FRATERNO';
   --   const_intelligent_server_name   CONSTANT VARCHAR2 (1024) := 'IP-10-14473-168';
   const_intelligent_server_proj   CONSTANT VARCHAR2 (1024) := '001. Hola Mundo';
   const_intelligent_server_user   CONSTANT VARCHAR2 (1024) := 'Emeishan';
   const_intelligent_server_pass   CONSTANT VARCHAR2 (1024) := 'from300($48)to500yuan';
   const_intelligent_server_wurl   CONSTANT VARCHAR2 (1024) := '/MicroStrategy/servlet/mstrWeb?';
   --   const_intelligent_server_pass   CONSTANT VARCHAR2 (1024) := 'YamanakayGurdon';
   --   const_intelligent_server_wurl   CONSTANT VARCHAR2 (1024) := '/MicroStrategy/servlet/taskProc?';
--   const_intelligent_server_wurl   CONSTANT VARCHAR2 (1024) := '/MicroStrategy/asp/Main.aspx?';
   const_intelligent_server_ntus   CONSTANT VARCHAR2 (1024) := 'VALME\xxxxxx';
   const_intelligent_server_ntpw   CONSTANT VARCHAR2 (1024) := '*******';

   PROCEDURE png (reportId      IN VARCHAR2 DEFAULT '9C5AE6B84A50C46DC5E94FA18D95D925',
                  projectName   IN VARCHAR2 DEFAULT const_intelligent_server_proj,
                  rWidth        IN NUMBER DEFAULT 750,
                  rHeight       IN NUMBER DEFAULT 400);

   PROCEDURE htm (documentId      IN VARCHAR2 DEFAULT '99E6EA454EFE37373F2980A43323C92D',
                  projectName   IN VARCHAR2 DEFAULT const_intelligent_server_proj);

   PROCEDURE xml (reportId      IN VARCHAR2 DEFAULT '99E6EA454EFE37373F2980A43323C92D',
                  projectName   IN VARCHAR2 DEFAULT const_intelligent_server_proj);

   PROCEDURE deliver_chunks (t_content IN CLOB, l_file_etag IN VARCHAR2);
END;
/
