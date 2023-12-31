CREATE DATABASE IF NOT EXISTS SEGREDOS_HOSPITAL;
USE SEGREDOS_HOSPITAL;

/* Modelo lógico - Os Segredos do Hospital: */

CREATE TABLE Medico (
    CRM varchar(20) PRIMARY KEY,
    Nome varchar(255),
    RG varchar(20),
    CPF varchar(14),
    Endereco varchar(255),
    Telefone varchar(15),
    Cargo varchar(50)
);

CREATE TABLE Especialidades (
    Id_Especialidade int PRIMARY KEY,
    Nome_Especialidade varchar(255)
);

CREATE TABLE Pacientes (
    CPF varchar(14) PRIMARY KEY,
    Nome varchar(255),
    RG varchar(20),
    Endereco varchar(255),
    Telefone varchar(15),
    E_mail varchar(255),
    Data_Nascimento date
);

CREATE TABLE Consultas (
    Id_consulta int PRIMARY KEY,
    Data_consulta date,
    Nome_medico varchar(255),
    Nome_paciente varchar(255),
    Valor_consulta float,
    Nome_especialidade varchar(255),
    Nome_convenio varchar(255),
    fk_medico_crm varchar(20),
    fk_paciente_cpf varchar(14),
    FOREIGN KEY (fk_medico_crm) REFERENCES Medico (CRM),
    FOREIGN KEY (fk_paciente_cpf) REFERENCES Pacientes (CPF)
);

CREATE TABLE Receita_Medica (
    Id_receita int PRIMARY KEY,
    Nome_medicamento varchar(255),
    Qtde_medicamentos int,
    Instrucoes_de_uso varchar(255),
    fk_medico_crm varchar(20),
    FOREIGN KEY (fk_medico_crm) REFERENCES Medico (CRM)
);

CREATE TABLE Convenio (
    Id_Convenio int PRIMARY KEY,
    Nome_Convenio varchar(255),
    CNPJ varchar(20),
    Tempo_Carencia int,
    fk_paciente_cpf varchar(14),
    FOREIGN KEY (fk_paciente_cpf) REFERENCES Pacientes (CPF)
);

CREATE TABLE Tipo_quarto (
    Id int PRIMARY KEY,
    Descricao varchar(255),
    valor_diaria varchar(255)
);

CREATE TABLE Quarto (
    Id int PRIMARY KEY,
    Numero int,
    Tipo varchar(255),
    fk_Tipo_quarto_Id int,
    FOREIGN KEY (fk_Tipo_quarto_Id) REFERENCES Tipo_quarto (Id) ON DELETE CASCADE
);

CREATE TABLE Enfermeiro (
    Id int PRIMARY KEY,
    Nome varchar(255),
    CPF varchar(14),
    CRE varchar(20)
);

CREATE TABLE Internacao (
    Id int PRIMARY KEY,
    Data_entrada date,
    Data_prev_alta date,
    Procedimento varchar(255),
    Data_alta date,
    fk_Quarto_Id int,
    fk_Medico_CRM varchar(20),
    fk_paciente_cpf varchar(14),
    fk_enfermeiro_id int,
    FOREIGN KEY (fk_Quarto_Id) REFERENCES Quarto (Id) ON DELETE CASCADE,
    FOREIGN KEY (fk_Medico_CRM) REFERENCES Medico (CRM),
    FOREIGN KEY (fk_paciente_cpf) REFERENCES Pacientes (CPF),
    FOREIGN KEY (fk_enfermeiro_id) REFERENCES Enfermeiro (Id)
);


