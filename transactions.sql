-- --------------------------- TRANSAÇÕES -----------------------------------

-- transação 1 - inserir um novo doador - COMMIT
SET autocommit = FALSE;
START TRANSACTION;
INSERT INTO sangue.pessoa VALUES ('22233345454', 'Laura', '2004-03-20', 'Brasil', 'PR', 'Curitiba', 'Rua Teste', 'Santa Felicidade', 'a');
SET @cpf := '22233345454';
INSERT INTO sangue.doador VALUES (@cpf, 'F', False, 'O-', '50.0');
INSERT INTO sangue.requisitos VALUES (NULL,True, True, False, False, True, True, @cpf);
COMMIT;

-- transação 2 - inserir um novo paciente - COMMIT
SET autocommit = FALSE;
START TRANSACTION;
INSERT INTO sangue.pessoa VALUES ('11122233344', 'Laura', '2004-03-20', 'Brasil', 'PR', 'Curitiba', 'Rua Teste', 'Santa Felicidade', 'a');
SET @cpf := '11122233344';
INSERT INTO sangue.paciente VALUES (@cpf, 'M', 'O-', '70.0');
COMMIT;

-- transação 3 - inserir um novo funcionario - COMMIT
SET autocommit = FALSE;
START TRANSACTION;
INSERT INTO sangue.pessoa VALUES ('22233344455', 'Melissa', '2004-03-20', 'Brasil', 'PR', 'Curitiba', 'Rua Teste', 'Santa Felicidade', 'a');
SET @cpf := '22233344455';
INSERT INTO sangue.funcionario VALUES (@cpf, '2022-10-13', 'enfermeiro');
COMMIT;

-- transação 4 - transferir um doador para paciente - ROLLBACK TO SAVEPOINT
SET autocommit = FALSE;
START TRANSACTION;
SET @cpf := '22233345454';
SAVEPOINT excluir_doador;
DELETE FROM sangue.requisitos WHERE cpf_doador = @cpf;
DELETE FROM sangue.doador WHERE cpf_doador = @cpf;
ROLLBACK TO SAVEPOINT excluir_doador;
INSERT INTO sangue.paciente VALUES (@cpf, 'F', 'O-', '50.0');
COMMIT;

-- transação 5 - excluir um funcionário - ROLLBACK TO SAVEPOINT
SET autocommit = FALSE;
START TRANSACTION;
SET @cpf := '22233344455';
SAVEPOINT excluir_funcionario;
DELETE FROM sangue.funcionario WHERE cpf_funcionario = @cpf;
DELETE FROM sangue.pessoa WHERE cpf = @cpf;
ROLLBACK TO SAVEPOINT excluir_funcionario;
COMMIT;

-- transação 6 - excluir um doador - ROLLBACK
SET autocommit = FALSE;
START TRANSACTION;
SET @cpf := '99229922992';
DELETE FROM sangue.requisitos WHERE cpf_doador = @cpf;
DELETE FROM sangue.doador WHERE cpf_doador = @cpf;
DELETE FROM sangue.pessoa WHERE cpf = @cpf;
ROLLBACK;
COMMIT;

-- transação 7 - visualizar se a pessoa é um doador, um paciente ou um funcionario (se for vai aparecer o cpf na coluna correspondente) - COMMIT
SET autocommit = FALSE;
START TRANSACTION;
SET @cpf := '22233344455';
SELECT cpf_doador AS é_doador FROM sangue.doador WHERE cpf_doador = @cpf;
SELECT cpf_paciente AS é_paciente FROM sangue.paciente WHERE cpf_paciente = @cpf;
SELECT cpf_funcionario AS é_funcionario FROM sangue.funcionario WHERE cpf_funcionario = @cpf;
COMMIT;

-- transação 8 - atualizar as informações de um doador - ROLLBACK
SET autocommit = FALSE;
START TRANSACTION;
SET @cpf := '22233345454';
UPDATE sangue.pessoa SET nome = 'anastacia' WHERE cpf = @cpf;
UPDATE sangue.doador SET peso = 59.0 WHERE cpf_doador = @cpf;
UPDATE sangue.requisitos SET alimentacao = False WHERE cpf_doador = @cpf;
ROLLBACK;
COMMIT;

-- transação 9 - atualizar as informações de um paciente - ROLLBACK
START TRANSACTION;
SET @cpf := '22233345454';
UPDATE sangue.pessoa SET nome = 'Fabiano' WHERE cpf = @cpf;
UPDATE sangue.paciente SET peso = 60.0 WHERE cpf_paciente = @cpf;
ROLLBACK;
COMMIT;

-- transação 10 - atualizar as informações de um funcionário - ROLLBACK
SET autocommit = FALSE;
START TRANSACTION;
SET @cpf := '22233344455';
UPDATE sangue.pessoa SET nome = 'Talita' WHERE cpf = @cpf;
UPDATE sangue.funcionario SET cargo = 'Médica' WHERE cpf_funcionario = @cpf;
ROLLBACK;
COMMIT;