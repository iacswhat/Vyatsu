import Menu


if __name__ == '__main__':
    while True:
        print("Введите первую дробь>")
        main_frac = Menu.frac()
        print(main_frac)

        print("Введите вторую дробь>")
        sec_frac = Menu.frac()
        print(sec_frac)

        print("-----------------------")
        Menu.main_menu(main_frac, sec_frac)
