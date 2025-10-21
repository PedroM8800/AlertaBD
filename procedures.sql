DELIMITER //

CREATE PROCEDURE sp_inserir_funcionario (
    IN p_matricula VARCHAR(50),
    IN p_nome VARCHAR(150),
    IN p_cpf CHAR(11),
    IN p_data_nascimento DATE,
    IN p_email VARCHAR(150),
    IN p_senha VARCHAR(100),
    IN p_numero_telefone VARCHAR(15),
    IN p_id_cargo INT
)
BEGIN
    INSERT INTO Funcionario (matricula, nome, cpf, data_nascimento, email, senha, numero_telefone, id_cargo)
    VALUES (p_matricula, p_nome, p_cpf, p_data_nascimento, p_email, p_senha, p_numero_telefone, p_id_cargo);
END //

CREATE PROCEDURE sp_inserir_endereco_funcionario (
    IN p_cpf CHAR(11),
    IN p_rua VARCHAR(150),
    IN p_numero VARCHAR(10),
    IN p_complemento VARCHAR(100),
    IN p_id_bairro INT
)
BEGIN
    INSERT INTO Endereco (cpf, rua, numero, complemento, id_bairro)
    VALUES (p_cpf, p_rua, p_numero, p_complemento, p_id_bairro);
END //

CREATE PROCEDURE sp_inserir_informacao_corporal (
    IN p_cpf CHAR(11),
    IN p_peso DECIMAL(5,2),
    IN p_altura DECIMAL(4,2)
)
BEGIN
    DECLARE v_imc DECIMAL(5,2);
    SET v_imc = p_peso / (p_altura * p_altura);
    INSERT INTO Imc (cpf, peso_corporal, altura, imc)
    VALUES (p_cpf, p_peso, p_altura, v_imc);
END //

CREATE PROCEDURE sp_listar_funcionarios_completos ()
BEGIN
    SELECT 
        f.matricula, f.nome, f.cpf, f.email, f.data_nascimento,
        c.nome_cargo, c.salario,
        e.rua, e.numero, e.complemento,
        b.nome AS bairro, ci.nome AS cidade, es.nome AS estado,
        i.peso_corporal, i.altura, i.imc
    FROM Funcionario f
    LEFT JOIN Cargo c ON f.id_cargo = c.id_cargo
    LEFT JOIN Endereco e ON f.cpf = e.cpf
    LEFT JOIN Bairro b ON e.id_bairro = b.id_bairro
    LEFT JOIN Cidade ci ON b.id_cidade = ci.id_cidade
    LEFT JOIN Estado es ON ci.id_estado = es.id_estado
    LEFT JOIN Imc i ON f.cpf = i.cpf;
END //

CREATE PROCEDURE sp_atualizar_funcionario (
    IN p_cpf CHAR(11),
    IN p_email VARCHAR(150),
    IN p_numero_telefone VARCHAR(15),
    IN p_senha VARCHAR(100)
)
BEGIN
    UPDATE Funcionario
    SET email = p_email,
        numero_telefone = p_numero_telefone,
        senha = p_senha
    WHERE cpf = p_cpf;
END //

CREATE PROCEDURE sp_excluir_funcionario (
    IN p_cpf CHAR(11)
)
BEGIN
    DELETE FROM Funcionario WHERE cpf = p_cpf;
END //

CREATE PROCEDURE sp_inserir_endereco_ocorrencia (
    IN p_id_ocorrencia CHAR(11),
    IN p_rua VARCHAR(150),
    IN p_numero VARCHAR(10),
    IN p_complemento VARCHAR(100),
    IN p_id_bairro INT
)
BEGIN
    INSERT INTO Endereco (rua, numero, complemento, id_bairro)
    VALUES (p_rua, p_numero, p_complemento, p_id_bairro);
END //

CREATE PROCEDURE sp_inserir_ocorrencia (
    in p_titulo varchar(155),
    IN p_data_hora DATETIME,
    IN p_envolvidos VARCHAR(150),
    IN p_detalhes VARCHAR(255),
    IN p_status_atual ENUM('Em andamento', 'Encerrada', 'Cancelada'),
    IN p_prioridade ENUM('Baixa', 'Media', 'Alta'),
    IN p_id_tipo_ocorrencia INT,
    IN p_id_endereco INT
)
BEGIN
    INSERT INTO Ocorrencia (
        titulo, data_hora, envolvidos, detalhes, status_atual, prioridade,
        id_tipo_ocorrencia, id_endereco
    ) VALUES (
        p_titulo, p_data_hora, p_envolvidos, p_detalhes, p_status_atual, p_prioridade,
        p_id_tipo_ocorrencia, p_id_endereco
    );
END //

CREATE PROCEDURE sp_atualizar_ocorrencia (
    IN p_id_ocorrencia INT,
    in p_titulo varchar(155),
    IN p_data_hora DATETIME,
    IN p_envolvidos VARCHAR(150),
    IN p_detalhes VARCHAR(255),
    IN p_status_atual ENUM('Em andamento', 'Encerrada', 'Cancelada'),
    IN p_prioridade ENUM('Baixa', 'Media', 'Alta'),
    IN p_id_tipo_ocorrencia INT,
    IN p_id_endereco INT
)
BEGIN
    UPDATE Ocorrencia
    SET titulo = p_titulo,
		data_hora = p_data_hora,
        envolvidos = p_envolvidos,
        detalhes = p_detalhes,
        status_atual = p_status_atual,
        prioridade = p_prioridade,
        id_tipo_ocorrencia = p_id_tipo_ocorrencia,
        id_endereco = p_id_endereco
    WHERE id_ocorrencia = p_id_ocorrencia;
