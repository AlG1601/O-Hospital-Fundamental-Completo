# O Hospital Fundamental

Bem-vindo ao repositório "O Hospital Fundamental". Aqui você encontrará o desenvolvimento do banco de dados para um sistema hospitalar, com foco especial no controle de internações de pacientes.

## Descrição

Após a primeira versão do projeto de banco de dados, percebemos a necessidade de expandir as funcionalidades para incluir requisitos essenciais, principalmente relacionados ao controle de internações. O sistema registra dados como data de entrada, data prevista e efetiva de alta, além de procedimentos a serem realizados.

As internações estão vinculadas a quartos, cada um com número, tipo, descrição e valor diário. O hospital possui tipos de quarto como apartamentos, quartos duplos e enfermarias.

Profissionais de enfermagem são responsáveis por acompanhar os pacientes. Cada enfermeiro(a) possui nome, CPF e registro no conselho de enfermagem (CRE).

## Modelo Lógico

Abaixo está o modelo lógico do banco de dados:
<img src="https://github.com/AlG1601/Os-Segredos-do-Hospital/blob/main/img%20Modelo%20l%C3%B3gico%20-%20Os%20Segredos%20do%20Hospital.png" />

## Modelo Físico
Aqui está o modelo físico do banco de dados, apresentado em SQL:
``` MySQL
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
```

## Agradecimentos
Obrigado por explorar "Os Segredos do Hospital". Se tiver alguma sugestão ou contribuição, fique à vontade para criar um pull request. Juntos, estamos construindo algo incrível!
