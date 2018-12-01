
-- Pacientes de um médico em alguma data
-- Entradas: nome do medico ('Alberto'), data ('2018-11-10')
SELECT *
FROM Prontuario NATURAL JOIN Internacao 
	NATURAL JOIN Assiste
	NATURAL JOIN Medica
	JOIN Funcionario USING (codigo_func)
WHERE Funcionario.nome = 'Alberto' AND
	Internacao.data_inicio <= '2018-11-10'
	AND (Internacao.data_fim IS NULL OR Internacao.data_fim >= '2018-11-10');


-- Numero de vezes que cada medicamento foi prescrito
SELECT nome_medicamento, COUNT(*)
FROM Medicamento NATURAL JOIN ComTratamento
	NATURAL JOIN Prescricao
GROUP BY nome_medicamento;

-- Enfermeira que administrou mais prescrições
SELECT Funcionario.nome
FROM Funcionario NATURAL JOIN Enfermeira 
	NATURAL JOIN Administra
	NATURAL JOIN Prescricao
	JOIN Prontuario USING(numero_prontuario)
GROUP BY (coren, Funcionario.nome)
HAVING COUNT(*) = (
	SELECT MAX(atendimentos)
	FROM (
		SELECT COUNT(*) AS atendimentos
		FROM Funcionario NATURAL JOIN Enfermeira 
			NATURAL JOIN Administra
			NATURAL JOIN Prescricao
			JOIN Prontuario USING(numero_prontuario)
		GROUP BY coren
	) AS Atendimento
);

-- Doença mais diagnosticada uma especialidade 
SELECT Doenca.nome, COUNT(DISTINCT (cid, data_diag, numero_prontuario))
FROM Medica NATURAL JOIN Assiste
	NATURAL JOIN Internacao
	NATURAL JOIN Prontuario
	NATURAL JOIN Diagnostico
	JOIN Doenca USING (cid)
WHERE especialidade = 'Pneumologista'
GROUP BY (cid, Doenca.nome)
HAVING COUNT(DISTINCT (cid, data_diag, numero_prontuario)) = (
	SELECT MAX(diagnosticos)
	FROM (
		SELECT COUNT(DISTINCT (cid, data_diag, numero_prontuario)) AS diagnosticos
		FROM Medica NATURAL JOIN Assiste
			NATURAL JOIN Internacao
			NATURAL JOIN Prontuario
			NATURAL JOIN Diagnostico
			JOIN Doenca USING (cid)
		WHERE especialidade = 'Pneumologista'
		GROUP BY (cid, Doenca.nome)
	) AS diags
)

-- Retorna quais hospitais tem todas as especialidades de um dado hospital
-- Entrada: hospital( 'PRONTO SOCORRO' )
SELECT nome_hospital
FROM Hospital H1
WHERE NOT EXISTS (
	SELECT DISTINCT *
	FROM Medica NATURAL JOIN Trabalho
		NATURAL JOIN Hospital
	WHERE nome_hospital = 'PRONTO SOCORRO' AND especialidade IS NOT NULL AND especialidade NOT IN (
		SELECT DISTINCT especialidade
		FROM Medica NATURAL JOIN Trabalho
			NATURAL JOIN Hospital
		WHERE Hospital.nome_hospital = H1.nome_hospital AND especialidade IS NOT NULL
	)
)

-- Retorna Exames que um paciente fez em uma dada internação
-- Entrada: numero_prontuario ( 5 ) e data da internação ( '2018-11-10' )
SELECT tipo, data_hora_solicitacao, data_hora_realizacao, resultado
FROM Internacao NATURAL JOIN Prontuario
	NATURAL JOIN Exame
WHERE numero_prontuario = 5 AND data_inicio = '2018-11-10'
	AND Exame.data_hora_solicitacao >= data_inicio AND
	( data_fim IS NULL OR data_fim >= Exame.data_hora_solicitacao);

