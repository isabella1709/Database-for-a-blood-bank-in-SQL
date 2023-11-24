-- ------------------------------------- 6 USERS ----------------------------------------

-- user 1
CREATE USER 'ana'@'localhost' IDENTIFIED BY '111';

-- user 2
CREATE USER 'isa'@'localhost' IDENTIFIED BY '222';

-- user 3
CREATE USER 'vitor'@'localhost' IDENTIFIED BY '333';

-- user 4
CREATE USER 'vinicius'@'localhost' IDENTIFIED BY '444';

-- user 5
CREATE USER 'michele'@'localhost' IDENTIFIED BY '555';

-- user 6
CREATE USER 'gabriel'@'localhost' IDENTIFIED BY '666';

-- ------------------------------------- 4 USERS ----------------------------------------

-- role 1 - adm terá acesso global
CREATE ROLE IF NOT EXISTS 'adm';
GRANT ALL ON *.* TO 'adm' WITH GRANT OPTION;
GRANT 'adm' TO 'ana'@'localhost', 'isa'@'localhost' WITH ADMIN OPTION;
SET DEFAULT ROLE 'adm' TO 'ana'@'localhost', 'isa'@'localhost';
-- quando entro em ana n to conseguindo visualizar nenhum banco de dados

-- role 2 - funcionario terá acesso somente ao banco de dados 'sangue'
CREATE ROLE IF NOT EXISTS 'funcionario';
GRANT ALL ON sangue.* TO 'funcionario';
GRANT 'funcionario' TO 'vitor'@'localhost', 'vinicius'@'localhost';
SET DEFAULT ROLE 'funcionario' TO 'vitor'@'localhost', 'vinicius'@'localhost';

-- role 3 -- doador pode visualizar somente as tabelas requisitos e doador, já que são as únicas que lhe dizem respeito.
CREATE ROLE IF NOT EXISTS 'doador';
GRANT SELECT ON sangue.requisitos to 'doador';
GRANT SELECT ON sangue.doador to 'doador';
GRANT 'doador' TO 'michele'@'localhost';
SET DEFAULT ROLE 'doador' TO 'michele'@'localhost';

-- role 4 -- paciente pode visualizar somente a tabela paciente
CREATE ROLE IF NOT EXISTS 'paciente';
GRANT SELECT ON sangue.paciente to 'paciente';
GRANT 'paciente' TO 'gabriel'@'localhost';
SET DEFAULT ROLE 'paciente' TO 'gabriel'@'localhost';

-- testes
select * from mysql.user;
SELECT * FROM mysql.db;
SELECT * FROM mysql.columns_priv;
SELECT * FROM mysql.role_edges;
SELECT * FROM mysql.tables_priv;
SHOW GRANTS FOR 'michele'@'localhost';


