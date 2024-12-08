# **Pacotes PL/SQL para Gestão de Alunos, Disciplinas e Professores**

Este repositório contém pacotes PL/SQL que implementam operações relacionadas às entidades `ALUNO`, `DISCIPLINA` e `PROFESSOR`.

---

## **Pacotes**

### **PKG_ALUNO**
- **Procedure: excluir_aluno**  
  Exclui um aluno com base no ID informado e remove todas as matrículas associadas ao mesmo.

- **Procedure: listar_alunos_maiores_de_18**  
  Lista os nomes e datas de nascimento de alunos com idade superior a 18 anos utilizando um cursor.

- **Procedure: listar_alunos_por_curso**  
  Exibe os nomes dos alunos matriculados em um curso específico, com base no ID do curso fornecido.

---

### **PKG_DISCIPLINA**
- **Procedure: cadastrar_disciplina**  
  Cadastra uma nova disciplina na tabela com os parâmetros de nome, descrição e carga horária.

- **Procedure: total_alunos_disciplina**  
  Lista as disciplinas com mais de 10 alunos matriculados e exibe o número total de alunos de cada uma.

- **Procedure: media_idade_disciplina**  
  Calcula a média de idade dos alunos matriculados em uma disciplina específica, utilizando um cursor parametrizado.

- **Procedure: listar_alunos_disciplina**  
  Exibe os nomes dos alunos matriculados em uma disciplina específica.

---

### **PKG_PROFESSOR**
- **Procedure: total_turmas_professor**  
  Lista os nomes dos professores e o total de turmas que cada um leciona, exibindo apenas professores com mais de uma turma.

- **Function: total_turmas_func**  
  Retorna o total de turmas de um professor com base no ID informado.

- **Function: professor_disciplina_func**  
  Retorna o nome do professor que ministra uma disciplina específica com base no ID da disciplina.

---

## **Instruções de Execução**

1. **Configuração Inicial:**
   - Crie as tabelas `ALUNOS`, `DISCIPLINAS`, `MATRICULAS`, `PROFESSORES` e `TURMAS` conforme a modelagem do seu sistema.

2. **Carregando os Pacotes:**
   - Execute os arquivos `.pks` (especificação) e `.pkb` (corpo) na ordem correta:
     1. `pkg_aluno.pks` e `pkg_aluno.pkb`
     2. `pkg_disciplina.pks` e `pkg_disciplina.pkb`
     3. `pkg_professor.pks` e `pkg_professor.pkb`

3. **Testando os Pacotes:**
   - Utilize blocos PL/SQL anônimos para testar as procedures e funções. Exemplos:
     ```sql
     BEGIN
         pkg_aluno.excluir_aluno(1);
         pkg_disciplina.cadastrar_disciplina('Matemática', 'Curso de Matemática Básica', 40);
         pkg_professor.total_turmas_professor;
     END;
     /
     ```
   - Para funções:
     ```sql
     DECLARE
         v_total_turmas NUMBER;
         v_professor_nome VARCHAR2(100);
     BEGIN
         v_total_turmas := pkg_professor.total_turmas_func(1);
         DBMS_OUTPUT.PUT_LINE('Total de Turmas: ' || v_total_turmas);

         v_professor_nome := pkg_professor.professor_disciplina_func(1);
         DBMS_OUTPUT.PUT_LINE('Professor da Disciplina: ' || v_professor_nome);
     END;
     /
     ```

4. **Habilitando o DBMS_OUTPUT:**
   - Caso esteja usando o SQL Developer, habilite o painel de saída:
     - Vá em **View > DBMS Output**.
     - Clique em **+** para habilitar a saída do seu banco.

5. **Personalização:**
   - Modifique os scripts conforme a estrutura e requisitos específicos do seu banco de dados.

---

## **Estrutura do Repositório**

```plaintext
├── packages/
│   ├── pkg_aluno.pks
│   ├── pkg_aluno.pkb
│   ├── pkg_disciplina.pks
│   ├── pkg_disciplina.pkb
│   ├── pkg_professor.pks
│   ├── pkg_professor.pkb
└── README.md