END //

CREATE PROCEDURE sp_excluir_ocorrencia (
    IN p_id_ocorrencia INT
)
BEGIN
    DELETE FROM Ocorrencia
    WHERE id_ocorrencia = p_id_ocorrencia;
END //

CREATE PROCEDURE sp_consultar_ocorrencia (
    IN p_id_ocorrencia INT
)
BEGIN
    SELECT o.id_ocorrencia,
		   o.titulo,
           o.data_hora,
           o.envolvidos,
           o.detalhes,
           o.status_atual,
           o.prioridade,
           t.nome_tipo AS tipo_ocorrencia,
           e.logradouro AS endereco
    FROM Ocorrencia o
    JOIN tipo_ocorrencia t ON o.id_tipo_ocorrencia = t.id_tipo_ocorrencia
    JOIN Endereco_Ocorrencia e ON o.id_endereco = e.id_endereco
    WHERE o.id_ocorrencia = p_id_ocorrencia;
END //


CREATE PROCEDURE sp_inserir_unidade (
    IN p_nome VARCHAR(150),
    IN p_descricao VARCHAR(255)
)
BEGIN
    INSERT INTO Unidade (nome, descricao)
    VALUES (p_nome, p_descricao);
END //

CREATE PROCEDURE sp_atualizar_unidade (
    IN p_id_unidade INT,
    IN p_nome VARCHAR(150),
    IN p_descricao VARCHAR(255)
)
BEGIN
    UPDATE Unidade
    SET nome = p_nome,
        descricao = p_descricao
    WHERE id_unidade = p_id_unidade;
END //

CREATE PROCEDURE sp_excluir_unidade (
    IN p_id_unidade INT
)
BEGIN
    DELETE FROM Unidade
    WHERE id_unidade = p_id_unidade;
END //

CREATE PROCEDURE sp_consultar_unidade (
    IN p_id_unidade INT
)
BEGIN
    SELECT * FROM Unidade
    WHERE id_unidade = p_id_unidade;
END //

CREATE PROCEDURE sp_inserir_alteracao (
    IN p_atuante_principal_cpf CHAR(11),
    IN p_data_e_hora DATETIME,
    IN p_tipo_de_alteracao VARCHAR(150),
    IN p_area_alteracao VARCHAR(150),
    IN p_descricao VARCHAR(255)
)
BEGIN
    INSERT INTO alteracao_cometida (
        atuante_principal_cpf, data_e_hora, tipo_de_alteracao, area_alteracao, descricao
    ) VALUES (
        p_atuante_principal_cpf, p_data_e_hora, p_tipo_de_alteracao, p_area_alteracao, p_descricao
    );
END //

CREATE PROCEDURE sp_atualizar_alteracao (
    IN p_id_alteracao INT,
    IN p_atuante_principal_cpf CHAR(11),
    IN p_data_e_hora DATETIME,
    IN p_tipo_de_alteracao VARCHAR(150),
    IN p_area_alteracao VARCHAR(150),
    IN p_descricao VARCHAR(255)
)
BEGIN
    UPDATE alteracao_cometida
    SET atuante_principal_cpf = p_atuante_principal_cpf,
        data_e_hora = p_data_e_hora,
        tipo_de_alteracao = p_tipo_de_alteracao,
        area_alteracao = p_area_alteracao,
        descricao = p_descricao
    WHERE id_alteracao = p_id_alteracao;
END //

CREATE PROCEDURE sp_excluir_alteracao (
    IN p_id_alteracao INT
)
BEGIN
    DELETE FROM alteracao_cometida
    WHERE id_alteracao = p_id_alteracao;
END //

CREATE PROCEDURE sp_consultar_alteracao (
    IN p_id_alteracao INT
)
BEGIN
    SELECT a.id_alteracao,
           a.data_e_hora,
           a.tipo_de_alteracao,
           a.area_alteracao,
           a.descricao,
           f.cpf,
           f.nome AS nome_funcionario
    FROM alteracao_cometida a
    JOIN Funcionario f ON a.atuante_principal_cpf = f.cpf
    WHERE a.id_alteracao = p_id_alteracao;
END //

CREATE PROCEDURE sp_listar_alteracoes (
    IN p_area_filtro VARCHAR(150)
)
BEGIN
    IF p_area_filtro IS NULL OR p_area_filtro = '' THEN
        SELECT a.id_alteracao,
               a.data_e_hora,
               a.tipo_de_alteracao,
               a.area_alteracao,
               a.descricao,
               f.nome AS nome_funcionario
        FROM alteracao_cometida a
        JOIN Funcionario f ON a.atuante_principal_cpf = f.cpf
        ORDER BY a.data_e_hora DESC;
    ELSE
        SELECT a.id_alteracao,
               a.data_e_hora,
               a.tipo_de_alteracao,
               a.area_alteracao,
               a.descricao,
               f.nome AS nome_funcionario
        FROM alteracao_cometida a
        JOIN Funcionario f ON a.atuante_principal_cpf = f.cpf
        WHERE a.area_alteracao = p_area_filtro
        ORDER BY a.data_e_hora DESC;
    END IF;
END //

DELIMITER ;
