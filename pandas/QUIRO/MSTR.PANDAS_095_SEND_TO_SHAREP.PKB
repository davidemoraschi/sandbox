CREATE OR REPLACE PACKAGE BODY MSTR.PANDAS_095_SEND_TO_SHAREP
AS
   --   PROCEDURE RETRY_N_TIMES (p_retries_number   IN NUMBER DEFAULT 3,
   --                            p_payload          IN VARCHAR2 DEFAULT '<h1>Hello World</h1>',
   --                            p_user             IN VARCHAR2 DEFAULT con_str_sharepoint_user,
   --                            p_password         IN VARCHAR2 DEFAULT con_str_sharepoint_pass,
   --                            p_domain           IN VARCHAR2 DEFAULT con_str_sharepoint_domain,
   --                            p_list             IN VARCHAR2 DEFAULT con_str_sharepoint_list,
   --                            p_filename         IN VARCHAR2 DEFAULT 'test',
   --                            p_fileext          IN VARCHAR2 DEFAULT '.html',
   --                            p_mimetype         IN VARCHAR2 DEFAULT 'text/html')
   --   IS
   --      l_result   VARCHAR2 (32767);
   --      n_retry    NUMBER := 0;
   --   BEGIN
   --      l_result :=
   --         TEXT_FILE (p_payload,
   --                    p_user,
   --                    p_password,
   --                    p_domain,
   --                    p_list,
   --                    p_filename,
   --                    p_fileext,
   --                    p_mimetype);
   --      n_retry := 1;
   --
   --      WHILE n_retry <= p_retries_number
   --      LOOP
   --         IF INSTR (l_result, '<?xml version="1.0" encoding="utf-8" standalone="yes"?>') > 0
   --         THEN
   --            DBMS_OUTPUT.put_line (l_result);
   --            EXIT;
   --         ELSE
   --            DBMS_OUTPUT.put_line (l_result);
   --            l_result :=
   --               TEXT_FILE (p_payload,
   --                          p_user,
   --                          p_password,
   --                          p_domain,
   --                          p_list,
   --                          p_filename,
   --                          p_fileext,
   --                          p_mimetype);
   --            n_retry := n_retry + 1;
   --         END IF;
   --      END LOOP;
   --   END;
   --
   --   FUNCTION TEXT_FILE (p_payload    IN VARCHAR2 DEFAULT '<h1>Hello World</h1>',
   --                       p_user       IN VARCHAR2 DEFAULT con_str_sharepoint_user,
   --                       p_password   IN VARCHAR2 DEFAULT con_str_sharepoint_pass,
   --                       p_domain     IN VARCHAR2 DEFAULT con_str_sharepoint_domain,
   --                       p_list       IN VARCHAR2 DEFAULT con_str_sharepoint_list,
   --                       p_filename   IN VARCHAR2 DEFAULT 'test',
   --                       p_fileext    IN VARCHAR2 DEFAULT '.html',
   --                       p_mimetype   IN VARCHAR2 DEFAULT 'text/html')
   --      RETURN VARCHAR2
   --   IS
   --      --   p_user             VARCHAR2 (32767) := 'apisa@proyectopandas.onmicrosoft.com';                   -- := con_str_sharepoint_user:
   --      --   p_password         VARCHAR2 (32767) := 'Sharepoint$10.25';                                       -- := con_str_sharepoint_pass;
   --      --   p_domain           VARCHAR2 (32767) := 'proyectopandas';                                      -- :=  con_str_sharepoint_domain;
   --      --   p_list             VARCHAR2 (32767) := 'SiteAssets';                                             -- := con_str_sharepoint_list;
   --      --RETURN VARCHAR2
   --      --   l_payload          VARCHAR2 (32767)
   --      --      := '<?xml version="1.0" encoding="iso-8859-1" ?><Response><Say voice="woman" language="es">Buenos d�as, bienvenido al Proyecto PANDAS.</Say><Pause length="1"/><Say voice="woman" language="es">Este es un mensaje autom�tico, no intente hablarme.</Say></Response>';
   --      --         :=    '{ Title: "Tre", Content: "POST HTML desde Oracle '
   --      --            || TO_CHAR (SYSDATE, 'DD/MM HH24:MI:SS')
   --      --            || '", Result: "SUCCESS"  }';
   --      x_content          XMLTYPE;
   --      l_text             VARCHAR2 (32767);
   --      p_content          CLOB;
   --      l_http_request     UTL_HTTP.req;
   --      l_http_response    UTL_HTTP.resp;
   --
   --      l_saml             VARCHAR2 (32767)
   --         :=    '<s:Envelope xmlns:s="http://www.w3.org/2003/05/soap-envelope"
   --      xmlns:a="http://www.w3.org/2005/08/addressing"
   --      xmlns:u="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">
   --  <s:Header>
   --    <a:Action s:mustUnderstand="1">http://schemas.xmlsoap.org/ws/2005/02/trust/RST/Issue</a:Action>
   --    <a:ReplyTo>
   --      <a:Address>http://www.w3.org/2005/08/addressing/anonymous</a:Address>
   --    </a:ReplyTo>
   --    <a:To s:mustUnderstand="1">https://login.microsoftonline.com/extSTS.srf</a:To>
   --    <o:Security s:mustUnderstand="1"
   --       xmlns:o="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">
   --      <o:UsernameToken>
   --        <o:Username>'
   --            || p_user
   --            || '</o:Username>
   --        <o:Password>'
   --            || p_password
   --            || '</o:Password>
   --      </o:UsernameToken>
   --    </o:Security>
   --  </s:Header>
   --  <s:Body>
   --    <t:RequestSecurityToken xmlns:t="http://schemas.xmlsoap.org/ws/2005/02/trust">
   --      <wsp:AppliesTo xmlns:wsp="http://schemas.xmlsoap.org/ws/2004/09/policy">
   --        <a:EndpointReference>
   --          <a:Address>https://'
   --            || p_domain
   --            || '.sharepoint.com</a:Address>
   --        </a:EndpointReference>
   --      </wsp:AppliesTo>
   --      <t:KeyType>http://schemas.xmlsoap.org/ws/2005/05/identity/NoProofKey</t:KeyType>
   --      <t:RequestType>http://schemas.xmlsoap.org/ws/2005/02/trust/Issue</t:RequestType>
   --      <t:TokenType>urn:oasis:names:tc:SAML:1.0:assertion</t:TokenType>
   --    </t:RequestSecurityToken>
   --  </s:Body>
   --</s:Envelope>';
   --      l_security_token   VARCHAR2 (32767);
   --      h_name             VARCHAR2 (32767);
   --      h_value            VARCHAR2 (32767);
   --      FedAuth_cookie     VARCHAR2 (32767);
   --      rtFa_cookie        VARCHAR2 (32767);
   --   BEGIN
   --      UTL_HTTP.set_proxy (PANDAS_091_UPLOAD_TO_SHAREP.con_str_http_proxy);
   --      UTL_HTTP.set_wallet (PATH       => PANDAS_091_UPLOAD_TO_SHAREP.con_str_wallet_path,
   --                           PASSWORD   => PANDAS_091_UPLOAD_TO_SHAREP.con_str_wallet_pass);
   --      l_http_request :=
   --         UTL_HTTP.BEGIN_REQUEST ('https://login.microsoftonline.com/extSTS.srf',
   --                                 PANDAS_091_UPLOAD_TO_SHAREP.const_sharepoint_service_meth,
   --                                 PANDAS_091_UPLOAD_TO_SHAREP.const_sharepoint_service_prot);
   --      --UTL_HTTP.set_cookie_support (l_http_request, FALSE);
   --      --TRUE, 300, 300);
   --      UTL_HTTP.set_persistent_conn_support (TRUE, 5);
   --      UTL_HTTP.set_header (l_http_request, 'Content-Length', LENGTH (l_saml));
   --      UTL_HTTP.WRITE_TEXT (l_http_request, l_saml);
   --      l_http_response := UTL_HTTP.GET_RESPONSE (l_http_request);
   --      DBMS_LOB.createtemporary (p_content, FALSE);
   --
   --      BEGIN
   --         LOOP
   --            UTL_HTTP.read_text (l_http_response, l_text, 32766);
   --            DBMS_LOB.writeappend (p_content, LENGTH (l_text), l_text);
   --         END LOOP;
   --      EXCEPTION
   --         WHEN UTL_HTTP.end_of_body
   --         THEN
   --            UTL_HTTP.end_response (l_http_response);
   --      END;
   --
   --      x_content := xmltype (p_content);
   --      l_security_token :=
   --         x_content.EXTRACT (
   --            '/S:Envelope/S:Body/wst:RequestSecurityTokenResponse/wst:RequestedSecurityToken/wsse:BinarySecurityToken/text()',
   --            'xmlns:S="http://www.w3.org/2003/05/soap-envelope" xmlns:wst="http://schemas.xmlsoap.org/ws/2005/02/trust" xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"').getstringval ();
   --      --DBMS_OUTPUT.put_line (p_content);
   --      --DBMS_OUTPUT.put_line (l_security_token);
   --      DBMS_LOB.freetemporary (p_content);
   --      --RETURN;
   --
   --      l_http_request :=
   --         UTL_HTTP.BEGIN_REQUEST ('https://'                             --|| PANDAS_091_UPLOAD_TO_SHAREP.con_str_sharepoint_domain
   --                                           || p_domain || '.sharepoint.com/_forms/default.aspx?wa=wsignin1.0',
   --                                 PANDAS_091_UPLOAD_TO_SHAREP.const_sharepoint_service_meth,
   --                                 PANDAS_091_UPLOAD_TO_SHAREP.const_sharepoint_service_prot);
   --      --UTL_HTTP.set_cookie_support (l_http_request, TRUE);
   --      UTL_HTTP.SET_COOKIE_SUPPORT (TRUE, 300, 40);
   --      UTL_HTTP.set_persistent_conn_support (TRUE, 5);
   --      UTL_HTTP.set_header (l_http_request, 'Content-Length', LENGTH (l_security_token));
   --      UTL_HTTP.WRITE_TEXT (l_http_request, l_security_token);
   --      l_http_response := UTL_HTTP.GET_RESPONSE (l_http_request);
   --      DBMS_LOB.createtemporary (p_content, FALSE);
   --
   --      FOR i IN 1 .. UTL_HTTP.get_header_count (l_http_response)
   --      LOOP
   --         UTL_HTTP.get_header (l_http_response,
   --                              i,
   --                              h_name,
   --                              h_value);
   --
   --         IF INSTR (h_name, 'Set-Cookie') > 0
   --         THEN
   --            --DBMS_OUTPUT.put_line (i || '.' || h_name || ':' || h_value);
   --
   --            IF INSTR (h_value, 'FedAuth=') > 0
   --            THEN
   --               --DBMS_OUTPUT.put_line ('found cookie FedAuth');
   --               --DBMS_OUTPUT.put_line (i || '.' || h_name || ':' || h_value);
   --               FedAuth_cookie := (SUBSTR (h_value, 1, INSTR (h_value, '==;') + 1));
   --            END IF;
   --
   --            --END IF;
   --
   --            IF INSTR (h_value, 'rtFa=') > 0
   --            THEN
   --               --DBMS_OUTPUT.put_line ('found cookie rtFa');
   --               --DBMS_OUTPUT.put_line (i || '.' || h_name || ':' || h_value);
   --               rtFa_cookie := (SUBSTR (h_value, 1, INSTR (h_value, '==;') + 1));
   --            END IF;
   --         END IF;
   --      --
   --      --         IF INSTR (h_value, 'FedAuth=') > 0
   --      --         THEN
   --      --            --DBMS_OUTPUT.put_line (h_name || ':' || h_value);
   --      --            --DBMS_OUTPUT.put_line (h_name || ': ' || h_value);
   --      --            --p_FedAuth := REPLACE (h_value, ' path=/; secure; HttpOnly', '');
   --      --            FedAuth_cookie := (SUBSTR (h_value, 1, INSTR (h_value, '+;') + 0));
   --      --         --DBMS_OUTPUT.put_line (FedAuth_cookie);
   --      --         --FedAuth_cookie := REPLACE (FedAuth_cookie, 'FedAuth=', '') || ';';
   --      --         --         DBMS_OUTPUT.put_line (FedAuth_cookie);
   --      --         END IF;
   --
   --      --         IF INSTR (h_value, 'rtFa=') > 0
   --      --         THEN
   --      --            --DBMS_OUTPUT.put_line (h_name || ':' || h_value);
   --      --            --DBMS_OUTPUT.put_line (h_name || ': ' || h_value);
   --      --            --p_rtFa := REPLACE (h_value, ' domain=sharepoint.com; path=/; HttpOnly', '');
   --      --            --p_rtFa := REPLACE (h_value, 'rtFa=', '');
   --      --            rtFa_cookie := (SUBSTR (h_value, 1, INSTR (h_value, '==;') + 1));
   --      --         --DBMS_OUTPUT.put_line (rtFa_cookie);
   --      --         --rtFa_cookie := REPLACE (rtFa_cookie, 'rtFa=', '') || ';';
   --      --         END IF;
   --      END LOOP;
   --
   --      BEGIN
   --         LOOP
   --            UTL_HTTP.read_text (l_http_response, l_text, 32766);
   --            DBMS_LOB.writeappend (p_content, LENGTH (l_text), l_text);
   --         END LOOP;
   --      EXCEPTION
   --         WHEN UTL_HTTP.end_of_body
   --         THEN
   --            UTL_HTTP.end_response (l_http_response);
   --      END;
   --
   --      --DBMS_OUTPUT.put_line ('FedAuth_cookie:' || FedAuth_cookie);
   --      --DBMS_OUTPUT.put_line ('rtFa_cookie:' || rtFa_cookie);
   --
   --      --RETURN;
   --
   --      --DBMS_OUTPUT.put_line (p_content);
   --      DBMS_LOB.freetemporary (p_content);
   --      /*
   --         l_http_request := UTL_HTTP.BEGIN_REQUEST ('https://apisa365.sharepoint.com/pandas/_vti_bin/ListData.svc/Anuncios');
   --         --UTL_HTTP.set_cookie_support (l_http_request, TRUE);
   --         UTL_HTTP.set_header (l_http_request, 'Cookie', FedAuth_cookie||' '||rtFa_cookie);
   --         DBMS_OUTPUT.put_line (FedAuth_cookie||'; '||rtFa_cookie);
   --         UTL_HTTP.SET_HEADER(l_http_request, 'User-Agent', 'Mozilla/4.0');
   --         --DBMS_OUTPUT.put_line (rtFa_cookie);
   --         --UTL_HTTP.set_header (l_http_request, 'Cookie', rtFa_cookie);
   --         l_http_response := UTL_HTTP.GET_RESPONSE (l_http_request);
   --         DBMS_LOB.createtemporary (p_content, FALSE);
   --
   --         BEGIN
   --            LOOP
   --               UTL_HTTP.read_text (l_http_response, l_text, 32766);
   --               DBMS_LOB.writeappend (p_content, LENGTH (l_text), l_text);
   --            END LOOP;
   --         EXCEPTION
   --            WHEN UTL_HTTP.end_of_body
   --            THEN
   --               UTL_HTTP.end_response (l_http_response);
   --         END;
   --
   --         --   x_content := xmltype (p_content);
   --         DBMS_OUTPUT.put_line (DBMS_LOB.SUBSTR (p_content, 200, 1));
   --         DBMS_LOB.freetemporary (p_content);
   --      */
   --      l_http_request :=
   --         UTL_HTTP.BEGIN_REQUEST ('https://'                             --|| PANDAS_091_UPLOAD_TO_SHAREP.con_str_sharepoint_domain
   --                                           || p_domain || '.sharepoint.com/_vti_bin/ListData.svc/' || p_list,
   --                                 PANDAS_091_UPLOAD_TO_SHAREP.const_sharepoint_service_meth,
   --                                 PANDAS_091_UPLOAD_TO_SHAREP.const_sharepoint_service_prot);
   --      UTL_HTTP.set_header (l_http_request, 'Cookie', FedAuth_cookie || '; ' || rtFa_cookie);
   --      UTL_HTTP.SET_HEADER (l_http_request,
   --                           'User-Agent',
   --                           'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Win64; x64; Trident/5.0)');
   --      UTL_HTTP.set_header (l_http_request, 'Content-Length', LENGTH (p_payload));
   --      UTL_HTTP.set_header (l_http_request, 'content-type', p_mimetype || '; charset=' || 'iso-8859-1');
   --      UTL_HTTP.set_header (l_http_request,
   --                           'Slug',
   --                           '/SiteAssets/' || p_filename || TO_CHAR (SYSTIMESTAMP, 'yyyymmdd_hh24miss') || p_fileext);
   --      UTL_HTTP.WRITE_TEXT (l_http_request, p_payload);
   --      l_http_response := UTL_HTTP.GET_RESPONSE (l_http_request);
   --      DBMS_LOB.createtemporary (p_content, FALSE);
   --
   --      BEGIN
   --         LOOP
   --            UTL_HTTP.read_text (l_http_response, l_text, 32766);
   --            DBMS_LOB.writeappend (p_content, LENGTH (l_text), l_text);
   --         END LOOP;
   --      EXCEPTION
   --         WHEN UTL_HTTP.end_of_body
   --         THEN
   --            UTL_HTTP.end_response (l_http_response);
   --      END;
   --
   --      --   x_content := xmltype (p_content);
   --      RETURN (DBMS_LOB.SUBSTR (p_content, 2000, 1));
   --      --      DBMS_OUTPUT.put_line ('Response:' || p_content);
   --      DBMS_LOB.freetemporary (p_content);
   --   EXCEPTION
   --      WHEN OTHERS
   --      THEN
   --         RETURN (DBMS_UTILITY.format_error_backtrace);
   --   END;
   --   FUNCTION LISTDATA (listdata_url IN VARCHAR2, listdata_payload IN VARCHAR2, listdata_charset IN VARCHAR2 DEFAULT 'iso-8859-1')
   --      RETURN BOOLEAN
   --   IS
   --      l_ntlm_auth_str   VARCHAR2 (2000);
   --      l_http_request    UTL_HTTP.req;
   --      l_http_response   UTL_HTTP.resp;
   --      --      name              VARCHAR2 (256);
   --      --      VALUE             VARCHAR2 (256);
   --      p_content         CLOB;
   --      l_text            VARCHAR2 (32767);
   --   BEGIN
   --      l_ntlm_auth_str :=
   --         sys.ntlm_http_pkg.begin_request (listdata_url, const_sharepoint_server_ntus, const_sharepoint_server_ntpw);
   --      --      DBMS_OUTPUT.put_line ('Authorization=' || l_ntlm_auth_str);
   --      l_http_request := UTL_HTTP.BEGIN_REQUEST (listdata_url, const_sharepoint_service_meth, const_sharepoint_service_prot);
   --      UTL_HTTP.set_header (l_http_request, 'Authorization', l_ntlm_auth_str);
   --      --      UTL_HTTP.set_header (l_http_request, 'content-type', 'application/json; charset=utf-8');--charset=iso-8859-1
   --      UTL_HTTP.set_header (l_http_request, 'content-type', 'application/json; charset=' || listdata_charset);
   --      UTL_HTTP.set_header (l_http_request, 'Content-Length', LENGTH (listdata_payload));
   --      UTL_HTTP.WRITE_TEXT (l_http_request, listdata_payload);
   --      l_http_response := UTL_HTTP.GET_RESPONSE (l_http_request);
   --
   --      --      FOR i IN 1 .. UTL_HTTP.GET_HEADER_COUNT (l_http_response)
   --      --      LOOP
   --      --         UTL_HTTP.GET_HEADER (l_http_response,
   --      --                              i,
   --      --                              name,
   --      --                              VALUE);
   --      --         DBMS_OUTPUT.PUT_LINE (name || ': ' || VALUE);
   --      --      END LOOP;
   --
   --      DBMS_LOB.createtemporary (p_content, FALSE);
   --
   --      -- Copy the response into the CLOB.
   --      BEGIN
   --         LOOP
   --            UTL_HTTP.read_text (l_http_response, l_text, 32766);
   --            DBMS_LOB.writeappend (p_content, LENGTH (l_text), l_text);
   --         END LOOP;
   --      EXCEPTION
   --         WHEN UTL_HTTP.end_of_body
   --         THEN
   --            UTL_HTTP.end_response (l_http_response);
   --      END;
   --
   --      --DBMS_OUTPUT.put_line ('resp=' || p_content);
   --
   --      DBMS_LOB.freetemporary (p_content);
   --      --      DBMS_OUTPUT.put_line ('resp.status_code=' || l_http_response.status_code);
   --      sys.ntlm_http_pkg.end_request;
   --      RETURN TRUE;
   --   END;
   FUNCTION XRequestDigest (p_SharePointURL IN VARCHAR2 DEFAULT con_str_sharepoint_domain, p_charset IN VARCHAR2 DEFAULT 'utf-8')
      RETURN VARCHAR2
   IS
      l_ntlm_auth_str   VARCHAR2 (2000);
      l_http_request    UTL_HTTP.req;
      l_http_response   UTL_HTTP.resp;
      name              VARCHAR2 (256);
      VALUE             VARCHAR2 (256);
      p_content         CLOB;
      l_text            VARCHAR2 (32767);
      l_response_xml    XMLTYPE;
   BEGIN
      DBMS_SESSION.set_identifier ('MicroStrategy Pandas Connector');
      DBMS_APPLICATION_INFO.set_module ('SEND_TO_SHAREP', 'XRequestDigest');
      l_ntlm_auth_str :=
         sys.ntlm_http_pkg.begin_request (p_SharePointURL, const_sharepoint_server_ntus, const_sharepoint_server_ntpw);

      l_http_request := UTL_HTTP.BEGIN_REQUEST (p_SharePointURL, const_sharepoint_service_meth, const_sharepoint_service_prot);
      UTL_HTTP.set_header (l_http_request, 'Authorization', l_ntlm_auth_str);
      --      UTL_HTTP.set_header (l_http_request, 'content-type', 'application/json; charset=utf-8');--charset=iso-8859-1
      --  UTL_HTTP.set_header (l_http_request, 'content-type', 'application/json; charset=' || p_charset);
      -- UTL_HTTP.set_header (l_http_request, 'Content-Length', LENGTH (listdata_payload));
      UTL_HTTP.set_header (l_http_request, 'Content-Length', 0);
      --UTL_HTTP.WRITE_TEXT (l_http_request, listdata_payload);
      l_http_response := UTL_HTTP.GET_RESPONSE (l_http_request);

      --      FOR i IN 1 .. UTL_HTTP.GET_HEADER_COUNT (l_http_response)
      --      LOOP
      --         UTL_HTTP.GET_HEADER (l_http_response,
      --                              i,
      --                              name,
      --                              VALUE);
      --         DBMS_OUTPUT.PUT_LINE (name || ': ' || VALUE);
      --      END LOOP;

      DBMS_LOB.createtemporary (p_content, FALSE);

      -- Copy the response into the CLOB.
      BEGIN
         LOOP
            UTL_HTTP.read_text (l_http_response, l_text, 32766);
            DBMS_LOB.writeappend (p_content, LENGTH (l_text), l_text);
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            UTL_HTTP.end_response (l_http_response);
      END;

      --      DBMS_OUTPUT.put_line ('resp=' || p_content);
      l_response_xml := xmltype (p_content);

      DBMS_LOB.freetemporary (p_content);
      --DBMS_OUTPUT.put_line ('resp.status_code=' || l_http_response.status_code);
      sys.ntlm_http_pkg.end_request;

      DBMS_APPLICATION_INFO.set_module ('SEND_TO_SHAREP', NULL);
      --RETURN l_ntlm_auth_str;
      RETURN l_response_xml.EXTRACT ('/d:GetContextWebInformation/d:FormDigestValue/text()',
                                     'xmlns:d="http://schemas.microsoft.com/ado/2007/08/dataservices"').getstringval ();
   END;

   PROCEDURE TXT_FILE (p_SharePointSiteURL   IN VARCHAR2 DEFAULT con_str_sharepoint_domain,
                       p_charset             IN VARCHAR2 DEFAULT 'utf-8',
                       p_FolderName          IN VARCHAR2 DEFAULT 'Documentos compartidos',
                       p_FileName            IN VARCHAR2 DEFAULT 'TEST.txt',
                       p_FileContent         IN VARCHAR2 DEFAULT 'HELLO WORLD')
   IS
      l_ntlm_auth_str             VARCHAR2 (2000);
      l_ntlm_XRequestDigest_str   VARCHAR2 (2000);
      l_uploadURL                 VARCHAR2 (4000);
      l_http_request              UTL_HTTP.req;
      l_http_response             UTL_HTTP.resp;
      name                        VARCHAR2 (256);
      VALUE                       VARCHAR2 (256);
      p_content                   CLOB;
      l_text                      VARCHAR2 (32767);
   BEGIN
      DBMS_SESSION.set_identifier ('MicroStrategy Pandas Connector');
      DBMS_APPLICATION_INFO.set_module ('SEND_TO_SHAREP', 'XRequestDigest');
      --l_ntlm_XRequestDigest_str := XRequestDigest (p_SharePointSiteURL || '/_api/contextinfo', p_charset);
      --DBMS_OUTPUT.put_line ('l_ntlm_XRequestDigest_str=' || l_ntlm_XRequestDigest_str);

