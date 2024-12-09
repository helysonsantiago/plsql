CREATE OR REPLACE PACKAGE pkg_professor IS
    PROCEDURE total_turmas_professor;
    FUNCTION total_turmas_func(p_id_professor IN NUMBER) RETURN NUMBER;
    FUNCTION professor_disciplina_func(p_id_disciplina IN NUMBER) RETURN VARCHAR2;
END pkg_professor;
/
