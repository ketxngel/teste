-- Database: Sistema onibus

-- DROP DATABASE IF EXISTS "Sistema onibus";

CREATE DATABASE "Sistema onibus"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;



	CREATE TABLE Administrador(
    Admin_id INT PRIMARY KEY,
    Nome VARCHAR(50),
    Senha VARCHAR(50)
);

CREATE TABLE Cidade(
    Nome VARCHAR(50) PRIMARY KEY,
    Num_habitantes INT
);

CREATE TABLE Empresa (
    Nome VARCHAR(50) PRIMARY KEY,
    Contato VARCHAR(14)
);

CREATE TABLE Garagem(
    Nome VARCHAR(50) PRIMARY KEY,
    Num_vagas INT,
    Empresa_id VARCHAR(50),
    FOREIGN KEY (Empresa_id) REFERENCES Empresa(Nome)
);

CREATE TABLE Horario(
    Horario_id INT PRIMARY KEY,
    Duracao VARCHAR(25),
    Dia_semana VARCHAR(50)
);

CREATE TABLE Linha(
    Nome VARCHAR(3) PRIMARY KEY,
    Modelo VARCHAR(50),
    Empresa_id VARCHAR(50),
    Garagem_id VARCHAR(50),
    FOREIGN KEY (Empresa_id) REFERENCES Empresa(Nome),
    FOREIGN KEY (Garagem_id) REFERENCES Garagem(Nome)
);

CREATE TABLE Motorista(
    Motorista_id INT PRIMARY KEY, -- chave primaria tem que mudar no desenho que está como PK o nome o que não corresponde com o banco
	Nome VARCHAR(50),
    Telefone VARCHAR(15),
    Foto BYTEA,
	Linha_id VARCHAR(3),
	Empresa_id VARCHAR(50),
	FOREIGN KEY (Linha_id) REFERENCES Linha(Nome),
	FOREIGN KEY (Empresa_id) REFERENCES Empresa(Nome)
);

CREATE TABLE Terminal(
    Nome VARCHAR(50) PRIMARY KEY,
    Cidade_id VARCHAR(50),
    FOREIGN KEY (Cidade_id) REFERENCES Cidade(Nome)
);

CREATE TABLE Trajeto(
    Linha_id VARCHAR(3),
    Origem_id VARCHAR(50),
    Destino_id VARCHAR(50),
    PRIMARY KEY (Linha_id, Origem_id, Destino_id),
    FOREIGN KEY (Linha_id) REFERENCES Linha(Nome),
    FOREIGN KEY (Origem_id) REFERENCES Terminal(Nome),
    FOREIGN KEY (Destino_id) REFERENCES Terminal(Nome)
);

CREATE TABLE Parada(
    Nome VARCHAR(6) PRIMARY KEY,
    Cidade_id VARCHAR(50),
    FOREIGN KEY (Cidade_id) REFERENCES Cidade(Nome)
);

CREATE TABLE Trajeto_Parada(
    Linha_id VARCHAR(3),
    Parada_1 VARCHAR(6),
    Parada_2 VARCHAR(6),
    Parada_3 VARCHAR(6),
    Parada_4 VARCHAR(6),
    Parada_5 VARCHAR(6),
    PRIMARY KEY (Linha_id),
    FOREIGN KEY (Linha_id) REFERENCES Linha(Nome),
	FOREIGN KEY (Parada_1) REFERENCES Parada(Nome),
	FOREIGN KEY (Parada_2) REFERENCES Parada(Nome),
	FOREIGN KEY (Parada_3) REFERENCES Parada(Nome),
	FOREIGN KEY (Parada_4) REFERENCES Parada(Nome),
	FOREIGN KEY (Parada_5) REFERENCES Parada(Nome)
);

