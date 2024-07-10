#include <iostream>
#include <cstdlib>
#include <string>


using namespace std;



template<class T>
T readnumber(int min, int max, T type) 
{
	bool flag = true;
	do 
	{
		cin >> type;
		if (!cin.good() || cin.get() != '\n')
		{
			system("cls");
			cout << "Ошибка! Повторите ввод: \n";
			cin.clear();
			cin.ignore(255, '\n');
		}
		else if (type < min || type > max)
		{
			system("cls");
			cout << "Вы ввели не верное число. \n";
		}
		else flag = false;
	} while (flag == true);

	return type;
}


char readchar()
{
	bool flag = true;
	char symb;
	do
	{
		cin >> symb;
		if (!cin.good() || cin.get() != '\n')
		{
			system("cls");
			cout << "Ошибка! Повторите ввод: \n";
			cin.clear();
			cin.ignore(255, '\n');
		}
		else flag = false;

	} while (flag == true);
	

	return symb;
}


struct node {
	char* str;
	double f;
	node* next;
	int size;
};



int main()
{
	int num;
	node* Q_first = NULL;
	node* Q;
	node* Q1;
	int nume = 0;
	setlocale(LC_ALL, "ru");
	do {

		
		cout << endl;
		cout << ("0. Выход \n");
		cout << ("1. Добавить элемент \n");
		cout << ("2. Вывод очереди \n");
		cout << ("3. Удалить улемент \n");
		cout << ("4. Очистить очередь \n");
		cout << ("Выбирите номер команды: \n");

		
		num = readnumber(0, 4, 1);
		switch (num)
		{
		case 1:
		{
			if (nume == 0)
			{
				Q = (node*)calloc(1, sizeof(node));
				cout << ("Введите количество элементов массивы символов: \n");
				Q->size = readnumber(1, 100, 1);
				Q->str = (char*)calloc(Q->size, sizeof(char));
				
				for (int i = 0; i < Q->size; i++)
				{
					cout << "Введите " << i << " элемент массива: ";
					Q->str[i] = readchar();
				}

				cout << "Введите число: ";
				//Q->f = (double*)calloc(1, sizeof(double));
			Q->f = readnumber(-10000000, 10000000, 1.0);

				Q->next = Q;
				Q_first = Q;
				nume++;
				break;
			}
			else
			{
				Q1 = (node*)calloc(1, sizeof(node));
				cout << ("Введите количество элементов массивы символов: \n");
				Q1->size = readnumber(1, 100, 1);
				Q1->str = (char*)calloc(Q1->size, sizeof(char));
				for (int i = 0; i < Q1->size; i++)
				{
					cout << "Введите " << i << " элемент массива: ";
					Q1->str[i] = readchar();
				}

				cout << "Введите число: ";
				//Q1->f = (double*)calloc(1, sizeof(double));
				Q1->f = readnumber(-10000000, 10000000, 1.0);
				Q1->next = Q_first;
				Q = Q_first;
				for (int i = 1; i < nume; i++)
				{
					Q = Q->next;
				}
				Q->next = Q1;
				nume++;
				break;
			}
		}
		case 2:
		{
			if (Q_first != NULL)
			{
				Q = Q_first;
				for (int j = 0; j < nume; j++)
				{
					cout << "Массив символов " << j + 1 << " элемента очереди: ";
					for (int i = 0; i < Q->size; i++)
					{
						cout << Q->str[i] << " ";
					}
					cout << "\n";
					cout << "Вещественное число " << j + 1 << " элемента очереди: ";
					cout << Q->f << "\n";
					Q = Q->next;
				}
			}
			else cout << "Очередь пуста \n";
			break;
		}
		case 3:
		{
			if (Q_first != NULL)
			{
				Q = Q_first->next;
				free(Q_first->str);
				//free(Q_first->f);
				free(Q_first);
				Q_first = Q;
				nume--;
				if (nume == 0)
				{
					Q_first = NULL;
				}
				cout << "Элемент удален \n";
			}
			else
				cout << "Очередь пуста \n";
			break;
		}
		case 4:
		{
			if (Q_first != NULL)
			{
				for (int i = 1; i < nume; i++)
				{
					Q = Q_first->next;
					free(Q_first->str);
					//free(Q_first->f);
					free(Q_first);
					Q_first = Q;
				}
				free(Q_first->str);
				//free(Q_first->f);
				free(Q_first);
				Q_first = NULL;
				nume = 0;
				cout << ("Очередь очищена \n");
			}
			else cout << "Очередь пуста \n";
			break;
		}
		case 0:
		{
			if (Q_first != NULL)
			{
				for (int i = 1; i < nume; i++)
				{
					Q = Q_first->next;
					free(Q_first->str);
					//free(Q_first->f);
					free(Q_first);
					Q_first = Q;
				}
				free(Q_first->str);
				//free(Q_first->f);
				free(Q_first);
				Q_first = NULL;
				nume = 0;
				cout << ("Очередь очищена \n");
			}
			else cout << "Очередь пуста \n";
			num = 0;
			break;
		}
		}
	} while (num != 0);




	return(0);
}


