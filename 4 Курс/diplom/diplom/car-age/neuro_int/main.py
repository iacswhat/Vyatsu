import sys
from PyQt6.QtWidgets import QApplication, QWidget, QPushButton, QLabel, QVBoxLayout, QTextEdit, QTableWidget, QTableWidgetItem
import test_single


list = ["Искусство", "Спорт", "Книги/Фильмы", "Наука", "Путешествия", "Кулинария", "Политика"]


class MyWindow(QWidget):
    def __init__(self):
        super().__init__()
        self.initUI()

    def initUI(self):
        self.setWindowTitle('Предсказание интересов')
        self.setGeometry(400, 250, 750, 500)

        self.label_model = QLabel('Введите модель', self)
        self.label_age = QLabel('Введите возраст', self)

        self.text_edit_model = QTextEdit(None, self)
        self.text_edit_model.setFixedSize(750, 30)
        
        self.text_edit_age = QTextEdit(None, self)
        self.text_edit_age.setFixedSize(750, 30)

        self.table = QTableWidget(self)
        self.table.setColumnCount(7)
        self.table.setRowCount(2)
        for col in range(7):
            item = QTableWidgetItem(list[col])
            self.table.setItem(0, col, item)

        self.button = QPushButton('Получить', self)
        self.button.setFixedSize(750, 40)
        self.button.clicked.connect(self.proc)

        vbox = QVBoxLayout()
        vbox.addWidget(self.label_model)
        vbox.addWidget(self.text_edit_model)
        vbox.addWidget(self.label_age)
        vbox.addWidget(self.text_edit_age)
        vbox.addWidget(self.table)
        vbox.addWidget(self.button)

        self.setLayout(vbox)

    def proc(self):
        model = self.text_edit_model.toPlainText()
        age = self.text_edit_age.toPlainText()
        if (model != "") & (age != ""):
            predictions = test_single.main(model, age)
            print(predictions)
            for col in range(7):
                predictions[col] = float(predictions[col])
                item = QTableWidgetItem(str("{:2.2f}".format(predictions[col] * 100)) + "%")
                # if predictions[col] == 1:
                #     item = QTableWidgetItem("ДА")
                # else: item = QTableWidgetItem("НЕТ")
                self.table.setItem(1, col, item)



if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = MyWindow()
    window.show()
    sys.exit(app.exec())
