-- Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS SEGREDOS_HOSPITAL;
USE SEGREDOS_HOSPITAL;

CREATE TABLE Medico (
    Nome VARCHAR(255),
    RG VARCHAR(20),
    CPF VARCHAR(14),
    Endereco VARCHAR(255),
    Telefone VARCHAR(15),
    Cargo VARCHAR(50),
    CRM VARCHAR(20) PRIMARY KEY
);

CREATE TABLE Especialidades (
    Id_Especialidade INT PRIMARY KEY,
    Nome_Especialidade VARCHAR(255)
);

CREATE TABLE Pacientes_Consultas (
    Nome VARCHAR(255),
    CPF VARCHAR(14),
    RG VARCHAR(20),
    Endereco VARCHAR(255),
    Telefone VARCHAR(15),
    E_mail VARCHAR(255),
    Data_Nascimento DATE,
    Data_consulta DATE,
    Nome_medico VARCHAR(255),
    Nome_paciente VARCHAR(255),
    Valor_consulta FLOAT,
    Id_consulta INT,
    Nome_especialidade VARCHAR(255),
    Nome_convenio VARCHAR(255),
    PRIMARY KEY (CPF, Id_consulta)
);

CREATE TABLE Receita_Medica (
    Nome_medicamento VARCHAR(255),
    Qtde_medicamentos INT,
    Instrucoes_de_uso VARCHAR(255),
    Id_receita INT PRIMARY KEY
);

CREATE TABLE Convenio (
    Id_Convenio INT PRIMARY KEY,
    Nome_Convenio VARCHAR(255),
    CNPJ VARCHAR(20),
    Tempo_Carencia INT,
    fk_Pacientes_Consultas_CPF VARCHAR(14),
    fk_Pacientes_Consultas_Id_consulta INT,
    FOREIGN KEY (fk_Pacientes_Consultas_CPF, fk_Pacientes_Consultas_Id_consulta)
        REFERENCES Pacientes_Consultas (CPF, Id_consulta)
        ON DELETE CASCADE
);

CREATE TABLE Tipo_quarto (
    Id INT PRIMARY KEY,
    Descricao VARCHAR(255),
    valor_diaria VARCHAR(255)
);

CREATE TABLE Quarto (
    Id INT PRIMARY KEY,
    Numero INT,
    Tipo VARCHAR(255),
    fk_Tipo_quarto_Id INT,
    FOREIGN KEY (fk_Tipo_quarto_Id)
        REFERENCES Tipo_quarto (Id)
        ON DELETE CASCADE
);

CREATE TABLE Internacao (
    Id INT PRIMARY KEY,
    Data_entrada DATE,
    Data_prev_alta DATE,
    Procedimento VARCHAR(255),
    Data_alta DATE,
    fk_Quarto_Id INT,
    FOREIGN KEY (fk_Quarto_Id)
        REFERENCES Quarto (Id)
        ON DELETE CASCADE
);

CREATE TABLE Enfermeiro (
    Id INT PRIMARY KEY,
    Nome VARCHAR(255),
    CPF VARCHAR(14),
    CRE VARCHAR(20)
);

CREATE TABLE possui (
    fk_Medico_CRM VARCHAR(20),
    fk_Especialidades_Id_Especialidade INT,
    FOREIGN KEY (fk_Medico_CRM)
        REFERENCES Medico (CRM)
        ON DELETE RESTRICT,
    FOREIGN KEY (fk_Especialidades_Id_Especialidade)
        REFERENCES Especialidades (Id_Especialidade)
        ON DELETE RESTRICT
);

CREATE TABLE realiza (
    fk_Medico_CRM VARCHAR(20),
    fk_Consultas_Id_consulta INT,
    FOREIGN KEY (fk_Medico_CRM)
        REFERENCES Medico (CRM)
        ON DELETE RESTRICT,
    FOREIGN KEY (fk_Consultas_Id_consulta)
        REFERENCES Pacientes_Consultas (Id_consulta)
        ON DELETE RESTRICT
);

CREATE TABLE emitir (
    fk_Medico_CRM VARCHAR(20),
    fk_Receita_Medica_Id_receita INT,
    FOREIGN KEY (fk_Medico_CRM)
        REFERENCES Medico (CRM)
        ON DELETE RESTRICT,
    FOREIGN KEY (fk_Receita_Medica_Id_receita)
        REFERENCES Receita_Medica (Id_receita)
        ON DELETE RESTRICT
);

