from configparser import ConfigParser
from tkinter import END

import psycopg2
from tkinter.ttk import Treeview
from tkinter.ttk import Combobox
import config


def config(filename='database.ini', section='postgresql'):
    # create a parser
    parser = ConfigParser()
    # read config file
    parser.read(filename)

    # get section, default to postgresql
    db = {}
    if parser.has_section(section):
        params = parser.items(section)
        for param in params:
            db[param[0]] = param[1]
    else:
        raise Exception('Section {0} not found in the {1} file'.format(section, filename))

    return db

conn = None
cur = None

params = config()

def read():
    try:
        conn = psycopg2.connect(**params)

        cur = conn.cursor()

        cur.execute('SELECT p.name, p.age, p.position, te.name '
                    'FROM team te '
                    'JOIN player p '
                    'ON te.id = p.id_team')
        records = cur.fetchall()
        cur.close()
        return records
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.\n')

def cb_team_fill():
    try:
        conn = psycopg2.connect(**params)

        cur = conn.cursor()
        cur.execute('SELECT id, name FROM team')
        records = cur.fetchall()
        return records
    except(Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.\n')

def add(name, age, pos, team):

    team_s = 0
    if team == 'GSW':
        team_s = 1
    elif team == 'LAL':
        team_s = 4
    elif team == 'Huston Rockets':
        team_s = 5
    elif team == 'Celtics':
        team_s = 7

    try:
        conn = psycopg2.connect(**params)

        cur = conn.cursor()
        sql = 'INSERT INTO player(id_team, name, age, position) VALUES(%s, %s, %s, %s)'
        param = (team_s, name, age, pos)
        cur.execute(sql, param)
        cur.close()
        conn.commit()
    except(Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.\n')


def delete(name):
    try:
        conn = psycopg2.connect(**params)

        cur = conn.cursor()
        sql = 'DELETE FROM player WHERE name = %s'
        cur.execute(sql, (name,))
        cur.close()
        conn.commit()
    except(Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.\n')

def sort(age):
    try:
        conn = psycopg2.connect(**params)

        cur = conn.cursor()
        sql = 'SELECT p.name, p.age, p.position, te.name ' \
              'FROM team te ' \
              'JOIN player p ' \
              'ON te.id = p.id_team WHERE p.age <= %s'
        cur.execute(sql, (age,))
        records = cur.fetchall()
        cur.close()
        return records
    except(Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.\n')





