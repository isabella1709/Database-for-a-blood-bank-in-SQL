-- ----------------- PROCEDURES -----------------------------

-- PROCEDURE 1 - INSERINDO UM NOVO DOADOR NAS TABELAS PESSOA E DOADOR 

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS inserindo_novo_doador(IN nome VARCHAR(256), IN cpf VARCHAR(11), IN data_nasc date,
IN end_pais varchar(30), IN end_estado varchar(2), IN end_cidade varchar(50), IN end_rua varchar(50), 
IN end_bairro varchar(50), IN end_complemento varchar(50), IN genero char(1), IN apto bool,
IN tipo_sanguineo_doador varchar(3), peso decimal(3,1))
BEGIN
	INSERT INTO sangue.pessoa (cpf, nome, data_nasc, end_pais, end_estado, end_cidade, end_rua, end_bairro, end_complemento)
    VALUES (cpf, nome, data_nasc, end_pais, end_estado, end_cidade, end_rua, end_bairro, end_complemento);
    
    INSERT INTO sangue.doador (cpf_doador, genero, apto, tipo_sanguineo_doador, peso)
    VALUES (cpf, genero, apto, tipo_sanguineo_doador, peso);
END $$
DELIMITER ;

CALL sangue.inserindo_novo_doador('Larissa', '56789348673', '2000-03-03', 'Brasil', 'PR', 'Curitiba', 'Rua 23', 'Campina do Siqueira', 'B', 'F', True, 'A+', 54.0);

-- ----------------------------------------------------------------------------

-- PROCEDURE 2 - INSERINDO UM NOVO PACIENTE NAS TABELAS PESSOA E PACIENTE

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS inserindo_novo_paciente(IN nome VARCHAR(256), IN cpf VARCHAR(11), IN data_nasc date,
IN end_pais varchar(30), IN end_estado varchar(2), IN end_cidade varchar(50), IN end_rua varchar(50), 
IN end_bairro varchar(50), IN end_complemento varchar(50), IN genero char(1), IN tipo_sanguineo_paciente varchar(3),
IN peso decimal(3,1))
BEGIN
	INSERT INTO sangue.pessoa (cpf, nome, data_nasc, end_pais, end_estado, end_cidade, end_rua, end_bairro, end_complemento)
    VALUES (cpf, nome, data_nasc, end_pais, end_estado, end_cidade, end_rua, end_bairro, end_complemento);
    
    INSERT INTO sangue.paciente (cpf_paciente, genero, tipo_sanguineo_paciente, peso)
    VALUES (cpf, genero, tipo_sanguineo_paciente, peso);
END $$
DELIMITER ;

CALL sangue.inserindo_novo_paciente('Marrie', '08935166769', '2004-08-10', 'Brasil', 'PR', 'Curitiba', 'Rua 39', 'Santa Felicidade', 'bc', 'F', 'B+', 56.0);

-- ----------------------------------------------------------------------------

-- PROCEDURE 3 - INSERINDO UM NOVO FUNCIONARIO NAS TABELAS PESSOA E FUNCIONARIO

DELIMITER $$
CREATE PROCEDURE IF NOT EXISTS inserindo_novo_funcionario (IN nome VARCHAR(256), IN cpf VARCHAR(11), IN data_nasc date,
IN end_pais varchar(30), IN end_estado varchar(2), IN end_cidade varchar(50), IN end_rua varchar(50), 
IN end_bairro varchar(50), IN end_complemento varchar(50), IN data_contratacao date, IN cargo varchar(50))
BEGIN
	INSERT INTO sangue.pessoa (cpf, nome, data_nasc, end_pais, end_estado, end_cidade, end_rua, end_bairro, end_complemento)
    VALUES (cpf, nome, data_nasc, end_pais, end_estado, end_cidade, end_rua, end_bairro, end_complemento);
    
    INSERT INTO sangue.funcionario (cpf_funcionario, data_contratacao, cargo)
    VALUES (cpf, data_contratacao, cargo);
END $$
DELIMITER ;

CALL sangue.inserindo_novo_funcionario('Pedro', '08879084033', '1990-03-07', 'Brasil', 'PR', 'Curitiba', 'Rua 27', 'Bairro Alto', 'B', '2022-03-03', 'enfermeiro');

-- ----------------- FUNCTIONS -----------------------------

-- FUNCTION 1 - CALCULAR A IDADE DE UMA PESSOA

DELIMITER $$
CREATE FUNCTION idade_pessoa (data_nasc date)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE idade INT;
    SET idade = 2023 - YEAR(data_nasc);
    RETURN idade;
END $$
DELIMITER ;

-- ----------------------------------------------------------------------------

-- FUNCTION 2 - CALCULAR A QUANTIDADE TOTAL DE SANGUE DOADO PELO DOADOR

DELIMITER $$
CREATE FUNCTION total_sangue_doador (fun_cpf_doador VARCHAR(11))
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE total_sangue INT;
    SELECT SUM(quantidade) INTO total_sangue
    FROM sangue.sangue
    WHERE fun_cpf_doador = cpf_doador;
    
    RETURN total_sangue;
END $$
DELIMITER ;

-- ----------------------------------------------------------------------------

-- FUNCTION 3 - CALCULAR O NUMERO DE COLETAS DE CADA DOADOR

DELIMITER $$
CREATE FUNCTION numero_doacoes_doador (fun_cpf_doador VARCHAR(11))
RETURNS INT DETERMINISTIC
BEGIN 
	DECLARE doacoes_doador INT;
    SELECT COUNT(id_coleta) INTO doacoes_doador
    FROM sangue.coleta
    WHERE fun_cpf_doador = cpf_doador;
    
    RETURN doacoes_doador;
END $$
DELIMITER ;

-- ----------------- TRIGGERS -----------------------------

-- TRIGGER 1 - INSERT - VERIFICAR SE O PESO INSERIDO EM DOADOR É MAIOR QUE PESO MINIMO PARA DOAR

DELIMITER $$
CREATE TRIGGER peso_minimo_doador
BEFORE INSERT ON sangue.doador
FOR EACH ROW
BEGIN
	DECLARE peso_minimo DECIMAL(3,1);
    
    SET peso_minimo = 50.0;
    
    IF NEW.peso < peso_minimo THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Peso inferior ao peso mínimo necessário para doar";
	END IF;
END $$
DELIMITER ;

-- teste de peso abaixo do minimo
INSERT INTO sangue.doador (cpf_doador, genero, apto, tipo_sanguineo_doador, peso) 
VALUES ('12345678901', 'M', 1, 'A+', 45.0);

-- ----------------------------------------------------------------------------

-- TRIGGER 2 - UPDATE - VERIFICAR, ANTES DE FAZER ALGUM UPDATE NA TABELA DOADOR, SE ELE É APTO

DELIMITER $$
CREATE TRIGGER doador_apto
BEFORE UPDATE ON sangue.doador
FOR EACH ROW
BEGIN 
	IF NEW.apto = False THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "O doador não é apto para doar";
	END IF;
END $$
DELIMITER ;

-- teste de doador não apto
UPDATE sangue.doador SET apto = FALSE
WHERE cpf_doador = '11111111111';

-- ----------------------------------------------------------------------------

-- TRIGGER 3 - DELETE - AVISAR ANTES DE EXCLUIR UM PACIENTE

DELIMITER $$
CREATE TRIGGER excluir_paciente
BEFORE DELETE ON sangue.paciente
FOR EACH ROW
BEGIN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Você está excluindo um paciente";
END $$
DELIMITER ;

DELETE FROM sangue.paciente WHERE cpf_paciente = '66666666666';
