
CREATE OR REPLACE VIEW vw_funcionarios_cargos AS
SELECT 
    f.cpf,
    f.nome,
    f.matricula,
    c.nome_cargo
FROM Funcionario f
JOIN Cargo c ON f.id_cargo = c.id_cargo;

CREATE OR REPLACE VIEW vw_funcionarios_enderecos AS
SELECT 
    f.nome,
    e.rua,
    e.numero,
    e.complemento,
    b.nome AS bairro,
    ci.nome AS cidade,
    es.nome AS estado,
    es.sigla
FROM Funcionario f
JOIN Endereco e ON f.cpf = e.cpf
JOIN Bairro b ON e.id_bairro = b.id_bairro
JOIN Cidade ci ON b.id_cidade = ci.id_cidade
JOIN Estado es ON ci.id_estado = es.id_estado;

CREATE OR REPLACE VIEW vw_funcionarios_imc AS
SELECT 
    f.nome,
    i.peso_corporal AS peso,
    i.altura,
    i.imc,
    CASE
        WHEN i.imc < 18.5 THEN 'Abaixo do peso'
        WHEN i.imc BETWEEN 18.5 AND 24.9 THEN 'Peso normal'
        WHEN i.imc BETWEEN 25 AND 29.9 THEN 'Sobrepeso'
        ELSE 'Obesidade'
    END AS classificacao
FROM Funcionario f
JOIN Imc i ON f.cpf = i.cpf;

CREATE OR REPLACE VIEW vw_funcionarios_completos AS
SELECT 
    f.matricula,
    f.nome,
    f.cpf,
    f.email,
    f.data_nascimento,
    f.numero_telefone,
    c.nome_cargo,
    e.rua,
    e.numero,
    b.nome AS bairro,
    ci.nome AS cidade,
    es.nome AS estado,
    i.peso_corporal,
    i.altura,
    i.imc
FROM Funcionario f
LEFT JOIN Cargo c ON f.id_cargo = c.id_cargo
LEFT JOIN Endereco e ON f.cpf = e.cpf
LEFT JOIN Bairro b ON e.id_bairro = b.id_bairro
LEFT JOIN Cidade ci ON b.id_cidade = ci.id_cidade
LEFT JOIN Estado es ON ci.id_estado = es.id_estado
LEFT JOIN Imc i ON f.cpf = i.cpf;

CREATE OR REPLACE VIEW vw_ocorrencias_completas AS
SELECT 
    o.id_ocorrencia,
    o.data_hora,
    o.envolvidos,
    o.detalhes,
    o.status_atual,
    o.prioridade,
    t.nome_tipo AS tipo_ocorrencia,
    e.logradouro,
    e.numero,
    e.bairro,
    e.cidade,
    e.estado
FROM Ocorrencia o
JOIN tipo_ocorrencia t ON o.id_tipo_ocorrencia = t.id_tipo_ocorrencia
JOIN Endereco_Ocorrencia e ON o.id_endereco = e.id_endereco;

CREATE OR REPLACE VIEW vw_ocorrencias_ativas AS
SELECT *
FROM vw_ocorrencias_completas
WHERE status_atual = 'Em andamento';

CREATE OR REPLACE VIEW vw_unidades AS
SELECT id_unidade, nome, descricao
FROM Unidade;