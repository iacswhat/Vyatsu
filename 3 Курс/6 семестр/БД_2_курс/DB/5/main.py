from tkinter.messagebox import showinfo
from unittest import result

import database
from tkinter import *
from tkinter.ttk import Combobox
from tkinter.ttk import Treeview
from tkinter import messagebox


def add_str():
    name_s = format(name.get())
    age_s = format(age.get())
    pos_s = combo_pos.get()
    team_s = combo_team.get()
    database.add(name_s, age_s, pos_s, team_s)
    tree.delete(*tree.get_children())
    records = database.read()
    for player in records:
        tree.insert("", END, values=player)

def del_str():

    name_s = format(name_del.get())
    messagebox.askyesno(title='Внимание', message='Вы действительно хотите ужалить запись с именем ' + name_s + '?')
    if result:
        database.delete(name_s)
        tree.delete(*tree.get_children())
        records = database.read()
        for player in records:
            tree.insert("", END, values=player)


def sort():
    age_s = format(age_sort.get())
    sort_rec = database.sort(age_s)
    tree.delete(*tree.get_children())
    for player in sort_rec:
        tree.insert("", END, values=player)

def get_index(*args):
    print(str(combo_team.get()))




if __name__ == '__main__':
    window = Tk()
    window.title("Lab5")
    window.geometry('900x600')

    frame = LabelFrame(window, text='Добавьте нового игрока')
    frame.grid(row=0, column=0, columnspan=1, pady=10)

    Label(frame, text='Имя:').grid(row=1, column=0)
    name = Entry(frame)
    name.focus()
    name.grid(row=1, column=1)

    Label(frame, text='Возраст:').grid(row=2, column=0)
    age = Entry(frame)
    age.grid(row=2, column=1)

    Label(frame, text='Позиция:').grid(row=3, column=0)
    combo_pos = Combobox(frame, state="readonly")
    combo_pos['values'] = ('point guard', 'shooting guard', 'small forward', 'power forward', 'center')
    combo_pos.current(0)
    combo_pos.grid(row=3, column=1)

    Label(frame, text='Команда:').grid(row=4, column=0)
    var = StringVar()
    combo_team = Combobox(frame, state='readonly', textvariable=var)
    combo_team['values'] = ('GSW', 'LAL', 'Huston Rockets', 'Celtics')
    combo_team.current(0)
    combo_team.grid(row=4, column=1)
    var.trace('w', get_index)

    Button(frame, text='Добавить', command=add_str).grid(row=5, columnspan=2, sticky=W + E)
    message = Label(text='', fg='green')
    message.grid(row=5, column=0, columnspan=2, sticky=W + E)

    frame_del = LabelFrame(window, text='Удаление')
    frame_del.grid(row=0, column=1, columnspan=1, pady=0)
    Label(frame_del, text='Имя:').grid(row=1, column=0)
    name_del = Entry(frame_del)
    name_del.grid(row=1, column=1)

    Button(frame_del, text='Удалить', command=del_str).grid(row=2, columnspan=2, sticky=W + E)
    message = Label(text='', fg='green')
    message.grid(row=2, column=0, columnspan=2, sticky=W + E)

    frame_sort = LabelFrame(window, text='Фильтр')
    frame_sort.grid(row=0, column=2, columnspan=1, pady=0)
    Label(frame_sort, text='Возраст:').grid(row=1, column=0)
    age_sort = Entry(frame_sort)
    age_sort.grid(row=1, column=1)

    Button(frame_sort, text='Фильтровать', command=sort).grid(row=2, columnspan=2, sticky=W + E)
    message = Label(text='', fg='green')
    message.grid(row=2, column=0, columnspan=2, sticky=W + E)


    columns = ("name", "age", "position", "id_team")
    tree = Treeview(show="headings", columns=columns)
    tree.heading('name', text='Имя', anchor=CENTER)
    tree.heading('age', text='Возраст', anchor=CENTER)
    tree.heading('position', text='Позиция', anchor=CENTER)
    tree.heading('id_team', text='Команда', anchor=CENTER)
    tree.grid(row=6, column=0, columnspan=4, padx=20)
    records = database.read()
    for player in records:
        print(player, "\n")
        tree.insert("", END, values=player)

    mes = Label(window, text='')
    mes.grid(row=7, column=0)

    window.mainloop()