-- Inclusão de médicos com diferentes especialidades
INSERT INTO Medico (CRM, Nome, RG, CPF, Endereco, Telefone, Cargo)
VALUES
    ('CRM001', 'Dr. Pedro', '123456', '98765432101', 'Rua A, 123', '123456789', 'Cardiologista'),
    ('CRM002', 'Dr. Ana', '789012', '12345678901', 'Rua B, 456', '987654321', 'Pediatria'),
    ('CRM003', 'Dr. João', '345678', '87654321098', 'Rua C, 789', '654321987', 'Ginecologista'),
    ('CRM004', 'Dra. Carla', '567890', '54321098765', 'Rua D, 1011', '987654321', 'Ortopedista'),
    ('CRM005', 'Dr. Maria', '678901', '43210987654', 'Rua E, 1213', '123456789', 'Dermatologista'),
    ('CRM006', 'Dr. Roberto', '789012', '32109876543', 'Rua F, 1415', '654321987', 'Oftalmologista'),
    ('CRM007', 'Dra. Julia', '890123', '21098765432', 'Rua G, 1617', '987654321', 'Neurologista'),
    ('CRM008', 'Dr. Luiz', '901234', '10987654321', 'Rua H, 1819', '123456789', 'Oncologista'),
    ('CRM009', 'Dra. Sofia', '123456', '98765432109', 'Rua I, 2021', '987654321', 'Psiquiatra'),
    ('CRM010', 'Dr. Carlos', '234567', '87654321098', 'Rua J, 2223', '654321987', 'Urologista');

-- Inclusão de especialidades
INSERT INTO Especialidades (Id_Especialidade, Nome_Especialidade)
VALUES
    (1, 'Pediatria'),
    (2, 'Clínica Geral'),
    (3, 'Gastrenterologia'),
    (4, 'Dermatologia'),
    (5, 'Ortopedia'),
    (6, 'Cardiologia'),
    (7, 'Psiquiatria');

-- Inclusão de pacientes
INSERT INTO Pacientes (CPF, Nome, RG, Endereco, Telefone, E_mail, Data_Nascimento)
VALUES
    ('111.222.333-44', 'João Silva', '1234567', 'Rua A, 123', '1111-2222', 'joao@email.com', '1990-05-15'),
    ('222.333.444-55', 'Maria Oliveira', '7654321', 'Rua B, 456', '2222-3333', 'maria@email.com', '1985-08-20'),
    ('333.444.555-66', 'Carlos Santos', '9876543', 'Rua C, 789', '3333-4444', 'carlos@email.com', '1978-12-10'),
    ('444.555.666-77', 'Ana Pereira', '3456789', 'Rua D, 012', '4444-5555', 'ana@email.com', '1995-03-25'),
    ('555.666.777-88', 'Lucas Oliveira', '8765432', 'Rua E, 345', '5555-6666', 'lucas@email.com', '1980-06-30'),
    ('666.777.888-99', 'Mariana Santos', '2345678', 'Rua F, 678', '6666-7777', 'mariana@email.com', '1992-09-14'),
    ('777.888.999-00', 'Roberto Pereira', '8901234', 'Rua G, 901', '7777-8888', 'roberto@email.com', '1987-02-05'),
    ('888.999.000-11', 'Isabel Silva', '5678901', 'Rua H, 234', '8888-9999', 'isabel@email.com', '1998-07-18'),
    ('999.000.111-22', 'Ricardo Oliveira', '1237890', 'Rua I, 567', '9999-0000', 'ricardo@email.com', '1983-10-23'),
    ('123.234.345-45', 'Cristina Santos', '4567890', 'Rua J, 890', '1234-5678', 'cristina@email.com', '1996-01-28'),
    ('234.345.456-56', 'Felipe Pereira', '7890123', 'Rua K, 123', '2345-6789', 'felipe@email.com', '1989-04-12'),
    ('345.456.567-67', 'Beatriz Oliveira', '0123456', 'Rua L, 456', '3456-7890', 'beatriz@email.com', '1991-11-07'),
    ('456.567.678-78', 'Guilherme Silva', '3456789', 'Rua M, 789', '4567-8901', 'guilherme@email.com', '1986-08-15'),
    ('567.678.789-89', 'Tatiane Santos', '6789012', 'Rua N, 012', '5678-9012', 'tatiane@email.com', '1994-05-20'),
    ('678.789.890-90', 'Daniel Pereira', '9012345', 'Rua O, 345', '6789-0123', 'daniel@email.com', '1982-02-03');
    
