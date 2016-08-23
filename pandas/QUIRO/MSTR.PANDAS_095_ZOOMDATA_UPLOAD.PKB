CREATE OR REPLACE PACKAGE BODY MSTR.PANDAS_095_ZOOMDATA_UPLOAD
AS
   PROCEDURE SEND_JSON (zoomdata_payload IN VARCHAR2)
   IS
      v_inicio_ts           DATE;
      v_fin_ts              DATE;
      v_elapsed             NUMBER;
      v_last_refresh        DATE;
      v_area_hospitalaria   VARCHAR2 (10);
      l_http_request        UTL_HTTP.req;
      l_http_response       UTL_HTTP.resp;
      p_content             CLOB;
      l_text                VARCHAR2 (32767);
      name                  VARCHAR2 (256);
      VALUE                 VARCHAR2 (256);
   BEGIN
      v_inicio_ts := SYSDATE;

      --SELECT NATID_AREA_HOSPITALARIA INTO v_area_hospitalaria FROM MSTR_UTL_CODIGOS;

      -- Set up proxy servers if required
      --UTL_HTTP.set_proxy (PANDAS_093_TWIT.con_str_http_proxy);
      l_http_request := UTL_HTTP.BEGIN_REQUEST (url => const_zoomdata_service_host, method => 'POST');
      UTL_HTTP.SET_AUTHENTICATION (r          => l_http_request,
                                   username   => const_zoomdata_service_user,
                                   password   => const_zoomdata_service_pass);                    -- Use HTTP Basic Authen. Scheme
      UTL_HTTP.set_header (l_http_request, 'content-type', 'application/json; charset=ISO-8859-1');
      UTL_HTTP.set_header (l_http_request, 'Content-Length', LENGTH (zoomdata_payload));
      UTL_HTTP.WRITE_TEXT (l_http_request, zoomdata_payload);
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

      DBMS_LOB.freetemporary (p_content);
      DBMS_OUTPUT.put_line ('resp.status_code=' || l_http_response.status_code);
   --DBMS_SNAPSHOT.REFRESH ('MSTR_UTL_LAST_REFRESH', 'C');

   --DBMS_STATS.gather_table_stats ('PILOTOBI', 'MSTR_UTL_LAST_REFRESH');
   --COMMIT;
   /*
   --     SELECT MAX (LAST_REFRESH_DATE) INTO v_last_refresh FROM MSTR_DET_CAMAS_DEL_DIA;

        v_fin_ts := SYSDATE;
        v_elapsed := (v_fin_ts - v_inicio_ts) * 24 * 60;
        MSTR.PANDAS_090_POST_TO_SHAREP_v3.RETRY_N_TIMES (
           3,
           '{ Title: "Carga Censo de Camas", Content: "'
           || '<table border=''1'' cellpadding=''3''><tr><td bgcolor=''#CEA539''>Última Ejecución</td><td bgcolor=''#CEA539''>Duración (min.)</td><td bgcolor=''#CEA539''>Fecha Replica</td></tr><tr><td bgcolor=''#232325''>'
           || TO_CHAR (SYSDATE, 'dd-mon hh24:mi')
           || '</td><td>'
           || ROUND (v_elapsed, 2)
           || '</td><td>'
           || TO_CHAR (v_last_refresh, 'dd-mon hh24:mi')
           || '</td></tr></table> '
           || '", Result: "SUCCESS"  }');
        MSTR.PANDAS_093_TWIT.POST_STATUS (
           TO_CHAR (SYSDATE, 'hh24"h"mi') || '+' || v_area_hospitalaria || '+Carga+Censo+de+Camas+completada+#ProyectoPandas',
           'PANDAS_HOSPI');
     EXCEPTION
        WHEN OTHERS
        THEN
           BEGIN
              MSTR.PANDAS_093_TWIT.POST_STATUS (
                    'Camas+'
                 || TO_CHAR (SYSDATE, 'hh24"h"mi')
                 || '+'
                 || v_area_hospitalaria
                 || '+'
                 || SUBSTR (REPLACE (REPLACE (REPLACE (SQLERRM, ' ', '+'), ',', ''), CHR (10), '+'), 1, 90)
                 || '...#ProyectoPandas',
                 'PANDAS_ERROR');
           END;

           RAISE;
           */
   END SEND_JSON;
END;
/
