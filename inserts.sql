
INSERT INTO Estado (nome, sigla) VALUES 
('São Paulo', 'SP'),
('Rio de Janeiro', 'RJ');

INSERT INTO Cidade (nome, id_estado) VALUES 
('São Paulo', 1),
('Campinas', 1),
('Rio de Janeiro', 2);

INSERT INTO Bairro (nome, id_cidade) VALUES
('Centro', 1),
('Jardins', 1),
('Copacabana', 3);

INSERT INTO Cargo (nome_cargo) VALUES
('Gerente'),
('Analista de Sistemas'),
('Técnico de Suporte');

INSERT INTO Funcionario (cpf, matricula, nome, data_nascimento, email, senha, numero_telefone, id_cargo)
VALUES
('12345678901', 'MAT001', 'Carlos Pereira', '1990-05-14', 'carlos@empresa.com', 'senha123', '1199887766', 1),
('23456789012', 'MAT002', 'Mariana Alves', '1988-09-21', 'mariana@empresa.com', 'senha456', '2199883344', 2),
('34567890123', 'MAT003', 'João Silva', '1995-01-10', 'joao@empresa.com', 'senha789', '1199775544', 3);


insert into tipo_ocorrencia (nome_tipo, descricao_tipo) values
('incendio','1'),
('resgate','2'),
('APH', '3'),
('prevenção','4');

INSERT INTO Imc (cpf, peso_corporal, altura, imc) VALUES
('12345678901', 82.5, 1.80, calcular_imc(82.5, 1.80)),
('23456789012', 65.0, 1.65, calcular_imc(65.0, 1.65)),
('34567890123', 90.0, 1.75, calcular_imc(90.0, 1.75));