-- Inclusão de consultas
INSERT INTO Consultas (Id_consulta, Data_consulta, Nome_medico, Nome_paciente, Valor_consulta, Nome_especialidade, Nome_convenio, fk_medico_crm, fk_paciente_cpf)
VALUES
    (1, '2018-03-10', 'Dr. Oliveira', 'João Silva', 150.00, 'Clínica Geral', 'Convenio A', 'CRM001', '111.222.333-44'),
    (2, '2019-05-20', 'Dra. Santos', 'Maria Oliveira', 180.00, 'Pediatria', 'Convenio B', 'CRM003', '222.333.444-55'),
    (3, '2017-08-15', 'Dr. Silva', 'Carlos Santos', 120.00, 'Gastrenterologia', 'Convenio C', 'CRM008', '333.444.555-66'),
    (4, '2016-12-05', 'Dra. Pereira', 'Ana Pereira', 200.00, 'Dermatologia', 'Convenio D', 'CRM002', '444.555.666-77'),
    (5, '2015-02-18', 'Dr. Oliveira', 'Lucas Oliveira', 160.00, 'Clínica Geral', 'Convenio E', 'CRM009', '555.666.777-88'),
    (6, '2018-11-30', 'Dra. Santos', 'Mariana Santos', 180.00, 'Pediatria', 'Convenio F', 'CRM007', '666.777.888-99'),
    (7, '2016-06-25', 'Dr. Silva', 'Roberto Pereira', 130.00, 'Gastrenterologia', 'Convenio G', 'CRM007', '777.888.999-00'),
    (8, '2019-09-14', 'Dra. Pereira', 'Isabel Silva', 190.00, 'Dermatologia', 'Convenio H', 'CRM010', '888.999.000-11'),
    (9, '2017-04-08', 'Dr. Oliveira', 'Ricardo Oliveira', 170.00, 'Clínica Geral', 'Convenio I', 'CRM008', '999.000.111-22'),
    (10, '2015-10-22', 'Dra. Santos', 'Cristina Santos', 140.00, 'Pediatria', 'Convenio J', 'CRM006', '123.234.345-45'),
    (11, '2016-07-11', 'Dr. Silva', 'Felipe Pereira', 160.00, 'Gastrenterologia', 'Convenio K', 'CRM001', '234.345.456-56'),
    (12, '2018-01-28', 'Dra. Pereira', 'Beatriz Oliveira', 180.00, 'Dermatologia', 'Convenio L', 'CRM004', '345.456.567-67'),
    (13, '2019-06-05', 'Dr. Oliveira', 'Guilherme Silva', 150.00, 'Clínica Geral', 'Convenio M', 'CRM005', '456.567.678-78'),
    (14, '2017-03-19', 'Dra. Santos', 'Tatiane Santos', 160.00, 'Pediatria', 'Convenio N', 'CRM004', '567.678.789-89'),
    (15, '2016-09-03', 'Dr. Silva', 'Daniel Pereira', 140.00, 'Gastrenterologia', 'Convenio O', 'CRM007', '678.789.890-90'),
    (16, '2019-12-10', 'Dra. Pereira', 'João Silva', 190.00, 'Dermatologia', 'Convenio P', 'CRM004', '111.222.333-44'),
    (17, '2016-04-25', 'Dr. Oliveira', 'Maria Oliveira', 130.00, 'Clínica Geral', 'Convenio Q', 'CRM001', '222.333.444-55'),
    (18, '2018-08-12', 'Dra. Santos', 'Carlos Santos', 160.00, 'Pediatria', 'Convenio R', 'CRM010', '333.444.555-66'),
    (19, '2017-02-05', 'Dr. Silva', 'Ana Pereira', 180.00, 'Gastrenterologia', 'Convenio S', 'CRM006', '444.555.666-77'),
    (20, '2015-11-18', 'Dra. Pereira', 'Lucas Oliveira', 150.00, 'Dermatologia', 'Convenio T', 'CRM008', '555.666.777-88');

-- Incluindo convênios
INSERT INTO Convenio (Id_Convenio, Nome_Convenio, CNPJ, Tempo_Carencia, fk_paciente_cpf)
VALUES
    (1, 'Convenio A', '12345678901234', 30, '111.222.333-44'),
    (2, 'Convenio B', '23456789012345', 30, '222.333.444-55'),
    (3, 'Convenio C', '34567890123456', 30, '333.444.555-66'),
    (4, 'Convenio D', '45678901234567', 30, '444.555.666-77');
    
