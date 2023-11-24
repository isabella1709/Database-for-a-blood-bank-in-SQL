-- ----------------------------------------------- CONSULTAS -------------------------------------------------
-- 1 /*Quantidade de sangue armazenada*/
SELECT SUM(quantidade) FROM sangue.sangue;

-- 2 /*Número de doações*/
SELECT COUNT(*) FROM sangue.doacao;

-- 3 /*Compatibilidade entre doador e paciente*/
SELECT * FROM sangue.compatibilidade WHERE compativel = 1;

-- 4 /*Quantidade de pessoas aptas a doar*/
SELECT COUNT(*) FROM sangue.requisitos WHERE saudavel = 1 and alimentacao = 1 and descanso = 1 and peso_minimo = 1 and idade_minima = 1 and idade_maxima = 1;

-- 5 /*Relatório do processo de cada doação*/
SELECT * FROM sangue.doacao;

-- 6 /*Tipo sanguíneo mais armazenado*/
SELECT tipo_sanguineo_doador, SUM(s.quantidade) AS total_armazenado
FROM sangue.doador AS d
INNER JOIN sangue.sangue AS s ON d.cpf_doador = s.cpf_doador
GROUP BY tipo_sanguineo_doador
ORDER BY total_armazenado DESC;

-- 7 /*Tipo sanguíneo menos armazenado*/
SELECT tipo_sanguineo_doador, SUM(s.quantidade) AS total_armazenado
FROM sangue.doador AS d
INNER JOIN sangue.sangue AS s ON d.cpf_doador = s.cpf_doador
GROUP BY tipo_sanguineo_doador
ORDER BY total_armazenado;

-- 8 /*Tipo sanguíneo mais requisitado*/
-- virou: Quantidade de doações do tipo O-
SELECT tipo_sanguineo_doador, SUM(s.quantidade) AS total_O_negativo 
FROM sangue.doador AS d
INNER JOIN sangue.sangue AS s ON d.cpf_doador = s.cpf_doador
WHERE tipo_sanguineo_doador = 'O-';

-- 9 /*Tipo sanguíneo menos requisitado*/
-- virou: Quantidade de doações do tipo O-
SELECT tipo_sanguineo_doador, SUM(s.quantidade) AS total_AB_positivo
FROM sangue.doador AS d
INNER JOIN sangue.sangue AS s ON d.cpf_doador = s.cpf_doador
WHERE tipo_sanguineo_doador = 'AB+';

-- 10 /*Hospital mais próximo ao doador*/
-- virou: Hospital na mesma rua da pessoa
SELECT p.cpf, h.nome_hospital, h.end_rua
FROM sangue.pessoa AS p 
LEFT JOIN sangue.hospital AS h ON p.end_rua = h.end_rua;

-- 11 /*Hospital mais utilizado para doações*/
SELECT h.nome_hospital, COUNT(d.id_doacao) AS total_doacoes
FROM sangue.hospital AS h
LEFT JOIN sangue.doacao AS d ON h.id_hospital = d.id_hospital
GROUP BY h.nome_hospital
ORDER BY total_doacoes DESC;

-- 12 /*Hospital menos utilizado para doações*/
SELECT h.nome_hospital, COUNT(d.id_doacao) AS total_doacoes
FROM sangue.hospital AS h
LEFT JOIN sangue.doacao AS d ON h.id_hospital = d.id_hospital
GROUP BY h.nome_hospital
ORDER BY total_doacoes;

-- 13 /*Funcionáros cadastrados no processo de doação*/
SELECT * FROM sangue.pessoa, sangue.funcionario WHERE pessoa.cpf = funcionario.cpf_funcionario ORDER BY nome;

-- 14 /*Quantidade de funcionários*/
SELECT COUNT(*) FROM sangue.funcionario;

-- 15 /*Número anual de doações*/
SELECT COUNT(*) FROM sangue.doacao;

-- 16 /*Mostrar grau de necessidade do paciente a doação*/
-- virou: paciente mais recorrente
SELECT pc.cpf_paciente, p.nome AS nome_doador, COUNT(d.id_doacao) AS total_doacoes
FROM sangue.paciente AS pc
INNER JOIN sangue.pessoa AS p ON pc.cpf_paciente = p.cpf
INNER JOIN sangue.doacao AS d ON pc.cpf_paciente = d.cpf_paciente
GROUP BY pc.cpf_paciente
ORDER BY total_doacoes DESC;

