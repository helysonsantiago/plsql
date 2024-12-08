CREATE OR REPLACE PACKAGE BODY pkg_aluno IS
    PROCEDURE excluir_aluno(p_id_aluno IN NUMBER) IS
    BEGIN
        DELETE FROM MATRICULAS WHERE ID_ALUNO = p_id_aluno;
        DELETE FROM ALUNOS WHERE ID_ALUNO = p_id_aluno;
    END excluir_aluno;

    PROCEDURE listar_alunos_maiores_de_18 IS
        CURSOR c_alunos IS
            SELECT NOME, DATA_NASCIMENTO
            FROM ALUNOS
            WHERE (SYSDATE - DATA_NASCIMENTO) / 365 > 18;
    BEGIN
        FOR r IN c_alunos LOOP
            DBMS_OUTPUT.PUT_LINE('Nome: ' || r.NOME || ', Data de Nascimento: ' || r.DATA_NASCIMENTO);
        END LOOP;
    END listar_alunos_maiores_de_18;

    PROCEDURE listar_alunos_por_curso(p_id_curso IN NUMBER) IS
        CURSOR c_curso IS
            SELECT NOME
            FROM ALUNOS
            WHERE ID_CURSO = p_id_curso;
    BEGIN
        FOR r IN c_curso LOOP
            DBMS_OUTPUT.PUT_LINE('Nome: ' || r.NOME);
        END LOOP;
    END listar_alunos_por_curso;
END pkg_aluno;
/
