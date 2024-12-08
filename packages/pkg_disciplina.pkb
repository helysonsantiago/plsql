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

    PROCEDURE media_idade_disciplina(p_id_disciplina IN NUMBER) IS
        CURSOR c_media IS
            SELECT AVG((SYSDATE - a.DATA_NASCIMENTO) / 365) AS MEDIA_IDADE
            FROM ALUNOS a
            JOIN MATRICULAS m ON a.ID_ALUNO = m.ID_ALUNO
            WHERE m.ID_DISCIPLINA = p_id_disciplina;
        v_media_idade NUMBER;
    BEGIN
        OPEN c_media;
        FETCH c_media INTO v_media_idade;
        CLOSE c_media;
        DBMS_OUTPUT.PUT_LINE('Média de Idade: ' || v_media_idade);
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
