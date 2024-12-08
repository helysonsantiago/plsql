CREATE OR REPLACE PACKAGE BODY pkg_professor IS
    PROCEDURE total_turmas_professor IS
        CURSOR c_professores IS
            SELECT p.NOME, COUNT(t.ID_TURMA) AS TOTAL_TURMAS
            FROM PROFESSORES p
            JOIN TURMAS t ON p.ID_PROFESSOR = t.ID_PROFESSOR
            GROUP BY p.NOME
            HAVING COUNT(t.ID_TURMA) > 1;
    BEGIN
        FOR r IN c_professores LOOP
            DBMS_OUTPUT.PUT_LINE('Professor: ' || r.NOME || ', Total de Turmas: ' || r.TOTAL_TURMAS);
        END LOOP;
    END total_turmas_professor;

    FUNCTION total_turmas_func(p_id_professor IN NUMBER) RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_total
        FROM TURMAS
        WHERE ID_PROFESSOR = p_id_professor;
        RETURN v_total;
    END total_turmas_func;

    FUNCTION professor_disciplina_func(p_id_disciplina IN NUMBER) RETURN VARCHAR2 IS
        v_nome_professor VARCHAR2(100);
    BEGIN
        SELECT p.NOME
        INTO v_nome_professor
        FROM PROFESSORES p
        JOIN TURMAS t ON p.ID_PROFESSOR = t.ID_PROFESSOR
        WHERE t.ID_DISCIPLINA = p_id_disciplina;
        RETURN v_nome_professor;
    END professor_disciplina_func;
END pkg_professor;
/