-- Adicionar uma coluna fk_convenio_id na tabela Pacientes
ALTER TABLE Pacientes ADD COLUMN fk_convenio_id INT;

-- Atualizar a tabela Convenio para referenciar Pacientes
ALTER TABLE Convenio ADD CONSTRAINT FK_Convenio_Pacientes
    FOREIGN KEY (fk_paciente_cpf) REFERENCES Pacientes (CPF);

-- Associando pacientes a convênios
UPDATE Pacientes SET fk_convenio_id = 1 WHERE CPF = '111.222.333-44';
UPDATE Pacientes SET fk_convenio_id = 2 WHERE CPF = '222.333.444-55';
UPDATE Pacientes SET fk_convenio_id = 3 WHERE CPF = '333.444.555-66';
UPDATE Pacientes SET fk_convenio_id = 4 WHERE CPF = '444.555.666-77';
UPDATE Pacientes SET fk_convenio_id = 1 WHERE CPF = '555.666.777-88';

-- Realizando consultas associadas a pacientes
INSERT INTO Consultas (Id_consulta, Data_consulta, Nome_medico, Nome_paciente, Valor_consulta, Nome_especialidade, Nome_convenio, fk_medico_crm, fk_paciente_cpf)
VALUES
    (21, '2018-03-10', 'Dr. Oliveira', 'João Silva', 150.00, 'Clínica Geral', 'Convenio A', 'CRM001', '111.222.333-44'),
    (22, '2019-05-20', 'Dra. Santos', 'Maria Oliveira', 180.00, 'Pediatria', 'Convenio B', 'CRM003', '222.333.444-55'),
    (23, '2017-08-15', 'Dr. Silva', 'Carlos Santos', 120.00, 'Gastrenterologia', 'Convenio C', 'CRM008', '333.444.555-66'),
    (24, '2016-12-05', 'Dra. Pereira', 'Ana Pereira', 200.00, 'Dermatologia', 'Convenio D', 'CRM002', '444.555.666-77'),
    (25, '2015-02-18', 'Dr. Oliveira', 'Lucas Oliveira', 160.00, 'Clínica Geral', 'Convenio A', 'CRM009', '555.666.777-88');

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

ALTER TABLE Convenio
ADD COLUMN fk_Medico_CRM VARCHAR(20),
ADD CONSTRAINT FK_Convenio_Medico
    FOREIGN KEY (fk_Medico_CRM)
    REFERENCES Medico (CRM)
    ON DELETE CASCADE;

-- Criar tabela de relacionamento entre Internacao e Enfermeiro
CREATE TABLE Enfermeiro_Internacao (
    fk_Enfermeiro_Id INT,
    fk_Internacao_Id INT,
    PRIMARY KEY (fk_Enfermeiro_Id, fk_Internacao_Id),
    FOREIGN KEY (fk_Enfermeiro_Id) REFERENCES Enfermeiro (Id) ON DELETE RESTRICT,
    FOREIGN KEY (fk_Internacao_Id) REFERENCES Internacao (Id) ON DELETE CASCADE
);

-- Inserir tipos de quartos
INSERT INTO Tipo_quarto (Id, Descricao, valor_diaria)
VALUES
    (1, 'Apartamento', '300.00'),
    (2, 'Quarto Duplo', '200.00'),
    (3, 'Enfermaria', '150.00');

-- Inserir quartos
INSERT INTO Quarto (Id, Numero, Tipo, fk_Tipo_quarto_Id)
VALUES
    (1, 101, 'Apartamento', 1),
    (2, 201, 'Quarto Duplo', 2),
    (3, 301, 'Enfermaria', 3),
    (4, 102, 'Apartamento', 1),
    (5, 202, 'Quarto Duplo', 2);
    
