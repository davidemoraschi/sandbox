CREATE OR REPLACE PACKAGE BODY MSTR_SIGLO.PANDAS_090_POST_TO_SHAREPOINT 
AS
	FUNCTION LISTDATA (listdata_url IN VARCHAR2, listdata_payload IN VARCHAR2, listdata_charset IN VARCHAR2 DEFAULT 'iso-8859-1')
		RETURN BOOLEAN IS
		l_ntlm_auth_str VARCHAR2 (2000);
		l_http_request UTL_HTTP.req;
		l_http_response UTL_HTTP.resp;
		name VARCHAR2 (256);
		VALUE VARCHAR2 (256);
		p_content CLOB;
		l_text VARCHAR2 (32767);
	BEGIN
		l_ntlm_auth_str := sys.ntlm_http_pkg.begin_request (listdata_url, const_sharepoint_server_ntus, const_sharepoint_server_ntpw);
		--	 DBMS_OUTPUT.put_line ('Authorization=' || l_ntlm_auth_str);
		l_http_request := UTL_HTTP.BEGIN_REQUEST (listdata_url, const_sharepoint_service_meth, const_sharepoint_service_prot);
		UTL_HTTP.set_header (l_http_request, 'Authorization', l_ntlm_auth_str);
		--	 UTL_HTTP.set_header (l_http_request, 'content-type', 'application/json; charset=utf-8');--charset=iso-8859-1
		UTL_HTTP.set_header (l_http_request, 'content-type', 'application/json; charset=' || listdata_charset);
		UTL_HTTP.set_header (l_http_request, 'Content-Length', LENGTH (listdata_payload));
		UTL_HTTP.WRITE_TEXT (l_http_request, listdata_payload);
		l_http_response := UTL_HTTP.GET_RESPONSE (l_http_request);

		FOR i IN 1 .. UTL_HTTP.GET_HEADER_COUNT (l_http_response) LOOP
			UTL_HTTP.GET_HEADER (l_http_response
													,i
													,name
													,VALUE);
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
			WHEN UTL_HTTP.end_of_body THEN
				UTL_HTTP.end_response (l_http_response);
		END;

		DBMS_OUTPUT.put_line ('resp=' || p_content);

		DBMS_LOB.freetemporary (p_content);
		DBMS_OUTPUT.put_line ('resp.status_code=' || l_http_response.status_code);
		sys.ntlm_http_pkg.end_request;
		RETURN TRUE;
	END;
END;
/