-- 17 /*Funcionário mais recorrente*/
SELECT f.cpf_funcionario, p.nome AS nome_funcionario, COUNT(c.id_coleta) AS total_coletas
FROM sangue.funcionario AS f
INNER JOIN sangue.pessoa AS p ON f.cpf_funcionario = p.cpf
INNER JOIN sangue.coleta AS c ON f.cpf_funcionario = c.cpf_funcionario
GROUP BY f.cpf_funcionario
ORDER BY total_coletas DESC;

-- 18 /*Doador mais recorrente*/
SELECT d.cpf_doador, p.nome AS nome_doador, COUNT(c.id_coleta) AS total_coletas
FROM sangue.doador AS d
INNER JOIN sangue.pessoa AS p ON d.cpf_doador = p.cpf
INNER JOIN sangue.coleta AS c ON d.cpf_doador = c.cpf_doador
GROUP BY d.cpf_doador
ORDER BY total_coletas DESC;

-- 19 /*Número de doações de um doador*/
SELECT cpf_doador, COUNT(id_coleta) FROM sangue.coleta 
GROUP BY cpf_doador;

-- 20 /*Faixa etária e genero mais recorrente*/
-- virou: idade de cada pessoa
SELECT nome, data_nasc, (2023 - YEAR(data_nasc)) AS idade
FROM sangue.pessoa;


-- -------------------- VIEWS ------------------------------------

-- VIEW 1 - Informações sobre o doador e suas coletas
CREATE OR REPLACE VIEW informacoes_doador (cpf, nome, tipo_sanguineo_doador, id_coleta)
AS
SELECT p.cpf, p.nome, d.tipo_sanguineo_doador, c.id_coleta 
FROM sangue.pessoa AS p
INNER JOIN sangue.doador AS d ON p.cpf = d.cpf_doador
INNER JOIN sangue.coleta AS c ON d.cpf_doador = c.cpf_doador
GROUP BY p.cpf, p.nome, c.id_coleta
ORDER BY c.id_coleta;

-- VIEW 2 - Informações sobre o paciente e as doações que recebeu
CREATE OR REPLACE VIEW informacoes_paciente (cpf, nome, tipo_sanguineo_paciente, id_doacao)
AS
SELECT p.cpf, p.nome, pac.tipo_sanguineo_paciente, doa.id_doacao
FROM sangue.pessoa AS p
INNER JOIN sangue.paciente AS pac ON p.cpf = pac.cpf_paciente
INNER JOIN sangue.doacao AS doa ON pac.cpf_paciente = doa.cpf_paciente
GROUP BY p.cpf, p.nome, doa.id_doacao
ORDER BY doa.id_doacao;

-- VIEW 3 - Informações sobre o funcionário e as coletas que trabalhou
CREATE OR REPLACE VIEW informacoes_funcionario_coleta (cpf, nome, cargo, id_coleta)
AS
SELECT p.cpf, p.nome, f.cargo, c.id_coleta
FROM sangue.pessoa AS p
INNER JOIN sangue.funcionario AS f ON p.cpf = f.cpf_funcionario
INNER JOIN sangue.coleta AS c ON f.cpf_funcionario = c.cpf_funcionario
GROUP BY p.cpf, f.cargo, c.id_coleta
ORDER BY p.nome;

-- VIEW EXTRA - Informações sobre o funcionário e as doações que trabalhou
CREATE OR REPLACE VIEW informacoes_funcionario_doacao (cpf, nome, cargo, id_doacao)
AS
SELECT p.cpf, p.nome, f.cargo, doa.id_doacao
FROM sangue.pessoa AS p
INNER JOIN sangue.funcionario AS f ON p.cpf = f.cpf_funcionario
INNER JOIN sangue.doacao AS doa ON f.cpf_funcionario = doa.cpf_funcionario
GROUP BY p.cpf, f.cargo, doa.id_doacao
ORDER BY p.nome;