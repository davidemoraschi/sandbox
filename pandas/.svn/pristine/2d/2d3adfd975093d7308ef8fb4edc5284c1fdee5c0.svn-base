CREATE OR REPLACE PACKAGE BODY MSTR.pandas_080_lync
AS
   FUNCTION autodiscovery (p_domain IN VARCHAR2)
      RETURN VARCHAR2
   IS
      p_content   CLOB;
      l_text      VARCHAR2 (32767);
      obj         json;
      objxml      XMLTYPE;
      p_FedAuth   VARCHAR2 (4000);
   BEGIN
      UTL_HTTP.set_proxy (con_str_http_proxy);

      l_http_request := UTL_HTTP.BEGIN_REQUEST ('http://LyncDiscover.' || p_domain, 'GET', const_lync_service_prot);
      --UTL_HTTP.set_header (l_http_request, 'Authorization', l_ntlm_auth_str);
      --      UTL_HTTP.set_header (l_http_request, 'content-type', 'application/json; charset=utf-8');--charset=iso-8859-1
      --UTL_HTTP.set_header (l_http_request, 'content-type', 'application/json; charset=' || listdata_charset);
      --UTL_HTTP.set_header (l_http_request, 'Content-Length', LENGTH (listdata_payload));
      --UTL_HTTP.WRITE_TEXT (l_http_request, listdata_payload);
      l_http_response := UTL_HTTP.GET_RESPONSE (l_http_request);
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

      --DBMS_OUTPUT.put_line (p_content);
      --RETURN p_content;
      --report_len  := length(report_clob);
      --report      := TO_CHAR(dbms_lob.substr(report_clob, report_len, 1 ));
      obj := json (TO_CHAR (DBMS_LOB.SUBSTR (p_content, LENGTH (p_content), 4)));
      --obj.print;
      --dbms_output.put_line(json_ext.get_string(obj, '_links'));
      objxml := json_xml.json_to_xml (obj);

      DBMS_LOB.freetemporary (p_content);
      l_user_href := (REPLACE (objxml.EXTRACT ('/root/_links/user/href/text()').getstringval (), '&quot;', ''));
      l_xframe_href := (REPLACE (objxml.EXTRACT ('/root/_links/xframe/href/text()').getstringval (), '&quot;', ''));
      --return l_user_href;
      --DBMS_OUTPUT.put_line ('l_xframe_hrefe=' || l_xframe_href);

      UTL_HTTP.set_wallet (PATH => con_str_wallet_path, PASSWORD => con_str_wallet_pass);

      l_http_request := UTL_HTTP.BEGIN_REQUEST (l_user_href, 'GET', const_lync_service_prot);

      UTL_HTTP.set_header (l_http_request, 'Referer', l_xframe_href);
      --      UTL_HTTP.set_header (l_http_request, 'content-type', 'application/json; charset=utf-8');--charset=iso-8859-1
      --UTL_HTTP.set_header (l_http_request, 'content-type', 'application/json; charset=' || listdata_charset);
      --UTL_HTTP.set_header (l_http_request, 'Content-Length', LENGTH (listdata_payload));
      --UTL_HTTP.WRITE_TEXT (l_http_request, listdata_payload);
      l_http_response := UTL_HTTP.GET_RESPONSE (l_http_request);
      DBMS_LOB.createtemporary (p_content, FALSE);

      FOR i IN 1 .. UTL_HTTP.get_header_count (l_http_response)
      LOOP
         UTL_HTTP.get_header (l_http_response,
                              i,
                              h_name,
                              h_value);

         --DBMS_OUTPUT.put_line (h_name || ': ' || h_value);
         IF INSTR (h_value, 'MsRtcOAuth') > 0
         THEN
            --DBMS_OUTPUT.put_line (h_name || ': ' || h_value);
            p_FedAuth := REPLACE (h_value, 'MsRtcOAuth href="', '');
            p_FedAuth := REPLACE (p_FedAuth, '"', '');
            p_FedAuth := SUBSTR (p_FedAuth, 1, INSTR (p_FedAuth, ',') - 1);
         END IF;
      END LOOP;

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

      --dbms_output.put_line (p_content);
      RETURN p_FedAuth;
      DBMS_LOB.freetemporary (p_content);
   -- return (REPLACE (objxml.extract('/root/_links/user/href/text()').getstringval(),'&quot;',''));
   END;

   FUNCTION autodiscovery_internal (p_domain IN VARCHAR2)
      RETURN VARCHAR2
   IS
      p_content       CLOB;
      l_text          VARCHAR2 (32767);
      obj             json;
      objxml          XMLTYPE;
      l_user_href     VARCHAR2 (32767);
      l_xframe_href   VARCHAR2 (32767);
      h_name          VARCHAR2 (255);
      h_value         VARCHAR2 (1023);
      p_FedAuth       VARCHAR2 (4000);
   BEGIN
      UTL_HTTP.set_proxy (con_str_http_proxy);

      l_http_request := UTL_HTTP.BEGIN_REQUEST ('http://LyncDiscoverInternal.' || p_domain, 'GET', const_lync_service_prot);
      --UTL_HTTP.set_header (l_http_request, 'Authorization', l_ntlm_auth_str);
      --      UTL_HTTP.set_header (l_http_request, 'content-type', 'application/json; charset=utf-8');--charset=iso-8859-1
      --UTL_HTTP.set_header (l_http_request, 'content-type', 'application/json; charset=' || listdata_charset);
      --UTL_HTTP.set_header (l_http_request, 'Content-Length', LENGTH (listdata_payload));
      --UTL_HTTP.WRITE_TEXT (l_http_request, listdata_payload);
      l_http_response := UTL_HTTP.GET_RESPONSE (l_http_request);
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

      --DBMS_OUTPUT.put_line (p_content);
      RETURN p_content;
      --report_len  := length(report_clob);
      --report      := TO_CHAR(dbms_lob.substr(report_clob, report_len, 1 ));
      obj := json (TO_CHAR (DBMS_LOB.SUBSTR (p_content, LENGTH (p_content), 4)));
      --obj.print;
      --dbms_output.put_line(json_ext.get_string(obj, '_links'));
      objxml := json_xml.json_to_xml (obj);

      DBMS_LOB.freetemporary (p_content);
      l_user_href := (REPLACE (objxml.EXTRACT ('/root/_links/user/href/text()').getstringval (), '&quot;', ''));
      l_xframe_href := (REPLACE (objxml.EXTRACT ('/root/_links/xframe/href/text()').getstringval (), '&quot;', ''));
      --return l_user_href;
      DBMS_OUTPUT.put_line ('l_xframe_hrefe=' || l_xframe_href);

      UTL_HTTP.set_wallet (PATH => con_str_wallet_path, PASSWORD => con_str_wallet_pass);

      l_http_request := UTL_HTTP.BEGIN_REQUEST (l_user_href, 'GET', const_lync_service_prot);

      UTL_HTTP.set_header (l_http_request, 'Referer', l_xframe_href);
      --      UTL_HTTP.set_header (l_http_request, 'content-type', 'application/json; charset=utf-8');--charset=iso-8859-1
      --UTL_HTTP.set_header (l_http_request, 'content-type', 'application/json; charset=' || listdata_charset);
      --UTL_HTTP.set_header (l_http_request, 'Content-Length', LENGTH (listdata_payload));
      --UTL_HTTP.WRITE_TEXT (l_http_request, listdata_payload);
      l_http_response := UTL_HTTP.GET_RESPONSE (l_http_request);
      DBMS_LOB.createtemporary (p_content, FALSE);

      FOR i IN 1 .. UTL_HTTP.get_header_count (l_http_response)
      LOOP
         UTL_HTTP.get_header (l_http_response,
                              i,
                              h_name,
                              h_value);

         --DBMS_OUTPUT.put_line (h_name || ': ' || h_value);
         IF INSTR (h_value, 'MsRtcOAuth') > 0
         THEN
            DBMS_OUTPUT.put_line (h_name || ': ' || h_value);
            p_FedAuth := REPLACE (h_value, 'MsRtcOAuth href="', '');
            p_FedAuth := REPLACE (p_FedAuth, '"', '');
         END IF;
      END LOOP;

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

      --dbms_output.put_line (p_content);
      RETURN p_FedAuth;
      DBMS_LOB.freetemporary (p_content);
   -- return (REPLACE (objxml.extract('/root/_links/user/href/text()').getstringval(),'&quot;',''));
   END;

   FUNCTION authentication (p_MsRtcOAuth IN VARCHAR2)
      RETURN VARCHAR2
   IS
      listdata_payload   VARCHAR2 (32767)
         := 'grant_type=urn:microsoft.rtc:anonmeeting&password=9WN6F08G&ms_rtc_conferenceuri=sip:davide@apisa365.onmicrosoft.com;gruu;opaque=app:conf:focus:id:9WN6F08G';
      p_content          CLOB;
      l_text             VARCHAR2 (32767);
      obj                json;
      objxml             XMLTYPE;
   BEGIN
      UTL_HTTP.set_proxy (con_str_http_proxy);

      l_http_request := UTL_HTTP.BEGIN_REQUEST (p_MsRtcOAuth, 'POST', const_lync_service_prot);
      --UTL_HTTP.set_header (l_http_request, 'Authorization', l_ntlm_auth_str);
      --      UTL_HTTP.set_header (l_http_request, 'content-type', 'application/json; charset=utf-8');--charset=iso-8859-1
      UTL_HTTP.set_header (l_http_request, 'Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8');
      UTL_HTTP.set_header (l_http_request, 'Content-Length', LENGTH (listdata_payload));
      UTL_HTTP.WRITE_TEXT (l_http_request, listdata_payload);
      l_http_response := UTL_HTTP.GET_RESPONSE (l_http_request);
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

      --DBMS_OUTPUT.put_line (p_content);
      --RETURN p_content;
      --report_len  := length(report_clob);
      --report      := TO_CHAR(dbms_lob.substr(report_clob, report_len, 1 ));
      obj := json (TO_CHAR (DBMS_LOB.SUBSTR (p_content, LENGTH (p_content), 1)));
      obj.print;
      objxml := json_xml.json_to_xml (obj);
      dbms_output.put_line(objxml.extract('/').getstringval());

      DBMS_LOB.freetemporary (p_content);
      l_user_OAuth_token := REPLACE (objxml.EXTRACT ('/root/access_token/text()').getstringval (), '&quot;', '');
      DBMS_OUTPUT.put_line (l_user_OAuth_token);
      UTL_HTTP.set_wallet (PATH => con_str_wallet_path, PASSWORD => con_str_wallet_pass);
      l_http_request := UTL_HTTP.BEGIN_REQUEST (l_user_href, 'GET', const_lync_service_prot);
      --      UTL_HTTP.set_header (l_http_request, 'Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8');
      UTL_HTTP.set_header (l_http_request, 'Referer', l_xframe_href);
      --Authorization: Bearer cwt=AAEB...buHc
      UTL_HTTP.set_header (l_http_request, 'Authorization', 'Bearer ' || l_user_OAuth_token);
      DBMS_OUTPUT.put_line (l_user_href);
      DBMS_OUTPUT.put_line (l_user_OAuth_token);
      DBMS_OUTPUT.put_line (l_xframe_href);

      --      UTL_HTTP.set_header (l_http_request, 'content-type', 'application/json; charset=utf-8');--charset=iso-8859-1
      --UTL_HTTP.set_header (l_http_request, 'Content-Type', 'application/x-www-form-urlencoded;charset=UTF-8');
      --UTL_HTTP.set_header (l_http_request, 'Content-Length', LENGTH (listdata_payload));
      --UTL_HTTP.WRITE_TEXT (l_http_request, listdata_payload);
      l_http_response := UTL_HTTP.GET_RESPONSE (l_http_request);
      DBMS_LOB.createtemporary (p_content, FALSE);

      FOR i IN 1 .. UTL_HTTP.get_header_count (l_http_response)
      LOOP
         UTL_HTTP.get_header (l_http_response,
                              i,
                              h_name,
                              h_value);

         DBMS_OUTPUT.put_line (h_name || ': ' || h_value);
      --         IF INSTR (h_value, 'MsRtcOAuth') > 0
      --         THEN
      --            --DBMS_OUTPUT.put_line (h_name || ': ' || h_value);
      --            p_FedAuth := REPLACE (h_value, 'MsRtcOAuth href="', '');
      --            p_FedAuth := REPLACE (p_FedAuth, '"', '');
      --            p_FedAuth := SUBSTR (p_FedAuth, 1, INSTR (p_FedAuth, ',') - 1);
      --         END IF;
      END LOOP;

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

      DBMS_OUTPUT.put_line (p_content);
      --report_len  := length(report_clob);
      --report      := TO_CHAR(dbms_lob.substr(report_clob, report_len, 1 ));
      --obj := json (TO_CHAR (DBMS_LOB.SUBSTR (p_content, LENGTH (p_content), 1)));
      --obj.print;
      --objxml := json_xml.json_to_xml (obj);
      --dbms_output.put_line(objxml.extract('/').getstringval());

      RETURN p_content;
      DBMS_LOB.freetemporary (p_content);
   --RETURN REPLACE (objxml.EXTRACT ('/root/access_token/text()').getstringval (), '&quot;', '');
   END;
END;
/