CREATE TABLE requer (
    fk_Enfermeiro_Id INT,
    fk_Internacao_Id INT,
    FOREIGN KEY (fk_Enfermeiro_Id)
        REFERENCES Enfermeiro (Id)
        ON DELETE RESTRICT,
    FOREIGN KEY (fk_Internacao_Id)
        REFERENCES Internacao (Id)
        ON DELETE SET NULL
);

CREATE TABLE requer_Internacao_Pacientes_Consultas_Medico (
    fk_Internacao_Id INT,
    fk_Pacientes_Consultas_CPF VARCHAR(14),
    fk_Pacientes_Consultas_Id_consulta INT,
    fk_Medico_CRM VARCHAR(20),
    FOREIGN KEY (fk_Internacao_Id)
        REFERENCES Internacao (Id)
        ON DELETE RESTRICT,
    FOREIGN KEY (fk_Pacientes_Consultas_CPF, fk_Pacientes_Consultas_Id_consulta)
        REFERENCES Pacientes_Consultas (CPF, Id_consulta)
        ON DELETE NO ACTION,
    FOREIGN KEY (fk_Medico_CRM)
        REFERENCES Medico (CRM)
        ON DELETE NO ACTION
);

ALTER TABLE possui ADD CONSTRAINT FK_possui_1
    FOREIGN KEY (fk_Medico_CRM)
    REFERENCES Medico (CRM)
    ON DELETE RESTRICT;

ALTER TABLE possui ADD CONSTRAINT FK_possui_2
    FOREIGN KEY (fk_Especialidades_Id_Especialidade)
    REFERENCES Especialidades (Id_Especialidade)
    ON DELETE RESTRICT;

ALTER TABLE realiza ADD CONSTRAINT FK_realiza_1
    FOREIGN KEY (fk_Medico_CRM)
    REFERENCES Medico (CRM)
    ON DELETE RESTRICT;

ALTER TABLE realiza ADD CONSTRAINT FK_realiza_2
    FOREIGN KEY (fk_Consultas_Id_consulta)
    REFERENCES Pacientes_Consultas (Id_consulta)
    ON DELETE RESTRICT;

ALTER TABLE emitir ADD CONSTRAINT FK_emitir_1
    FOREIGN KEY (fk_Medico_CRM)
    REFERENCES Medico (CRM)
    ON DELETE RESTRICT;

ALTER TABLE emitir ADD CONSTRAINT FK_emitir_2
    FOREIGN KEY (fk_Receita_Medica_Id_receita)
    REFERENCES Receita_Medica (Id_receita)
    ON DELETE RESTRICT;

ALTER TABLE requer ADD CONSTRAINT FK_requer_1
    FOREIGN KEY (fk_Enfermeiro_Id)
    REFERENCES Enfermeiro (Id)
    ON DELETE RESTRICT;

ALTER TABLE requer ADD CONSTRAINT FK_requer_2
    FOREIGN KEY (fk_Internacao_Id)
    REFERENCES Internacao (Id)
    ON DELETE SET NULL;

ALTER TABLE requer_Internacao_Pacientes_Consultas_Medico ADD CONSTRAINT FK_requer_Internacao_Pacientes_Consultas_Medico_1
    FOREIGN KEY (fk_Internacao_Id)
    REFERENCES Internacao (Id)
    ON DELETE RESTRICT;

ALTER TABLE requer_Internacao_Pacientes_Consultas_Medico ADD CONSTRAINT FK_requer_Internacao_Pacientes_Consultas_Medico_2
    FOREIGN KEY (fk_Pacientes_Consultas_CPF, fk_Pacientes_Consultas_Id_consulta)
    REFERENCES Pacientes_Consultas (CPF, Id_consulta)
    ON DELETE NO ACTION;

ALTER TABLE requer_Internacao_Pacientes_Consultas_Medico ADD CONSTRAINT FK_requer_Internacao_Pacientes_Consultas_Medico_3
    FOREIGN KEY (fk_Medico_CRM)
    REFERENCES Medico (CRM)
    ON DELETE NO ACTION;
    
-- Inserções fictícias