--      l_ntlm_auth_str :=
--         sys.ntlm_http_pkg.begin_request (p_SharePointSiteURL, const_sharepoint_server_ntus, const_sharepoint_server_ntpw);
--      DBMS_OUTPUT.put_line ('l_ntlm_auth_str=' || l_ntlm_auth_str);
      l_uploadURL := --            p_SharePointSiteURL
                     --         || '/_api/web/GetFolderByServerRelativeUrl(''/'
                     --         || p_FolderName
                     --         || ''')/Files/add(url='''
                     --         || p_FileName
                     --         || ''',overwrite=true)';

                     --'http://sp13pruebas.sas.junta-andalucia.es/_api/web/GetFolderByServerRelativeUrl(''/Documentos compartidos'')';
                     'http://sp13pruebas.sas.junta-andalucia.es/_api/web';
      DBMS_OUTPUT.put_line ('l_uploadURL=' || l_uploadURL);
      l_http_request := UTL_HTTP.BEGIN_REQUEST (l_uploadURL, const_sharepoint_service_meth, 'GET');
      --UTL_HTTP.set_header (l_http_request, 'Authorization', l_ntlm_auth_str);
      --UTL_HTTP.set_header (l_http_request, 'X-RequestDigest', l_ntlm_XRequestDigest_str);                     --charset=iso-8859-1
      --UTL_HTTP.set_header (l_http_request, 'content-type', 'application/json; charset=' || p_charset);
      --UTL_HTTP.set_header (l_http_request, 'Content-Length', LENGTH (p_FileContent));
      --UTL_HTTP.set_header (l_http_request, 'Content-Length', 0);
      --UTL_HTTP.WRITE_TEXT (l_http_request, p_FileContent);
      l_http_response := UTL_HTTP.GET_RESPONSE (l_http_request);

      FOR i IN 1 .. UTL_HTTP.GET_HEADER_COUNT (l_http_response)
      LOOP
         UTL_HTTP.GET_HEADER (l_http_response,
                              i,
                              name,
                              VALUE);
         DBMS_OUTPUT.PUT_LINE (name || ': ' || VALUE);
      END LOOP;

      DBMS_LOB.createtemporary (p_content, FALSE);

      -- Copy the response into the CLOB.
      BEGIN
         LOOP
            UTL_HTTP.read_text (l_http_response, l_text, 32766);
            DBMS_LOB.writeappend (p_content, LENGTH (l_text), l_text);
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            UTL_HTTP.end_response (l_http_response);
      END;

      DBMS_OUTPUT.put_line ('resp=' || p_content);
      --l_response_xml := xmltype (p_content);

      DBMS_LOB.freetemporary (p_content);


      sys.ntlm_http_pkg.end_request;
      DBMS_APPLICATION_INFO.set_module ('SEND_TO_SHAREP', NULL);
   END;
END;
/
