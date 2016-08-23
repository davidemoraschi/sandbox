CREATE OR REPLACE PACKAGE CDM.pq_censo_de_camas
IS
   PROCEDURE corte_nocturno;

   PROCEDURE corte_a_las_0800AM;

   PROCEDURE corte_a_las_1800PM;

   PROCEDURE media_mensual;

   PROCEDURE check_censo_de_camas;

   PROCEDURE check_censo_a_las_0800AM;

   PROCEDURE check_censo_a_las_1800PM;
END pq_censo_de_camas;
/
