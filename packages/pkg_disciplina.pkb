CREATE OR REPLACE PACKAGE BODY pkg_disciplina IS
    PROCEDURE cadastrar_disciplina(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER) IS
    BEGIN
        INSERT INTO DISCIPLINAS (ID_DISCIPLINA, NOME, DESCRICAO, CARGA_HORARIA)
        VALUES (SEQ_DISCIPLINA_ID.NEXTVAL, p_nome, p_descricao, p_carga_horaria);
    END cadastrar_disciplina;

    PROCEDURE total_alunos_disciplina IS
        CURSOR c_total IS
            SELECT d.NOME, COUNT(m.ID_ALUNO) AS TOTAL_ALUNOS
            FROM DISCIPLINAS d
            JOIN MATRICULAS m ON d.ID_DISCIPLINA = m.ID_DISCIPLINA
            GROUP BY d.NOME
            HAVING COUNT(m.ID_ALUNO) > 10;
    BEGIN
        FOR r IN c_total LOOP
            DBMS_OUTPUT.PUT_LINE('Disciplina: ' || r.NOME || ', Total de Alunos: ' || r.TOTAL_ALUNOS);
        END LOOP;
    END total_alunos_disciplina;

   FUNCTION media_idade_disciplina(p_id_disciplina IN NUMBER) RETURN NUMBER IS
        v_media_idade NUMBER;
    BEGIN
        SELECT AVG(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM a.DATA_NASCIMENTO)) AS MEDIA_IDADE
        INTO v_media_idade
        FROM ALUNOS a
        JOIN MATRICULAS m ON a.ID_ALUNO = m.ID_ALUNO
        WHERE m.ID_DISCIPLINA = p_id_disciplina;
        
        RETURN v_media_idade;
    END media_idade_disciplina;


    PROCEDURE listar_alunos_disciplina(p_id_disciplina IN NUMBER) IS
        CURSOR c_alunos IS
            SELECT a.NOME
            FROM ALUNOS a
            JOIN MATRICULAS m ON a.ID_ALUNO = m.ID_ALUNO
            WHERE m.ID_DISCIPLINA = p_id_disciplina;
    BEGIN
        FOR r IN c_alunos LOOP
            DBMS_OUTPUT.PUT_LINE('Aluno: ' || r.NOME);
        END LOOP;
    END listar_alunos_disciplina;
END pkg_disciplina;
/