CREATE TABLE Horario_Linha(
    Linha_id VARCHAR(3),
    Horario_1 INT,
    Horario_2 INT,
    Horario_3 INT,
    Horario_4 INT,
    Horario_5 INT,
    PRIMARY KEY (Linha_id),
    FOREIGN KEY (Linha_id) REFERENCES Linha(Nome),
	FOREIGN KEY (Horario_1) REFERENCES Horario(Horario_id),
	FOREIGN KEY (Horario_2) REFERENCES Horario(Horario_id),
	FOREIGN KEY (Horario_3) REFERENCES Horario(Horario_id),
	FOREIGN KEY (Horario_4) REFERENCES Horario(Horario_id),
	FOREIGN KEY (Horario_5) REFERENCES Horario(Horario_id)
);

-- INSERÇÃO DE ADMINISTRADORES --
INSERT INTO Administrador (admin_id, nome, senha)
VALUES
    (1, 'Maristela Holanda', 'Banco_Dados24.1'),
    (2, 'Gabriel Faustino', 'Banco_Dados24.1'),
    (3, 'Bianca Carvalho', 'Banco_Dados24.1'),
    (4, 'Kethlen Ângela', 'Banco_Dados24.1'),
    (5, 'Luana Ferreira', 'Banco_Dados24.1');


	SELECT * FROM Administrador;


	-- INSERÇÃO DE CIDADES --
INSERT INTO Cidade (nome, num_habitantes)
VALUES
    ('Nova Esperança', 287000),
    ('Vale do Sol', 135000),
    ('Orquídea Azul', 458000),
    ('Verdemontes', 76000),
    ('Aurora do Vale', 213000);


	SELECT * FROM Cidade;


	-- INSERÇÃO DE EMPRESAS --
INSERT INTO Empresa (nome, contato)
VALUES
    ('TransVia Express', '(61) 3445-7766'),
    ('Rota Brasil', '(61) 3892-1433'),
    ('Expresso Horizonte', '(61) 3567-9822'),
    ('Viação Estrela Azul', '(61) 3728-5544'),
    ('RotaSul Transportes', '(61) 3998-2233');

-- CONSULTA PARA VERIFICAR A INSERÇÃO --
SELECT * FROM Empresa;

-- INSERÇÃO DE GARAGENS --
INSERT INTO Garagem (nome, num_vagas, empresa_id)
VALUES
    ('Garagem_TE', 6, 'TransVia Express'),
    ('Garagem_RB', 6, 'Rota Brasil'),
    ('Garagem_EH', 6, 'Expresso Horizonte'),
    ('Garagem_VEA', 6, 'Viação Estrela Azul'),
    ('Garagem_RST', 8, 'RotaSul Transportes');

-- CONSULTA PARA VERIFICAR A INSERÇÃO --
SELECT * FROM Garagem;

-- INSERÇÃO DE HORÁRIOS --
INSERT INTO horario (horario_id, duracao, dia_semana)
VALUES 
    (1, '06:00-08:00', 'Segunda à Domingo'),
    (2, '08:00-10:00', 'Segunda à Domingo'),
    (3, '10:00-12:00', 'Segunda à Domingo'),
    (4, '12:00-14:00', 'Segunda à Domingo'),
    (5, '14:00-16:00', 'Segunda à Domingo'),
    (6, '16:00-18:00', 'Segunda à Domingo'),
    (7, '18:00-20:00', 'Segunda à Domingo'),
    (8, '20:00-22:00', 'Segunda à Domingo'),
    (9, '06:00-08:00', 'Segunda à Sexta'),
    (10, '18:00-20:00', 'Segunda à Sexta');

-- CONSULTAS PARA VERIFICAÇÃO --
SELECT * FROM horario;


-- INSERÇÃO DE TERMINAIS  --
INSERT INTO Terminal (Nome, Cidade_id)
VALUES
    ('Terminal Arara Azul', 'Nova Esperança'),
    ('Terminal Patas Pintadas', 'Vale do Sol'),
    ('Terminal Anta Careca', 'Orquídea Azul'),
    ('Terminal Vales Vermelhos', 'Verdemontes'),
    ('Terminal Capim Dourado', 'Aurora do Vale');

