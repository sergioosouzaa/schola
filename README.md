# Desafio da semana

## Tarefa 1: Seeds

Escrever um arquivo de seeds para inicializar o DB com dados;

- ao final da execução dos seeds devem existir dados dos últimos 10 anos (2012-2022), mais o ano atual (2023);
- devem existir as seguintes disciplina: Matemática, Português, História, Geografia, Física, Química e Inglês;
- para cada ano devem existir um curso para cada séria em que a escola tem aulas, do 5° ao 9° anos;
- para cada turma deve existir uma quantidade aleatória de alunos matrículados, entre 20 e 40;
- parte dos alunos matriculados devem "continuar" na escola entre um ano e outro, por exemplo, João estava matriculado
no 5° ano em 2021 e estava matrículado no 6° ano em 2022. A decisão de re-matricular um aluno pode ser aleatória
e não precisa levar em consideração notas;
- não é necessários usar nenhuma lógica nos códigos de matrícula de um mesmo aluno em anos diferentes. POdem usar UUIDs
mesmo;
- em cada ano passado, cada aluno deve ter 8 notas em cada disciplina. No ano atual, coloquem 4 notas em cada disciplina.
Os valores podem ser aleatórios, entre 0 e 10.
- o conjunto de professores pode ser fixo entre os diferentes anos, mas é necessário que haja alocações diferentes deles
em disciplina, por exemplo, um professor que em um ano dava aulas de matemática e física pro 5° ano, em outro ano pode
dar aulas apenas de física pro 9° ano e matemática no 6° ano. Usem a lógica que quiserem, inclusive aleatória;
- usem a gem FFaker para ciar nomes de alunos e professores;

## Tarefa 2: Index e show de student

Ambas as página podem receber um _query param_ opcional `year`, que informa o ano que queremos mostrar as informações
abaixo. Se não informado, será usado o ano atual. Caso o aluno não esteja matriculado no ano selecionado, exibir um
_flash message_ com essa informação:

Exibir os campos faltantes da tabela de index:

- matrícula (registration) ativa no ano em questão (ou - caso não matriculado);
- curso no qual o aluno está matriculado no ano em questão (ou - caso não matriculado);

Exibir os campos faltantes na página de show:

- matrícula (registration) ativa no ano em questão (ou - caso não matriculado);
- curso no qual o aluno está matriculado no ano em questão (ou - caso não matriculado);
- exibir as médias do aluno em questão na tabela;

## Tarefa 3: Dashboard

Implementar a página de Dashboard, que mostra algumas estatísticas da aplicação. Essa página sempre mostra informações
de um ano específico, recebendo um _query param_ opcional `year`. Se não informado, será usado o ano atual.

- Enrollments by course: número de matrículas por curso, ordenado por nome do curso;
- Youngests student by course: Nome e idade do estudante mais novo de cada curso, ordenado por nome do curso;
- Best grades by subject: Nome do estudante, nota e curso do estudante que tirou a melhor nota em cada matéria, ordenado
por nome da matéria;
- Top overloaded teachers: Nome dos 5 professores com mais alunos, entre todos os cursos e disciplicas que ele(a) dá aula,
e o número de alunos. Ordenado em ordem descrescente do número de alunos;

# Critérios & Dicas

- Você deve buscar reduzir o número de consultas ao banco e fazê-las da forma mais eficiente que conseguir.
- Use boas práticas de organização e reuso das consultas.
- Crie ou alterem as associações existentes, caso precisem.
- Não há necessidade de adicionar nenhuma coluna às tabelas.
- Evite colocar código nos controllers que não deveriam estar lá.
- Escreva testes.
- Não deixe pra tirar dúvidas só no final da semana.
- Rode o projeto usando `docker compose up`.
