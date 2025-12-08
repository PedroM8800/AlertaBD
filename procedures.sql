DELIMITER $$
CREATE PROCEDURE sp_inserir_funcionario (
    IN p_cpf CHAR(11),
    IN p_matricula VARCHAR(50),
    IN p_nome VARCHAR(150),
    IN p_data_nascimento DATE,
    IN p_email VARCHAR(150),
    IN p_senha VARCHAR(150),
    IN p_numero_telefone VARCHAR(15),
    IN p_id_cargo INT
)
BEGIN
    -- Insere o funcionário principal
    INSERT INTO Funcionario (cpf, matricula, nome, data_nascimento, email, senha, numero_telefone, id_cargo)
    VALUES (p_cpf, p_matricula, p_nome, p_data_nascimento, p_email, p_senha, p_numero_telefone, p_id_cargo);

    -- Prepara o registro de endereço (sem detalhes, apenas o CPF)
    INSERT INTO Endereco_Funcionario (cpf, id_bairro)
    VALUES (p_cpf, 1); -- Assumindo que '1' é um Bairro padrão/temporário válido
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_registrar_ocorrencia (
    IN p_titulo VARCHAR(155),
    IN p_data_hora DATETIME,
    IN p_envolvidos VARCHAR(150),
    IN p_detalhes VARCHAR(255),
    IN p_status_atual ENUM('Em andamento', 'Encerrada', 'Cancelada'),
    IN p_prioridade ENUM('Baixa', 'Media', 'Alta'),
    IN p_pasta_recursos VARCHAR(60),
    IN p_id_tipo_ocorrencia INT,
    IN p_latitude DECIMAL(10, 8),
    IN p_longitude DECIMAL(10, 8)
)
BEGIN
    DECLARE v_id_endereco INT;

    -- 1. Insere o Endereço da Ocorrência
    INSERT INTO Endereco_Ocorrencia (latitude, longitude)
    VALUES (p_latitude, p_longitude);

    -- Pega o ID do endereço recém-inserido
    SET v_id_endereco = LAST_INSERT_ID();

    -- 2. Insere a Ocorrência
    INSERT INTO Ocorrencia (titulo, data_hora, envolvidos, detalhes, status_atual, prioridade, pasta_recursos, id_tipo_ocorrencia, id_endereco_ocorrencia)
    VALUES (p_titulo, p_data_hora, p_envolvidos, p_detalhes, p_status_atual, p_prioridade, p_pasta_recursos, p_id_tipo_ocorrencia, v_id_endereco);
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_atualizar_imc (
    IN p_cpf CHAR(11),
    IN p_peso DECIMAL(5,2),
    IN p_altura DECIMAL(4,2)
)
BEGIN
    DECLARE v_imc DECIMAL(5,2);

    -- Calcula o IMC usando a função
    SET v_imc = calcular_imc(p_peso, p_altura);

    -- Insere ou atualiza (usando REPLACE ou ON DUPLICATE KEY UPDATE se preferir)
    INSERT INTO Imc (cpf, peso_corporal, altura, imc)
    VALUES (p_cpf, p_peso, p_altura, v_imc)
    ON DUPLICATE KEY UPDATE 
        peso_corporal = p_peso, 
        altura = p_altura, 
        imc = v_imc;
END $$
DELIMITER ;

