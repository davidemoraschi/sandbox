CREATE OR REPLACE PACKAGE MSTR_SIGLO.ETL_LOAD_CENTROCONSUMO AS
	/******************************************************************************
	 NAME: ETL_LOAD_INFHOS
	 PURPOSE:

	 REVISIONS:
	 Ver Date Author Description
	 --------- ---------- --------------- ------------------------------------
	 1.0 9/17/2012 Davide 1. Created this package.
	******************************************************************************/
	const_sharepoint_listdata_url CONSTANT VARCHAR2 (1024) := 'http://pandas.sas.junta-andalucia.es/siglo/_vti_bin/ListData.svc/PANDAS_ETL';

	PROCEDURE P_001 (Param1 IN NUMBER DEFAULT NULL);

	PROCEDURE P_N0;

	PROCEDURE P_N1;
-- PROCEDURE P_N2;
-- PROCEDURE P_N3;

-- PROCEDURE P_N4;

-- PROCEDURE P_N5;
--
-- PROCEDURE P_N6;
--
-- PROCEDURE P_N7;
--
-- PROCEDURE P_N8;
--
-- PROCEDURE P_N9;
--
-- PROCEDURE P_NA;
--
-- PROCEDURE P_NB;
--
-- PROCEDURE P_NC;
--
-- PROCEDURE P_NZ;
/* PROCEDURE U_001 (Param1 IN VARCHAR2 DEFAULT NULL, Param2 IN VARCHAR2 DEFAULT NULL);*/
END;
/
