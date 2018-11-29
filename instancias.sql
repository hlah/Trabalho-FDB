
-- Insere hospitais (não inserimos 10, porque para fazer sentido
-- cada hospital teria que ter algum numero significativo de funcionarios
-- gerando um numero muito grande destes.
INSERT INTO Hospital VALUES( 'HCPA', 'A', 'Porto Alegre', 'RS' );
INSERT INTO Hospital VALUES( 'SANTA CASA', 'B', 'Porto Alegre', 'RS' );
INSERT INTO Hospital VALUES( 'PRONTO SOCORRO', 'C', 'Porto Alegre', 'RS' );

-- Insere Prontuarios (com pacientes)
INSERT INTO Prontuario VALUES( 1, '1234567890', 'Luis Inacio Lula da Silva', '1949-03-15', 'M', 'brasileiro'); -- internado desde 10/11/2018
INSERT INTO Prontuario VALUES( 2, '1235555890', 'Augusto Ribeiro', '1955-11-18', 'M', 'brasileiro');
INSERT INTO Prontuario VALUES( 3, '3838383888', 'Angelina Pereira', '1985-09-01', 'F', 'brasileiro'); -- inernado entre 10/08/2017 e 15/12/2017
INSERT INTO Prontuario VALUES( 4, '5555555555', 'Mario Cavalcante', '1965-02-01', 'F', 'brasileiro'); -- transexual -- internado entre 05/04/2018 e 20/05/2018
INSERT INTO Prontuario VALUES( 5, '1234123412', 'Julia Silva', '1945-11-01', 'F', 'brasileiro');
INSERT INTO Prontuario VALUES( 6, '5733256344', 'Marta Silveira', '1987-01-01', 'F', 'brasileiro');
INSERT INTO Prontuario VALUES( 7, '9345788424', 'Bruno Costa', '1984-03-01', 'M', 'brasileiro');
INSERT INTO Prontuario VALUES( 8, '7748342663', 'Xeila Coelho', '1975-12-11', 'F', 'brasileiro');
INSERT INTO Prontuario VALUES( 9, '5948128946', 'Giovane Silva Ribeiro Cavalcante', '1985-11-01', 'F', 'brasileiro');
INSERT INTO Prontuario VALUES( 10, '599159912', 'Ricardo Moraes', '1988-05-01', 'M', 'brasileiro'); -- internado entre 09/11/2017 e 15/11/2017

-- Visitane
INSERT INTO Visitante VALUES( '1111111111', 'Haddad');
INSERT INTO Visitante VALUES( '2222222222', 'Joao');
INSERT INTO Visitante VALUES( '3333333333', 'Maria');
INSERT INTO Visitante VALUES( '4444444444', 'Afonso');
INSERT INTO Visitante VALUES( '5555555555', 'Frederico');
INSERT INTO Visitante VALUES( '6666666666', 'Alberto');
INSERT INTO Visitante VALUES( '7777777777', 'Marilia');
INSERT INTO Visitante VALUES( '8888888888', 'Bruna');
INSERT INTO Visitante VALUES( '9999999999', 'Jessica');
INSERT INTO Visitante VALUES( '9009909090', 'Pedro');

-- Visita
INSERT INTO Visita VALUES( '1111111111', 1, '2018-11-15');
INSERT INTO Visita VALUES( '1111111111', 1, '2018-11-14');
INSERT INTO Visita VALUES( '1111111111', 1, '2018-11-13');
INSERT INTO Visita VALUES( '2222222222', 1, '2018-12-12');
INSERT INTO Visita VALUES( '3333333333', 1, '2018-11-15');
INSERT INTO Visita VALUES( '4444444444', 3, '2017-10-14');
INSERT INTO Visita VALUES( '5555555555', 4, '2018-04-10');
INSERT INTO Visita VALUES( '6666666666', 4, '2018-05-05');
INSERT INTO Visita VALUES( '7777777777', 4, '2018-04-11');
INSERT INTO Visita VALUES( '8888888888', 10, '2017-11-10');
INSERT INTO Visita VALUES( '9999999999', 10, '2017-11-11');
INSERT INTO Visita VALUES( '9009909090', 10, '2017-11-12');

-- Internações
INSERT INTO Internacao VALUES( 1, '2018-11-10', NULL, 'HCPA' );
INSERT INTO Internacao VALUES( 2, '2018-10-10', NULL, 'HCPA' );
INSERT INTO Internacao VALUES( 3, '2017-08-10', '2017-12-15', 'HCPA' );
INSERT INTO Internacao VALUES( 4, '2018-04-05', '2018-05-20', 'HCPA' ); 
INSERT INTO Internacao VALUES( 5, '2018-11-10', NULL, 'SANTA CASA' );
INSERT INTO Internacao VALUES( 6, '2018-10-01', '2018-10-31', 'SANTA CASA' );
INSERT INTO Internacao VALUES( 7, '2018-10-01', '2018-10-15', 'PRONTO SOCORRO' );
INSERT INTO Internacao VALUES( 8, '2018-09-01', '2018-10-11', 'PRONTO SOCORRO' );
INSERT INTO Internacao VALUES( 10, '2017-08-09', '2017-12-10', 'SANTA CASA' );
INSERT INTO Internacao VALUES( 10, '2017-11-09', '2017-11-15', 'SANTA CASA' );
INSERT INTO Internacao VALUES( 3, '2018-10-10', '2017-12-05', 'HCPA' );
INSERT INTO Internacao VALUES( 7, '2017-10-01', '2017-10-15', 'HCPA' );
INSERT INTO Internacao VALUES( 5, '2018-10-01', '2018-10-15', 'SANTA CASA' );
INSERT INTO Internacao VALUES( 5, '2017-10-09', '2017-10-13', 'SANTA CASA' );

-- Exames
INSERT INTO Exame VALUES( 'RAIO-X', '2018-11-10 08:00:00', 1, NULL, NULL, NULL );
INSERT INTO Exame VALUES( 'SODIO', '2018-11-10 08:00:00', 1, NULL, NULL, NULL );
INSERT INTO Exame VALUES( 'POTASSIO', '2018-11-10 08:00:00', 1, NULL, NULL, NULL );
INSERT INTO Exame VALUES( 'RAIO-X', '2018-10-10 08:00:00', 2, NULL, NULL, NULL );
INSERT INTO Exame VALUES( 'RAIO-X', '2017-08-10 08:00:00', 3, '2017-08-11 06:00:00', 'normal', 'raiox/imagens/10932' );
INSERT INTO Exame VALUES( 'RAIO-X', '2018-04-05 08:00:00', 4, '2018-04-06 07:00:00', 'normal', 'raiox/imagens/10933' ); 
INSERT INTO Exame VALUES( 'SODIO', '2018-04-05 08:00:00', 4, '2018-04-06 07:00:00', '140', NULL ); 
INSERT INTO Exame VALUES( 'POTASSIO', '2018-04-05 08:00:00', 4, '2018-04-06 07:00:00', '8,5', NULL ); 
INSERT INTO Exame VALUES( 'RAIO-X', '2018-11-10 08:00:00', 5, NULL, NULL, NULL );
INSERT INTO Exame VALUES( 'RAIO-X', '2018-10-01 08:00:00', 6, '2018-10-02 06:00:00', 'edema pulmonar', 'raiox/imagens/10934' );
INSERT INTO Exame VALUES( 'RAIO-X', '2018-10-01 08:00:00', 7, '2018-10-02 07:00:00', 'normal', 'raiox/imagens/10935' );
INSERT INTO Exame VALUES( 'RAIO-X', '2018-09-01 08:00:00', 8, '2018-09-02 09:00:00', 'enfisema', 'raiox/imagens/10936' );
INSERT INTO Exame VALUES( 'SODIO', '2018-09-01 08:00:00', 8, '2018-09-02 09:00:00', '139', NULL );
INSERT INTO Exame VALUES( 'POTASSIO', '2018-09-01 08:00:00', 8, '2018-09-02 09:00:00', '7,1', NULL );
INSERT INTO Exame VALUES( 'RAIO-X', '2017-08-09 08:00:00', 10, '2017-08-10 10:00:00', 'enfisema', 'raiox/imagens/10998' );
INSERT INTO Exame VALUES( 'RAIO-X', '2017-11-09 08:00:00', 10, '2017-11-10 03:00:00', 'normal', 'raiox/imagens/10910' );
INSERT INTO Exame VALUES( 'RAIO-X', '2018-10-10 08:00:00', 3, '2018-10-11 04:00:00', 'consolidaçao a esquerda', 'raiox/imagens/12121' );
INSERT INTO Exame VALUES( 'RAIO-X', '2017-10-01 08:00:00', 7, '2017-10-02 07:00:00', 'normal', 'raiox/imagens/43231' );
INSERT INTO Exame VALUES( 'RAIO-X', '2018-10-01 08:00:00', 5, '2018-10-02 08:00:00', 'normal', 'raiox/imagens/10333' );
INSERT INTO Exame VALUES( 'RAIO-X', '2017-10-09 08:00:00', 5, '2017-10-10 10:00:00', 'nodo 2cm PE', 'raiox/imagens/1092' );

-- Doenças
INSERT INTO Doenca VALUES( 'F10', 'Pneumonia' );
INSERT INTO Doenca VALUES( 'F11', 'Enfisema' );
INSERT INTO Doenca VALUES( 'E0', 'Cancer Pulmonar' );
INSERT INTO Doenca VALUES( 'A10', 'Gripe' );
INSERT INTO Doenca VALUES( 'B10', 'Insuficiencia Cardiaca' );
INSERT INTO Doenca VALUES( 'A11', 'Tuberculose' );
INSERT INTO Doenca VALUES( 'G10', 'Insuficiencia Renal' );
INSERT INTO Doenca VALUES( 'G15', 'Glomerulo Nefrite Aguda' );
INSERT INTO Doenca VALUES( 'C10', 'Diabetes Tipo I' );
INSERT INTO Doenca VALUES( 'C11', 'Diabetes Tipo II' );

-- Diagnosticos
INSERT INTO Diagnostico VALUES( 'B10', 6, '2018-10-02' );
INSERT INTO Diagnostico VALUES( 'A10', 3, '2017-08-11' );
INSERT INTO Diagnostico VALUES( 'A10', 4, '2018-04-06' );
INSERT INTO Diagnostico VALUES( 'A10', 7,  '2018-10-02');
INSERT INTO Diagnostico VALUES( 'A10', 10,  '2017-11-10');
INSERT INTO Diagnostico VALUES( 'F11', 8, '2018-09-02' );
INSERT INTO Diagnostico VALUES( 'F11', 10, '2017-08-10' );
INSERT INTO Diagnostico VALUES( 'E0', 5, '2017-10-10' );
INSERT INTO Diagnostico VALUES( 'G10', 4, '2018-04-06' );
INSERT INTO Diagnostico VALUES( 'G10', 8, '2018-09-02' );

-- Funcionarios
INSERT INTO Funcionario VALUES( 1, 'Alberto', 9000 );
INSERT INTO Funcionario VALUES( 2, 'Maria', 9500 );
INSERT INTO Funcionario VALUES( 3, 'Pedro', 9400 );
INSERT INTO Funcionario VALUES( 4, 'Beatriz', 9200 );
INSERT INTO Funcionario VALUES( 5, 'Carlos', 9700 );
INSERT INTO Funcionario VALUES( 6, 'Daniel', 9100 );
INSERT INTO Funcionario VALUES( 7, 'Egido', 9400 );
INSERT INTO Funcionario VALUES( 8, 'Fabio', 9500 );
INSERT INTO Funcionario VALUES( 9, 'Gabriela', 9800 );
INSERT INTO Funcionario VALUES( 10, 'Tiago', 9400 );
INSERT INTO Funcionario VALUES( 11, 'Ivonei', 9600 );
INSERT INTO Funcionario VALUES( 12, 'Julia', 9800 );
INSERT INTO Funcionario VALUES( 13, 'Karla', 8900 );
INSERT INTO Funcionario VALUES( 14, 'Luisa', 8600 );
INSERT INTO Funcionario VALUES( 15, 'Monica', 8100 );
INSERT INTO Funcionario VALUES( 16, 'Norberto', 8900 );
INSERT INTO Funcionario VALUES( 17, 'Otavio', 8400 );
INSERT INTO Funcionario VALUES( 18, 'Tais', 11000 );
INSERT INTO Funcionario VALUES( 19, 'Ana', 10400 );
INSERT INTO Funcionario VALUES( 20, 'Livia', 12000 );

-- Medicos
INSERT INTO Medico VALUES( 1, '120931', NULL);
INSERT INTO Medico VALUES( 2, '123445', NULL);
INSERT INTO Medico VALUES( 3, '434478', 'Pneumologista');
INSERT INTO Medico VALUES( 4, '737374', 'Pneumologista');
INSERT INTO Medico VALUES( 5, '122833', 'Pneumologista');
INSERT INTO Medico VALUES( 6, '273789', 'Nefrologista');
INSERT INTO Medico VALUES( 7, '538374', 'Nefrologista');
INSERT INTO Medico VALUES( 8, '435717', 'Nefrologista');
INSERT INTO Medico VALUES( 9, '521345', 'Cardiologista');
INSERT INTO Medico VALUES( 10, '123444', 'Cardiologista');

-- Enfermeiras
INSERT INTO Medico VALUES( 11, '1234421', NULL);
INSERT INTO Medico VALUES( 12, '4123516', NULL);
INSERT INTO Medico VALUES( 13, '5372463', 'Cirurgia');
INSERT INTO Medico VALUES( 14, '7526234', 'Pneumologista');
INSERT INTO Medico VALUES( 15, '5274543', 'Infectologista');
INSERT INTO Medico VALUES( 16, '5375754', NULL);
INSERT INTO Medico VALUES( 17, '5736345', 'Nefrologista');
INSERT INTO Medico VALUES( 18, '5374534', 'Nefrologista');
INSERT INTO Medico VALUES( 19, '9677567', 'Cirurgia');
INSERT INTO Medico VALUES( 20, '3456544', 'Cardiologista');



