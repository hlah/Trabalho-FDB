-- Tipo enumeravel para sexo
CREATE TYPE SEXO_T AS ENUM('M', 'F');

-- DROP TYPE SEXO_T;

-- Entidade hospital recebe tabela própia
CREATE TABLE Hospital (
nome_hospital VARCHAR NOT NULL PRIMARY KEY,
rua VARCHAR NOT NULL,
cidade VARCHAR NOT NULL,
uf CHAR(2) NOT NULL
);

-- A entidade Prontuario tem sua tabela própia
-- Como o paciente tem uma relação de um para um como o prontuário utilizamos a mesma tabela para representar os dois.
CREATE TABLE Prontuario (
numero_prontuario INT NOT NULL PRIMARY KEY,
rg CHAR(10) NOT NULL UNIQUE,
nome VARCHAR NOT NULL,
data_nascimento DATE,
sexo SEXO_T NOT NULL,
nacionalidade VARCHAR
);

-- Visitante também possui sua tabela própia
-- Só deve ser criado quando realizar uma visita
CREATE TABLE Visitante (
rg_visitante CHAR(10) NOT NULL PRIMARY KEY,
nome_visitante VARCHAR NOT NULL
);

-- A relação Visita tem cardinalidade (n, n) e por isso precisa de uma tabela pŕopia.
CREATE TABLE Visita (
rg_visitante VARCHAR NOT NULL,
numero_prontuario INT NOT NULL,
data_visita DATE NOT NULL,
FOREIGN KEY(rg_visitante) REFERENCES Visitante,
FOREIGN KEY(numero_prontuario) REFERENCES Prontuario,
PRIMARY KEY(rg_visitante, numero_prontuario, data_visita)
);

-- A entidade exame recebe uma tabela própia
-- A relação 'examinado' é (1, n), por isso a referencia fica no lado que é n, ou seja na entidade 'exame'
CREATE TABLE Exame (
tipo VARCHAR NOT NULL,
data_hora_solicitacao TIMESTAMP NOT NULL,
numero_prontuario INT NOT NULL,
data_hora_realizacao TIMESTAMP,
resultado VARCHAR,
imagem VARCHAR,
FOREIGN KEY(numero_prontuario) REFERENCES Prontuario,
PRIMARY KEY(numero_prontuario, tipo, data_hora_solicitacao)
);


-- A entidade doença possui uma tabela própia
CREATE TABLE Doenca (
cid VARCHAR NOT NULL PRIMARY KEY,
nome VARCHAR
);

-- O relacionamento diagnostico tem cardinalidade (n, n), por isso necessita tabela própia
CREATE TABLE Diagnostico (
cid VARCHAR NOT NULL,
numero_prontuario INT NOT NULL,
data_diag DATE NOT NULL,
FOREIGN KEY(cid) REFERENCES Doenca,
FOREIGN KEY(numero_prontuario) REFERENCES Prontuario,
PRIMARY KEY(cid, numero_prontuario, data_diag)
);

-- Internação recebe entidade própria
-- Relacionamento 'internado' é (1, n), referencia fica no lado n, ou seja, na entidade 'internado'
-- Relacionamento 'InternadoEm' é (1, n), a referencia fica no lado n, ou seja, na entidade 'internado'
CREATE TABLE Internacao (
numero_prontuario INT NOT NULL,
data_inicio DATE NOT NULL,
data_fim DATE,
nome_hospital VARCHAR NOT NULL,
FOREIGN KEY(numero_prontuario) REFERENCES Prontuario,
FOREIGN KEY(nome_hospital) REFERENCES Hospital,
PRIMARY KEY(numero_prontuario, data_inicio)
);

-- A genrealizacao funcionario -> medico, funcionari -> enfermeira foi feita utilizando uma tabela
-- separada para os atributos comuns e uma tabela dedicada a cada especializaçao, as tabelas são ligadas
-- utilizando uma chave primarioa comum entre elas

-- Funcionario, entiade 'abstrata'
CREATE TABLE Funcionario (
codigo_func INT NOT NULL PRIMARY KEY,
nome VARCHAR NOT NULL,
salario FLOAT NOT NULL
);

-- A entidade médico é uma especialização do funcionario, recebe tabela propia
CREATE TABLE Medico (
codigo_func INT NOT NULL PRIMARY KEY,
crm VARCHAR NOT NULL UNIQUE,
especialidade VARCHAR,
FOREIGN KEY(codigo_func) REFERENCES Funcionario
);

