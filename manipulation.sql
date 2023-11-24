-- --------------------------------------------- INSERTS -----------------------------------------------------

-- INSERTS NA TABELA PESSOA

INSERT INTO `sangue`.`pessoa` (cpf, nome, data_nasc, end_pais, end_estado,
end_cidade, end_rua, end_bairro, end_complemento)
VALUES ('11111111111', 'Ana Flávia', '2004-03-20', 'Brasil', 'PR', 'Curitiba', 'Rua Teste', 'Santa Felicidade', 'a'),
		('22222222222', 'Isabella', '2004-09-17', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 2', 'Batel', 'b'),
        ('33333333333', 'Vitor', '2004-10-27', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 3', 'Prado Velho', 'c'),
        ('44444444444', 'Vinicius', '2004-09-14', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 4', 'Centro', 'd'),
        ('55555555555', 'Mohamed', '2004-05-07', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 5', 'Ecoville', 'e'),
        ('66666666666', 'Gabriel', '2004-07-07', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 6', 'Boqueirão', 'f'),
        ('77777777777', 'Michele', '2004-10-17', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 7', 'Butiatuvinha', 'g'),
        ('88888888888', 'Yejin', '2004-09-13', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 8', 'Cabral', 'h'),
        ('99999999999', 'Clara', '2004-08-19', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 9', 'Orleans', 'i'),
        ('01010101010', 'Claudio', '1997-02-20', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 10', 'CIC', 'j'),
        ('12121212121', 'Maria', '2000-12-21', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 11', 'Campina do Siqueira', 'k'),
        ('23232323232', 'João', '1990-07-06', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 12', 'Ecoville', 'l'),
        ('34343434343', 'Julia', '2006-05-09', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 13', 'Agua Verde', 'm'),
        ('45454545454', 'Luísa', '2010-10-10', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 14', 'Campo Comprido', 'n'),
        ('56565656565', 'Carlos', '1982-11-15', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 15', 'Prado Velho', 'o'),
        ('19191919191', 'Cleiton', '1985-06-08', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 16', 'Batel', 'p'),
        ('15151515151', 'Legolas', '1980-06-08', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 18', 'Bigorrilho', 'q');
        
-- INSERTS NA TABELA DOADOR

INSERT INTO `sangue`.`doador`(cpf_doador, genero, apto, tipo_sanguineo_doador, peso)
VALUES ('11111111111', 'F', False, 'O-', '49.0'),
		('22222222222', 'F', True, 'O-', '50.0'),
        ('77777777777', 'F', True, 'AB+', '50.0'),
        ('88888888888', 'F', True, 'AB+', '50.0'),
        ('99999999999', 'F', True, 'O-', '50.0'),
        ('12121212121', 'F', False, 'AB-', '47.0'),
        ('19191919191', 'M', True, 'A+', '75.0'),
        ('15151515151', 'M', True, 'A+', '78.0');
        
-- INSERTS NA TABELA REQUISITOS

INSERT INTO `sangue`.`requisitos`(saudavel, alimentacao, descanso, peso_minimo, 
idade_minima, idade_maxima, cpf_doador)
VALUES (True, True, False, False, True, True, '11111111111'),
		(True, True, True, True, True, True, '22222222222'),
        (True, True, True, True, True, True, '77777777777'),
        (True, True, True, True, True, True, '88888888888'),
        (True, True, True, True, True, True, '99999999999'),
        (False, True, True, False, True, True, '12121212121'),
        (True, True, True, True, True, True, '19191919191'),
        (True, True, True, True, True, True, '15151515151');
        
-- INSERTS NA TABELA PACIENTE

INSERT INTO `sangue`.`paciente`(cpf_paciente, genero, tipo_sanguineo_paciente, peso)
VALUES ('01010101010', 'M', 'O-', '70.0'),
		('23232323232', 'M', 'AB+', '70.0'),
        ('56565656565', 'M', 'O+', '70.0'),
        ('34343434343', 'F', 'AB-', '60.0'),
        ('45454545454', 'F', 'A+', '54.0'),
        ('66666666666', 'M', 'B+', '60.0');
        
-- INSERTS NA TABELA FUNCIONARIO

INSERT INTO `sangue`.`funcionario`(cpf_funcionario, data_contratacao, cargo)
VALUES ('11111111111', '2022-10-13', 'enfermeiro'),
		('22222222222', '2022-01-13', 'enfermeiro'),
        ('33333333333', '2022-05-13', 'enfermeiro'),
        ('44444444444', '2022-03-13', 'enfermeiro'),
        ('55555555555', '2022-07-13', 'enfermeiro'),
        ('66666666666', '2022-11-13', 'enfermeiro');
        
-- INSERTS NA TABELA HOSPITAL

INSERT INTO `sangue`.`hospital`(nome_hospital, end_pais, end_estado, end_cidade,
 end_rua, end_bairro, end_complemento)
VALUES ('Hospital Santa Cruz', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 1', 'Santa Felicidade', 'a'),
		('Hospital Pequeno Principe', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 2', 'Ecoville', 'b'),
        ('Hospital Cruz Vermelha', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 3', 'Prado Velho', 'c'),
        ('Hospital Santa Casa', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 4', 'Agua Verde', 'd'),
        ('Hospital São Marcelino', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 5', 'Boqueirão', 'e'),
        ('Hospital Evangélico', 'Brasil', 'PR', 'Curitiba', 'Rua Teste 6', 'Bigorrilho', 'f');
        
-- INSERTS NA TABELA HOPITAL_FUNCIONARIO

INSERT INTO `sangue`.`hospital_funcionario`(id_hospital, cpf_funcionario)
VALUES ('1', '44444444444'),
		('2', '11111111111'),
        ('3', '22222222222'),
        ('4', '55555555555'),
        ('5', '66666666666'),
        ('6', '33333333333'),
        ('5', '11111111111'),
        ('3', '33333333333'),
        ('1', '44444444444'),
        ('4', '22222222222'),
        ('2', '11111111111'),
        ('6', '22222222222');		

-- INSERTS NA TABELA COLETA

INSERT INTO `sangue`.`coleta`(data_coleta, cpf_doador, cpf_funcionario, id_hospital)
VALUES ('2023-09-17', '22222222222', '44444444444', '1'),
		('2023-09-17', '77777777777', '11111111111', '2'),
        ('2023-09-17', '88888888888', '22222222222', '3'),
        ('2023-09-17', '99999999999', '55555555555', '4'),
        ('2023-09-17', '19191919191', '66666666666', '5'),
        ('2023-09-17', '15151515151', '33333333333', '6');
        
-- INSERTS NA TABELA DOAÇÃO

INSERT INTO `sangue`.`doacao`(data_doacao, cpf_paciente, cpf_funcionario, id_hospital)
VALUES ('2023-09-18', '01010101010', '11111111111', '5'),
		('2023-09-18', '23232323232', '33333333333', '3'),
        ('2023-09-18', '56565656565', '44444444444', '1'),
        ('2023-09-18', '34343434343', '22222222222', '4'),
        ('2023-09-18', '45454545454', '11111111111', '2'),
        ('2023-09-18', '66666666666', '22222222222', '6');
        
-- INSERTS NA TABELA COMPATIBILIDADE

INSERT INTO `sangue`.`compatibilidade`(compativel, id_coleta, cpf_doador, coleta_cpf_funcionario,
coleta_id_hospital, id_doacao, cpf_paciente, doacao_cpf_funcionario, doacao_id_hospital)
VALUES (True, '1', '22222222222', '44444444444', '1', '1', '01010101010', '11111111111', '5'),
		(True, '2', '77777777777', '11111111111', '2', '2', '23232323232', '33333333333', '3'),
        (False, '3', '88888888888', '22222222222', '3', '3', '56565656565', '44444444444', '1'),
        (True, '4', '99999999999', '55555555555', '4', '4', '34343434343', '22222222222', '4'),
        (True, '5', '19191919191', '66666666666', '5', '5', '45454545454', '11111111111', '2'),
        (False, '6', '15151515151', '33333333333', '6', '6', '66666666666', '22222222222', '6');
        
-- INSERTS NA TABELA SANGUE

INSERT INTO `sangue`.`sangue`(quantidade, id_hospital, id_coleta, cpf_doador, coleta_cpf_funcionario,
id_doacao, cpf_paciente, doacao_cpf_funcionario)
VALUES ('2', '1', '1', '22222222222', '44444444444', '1', '23232323232', '11111111111'),
		('1', '2', '2', '77777777777', '11111111111', '2', '01010101010', '33333333333'),
        ('3', '3', '3', '88888888888', '22222222222', '3', '56565656565', '44444444444'),
        ('2', '4', '4', '99999999999', '55555555555', '4', '34343434343', '22222222222'),
        ('1', '5', '5', '19191919191', '66666666666', '5', '45454545454', '11111111111'),
        ('3', '6', '6', '15151515151', '33333333333', '6', '66666666666', '22222222222');

-- --------------------------------------------- UPDATES -------------------------------------------------

-- UPDATE 1 - TABELA PESSOA 
UPDATE `sangue`.`pessoa` SET end_pais = 'Líbano'
WHERE pessoa.cpf = '55555555555';

-- UPDATE 2 - TABELA DOADOR
UPDATE `sangue`.`doador` SET peso = '48.0'
WHERE doador.cpf_doador = '11111111111';

-- UPDATE 3 - TABELA REQUISITOS
UPDATE `sangue`.`requisitos` SET alimentacao = False
WHERE requisitos.cpf_doador = '11111111111';

-- UPDATE 4 - TABELA PACIENTE
UPDATE `sangue`.`paciente` SET peso = '73.0'
WHERE paciente.cpf_paciente = '01010101010';

-- UPDATE 5 - TABELA FUNCIONARIO
UPDATE `sangue`.`funcionario` SET data_contratacao = '2022-10-14'
WHERE funcionario.cpf_funcionario = '11111111111';

-- --------------------------------------------- DELETES -------------------------------------------------

-- DELETE 6 - TABELA SANGUE
DELETE FROM `sangue`.`sangue` WHERE cpf_doador = '99999999999';

-- DELETE 5 - TABELA COMPATIBILIDADE
DELETE FROM `sangue`.`compatibilidade` WHERE cpf_doador = '99999999999';

-- DELETE 4 - TABELA COLETA
DELETE FROM `sangue`.`coleta` WHERE cpf_doador = '99999999999';

-- DELETE 3 - TABELA REQUISITOS
DELETE FROM `sangue`.`requisitos` WHERE cpf_doador = '99999999999';

-- DELETE 2 - TABELA DOADOR
DELETE FROM `sangue`.`doador` WHERE cpf_doador = '99999999999';

-- DELETE 1 - TABELA PESSOA
DELETE FROM `sangue`.`pessoa` WHERE cpf = '99999999999';











	