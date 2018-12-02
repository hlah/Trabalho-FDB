import sys, os
import psycopg2

def optInsertion(conn):
    os.system('clear');
    print('Insertion menu:')
    print('Type of insertion:')
    print('1 - Atribuir um medico a uma internacao')
    print('2 - Cadastrar um visitante no sistema')

    opt= str(input());
    queryFunct= {
                  "1": Insert1,
                  "2": Insert2,
                }.get(opt, optError)

    cur = conn.cursor()
    queryFunct(conn, cur)
    cur.close()

def optError(conn, cur):
    print('Invalid Option. Try again another time')

def Insert1(conn, cur):
    os.system('clear');
    print('1 - Atribuir um medico a uma internacao')
    crm = str(input('crm do medico: '))
    n_pront = str(input('Numero do prontuario: '))
    data_inter= str(input('Data de internacao(yyyy-mm-dd): '))
    sqlStr= "INSERT INTO Assiste VALUES(%s,%s,%s)"
    cur.execute(sqlStr,(crm, n_pront, data_inter))
    conn.commit()
    sqlQuery= " SELECT crm FROM Assiste NATURAL JOIN Medica \
WHERE numero_prontuario = %s AND data_inicio = %s"
    cur.execute(sqlQuery,(n_pront, data_inter))
    rows = cur.fetchall()
    didInsertion=False
    for row in rows:
        if crm in row:
            didInsertion= True
            
    if(didInsertion):
        print('inserção corretamente efetuada')
    else:
        print('insercao nao efetivada')


def Insert2(conn, cur):
    os.system('clear');
    print('2 - Cadastrar um visitante no sistema')
    nome=  str(input('informe o nome do visitante'))
    rg=  str(input('informe o rg do visitante'))
    sqlStr="INSERT INTO Visitante VALUES( %s, %s);"
    cur.execute(sqlStr,(rg, nome))
    conn.commit()