-- Inserir médicos e especialidades
INSERT INTO Medico (Nome, RG, CPF, Endereco, Telefone, Cargo, CRM) 
VALUES 
('Dr. Silva', '1234567', '12345678901', 'Rua A, 123', '123456789', 'Cardiologista', 'CRM123'),
('Dra. Souza', '9876543', '98765432109', 'Rua B, 456', '987654321', 'Ortopedista', 'CRM456');

INSERT INTO Especialidades (Id_Especialidade, Nome_Especialidade) 
VALUES 
(1, 'Cardiologia'),
(2, 'Ortopedia');

-- Inserir pacientes e consultas
INSERT INTO Pacientes_Consultas (Nome, CPF, RG, Endereco, Telefone, E_mail, Data_Nascimento, Data_consulta, Nome_medico, Nome_paciente, Valor_consulta, Id_consulta, Nome_especialidade, Nome_convenio) 
VALUES 
('João', '11122233344', '123456', 'Rua C, 789', '999888777', 'joao@email.com', '1990-01-01', '2023-01-10', 'Dr. Silva', 'João', 100.0, 1, 'Cardiologia', 'Convenio1'),
('Maria', '55566677788', '987654', 'Rua D, 1011', '333222111', 'maria@email.com', '1985-05-05', '2023-01-15', 'Dra. Souza', 'Maria', 120.0, 2, 'Ortopedia', 'Convenio2');

-- Inserir receitas médicas
INSERT INTO Receita_Medica (Nome_medicamento, Qtde_medicamentos, Instrucoes_de_uso, Id_receita) 
VALUES 
('RemédioA', 1, 'Tomar pela manhã', 1),
('RemédioB', 2, 'Tomar antes das refeições', 2);

-- Inserir convênios
INSERT INTO Convenio (Id_Convenio, Nome_Convenio, CNPJ, Tempo_Carencia, fk_Pacientes_Consultas_CPF, fk_Pacientes_Consultas_Id_consulta) 
VALUES 
(1, 'Convenio1', '12345678901234', 30, '11122233344', 1),
(2, 'Convenio2', '56789012345678', 45, '55566677788', 2);

-- Inserir tipos de quarto
INSERT INTO Tipo_quarto (Id, Descricao, valor_diaria) 
VALUES 
(1, 'Standard', '100.00'),
(2, 'Luxo', '200.00');

-- Inserir quartos
INSERT INTO Quarto (Id, Numero, Tipo, fk_Tipo_quarto_Id) 
VALUES 
(1, 101, 'Standard', 1),
(2, 201, 'Luxo', 2);

-- Inserir internações
INSERT INTO Internacao (Id, Data_entrada, Data_prev_alta, Procedimento, Data_alta, fk_Quarto_Id) 
VALUES 
(1, '2023-01-10', '2023-01-15', 'Cirurgia Cardíaca', '2023-01-16', 1),
(2, '2023-01-15', '2023-01-20', 'Cirurgia Ortopédica', '2023-01-21', 2);

-- Inserir enfermeiros
INSERT INTO Enfermeiro (Id, Nome, CPF, CRE) 
VALUES 
(1, 'Enf. Oliveira', '11122233344', '98765'),
(2, 'Enf. Santos', '55566677788', '54321');

-- Inserir relacionamentos possui
INSERT INTO possui (fk_Medico_CRM, fk_Especialidades_Id_Especialidade) 
VALUES 
('CRM123', 1),
('CRM456', 2);

-- Inserir relacionamentos realiza
INSERT INTO realiza (fk_Medico_CRM, fk_Consultas_Id_consulta) 
VALUES 
('CRM123', 1),
('CRM456', 2);

-- Inserir relacionamentos emitir
INSERT INTO emitir (fk_Medico_CRM, fk_Receita_Medica_Id_receita) 
VALUES 
('CRM123', 1),
('CRM456', 2);

-- Inserir relacionamentos requer
INSERT INTO requer (fk_Enfermeiro_Id, fk_Internacao_Id) 
VALUES 
(1, 1),
(2, 2);

-- Inserir relacionamentos requer_Internacao_Pacientes_Consultas_Medico
INSERT INTO requer_Internacao_Pacientes_Consultas_Medico (fk_Internacao_Id, fk_Pacientes_Consultas_CPF, fk_Pacientes_Consultas_Id_consulta, fk_Medico_CRM) 
VALUES 
(1, '11122233344', 1, 'CRM123'),
(2, '55566677788', 2, 'CRM456');