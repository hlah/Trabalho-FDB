import sys, os
import psycopg2

def optQuery(conn):
    os.system('clear');
    print('Query menu:')
    print('Type of query:')
    print('1 - Pacientes de um médico em alguma data')
    print('2 - Numero de vezes que cada medicamento foi prescrito')
    print('3 - Enfermeira que administrou mais prescrições')
    print('4 - Doença mais diagnosticada em uma especialidade')
    print('5 - Lista de hospitais com o mesmo suporte que um dado hospital')
    print('6 - Exames de um paciente em uma internacao')
    opt= str(input());
    queryFunct= {
                  "1": Query1,
                  "2": Query2,
                  "3": Query3,
                  "4": Query4,
                  "5": Query5,
                  "6": Query6
                }.get(opt, optError)

    cur = conn.cursor()
    queryFunct(cur)
    cur.close()



def optError(cur):
    print('Invalid Option. Try again another time')

def Query1(cur):
    os.system('clear');
    print('1 - Pacientes de um médico em alguma data')
    medico= str(input('Nome do medico(a): '))
    data= str(input('Data de Internação(yyyy-mm-dd): '))
    sqlStr= "SELECT * \
FROM Prontuario NATURAL JOIN Internacao \
	NATURAL JOIN Assiste \
	NATURAL JOIN Medica \
	JOIN Funcionario USING (codigo_func) \
WHERE Funcionario.nome = %s AND \
	Internacao.data_inicio <= %s \
	AND (Internacao.data_fim IS NULL OR Internacao.data_fim >= %s);"
    cur.execute(sqlStr,(medico,data,data))
    rows = cur.fetchall()
    print("The number of patients: ", cur.rowcount)
    for row in rows:
        print(row)


def Query2(cur):
    os.system('clear');
    print('2 - Numero de vezes que cada medicamento foi prescrito')
    sqlStr="SELECT nome_medicamento, COUNT(*) \
FROM Medicamento NATURAL JOIN ComTratamento \
	NATURAL JOIN Prescricao \
GROUP BY nome_medicamento;"
    
    cur.execute(sqlStr)
    rows = cur.fetchall()
    print("The number of entries: ", cur.rowcount)
    for row in rows:
        print(row)


def Query3(cur):
    os.system('clear');
    print('3 - Enfermeira que administrou mais prescrições')
    sqlStr=" SELECT Funcionario.nome \
FROM Funcionario NATURAL JOIN Enfermeira \
	NATURAL JOIN Administra \
	NATURAL JOIN Prescricao \
	JOIN Prontuario USING(numero_prontuario) \
GROUP BY (coren, Funcionario.nome) \
HAVING COUNT(*) = ( \
	SELECT MAX(atendimentos) \
	FROM ( \
		SELECT COUNT(*) AS atendimentos \
		FROM Funcionario NATURAL JOIN Enfermeira \
			NATURAL JOIN Administra \
			NATURAL JOIN Prescricao \
			JOIN Prontuario USING(numero_prontuario) \
		GROUP BY coren \
	) AS Atendimento );"
    cur.execute(sqlStr)
    rows = cur.fetchall()
    print("The number of entries: ", cur.rowcount)
    for row in rows:
        print(row)

def Query4(cur):
    os.system('clear');
    print('4 - Doença mais diagnosticada em uma especialidade')
    especialidade= str(input('Nome da especialidade: '))

    sqlStr="SELECT Doenca.nome, COUNT(DISTINCT (cid, data_diag, numero_prontuario)) \
FROM Medica NATURAL JOIN Assiste \
	NATURAL JOIN Internacao \
	NATURAL JOIN Prontuario \
	NATURAL JOIN Diagnostico \
	JOIN Doenca USING (cid) \
WHERE especialidade = %s \
GROUP BY (cid, Doenca.nome) \
HAVING COUNT(DISTINCT (cid, data_diag, numero_prontuario)) = ( \
	SELECT MAX(diagnosticos) \
	FROM ( \
		SELECT COUNT(DISTINCT (cid, data_diag, numero_prontuario)) AS diagnosticos \
		FROM Medica NATURAL JOIN Assiste \
			NATURAL JOIN Internacao \
			NATURAL JOIN Prontuario  \
			NATURAL JOIN Diagnostico \
			JOIN Doenca USING (cid) \
		WHERE especialidade = %s \
		GROUP BY (cid, Doenca.nome) \
	) AS diags );" 
    cur.execute(sqlStr,(especialidade,especialidade))
    rows = cur.fetchall()
    print("The number of entries: ", cur.rowcount)
    for row in rows:
        print(row)


def Query5(cur):
    os.system('clear');
    print('5 - Lista de hospitais com o mesmo suporte que um dado hospital')
    hospital= str(input('Nome do hospital: '))
    print(hospital)
    sqlStr="SELECT nome_hospital \
FROM Hospital H1 \
WHERE NOT EXISTS (  \
        SELECT DISTINCT * \
        FROM Medica NATURAL JOIN Trabalho \
                NATURAL JOIN Hospital \
	WHERE nome_hospital = %s AND especialidade IS NOT NULL AND especialidade NOT IN ( \
                SELECT DISTINCT especialidade \
                FROM Medica NATURAL JOIN Trabalho \
                    NATURAL JOIN Hospital \
                WHERE Hospital.nome_hospital = H1.nome_hospital AND especialidade IS NOT NULL) );"
    cur.execute(sqlStr,(hospital,))
    rows = cur.fetchall()
    print("The number of entries: ", cur.rowcount)
    for row in rows:
        print(row)


def Query6(cur):
    os.system('clear');
    print('6 - Exames de um paciente em uma internacao')
    prontuario= str(input("Numero do prontuario: "))
    data= str(input('Data de Internação(yyyy-mm-dd): '))
    sqlStr="SELECT tipo, data_hora_solicitacao, data_hora_realizacao, resultado \
FROM Internacao NATURAL JOIN Prontuario \
	NATURAL JOIN Exame \
WHERE numero_prontuario = %s AND data_inicio = %s \
	AND Exame.data_hora_solicitacao >= data_inicio AND \
	( data_fim IS NULL OR data_fim >= Exame.data_hora_solicitacao);"
    cur.execute(sqlStr,(prontuario, data))
    rows = cur.fetchall()
    print("The number of entries: ", cur.rowcount)
    for row in rows:
        print(row)
    



