
# **Pacotes PL/SQL para Gestão de Alunos, Disciplinas e Professores**

Este repositório contém pacotes PL/SQL que implementam operações relacionadas às entidades `ALUNO`, `DISCIPLINA` e `PROFESSOR` em um sistema educacional. Cada pacote possui procedures e funções para facilitar a manipulação e consulta de dados no banco de dados.

---

## **Pacotes Disponíveis**

### **PKG_ALUNO**
Este pacote oferece procedures para gestão dos alunos no sistema.

- **Procedure: `excluir_aluno`**  
  Exclui um aluno com base no ID informado. Remove também todas as matrículas associadas ao aluno excluído.
  
  **Exemplo de uso:**
  ```sql
  BEGIN
      pkg_aluno.excluir_aluno(1);  -- Exclui o aluno com ID 1
  END;
  ```

- **Procedure: `listar_alunos_maiores_de_18`**  
  Lista os alunos com idade superior a 18 anos, mostrando os nomes e datas de nascimento, utilizando um cursor.

  **Exemplo de uso:**
  ```sql
  BEGIN
      pkg_aluno.listar_alunos_maiores_de_18;
  END;
  ```

- **Procedure: `listar_alunos_por_curso`**  
  Exibe os nomes dos alunos matriculados em um curso específico, filtrando pelo ID do curso.

  **Exemplo de uso:**
  ```sql
  BEGIN
      pkg_aluno.listar_alunos_por_curso(2);  -- Alunos do curso com ID 2
  END;
  ```

---

### **PKG_DISCIPLINA**
Este pacote oferece procedures para gestão das disciplinas no sistema.

- **Procedure: `cadastrar_disciplina`**  
  Cadastra uma nova disciplina com os parâmetros de nome, descrição e carga horária.

  **Exemplo de uso:**
  ```sql
  BEGIN
      pkg_disciplina.cadastrar_disciplina('Matemática', 'Curso de Matemática Básica', 40);
  END;
  ```

- **Procedure: `total_alunos_disciplina`**  
  Exibe as disciplinas que possuem mais de 10 alunos matriculados, juntamente com o número total de alunos em cada uma.

  **Exemplo de uso:**
  ```sql
  BEGIN
      pkg_disciplina.total_alunos_disciplina;
  END;
  ```

- **Procedure: `media_idade_disciplina`**  
  Calcula e retorna a média de idade dos alunos matriculados em uma disciplina específica.

  **Exemplo de uso:**
  ```sql
  DECLARE
      v_media_idade NUMBER;
  BEGIN
      v_media_idade := pkg_disciplina.media_idade_disciplina(1);
      DBMS_OUTPUT.PUT_LINE('Média de Idade dos Alunos: ' || v_media_idade);
  END;
  ```

- **Procedure: `listar_alunos_disciplina`**  
  Lista os nomes dos alunos matriculados em uma disciplina específica.

  **Exemplo de uso:**
  ```sql
  BEGIN
      pkg_disciplina.listar_alunos_disciplina(1);
  END;
  ```

---

### **PKG_PROFESSOR**
Este pacote oferece procedures e funções para gestão dos professores e turmas no sistema.

- **Procedure: `total_turmas_professor`**  
  Exibe os professores que lecionam mais de uma turma, juntamente com o número total de turmas.

  **Exemplo de uso:**
  ```sql
  BEGIN
      pkg_professor.total_turmas_professor;
  END;
  ```

- **Function: `total_turmas_func`**  
  Retorna o número total de turmas de um professor com base no ID do professor.

  **Exemplo de uso:**
  ```sql
  DECLARE
      v_total_turmas NUMBER;
  BEGIN
      v_total_turmas := pkg_professor.total_turmas_func(1);
      DBMS_OUTPUT.PUT_LINE('Total de Turmas: ' || v_total_turmas);
  END;
  ```

- **Function: `professor_disciplina_func`**  
  Retorna o nome do professor que ministra uma disciplina específica, baseado no ID da disciplina.

  **Exemplo de uso:**
  ```sql
  DECLARE
      v_professor_nome VARCHAR2(100);
  BEGIN
      v_professor_nome := pkg_professor.professor_disciplina_func(1);
      DBMS_OUTPUT.PUT_LINE('Professor da Disciplina: ' || v_professor_nome);
  END;
  ```

---

## **Instruções de Execução**

1. **Configuração Inicial:**
   - Copie o conteudo do arquivo `todos_os_comandos.sql`, que está na raiz do projeto e cole no `LIVE SQL ORACLE` por fim, Execute os comandos.

2. **Testando os Pacotes:**
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