-- CONSULTA PARA VERIFICAÇÃO --
SELECT * FROM Terminal;


-- INSERÇÃO DE PARADAS --
INSERT INTO Parada (nome, cidade_id)
VALUES
    ('P1OA', 'Orquídea Azul'),
    ('P2OA', 'Orquídea Azul'),
    ('P3OA', 'Orquídea Azul'),
    ('P4OA', 'Orquídea Azul'),
    ('P5OA', 'Orquídea Azul'),
    ('P6OA', 'Orquídea Azul'),
    ('P7OA', 'Orquídea Azul'),
    ('P8OA', 'Orquídea Azul'),
    ('P9OA', 'Orquídea Azul'),
    ('P10OA', 'Orquídea Azul'),
    ('P11OA', 'Orquídea Azul'),
    ('P12OA', 'Orquídea Azul'),
    ('P1NE', 'Nova Esperança'),
    ('P2NE', 'Nova Esperança'),
    ('P3NE', 'Nova Esperança'),
    ('P4NE', 'Nova Esperança'),
    ('P5NE', 'Nova Esperança'),
    ('P6NE', 'Nova Esperança'),
    ('P7NE', 'Nova Esperança'),
    ('P8NE', 'Nova Esperança'),
    ('P1AV', 'Aurora do Vale'),
    ('P2AV', 'Aurora do Vale'),
    ('P3AV', 'Aurora do Vale'),
    ('P4AV', 'Aurora do Vale'),
    ('P5AV', 'Aurora do Vale'),
    ('P6AV', 'Aurora do Vale'),
    ('P7AV', 'Aurora do Vale'),
    ('P8AV', 'Aurora do Vale'),
    ('P1VS', 'Vale do Sol'),
    ('P2VS', 'Vale do Sol'),
    ('P3VS', 'Vale do Sol'),
    ('P4VS', 'Vale do Sol'),
    ('P5VS', 'Vale do Sol'),
    ('P1V', 'Verdemontes'),
    ('P2V', 'Verdemontes'),
    ('P3V', 'Verdemontes');

-- CONSULTA PARA VERIFICAÇÃO --
SELECT * FROM Parada;

