CREATE OR REPLACE PACKAGE BODY MSTR.PANDAS_093_TWIT
AS
   PROCEDURE POST_STATUS (p_status IN VARCHAR2 DEFAULT 'ok', p_account IN VARCHAR2 DEFAULT NULL)
   --RETURN VARCHAR2
   IS
      l_text            VARCHAR2 (32767);
      p_content         CLOB;
      --      l_payload         VARCHAR2 (32767) --      := 'From=%2B34518880448&To=%2B34690063666&Url=https://proyectopandas.sharepoint.com/_layouts/15/guestaccess.aspx?guestaccesstoken=3v0aMSSZ4g1mO0uQXw%2bmEqDiumftiWDxU7zU3JucoRo%3d&docid=167344f0290d64b87b23cb4a307691986';
      --                                        := 'From=%2B34518880448&To=%2B34' || p_phonenumber || '&Url=http://db.tt/EKIjLcWd'; --http://dl.dropbox.com/u/992968/TwiML/004_test.xml';
      --      --||utl_url.escape('https://proyectopandas.sharepoint.com/_layouts/15/guestaccess.aspx?guestaccesstoken=3v0aMSSZ4g1mO0uQXw%2bmEqDiumftiWDxU7zU3JucoRo%3d&docid=167344f0290d64b87b23cb4a307691986');
      --      --||'https://dl.dropboxusercontent.com/u/35291135/call.xml';
      l_http_request    UTL_HTTP.req;
      l_http_response   UTL_HTTP.resp;
   BEGIN
      UTL_HTTP.set_proxy (PANDAS_093_TWIT.con_str_http_proxy);
      UTL_HTTP.set_wallet (PATH => PANDAS_093_TWIT.con_str_wallet_path, PASSWORD => PANDAS_093_TWIT.con_str_wallet_pass);
      DBMS_OUTPUT.put_line (
         'http://eurostrategy.net:8081/twitter/status_update.jsp?twitter_account=' || p_account || '&twitter_status=' || p_status);
      l_http_request :=
         UTL_HTTP.BEGIN_REQUEST (
               'http://eurostrategy.net:8081/twitter/status_update.jsp?twitter_account='
            || p_account
            || '&twitter_status='
            || p_status,
            'GET',
            PANDAS_093_TWIT.const_sharepoint_service_prot);
      l_http_response := UTL_HTTP.GET_RESPONSE (l_http_request);
      DBMS_LOB.createtemporary (p_content, FALSE);

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

      --   x_content := xmltype (p_content);
      --   l_security_token :=
      --      x_content.EXTRACT (
      --         '/S:Envelope/S:Body/wst:RequestSecurityTokenResponse/wst:RequestedSecurityToken/wsse:BinarySecurityToken/text()',
      --         'xmlns:S="http://www.w3.org/2003/05/soap-envelope" xmlns:wst="http://schemas.xmlsoap.org/ws/2005/02/trust" xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"').getstringval ();
      DBMS_OUTPUT.put_line (p_content);
      --   --DBMS_OUTPUT.put_line (l_security_token);
      DBMS_LOB.freetemporary (p_content);
   --RETURN;
   END;
END;
/
