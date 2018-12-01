
-- Insere assiste somente se médico trabalha no hospital da internação
CREATE OR REPLACE FUNCTION insere_assiste() RETURNS TRIGGER AS $BODY$
BEGIN
	IF (SELECT nome_hospital FROM Internacao NATURAL JOIN Hospital
		WHERE numero_prontuario = NEW.numero_prontuario AND data_inicio = NEW.data_inicio)
		IN (SELECT nome_hospital FROM Medica NATURAL JOIN Funcionario NATURAL JOIN Trabalho
			WHERE crm = NEW.crm)
	THEN
		RETURN new;
	ELSE
		RAISE NOTICE 'Medica deve trabalhar no mesmo Hospital da internação!!!!';
		RETURN NULL;
	END IF;
		
END;
$BODY$ LANGUAGE PLPGSQL;

CREATE TRIGGER chceca_insere_assiste
	BEFORE INSERT ON Assiste
	FOR EACH ROW
	EXECUTE PROCEDURE insere_assiste();

-- não insere
-- INSERT INTO Assiste VALUES( '273789',  8, '2018-09-01' );
-- insere
-- INSERT INTO Assiste VALUES( '123444',  8, '2018-09-01' );
-- verifica
-- SELECT crm
-- FROM Assiste NATURAL JOIN Medica
-- WHERE numero_prontuario = 8 AND data_inicio = '2018-09-01'
-- remove
-- DELETE 
-- FROM Assiste
-- WHERE crm = '123444' AND numero_prontuario = 8 AND data_inicio = '2018-09-01'