-- INSERÇÃO DE LINHAS  --
INSERT INTO Linha (nome, modelo, empresa_id, garagem_id)
VALUES
    ('665', 'Micro Ônibus', 'TransVia Express', 'Garagem_TE'),
    ('557', 'Ônibus Urbano Padrão', 'TransVia Express', 'Garagem_TE'),
    ('755', 'Ônibus Urbano Padrão', 'TransVia Express', 'Garagem_TE'),
    ('494', 'Ônibus Urbano Sanfonado', 'TransVia Express', 'Garagem_TE'),
    ('821', 'Ônibus Interestadual', 'TransVia Express', 'Garagem_TE'),
    ('566', 'Ônibus Interestadual', 'TransVia Express', 'Garagem_TE'),
    ('242', 'Micro Ônibus', 'Rota Brasil', 'Garagem_RB'),
    ('859', 'Ônibus Urbano Padrão', 'Rota Brasil', 'Garagem_RB'),
    ('485', 'Ônibus Urbano Padrão', 'Rota Brasil', 'Garagem_RB'),
    ('748', 'Ônibus Urbano Sanfonado', 'Rota Brasil', 'Garagem_RB'),
    ('905', 'Ônibus Interestadual', 'Rota Brasil', 'Garagem_RB'),
    ('833', 'Ônibus Interestadual', 'Rota Brasil', 'Garagem_RB'),
    ('355', 'Micro Ônibus', 'Expresso Horizonte', 'Garagem_EH'),
    ('161', 'Ônibus Urbano Padrão', 'Expresso Horizonte', 'Garagem_EH'),
    ('167', 'Ônibus Urbano Padrão', 'Expresso Horizonte', 'Garagem_EH'),
    ('131', 'Ônibus Urbano Sanfonado', 'Expresso Horizonte', 'Garagem_EH'),
    ('586', 'Ônibus Interestadual', 'Expresso Horizonte', 'Garagem_EH'),
    ('797', 'Ônibus Interestadual', 'Expresso Horizonte', 'Garagem_EH'),
    ('234', 'Micro Ônibus', 'Viação Estrela Azul', 'Garagem_VEA'),
    ('284', 'Ônibus Urbano Padrão', 'Viação Estrela Azul', 'Garagem_VEA'),
    ('928', 'Ônibus Urbano Padrão', 'Viação Estrela Azul', 'Garagem_VEA'),
    ('750', 'Ônibus Urbano Sanfonado', 'Viação Estrela Azul', 'Garagem_VEA'),
    ('913', 'Ônibus Interestadual', 'Viação Estrela Azul', 'Garagem_VEA'),
    ('784', 'Ônibus Interestadual', 'Viação Estrela Azul', 'Garagem_VEA'),
    ('341', 'Micro Ônibus', 'RotaSul Transportes', 'Garagem_RST'),
    ('893', 'Micro Ônibus', 'RotaSul Transportes', 'Garagem_RST'),
    ('870', 'Ônibus Urbano Padrão', 'RotaSul Transportes', 'Garagem_RST'),
    ('458', 'Ônibus Urbano Padrão', 'RotaSul Transportes', 'Garagem_RST'),
    ('342', 'Ônibus Urbano Padrão', 'RotaSul Transportes', 'Garagem_RST'),
    ('747', 'Ônibus Urbano Sanfonado', 'RotaSul Transportes', 'Garagem_RST'),
    ('263', 'Ônibus Urbano Sanfonado', 'RotaSul Transportes', 'Garagem_RST'),
    ('988', 'Ônibus Urbano Sanfonado', 'RotaSul Transportes', 'Garagem_RST');

-- CONSULTA PARA VERIFICAÇÃO --
SELECT * FROM Linha;

-- INSERÇÃO DE TRAJETOS  --
INSERT INTO Trajeto (Linha_id, Origem_id, Destino_id)
VALUES
    ('821', 'Terminal Arara Azul', 'Terminal Anta Careca'),
    ('566', 'Terminal Arara Azul', 'Terminal Vales Vermelhos'),
    ('905', 'Terminal Vales Vermelhos', 'Terminal Capim Dourado'),
    ('784', 'Terminal Vales Vermelhos', 'Terminal Anta Careca'),
    ('833', 'Terminal Capim Dourado', 'Terminal Anta Careca'),
    ('586', 'Terminal Capim Dourado', 'Terminal Patas Pintadas'),
    ('797', 'Terminal Patas Pintadas', 'Terminal Anta Careca'),
    ('913', 'Terminal Patas Pintadas', 'Terminal Arara Azul'),
    ('821', 'Terminal Anta Careca', 'Terminal Arara Azul'),
    ('566', 'Terminal Vales Vermelhos', 'Terminal Arara Azul'),
    ('905', 'Terminal Capim Dourado', 'Terminal Vales Vermelhos'),
    ('784', 'Terminal Anta Careca', 'Terminal Vales Vermelhos'),
    ('833', 'Terminal Anta Careca', 'Terminal Capim Dourado'),
    ('586', 'Terminal Patas Pintadas', 'Terminal Capim Dourado'),
    ('797', 'Terminal Anta Careca', 'Terminal Patas Pintadas'),
    ('913', 'Terminal Arara Azul', 'Terminal Patas Pintadas'),
    ('665', 'Terminal Arara Azul', 'Terminal Arara Azul'),
    ('557', 'Terminal Arara Azul', 'Terminal Arara Azul'),
    ('755', 'Terminal Arara Azul', 'Terminal Arara Azul'),
    ('494', 'Terminal Arara Azul', 'Terminal Arara Azul'),
    ('242', 'Terminal Patas Pintadas', 'Terminal Patas Pintadas'),
    ('859', 'Terminal Patas Pintadas', 'Terminal Patas Pintadas'),
    ('485', 'Terminal Patas Pintadas', 'Terminal Patas Pintadas'),
    ('748', 'Terminal Patas Pintadas', 'Terminal Patas Pintadas'),
    ('355', 'Terminal Capim Dourado', 'Terminal Capim Dourado'),
    ('161', 'Terminal Capim Dourado', 'Terminal Capim Dourado'),
    ('167', 'Terminal Capim Dourado', 'Terminal Capim Dourado'),
    ('131', 'Terminal Capim Dourado', 'Terminal Capim Dourado'),
    ('234', 'Terminal Vales Vermelhos', 'Terminal Vales Vermelhos'),
    ('284', 'Terminal Vales Vermelhos', 'Terminal Vales Vermelhos'),
    ('928', 'Terminal Vales Vermelhos', 'Terminal Vales Vermelhos'),
    ('750', 'Terminal Vales Vermelhos', 'Terminal Vales Vermelhos'),
    ('341', 'Terminal Anta Careca', 'Terminal Anta Careca'),
    ('893', 'Terminal Anta Careca', 'Terminal Anta Careca'),
    ('870', 'Terminal Anta Careca', 'Terminal Anta Careca'),
    ('458', 'Terminal Anta Careca', 'Terminal Anta Careca'),
    ('342', 'Terminal Anta Careca', 'Terminal Anta Careca'),
    ('747', 'Terminal Anta Careca', 'Terminal Anta Careca'),
    ('263', 'Terminal Anta Careca', 'Terminal Anta Careca'),
    ('988', 'Terminal Anta Careca', 'Terminal Anta Careca');

