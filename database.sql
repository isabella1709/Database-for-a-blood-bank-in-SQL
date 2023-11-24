CREATE DATABASE IF NOT EXISTS sangue;
CREATE SCHEMA IF NOT EXISTS sangue;

USE sangue;

DROP DATABASE sangue;
DROP SCHEMA sangue;

-- CRIAÇÃO DA TABELA SANGUE.PESSOA
create table if not exists sangue.pessoa(
	cpf varchar(11) not null primary key unique,
    nome varchar(256) not null,
    data_nasc date not null,
    end_pais varchar(30) not null,
    end_estado varchar(2) not null,
    end_cidade varchar(50) not null,
    end_rua varchar(50) not null,
    end_bairro varchar(50) not null,
    end_complemento varchar(50)
);

-- CRIAÇÃO DA TABELA SANGUE.DOADOR
create table if not exists sangue.doador(
	cpf_doador varchar(11) not null primary key unique,
	genero char(1) not null,
    apto bool not null default false,
    tipo_sanguineo_doador varchar(3) not null,
    peso decimal(3,1) not null,
    foreign key (cpf_doador) references sangue.pessoa(cpf)
);

-- CRIAÇÃO DA TABELA SANGUE.REQUISITOS
create table if not exists sangue.requisitos(
	id_requisitos int not null primary key unique auto_increment,
	saudavel bool not null default false,
    alimentacao bool not null default false,
    descanso bool not null default false,
    peso_minimo bool not null default false,
    idade_minima bool not null default false,
    idade_maxima bool not null default false,
    cpf_doador varchar(11) not null unique,
    foreign key(cpf_doador) references sangue.doador(cpf_doador)
);

-- CRIAÇÃO DA TABELA SANGUE.PACIENTE
create table if not exists sangue.paciente(
	cpf_paciente varchar(11) not null primary key unique,
    genero char(1) not null,
    tipo_sanguineo_paciente varchar(3) not null,
    peso decimal(3,1) not null,
    foreign key (cpf_paciente) references sangue.pessoa(cpf)
);

-- CRIAÇÃO DA TABELA SANGUE.FUNCIONÁRIO
create table if not exists sangue.funcionario(
	cpf_funcionario varchar(11) not null primary key unique,
    data_contratacao date not null,
    cargo varchar(50) not null,
    foreign key (cpf_funcionario) references sangue.pessoa(cpf)
);

-- CRIAÇÃO DA TABELA SANGUE.HOSPITAL
create table if not exists sangue.hospital(
	id_hospital int not null primary key unique auto_increment,
	nome_hospital varchar(256) not null,
    end_pais varchar(30) not null,
    end_estado varchar(2) not null,
    end_cidade varchar(50) not null,
    end_rua varchar(50) not null,
    end_bairro varchar(50) not null,
    end_complemento varchar(50)
);

-- CRIAÇÃO DA TABELA SANGUE.HOSPITAL_FUNCIONÁRIO
create table if not exists sangue.hospital_funcionario(
	id_hospital int not null,
    cpf_funcionario varchar(11) not null,
	foreign key(id_hospital) references sangue.hospital(id_hospital),
	foreign key(cpf_funcionario) references sangue.funcionario(cpf_funcionario)
);

-- CRIAÇÃO DA TABELA SANGUE.COLETA
create table if not exists sangue.coleta(
	id_coleta int not null primary key unique auto_increment,
    data_coleta datetime not null,	
    cpf_doador varchar(11) not null,
    cpf_funcionario varchar(11) not null,
    id_hospital int not null,
    foreign key (cpf_doador) references sangue.doador(cpf_doador),
    foreign key (cpf_funcionario) references sangue.funcionario(cpf_funcionario),
    foreign key (id_hospital) references sangue.hospital(id_hospital)
);
    
-- CRIAÇÃO DA TABELA SANGUE.DOAÇÃO
-- tirei alguns unique
create table if not exists sangue.doacao(
	id_doacao int not null primary key unique auto_increment,
    data_doacao datetime not null,	
    cpf_paciente varchar(11) not null,
    cpf_funcionario varchar(11) not null,
    id_hospital int not null ,
    foreign key (cpf_paciente) references sangue.paciente(cpf_paciente),
    foreign key (cpf_funcionario) references sangue.funcionario(cpf_funcionario),
    foreign key (id_hospital) references sangue.hospital(id_hospital)
);

-- CRIAÇÃO DA TABELA SANGUE.COMPATIBILIDADE
create table if not exists sangue.compatibilidade(
	compativel bool not null,
    id_coleta int not null unique,
    cpf_doador varchar(11) not null,
    coleta_cpf_funcionario varchar(11) not null,
    coleta_id_hospital int not null,
    id_doacao int not null unique,
    cpf_paciente varchar(11) not null,
    doacao_cpf_funcionario varchar(11) not null,
	doacao_id_hospital int not null,
    foreign key (id_coleta) references sangue.coleta (id_coleta),
    foreign key (cpf_doador) references sangue.coleta (cpf_doador),
    foreign key (coleta_cpf_funcionario) references sangue.coleta (cpf_funcionario),
    foreign key (coleta_id_hospital) references sangue.coleta (id_hospital),
    foreign key (id_doacao) references sangue.doacao (id_doacao),
    foreign key (cpf_paciente) references sangue.doacao (cpf_paciente),
    foreign key (doacao_cpf_funcionario) references sangue.doacao (cpf_funcionario),
    foreign key (doacao_id_hospital) references sangue.doacao (id_hospital)
);

-- CRIAÇÃO DA TABELA SANGUE.SANGUE
create table if not exists sangue.sangue(
	id_sangue int not null primary key unique auto_increment,
    quantidade int not null,
    id_hospital int not null,
    id_coleta int not null unique,
    cpf_doador varchar(11) not null ,
    coleta_cpf_funcionario varchar(11) not null,
    id_doacao int not null unique,
    cpf_paciente varchar(11) not null ,
    doacao_cpf_funcionario varchar(11) not null,
    foreign key (id_hospital) references sangue.hospital(id_hospital),
	foreign key(id_coleta) references sangue.coleta(id_coleta),
	foreign key(cpf_doador) references sangue.coleta(cpf_doador),
    foreign key(coleta_cpf_funcionario) references sangue.coleta(cpf_funcionario),
	foreign key(id_doacao) references sangue.doacao(id_doacao),
	foreign key(cpf_paciente) references sangue.doacao(cpf_paciente),
    foreign key(doacao_cpf_funcionario) references sangue.doacao(cpf_funcionario)
);

