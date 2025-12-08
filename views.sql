CREATE OR REPLACE VIEW vw_detalhes_ocorrencia AS
SELECT
    O.id_ocorrencia,
    O.titulo,
    O.data_hora,
    O.status_atual,
    O.prioridade,
    O.detalhes, 
    O.envolvidos,
    TOC.nome_tipo AS tipo_principal,
    TOC.valor_tipo AS codigo_tipo,
    TOC.subtipo,
    TOC.id_subtipo AS codigo_subtipo,
    EO.rua,
    EO.numero,
    EO.complemento,
    EO.latitude,
    EO.longitude,
    B.nome AS nome_bairro,
    C.nome AS nome_cidade,
    E.sigla AS sigla_estado
FROM 
    Ocorrencia O
JOIN 
    tipo_ocorrencia TOC ON O.id_tipo_ocorrencia = TOC.id_tipo_ocorrencia -- Aqui está a mudança
JOIN 
    Endereco_Ocorrencia EO ON O.id_endereco_ocorrencia = EO.id_endereco_ocorrencia
JOIN 
    Bairro B ON EO.id_bairro = B.id_bairro
JOIN 
    Cidade C ON B.id_cidade = C.id_cidade
JOIN 
    Estado E ON C.id_estado = E.id_estado;
CREATE VIEW vw_detalhes_funcionario AS
SELECT
    F.matricula,
    F.nome,
    F.cpf,
    F.email,
    F.numero_telefone,
    C.nome_cargo,
    EF.rua,
    EF.numero,
    EF.latitude,
    EF.longitude,
    IMC.peso_corporal,
    IMC.altura,
    IMC.imc
FROM 
    Funcionario F
JOIN 
    Cargo C ON F.id_cargo = C.id_cargo
LEFT JOIN 
    Endereco_Funcionario EF ON F.cpf = EF.cpf
LEFT JOIN 
    Imc IMC ON F.cpf = IMC.cpf;
    
    CREATE VIEW vw_log_alteracoes_funcionario AS
SELECT
    AC.id_alteracao,
    F.nome AS atuante_principal,
    F.matricula AS matricula_atuante,
    AC.data_e_hora,
    AC.tipo_de_alteracao,
    AC.area_alteracao,
    AC.descricao
FROM 
    alteracao_cometida AC
JOIN 
    Funcionario F ON AC.atuante_principal_cpf = F.cpf;