-- CONSULTA PARA VERIFICAÇÃO --
SELECT * FROM Trajeto;

-- INSERÇÃO DE MOTORISTA  --

INSERT INTO Motorista(telefone, linha_id, empresa_id, nome, motorista_id) VALUES
('(61) 96013-8821', '665', 'TransVia Express', 'Lucas', 1),
('(61) 93396-8782', '557', 'TransVia Express', 'Mateus', 2),
('(61) 98307-8258', '755', 'TransVia Express', 'Gabriel ', 3),
('(61) 95797-6886', '494', 'TransVia Express', 'Rafael', 4),
('(61) 99271-8670', '821', 'TransVia Express', 'Gustavo', 5),
('(61) 96206-4900', '566', 'TransVia Express', 'Pedro', 6),
('(61) 96562-9019', '242', 'Rota Brasil', 'Thiago', 7),
('(61) 92261-2079', '859', 'Rota Brasil', 'Felipe', 8),
('(61) 91592-2363', '485', 'Rota Brasil', 'João', 9),
('(61) 97881-4855', '748', 'Rota Brasil', 'Bruno', 10),
('(61) 96902-3184', '905', 'Rota Brasil', 'Vinícius', 11),
('(61) 92071-6998', '833', 'Rota Brasil', 'Carlos', 12),
('(61) 92628-3021', '355', 'Expresso Horizonte', 'Ricardo', 13),
('(61) 96548-1500', '161', 'Expresso Horizonte', 'Fernando', 14),
('(61) 92503-9565', '167', 'Expresso Horizonte', 'André', 15),
('(61) 95878-4937', '131', 'Expresso Horizonte', 'Marcelo', 16),
('(61) 95681-9326', '586', 'Expresso Horizonte', 'Ana', 17),
('(61) 92640-3918', '797', 'Expresso Horizonte', 'Beatriz', 18),
('(61) 99451-4522', '234', 'Viação Estrela Azul', 'Carla', 19),
('(61) 94339-1495', '284', 'Viação Estrela Azul', 'Diana', 20),
('(61) 95232-3169', '928', 'Viação Estrela Azul', 'Elisa', 21),
('(61) 97734-2893', '750', 'Viação Estrela Azul', 'Fernanda', 22),
('(61) 95088-9602', '913', 'Viação Estrela Azul', 'Gabriela', 23),
('(61) 91276-9366', '784', 'Expresso Horizonte', 'Helena', 24),
('(61) 97956-8952', '341', 'RotaSul Transportes', 'Isabela', 25),
('(61) 98522-5702', '893', 'RotaSul Transportes', 'Juliana', 26),
('(61) 95944-7918', '870', 'RotaSul Transportes', 'Karina', 27),
('(61) 96067-1382', '458', 'RotaSul Transportes', 'Laura', 28),
('(61) 97511-1807', '342', 'RotaSul Transportes', 'Mariana', 29),
('(61) 95003-3995', '747', 'RotaSul Transportes', 'Natália', 30),
('(61) 91481-4672', '263', 'RotaSul Transportes', 'Olivia', 31),
('(61) 95336-8570', '988', 'RotaSul Transportes', 'Patrícia', 32);