-- A entidade enfermeira é uma especialização do funcionario, recebe tabela propia
CREATE TABLE Enfermeira (
codigo_func INT NOT NULL PRIMARY KEY,
coren VARCHAR NOT NULL UNIQUE,
especialidade VARCHAR,
FOREIGN KEY(codigo_func) REFERENCES Funcionario
);




-- Relacionamento 'Trabalho' é (n, n) e por isso precisa de tabaela propria
CREATE TABLE Trabalho (
codigo_func INT NOT NULL,
nome_hospital VARCHAR NOT NULL,
FOREIGN KEY(codigo_func) REFERENCES Funcionario,
FOREIGN KEY(nome_hospital) REFERENCES Hospital,
PRIMARY KEY(codigo_func, nome_hospital)
);

-- Relacionament 'Assiste tem cardinalidade (n, n), e por isso possui tabela própria
CREATE TABLE Assiste (
crm VARCHAR NOT NULL,
numero_prontuario INT NOT NULL,
data_inicio DATE NOT NULL,
FOREIGN KEY(crm) REFERENCES Medico(crm),
FOREIGN KEY(numero_prontuario, data_inicio) REFERENCES Internacao,
PRIMARY KEY(crm, numero_prontuario, data_inicio)
);

-- A entidade 'equipe' recebe uma tabela própria
CREATE TABLE Equipe (
codigo_equipe CHAR(4) NOT NULL PRIMARY KEY,
especialidade VARCHAR
);

-- Relacionamento 'Integrante' tem cardinalidade (n, n) e por isso recebe tabela pŕopria
CREATE TABLE Integrante (
codigo_func INT NOT NULL,
codigo_equipe CHAR(4) NOT NULL,
FOREIGN KEY(codigo_func) REFERENCES Funcionario,
FOREIGN KEY(codigo_equipe) REFERENCES Equipe,
PRIMARY KEY(codigo_func, codigo_equipe)
);

-- Entidade cirurgia recebe uma tabela própria
-- Relacionamento 'CirurgiaFeita' é (1, n), referencia fica no lado n, ou seja, na entidade 'cirurgia'
-- Relacionamento 'FeitaPor' é (1, n), referencia fica no lado n, ou seja, na entidade 'cirurgia'
CREATE TABLE Cirurgia (
codigo_cirurgia INT NOT NULL PRIMARY KEY,
numero_prontuario INT NOT NULL,
data_inicio DATE NOT NULL,
codigo_equipe CHAR(4) NOT NULL,
tipo VARCHAR NOT NULL,
descricao VARCHAR,
FOREIGN KEY(numero_prontuario, data_inicio) REFERENCES Internacao,
FOREIGN KEY(codigo_equipe) REFERENCES Equipe
);

-- Entidade prescrição tem tabela própria
-- Relacionamento 'Prescrito' é (1, n) referencia fica em lado 'n', na prescrição
-- Relacionamento 'Prescreve' é (1, n) referencia fica em lado 'n', na prescrição
CREATE TABLE Prescricao (
data_hora TIMESTAMP NOT NULL,
numero_prontuario INT NOT NULL,
medico_assinante VARCHAR NOT NULL,
FOREIGN KEY(numero_prontuario) REFERENCES Prontuario,
FOREIGN KEY(medico_assinante) REFERENCES Medico(crm),
PRIMARY KEY(data_hora, numero_prontuario)
);

-- Entidade Medicamento recebe entidade própria
CREATE TABLE Medicamento (
nome_medicamento VARCHAR NOT NULL PRIMARY KEY,
quantidade FLOAT NOT NULL,
unidade VARCHAR NOT NULL
);

-- Relacionamento 'ComTratamento' é (n, n), precisa de tabela própria
CREATE TABLE ComTratamento (
nome_medicamento VARCHAR NOT NULL,
numero_prontuario INT NOT NULL,
data_hora TIMESTAMP NOT NULL,
dose FLOAT NOT NULL,
modo_uso VARCHAR,
FOREIGN KEY(data_hora, numero_prontuario) REFERENCES Prescricao,
FOREIGN KEY(nome_medicamento) REFERENCES Medicamento,
PRIMARY KEY(nome_medicamento, numero_prontuario, data_hora)
);

-- Relacionamento 'Administara' é (n, n), precisa de tabela própria
CREATE TABLE Administra (
coren VARCHAR NOT NULL,
data_hora TIMESTAMP NOT NULL,
numero_prontuario INT NOT NULL,
FOREIGN KEY(coren) REFERENCES Enfermeira(coren),
FOREIGN KEY(data_hora, numero_prontuario) REFERENCES Prescricao,
PRIMARY KEY(coren, data_hora, numero_prontuario)
);