-- Inserir enfermeiros
INSERT INTO Enfermeiro (Id, Nome, CPF, CRE)
VALUES
    (1, 'Enfermeiro 1', '111.222.333-44', 'CRE001'),
    (2, 'Enfermeiro 2', '222.333.444-55', 'CRE002'),
    (3, 'Enfermeiro 3', '333.444.555-66', 'CRE003'),
    (4, 'Enfermeiro 4', '444.555.666-77', 'CRE004'),
    (5, 'Enfermeiro 5', '555.666.777-88', 'CRE005'),
    (6, 'Enfermeiro 6', '666.777.888-99', 'CRE006'),
    (7, 'Enfermeiro 7', '777.888.999-00', 'CRE007'),
    (8, 'Enfermeiro 8', '888.999.000-10', 'CRE008'),
    (9, 'Enfermeiro 9', '999.000.111-20', 'CRE009'),
    (10, 'Enfermeiro 10', '000.111.222-30', 'CRE010');

-- Inserir internações
INSERT INTO Internacao (Id, Data_entrada, Data_prev_alta, Procedimento, Data_alta, fk_Quarto_Id, fk_Medico_CRM, fk_Paciente_CPF, fk_enfermeiro_id)
VALUES
    (1, '2018-03-15', '2018-03-20', 'Cirurgia de Apêndice', '2018-03-22', 1, 'CRM001', '111.222.333-44', 1),
    (2, '2019-06-10', '2019-06-15', 'Tratamento de Fratura', '2019-06-18', 2, 'CRM003', '222.333.444-55', 2),
    (3, '2017-08-20', '2017-08-25', 'Exames Cardiológicos', '2017-08-28', 3, 'CRM008', '333.444.555-66', 3),
    (4, '2016-12-10', '2016-12-15', 'Cirurgia Plástica', '2016-12-18', 1, 'CRM002', '444.555.666-77', 4),
    (5, '2015-02-25', '2015-03-02', 'Tratamento Respiratório', '2015-03-05', 2, 'CRM009', '555.666.777-88', 5),
    (6, '2018-12-01', '2018-12-05', 'Cirurgia de Apêndice', '2018-12-08', 3, 'CRM007', '666.777.888-99', 6),
    (7, '2016-07-01', '2016-07-05', 'Tratamento de Fratura', '2016-07-08', 1, 'CRM007', '777.888.999-00', 7);

-- Atualizar mais duas internações para o mesmo paciente
UPDATE Internacao SET fk_Paciente_CPF = '111.222.333-44' WHERE Id IN (8, 9);

-- Inserir mais duas internações para o mesmo paciente
INSERT INTO Internacao (Id, Data_entrada, Data_prev_alta, Procedimento, Data_alta, fk_Quarto_Id, fk_Medico_CRM, fk_Paciente_CPF, fk_enfermeiro_id)
VALUES
    (8, '2019-09-10', '2019-09-15', 'Tratamento Cardíaco', '2019-09-18', 2, 'CRM010', '111.222.333-44', 8),
    (9, '2020-05-01', '2020-05-05', 'Cirurgia de Apêndice', '2020-05-08', 3, 'CRM005', '111.222.333-44', 9);

-- Inserir mais quatro internações para diferentes pacientes
INSERT INTO Internacao (Id, Data_entrada, Data_prev_alta, Procedimento, Data_alta, fk_Quarto_Id, fk_Medico_CRM, fk_Paciente_CPF, fk_enfermeiro_id)
VALUES
    (10, '2017-04-15', '2017-04-20', 'Exames Cardiológicos', '2017-04-22', 1, 'CRM008', '999.000.111-22', 5),
    (11, '2015-11-10', '2015-11-15', 'Tratamento Respiratório', '2015-11-18', 2, 'CRM006', '123.234.345-45', 6),
    (12, '2016-07-20', '2016-07-25', 'Cirurgia Plástica', '2016-07-28', 3, 'CRM001', '234.345.456-56', 2),
    (13, '2018-02-05', '2018-02-10', 'Tratamento de Fratura', '2018-02-12', 1, 'CRM004', '345.456.567-67', 1);


-- Associação entre internações e enfermeiros
INSERT INTO Enfermeiro_Internacao (fk_Enfermeiro_Id, fk_Internacao_Id)
VALUES
    (1, 1),
    (2, 1),
    (3, 2),
    (4, 2),
    (5, 3),
    (6, 3),
    (7, 4),
    (8, 4),
    (9, 5),
    (10, 5);

-- drop database if exists segredos_hospital;