-- CONSULTA PARA VERIFICAÇÃO --
SELECT * FROM Motorista;


-- INSERÇÃO DE Horario_Linha  --


INSERT INTO Horario_Linha(Linha_id, Horario_1, Horario_2, Horario_3, Horario_4, Horario_5) VALUES
('665', 1, 3, 5, 7, NULL),
('242', 1, 3, 5, 7, NULL),
('355', 1, 3, 5, 7, NULL),
('234', 1, 3, 5, 7, NULL),
('341', 1, 3, 5, 7, NULL),
('893', 1, 3, 5, 7, NULL),
('557', 1, 2, 4, 6, 8),
('755', 1, 2, 4, 6, 8),
('859', 1, 2, 4, 6, 8),
('485', 1, 2, 4, 6, 8),
('161', 1, 2, 4, 6, 8),
('167', 1, 2, 4, 6, 8),
('284', 1, 2, 4, 6, 8),
('928', 1, 2, 4, 6, 8),
('870', 1, 2, 4, 6, 8),
('458', 1, 2, 4, 6, 8),
('342', 1, 2, 4, 6, 8),
('494', 2, 3, 6, 7, 8),
('748', 2, 3, 6, 7, 8),
('131', 2, 3, 6, 7, 8),
('750', 2, 3, 6, 7, 8),
('747', 2, 3, 6, 7, 8),
('263', 2, 3, 6, 7, 8),
('988', 2, 3, 6, 7, 8),
('821', 9, 10, NULL, NULL, NULL),
('566', 9, 10, NULL, NULL, NULL),
('905', 9, 10, NULL, NULL, NULL),
('833', 9, 10, NULL, NULL, NULL),
('586', 9, 10, NULL, NULL, NULL),
('797', 9, 10, NULL, NULL, NULL),
('913', 9, 10, NULL, NULL, NULL),
('784', 9, 10, NULL, NULL, NULL);

-- CONSULTA PARA VERIFICAÇÃO --
SELECT * FROM Horario_Linha;


	-- UPDATE MOTORISTA PARA INSERIR FOTO  --

	UPDATE Motorista
SET Foto = pg_read_binary_file('C:\Users\mllbi\Documents\Projeto BD\gabriel.jpg')
WHERE Nome = 'Gabriel';


	-- QUERY MOTORISTA PARA BUSCAR FOTO  --
SELECT Foto
FROM Motorista
WHERE Nome = 'Gabriel';

-- 1. Criando a sequência
CREATE SEQUENCE motorista_id_seq;

-- 2. Definindo a coluna para usar a sequência
ALTER TABLE Motorista
ALTER COLUMN Motorista_id SET DEFAULT nextval('motorista_id_seq');

-- 3. Ajustando a sequência com base no valor máximo existente
SELECT setval('motorista_id_seq', COALESCE((SELECT MAX(Motorista_id) FROM Motorista), 0) + 1);

-- Alterando nome de lucas --
UPDATE Motorista
SET nome = 'Lucas.Souza'
WHERE motorista_id = 1;




