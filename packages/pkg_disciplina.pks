CREATE OR REPLACE PACKAGE pkg_disciplina IS
    PROCEDURE cadastrar_disciplina(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER);
    PROCEDURE total_alunos_disciplina;
    PROCEDURE media_idade_disciplina(p_id_disciplina IN NUMBER);
    PROCEDURE listar_alunos_disciplina(p_id_disciplina IN NUMBER);
END pkg_disciplina;
/
