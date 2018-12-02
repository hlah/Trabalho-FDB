#!/usr/bin/python3
import sys, os
import psycopg2
import queries

DEFAULT_USER_PASS=1
DB_NAME="Rede_hospitais"


def my_connect():
    if DEFAULT_USER_PASS==1:
        db_user="postgres"
        db_password="postgres"
    else:
        db_user= str(input("enter database user: "))
        db_password= str(input("enter database password: "))

    return psycopg2.connect(host="localhost",
                            database=DB_NAME,
                            user=db_user, 
                            password=db_password)

def optError(conn):
    print('Invalid Option. Try again another time')

def optInsertion(conn):
    print('Query menu:')


def optAlter(conn):
    print('Query menu:')

    

def main():
    conn= my_connect();

     # execute a statement
    cur= conn.cursor();
    print('PostgreSQL database version:')
    cur.execute('SELECT version()')

    # display the PostgreSQL database server version
    db_version = cur.fetchone()
    print(db_version)
    cur.close()

    os.system('clear');
    print('Select an Option')

    print('1- for queries')
    print('2- for insertions')
    print('3- for altering values')
    opt= str(input());

    optFunct= {
                  "1": queries.optQuery,
                  "2": optInsertion,
                  "3": optAlter
                }.get(opt, optError)
    
    optFunct(conn)



     # close the communication with the PostgreSQL
    if conn is not None:
        conn.close()
#    except (Exception, psycopg2.DatabaseError) as error:
#        print(error)
#    finally:
#        if conn is not None:
#            conn.close()
#            print('Database connection closed.')

main()
