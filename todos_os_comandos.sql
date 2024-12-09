CREATE TABLE ALUNOS (
    ID_ALUNO NUMBER PRIMARY KEY,
    NOME VARCHAR2(100),
    DATA_NASCIMENTO DATE,
    ID_CURSO NUMBER
);

CREATE TABLE DISCIPLINAS (
    ID_DISCIPLINA NUMBER PRIMARY KEY,
    NOME VARCHAR2(100),
    DESCRICAO VARCHAR2(200),
    CARGA_HORARIA NUMBER
);

CREATE TABLE MATRICULAS (
    ID_MATRICULA NUMBER PRIMARY KEY,
    ID_ALUNO NUMBER,
    ID_DISCIPLINA NUMBER,
    FOREIGN KEY (ID_ALUNO) REFERENCES ALUNOS(ID_ALUNO),
    FOREIGN KEY (ID_DISCIPLINA) REFERENCES DISCIPLINAS(ID_DISCIPLINA)
);

CREATE TABLE PROFESSORES (
    ID_PROFESSOR NUMBER PRIMARY KEY,
    NOME VARCHAR2(100)
);

CREATE TABLE TURMAS (
    ID_TURMA NUMBER PRIMARY KEY,
    ID_DISCIPLINA NUMBER,
    ID_PROFESSOR NUMBER,
    FOREIGN KEY (ID_DISCIPLINA) REFERENCES DISCIPLINAS(ID_DISCIPLINA),
    FOREIGN KEY (ID_PROFESSOR) REFERENCES PROFESSORES(ID_PROFESSOR)
);



INSERT INTO ALUNOS VALUES (1, 'Maria Silva', TO_DATE('2000-05-15', 'YYYY-MM-DD'), 101);
INSERT INTO ALUNOS VALUES (2, 'João Souza', TO_DATE('2010-06-20', 'YYYY-MM-DD'), 102);

INSERT INTO DISCIPLINAS VALUES (1, 'Matemática', 'Curso de Matemática Básica', 40);

INSERT INTO MATRICULAS VALUES (1, 1, 1);
INSERT INTO MATRICULAS VALUES (2, 2, 1);

INSERT INTO PROFESSORES VALUES (1, 'Carlos Almeida');
INSERT INTO TURMAS VALUES (1, 1, 1);

COMMIT;



CREATE SEQUENCE SEQ_ALUNO_ID
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;


CREATE SEQUENCE SEQ_DISCIPLINA_ID
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;


CREATE SEQUENCE SEQ_PROFESSOR_ID
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;


CREATE OR REPLACE PACKAGE pkg_aluno IS
    PROCEDURE excluir_aluno(p_id_aluno IN NUMBER);
    PROCEDURE listar_alunos_maiores_de_18;
    PROCEDURE listar_alunos_por_curso(p_id_curso IN NUMBER);
END pkg_aluno;
/


CREATE OR REPLACE PACKAGE pkg_disciplina IS
    PROCEDURE cadastrar_disciplina(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER);
    PROCEDURE total_alunos_disciplina;
    FUNCTION media_idade_disciplina(p_id_disciplina IN NUMBER) RETURN NUMBER;
    PROCEDURE listar_alunos_disciplina(p_id_disciplina IN NUMBER);
END pkg_disciplina;
/


CREATE OR REPLACE PACKAGE pkg_professor IS
    PROCEDURE total_turmas_professor;
    FUNCTION total_turmas_func(p_id_professor IN NUMBER) RETURN NUMBER;
    FUNCTION professor_disciplina_func(p_id_disciplina IN NUMBER) RETURN VARCHAR2;
END pkg_professor;
/



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