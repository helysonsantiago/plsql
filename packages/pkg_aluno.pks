CREATE OR REPLACE PACKAGE pkg_aluno IS
    PROCEDURE excluir_aluno(p_id_aluno IN NUMBER);
    PROCEDURE listar_alunos_maiores_de_18;
    PROCEDURE listar_alunos_por_curso(p_id_curso IN NUMBER);
END pkg_aluno;
/
