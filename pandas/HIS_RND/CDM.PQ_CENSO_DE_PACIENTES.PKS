CREATE OR REPLACE PACKAGE CDM.pq_censo_de_pacientes
IS
   PROCEDURE corte_nocturno;

   PROCEDURE corte_a_las_0800AM;

   PROCEDURE corte_a_las_1800PM;

   PROCEDURE preingresos_corte_nocturno;

   PROCEDURE preingresos_corte_a_las_0800AM;

   PROCEDURE seguimiento_de_urgencias;

   PROCEDURE check_censo_de_pacientes;

   PROCEDURE check_censo_a_las_0800AM;

   PROCEDURE check_censo_a_las_1800PM;

   PROCEDURE check_preingresos;

   PROCEDURE check_preingreso_a_las_0800AM;

   PROCEDURE error_handler_twit_me_baby ( p_SQLERRM IN VARCHAR2, p_error_backtrace IN VARCHAR2, p_nombre_carga IN VARCHAR2);
END pq_censo_de_pacientes;
/
