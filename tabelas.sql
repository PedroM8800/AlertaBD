CREATE DATABASE IF NOT EXISTS AlertaCon;
USE AlertaCon;

CREATE TABLE Estado (
    id_estado INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    sigla CHAR(2) NOT NULL
);

CREATE TABLE Cidade (
    id_cidade INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    id_estado INT NOT NULL,
    FOREIGN KEY (id_estado) REFERENCES Estado(id_estado)
);

CREATE TABLE Bairro (
    id_bairro INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    id_cidade INT NOT NULL,
    FOREIGN KEY (id_cidade) REFERENCES Cidade(id_cidade)
);

CREATE TABLE Cargo (
    id_cargo INT PRIMARY KEY AUTO_INCREMENT,
    nome_cargo VARCHAR(100) NOT NULL
);

CREATE TABLE Funcionario (
    cpf CHAR(11) PRIMARY KEY,
    matricula VARCHAR(50) UNIQUE NOT NULL,
    nome VARCHAR(150) NOT NULL,
    data_nascimento DATE NOT NULL,
    email VARCHAR(150),
    senha VARCHAR(150) NOT NULL,
    numero_telefone VARCHAR(15) NOT NULL,
    id_cargo INT,
    FOREIGN KEY (id_cargo) REFERENCES Cargo(id_cargo)
);

create table tipo_ocorrencia (
	id_tipo_ocorrencia int auto_increment primary key,
    nome_tipo varchar(100) not null,
    descricao_tipo varchar(255)
);

create table Ocorrencia (
id_ocorrencia int auto_increment primary key,
data_hora datetime not null,
envolvidos varchar(150),
detalhes varchar(255),
status_atual enum('Em andamento', 'Encerrada', 'Cancelada'),
prioridade enum('Baixa', 'Media', 'Alta'),

id_tipo_ocorrencia int not null,
foreign key(id_tipo_ocorrencia) references tipo_ocorrencia(id_tipo_ocorrencia)
	on update cascade
	on delete restrict
);

create table Unidade(
id_unidade int auto_increment primary key,
nome varchar(150),
descricao varchar(255)
); 

CREATE TABLE Endereco_Funcionario (
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    cpf CHAR(11),
    rua VARCHAR(150) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(100),
    id_bairro INT NOT NULL,
    FOREIGN KEY (cpf) REFERENCES Funcionario(cpf),
    FOREIGN KEY (id_bairro) REFERENCES Bairro(id_bairro)
);

CREATE TABLE Endereco_Ocorrencia (
    id_endereco INT PRIMARY KEY auto_increment,
    id_ocorrencia int,
    rua VARCHAR(150) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(100),
    id_bairro INT NOT NULL,
    foreign key (id_ocorrencia) references Ocorrencia(id_ocorrencia),
    FOREIGN KEY (id_bairro) REFERENCES Bairro(id_bairro)
);

CREATE TABLE Imc (
    id_imc INT PRIMARY KEY AUTO_INCREMENT,
    cpf CHAR(11) NOT NULL,
    peso_corporal DECIMAL(5,2) NOT NULL,
    altura DECIMAL(4,2) NOT NULL,
    imc DECIMAL(5,2),
    FOREIGN KEY (cpf) REFERENCES Funcionario(cpf)
);

DELIMITER $$
CREATE FUNCTION calcular_imc (peso_corporal DECIMAL(5,2), altura DECIMAL(4,2))
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    RETURN peso_corporal / (altura * altura);
END $$
DELIMITER ;
