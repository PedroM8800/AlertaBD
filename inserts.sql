
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


insert into tipo_ocorrencia (nome_tipo, valor_tipo) values
('incendio', '1'),
('resgate', '2'),
('APH', '3'),
('prevenção', '4'),
('Ocorrência Ambiental', '5'),
('Ocorrência Administrativa', '6'),
('Desastre Natural', '7');

insert into tipo_ocorrencia (subtipo, id_subtipo) values
-- 🔥 Tipo 1: Incêndio
('Incêndio em Edificação Residencial','101'),
('Incêndio em Edificação Comercial','102'),
('Incêndio Florestal','103'),
('Incêndio em Veículo','104'),
('Incêndio Industrial','105'),
('Princípio de Incêndio','106'),
('Incêndio em Área Urbana / Lixo / Terreno Baldio','107'),

-- 🚒 Tipo 2: Resgate
('Resgate em Altura','201'),
('Resgate Veicular','202'),
('Resgate Aquático','203'),
('Resgate em Espaço Confinado','204'),
('Resgate de Animal','205'),
('Resgate em Desabamento / Colapso Estrutural','206'),

-- 🏥 Tipo 3: APH
('Atendimento Clínico','301'),
('Atendimento Traumático','302'),
('Transporte Inter-Hospitalar','303'),
('Suporte Avançado de Vida (SAV)','304'),
('Suporte Básico de Vida (SBV)','305'),
('Atendimento Obstétrico','306'),
('Atendimento Psiquiátrico','307'),

-- 🧯 Tipo 4: Prevenção
('Vistoria Técnica','401'),
('Treinamento e Simulado','402'),
('Inspeção de Equipamentos','403'),
('Educação Comunitária','404'),
('Análise de Projeto','405'),
('Fiscalização de Evento Público','406'),

-- 🌱 Tipo 5: Ocorrência Ambiental
('Derramamento de Produto Químico','501'),
('Vazamento de Gás Tóxico','502'),
('Contaminação de Curso D’água','503'),
('Acidente com Substância Perigosa','504'),
('Incidente com Fauna / Animal Silvestre','505'),

-- 🏢 Tipo 6: Ocorrência Administrativa
('Ocorrência Interna','601'),
('Falha Operacional','602'),
('Avaria de Equipamento','603'),
('Acidente de Serviço','604'),
('Comunicação de Serviço','605'),
('Ocorrência Disciplinar','606'),

-- 🌪️ Tipo 7: Desastre Natural
('Enchente / Inundação','701'),
('Deslizamento de Terra','702'),
('Vendaval / Ciclone','703'),
('Terremoto / Tremor de Terra','704'),
('Colapso de Barragem','705'),
('Incêndio de Grandes Proporções','706');

;


INSERT INTO Imc (cpf, peso_corporal, altura, imc) VALUES
('12345678901', 82.5, 1.80, calcular_imc(82.5, 1.80)),
('23456789012', 65.0, 1.65, calcular_imc(65.0, 1.65)),
('34567890123', 90.0, 1.75, calcular_imc(90.0, 1.75));
