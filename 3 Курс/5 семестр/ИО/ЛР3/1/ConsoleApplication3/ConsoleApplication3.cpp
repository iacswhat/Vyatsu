#include "stdafx.h"
#include <iostream>
#include <cstdio>
#include <string>
#include "locale.h"
#include "math.h"

int SimplexMethod(int n1, int m1);
int gomoryMethod(int n1, int m1);

FILE* stream;
double basicMatr[50][50];
double matr[50][50];
double matrResults[50][10];
double matrMatr[20][50][50];
int n, m, nResult;
double basicResult[15];

int main()
{
	setlocale(LC_ALL, "Russian_Russia.1251");
	std::cout.precision(2);

	int err;
	char ScanStr;

	err = fopen_s(&stream, "matrix.txt", "r");

	if (err == 0 && stream != NULL)
	{
		int m1 = 0;
		do
		{
			ScanStr = fgetc(stream);
			if ((int)ScanStr != 10)
			{
				if ((int)ScanStr == 32)
				{
					m1 = m1 + 1;
				}
			}
			else
			{
				if (m1 > m)
				{
					m = m1;
				}
				m1 = 0;
				n = n + 1;
			}

		} while ((int)ScanStr != -1);

		rewind(stream);
		int h = NULL;
		char bufChar[10] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
		int n1 = 0;
		m1 = 3;
		bool singMoreFound = false;

		do
		{
			ScanStr = fgetc(stream);

			if ((int)ScanStr == 32)
			{
				basicMatr[n1][m1] = std::stod(bufChar);
				for (int i = 0; i < h; i++)
				{
					bufChar[i] = NULL;
				}
				m1 = m1 + 1;
				h = 0;
			}
			else if ((int)ScanStr == 10)
			{
				basicMatr[n1][m1] = std::stod(bufChar);
				for (int i = 0; i < h; i++)
				{
					bufChar[i] = NULL;
				}
				if (singMoreFound == true)
				{
					for (int i = 3; i <= m1; i++)
					{
						basicMatr[n1][i] = -basicMatr[n1][i];
					}
				}
				singMoreFound = false;
				n1 = n1 + 1;
				m1 = 3;
				h = 0;
			}
			else if ((int)ScanStr == -1)
			{
				basicMatr[n1][m1] = std::stod(bufChar);
				for (int i = 0; i < h; i++)
				{
					bufChar[i] = NULL;
				}
				if (singMoreFound == true)
				{
					for (int i = 3; i <= m1; i++)
					{
						basicMatr[n1][i] = -basicMatr[n1][i];
					}
				}
				singMoreFound = false;
				h = 0;
			}
			else if ((int)ScanStr == 62)
			{
				singMoreFound = true;
				bufChar[0] = 48;
			}
			else if ((int)ScanStr == 60 || (int)ScanStr == 61)
			{
				bufChar[0] = 48;
			}
			else
			{
				bufChar[h] = ScanStr;
				h = h + 1;
			}

		} while ((int)ScanStr != -1);

		fclose(stream);
	}
	else
	{

	}

	for (int i = 0; i <= n; i++)
	{
		basicMatr[i][m + 2] = basicMatr[i][m + 3];
		basicMatr[i][m + 3] = 0;
	}
	m = m - 1;

	for (int i = 0; i <= n; i++)
	{
		for (int j = 0; j <= m + 3; j++)
		{
			matr[i][j] = basicMatr[i][j];
		}
	}

	std::cout << n + 1 << " " << m + 1 << "\n";		//вывод записанных данных
	std::cout << std::endl;

	int result;
	result = SimplexMethod(n, m);

	int n1 = n;
	int m1 = m;

	if (result == 2)	//начало целочисленных
	{
		std::cout << std::endl;
		result = gomoryMethod(n, m);
	}
	int a;
	std::cin >> a;

	return 0;
}

int SimplexMethod(int n1, int m1)
{
	for (int i = 0; i <= n1; i++)
	{
		for (int j = 3; j <= m1 + 3; j++)
		{
			std::cout << matr[i][j] << "\t";
		}
		std::cout << std::endl;
	}

	double buf;
	for (int i = 1; i <= n1; i++)	//перемещение последнего столбца
	{
		buf = matr[i][m1 + 3];
		matr[i][m1 + 3] = matr[i][2];
		matr[i][2] = buf;
	}

	for (int i = 1; i <= n1; i++)	//заполнение единицами
	{
		matr[i][m1 + i + 2] = 1;
	}

	std::cout << std::endl;
	std::cout << "|БП" << "\t" << "|Сб" << "\t" << "|B" << "\t";	//вывод верхней строки
	for (int i = 1; i < m1 + n1 + 1; i++)
	{
		std::cout << "|x" << i << "(" << matr[0][i + 2] << ")" << "\t";
	}
	std::cout << std::endl;

	for (int i = 1; i <= n1; i++)		//вывод матрицы
	{
		std::cout << "|x";
		for (int j = 0; j < m1 + n1 + 3; j++)
		{
			if (j == 0)
			{
				std::cout << matr[i][j] << "\t";
			}
			else
			{
				std::cout << "|" << matr[i][j] << "\t";
			}
		}
		std::cout << std::endl;
	}

	std::cout << "|delta" << "\t" << "\t";

	for (int i = 2; i <= m1 + n1 + 2; i++)	//вывод индекстной строки
	{
		matr[n1 + 1][i] = -matr[0][i];
		std::cout << "|" << -matr[0][i] << "\t";
	}
	std::cout << std::endl;
	std::cout << std::endl;

	int n2 = 1;
	int m2 = 0;
	int basicM1 = 0;
	double basicElement = 0;
	double coefficient = 0;
	bool negativeBasisFound = false;
	while (n2 != n1 + 1)
	{
		if (matr[n2][2] < 0)
		{
			negativeBasisFound = true;
			bool negativeElementFound = false;
			for (int i = 3; i <= m1 + 4; i++)
			{
				if (matr[n2][i] < 0 && negativeElementFound == false)
				{
					negativeElementFound = true;
					basicM1 = i;
				}
			}
			if (negativeElementFound == true)
			{
				negativeBasisFound = false;
				matr[n2][0] = basicM1 - 2;			//запись номера x
				matr[n2][1] = matr[0][basicM1];		//запись номера от F
				basicElement = matr[n2][basicM1];	//запись опорного элемента
				for (int i = 1; i <= n1; i++)		//расчет симплекс таблицы относительно опорного элемента
				{
					coefficient = matr[i][basicM1] / basicElement;
					if (i != n2)
					{
						for (int j = 2; j <= m1 + n1 + 2; j++)
						{
							matr[i][j] = matr[i][j] - matr[n2][j] * coefficient;
						}
					}
				}
				for (int i = 2; i <= m1 + n1 + 2; i++)	//деление базовой строки на опорный элемент
				{
					matr[n2][i] = matr[n2][i] / basicElement;
				}

				std::cout << "|БП" << "\t" << "|Сб" << "\t" << "|B" << "\t";	//вывод верхней строки
				for (int i = 1; i < m1 + n1 + 1; i++)
				{
					std::cout << "|x" << i << "(" << matr[0][i + 2] << ")" << "\t";
				}
				std::cout << std::endl;

				for (int i = 1; i <= n1; i++)		//вывод матрицы
				{
					std::cout << "|x";
					for (int j = 0; j < m1 + n1 + 3; j++)
					{
						if (j == 0)
						{
							std::cout << matr[i][j] << "\t";
						}
						else
						{
							std::cout << "|" << matr[i][j] << "\t";
						}
					}
					std::cout << std::endl;
				}

				std::cout << "|delta" << "\t" << "\t";

				for (int i = 2; i <= m1 + n1 + 2; i++)	//вывод индекстной строки
				{
					std::cout << "|" << matr[n1 + 1][i] << "\t";
				}

				std::cout << std::endl;
				std::cout << std::endl;
				n2 = 0;

			}
		}
		n2 = n2 + 1;
	}

	if (negativeBasisFound == false)
	{
		int m1End = 3;					//номер опорного столбца
		basicElement = 0;				//опорный элемент
		double basicElementBuf;
		bool basicСolumnFound = true;	//проверка найден ли опорный столбец
		bool basicStringFound = false;	//проверка найдена ли опорная строка
		coefficient = 0;				//коэффициент для приведение опорного столбцца к 0
		int basicString = 0;			//номер опорной строки
		//const int INFINITY = 9999999;

		do
		{
			basicElementBuf = -INFINITY;
			basicСolumnFound = false;
			for (int i = 3; i <= m1 + n1 + 2; i++)	//поиск отрицательной переменной в индекстной строке
			{
				if (matr[n1 + 1][i] < 0)
				{
					if (basicElementBuf < abs(matr[n1 + 1][i]) && matr[n1 + 2][i] != 1)
					{
						basicElementBuf = abs(matr[n1 + 1][i]);
						m1End = i;
						basicСolumnFound = true;
					}
				}

			}

			if (basicСolumnFound == true)		//если отрицательный элемент найден
			{
				matr[n1 + 2][m1End] = 1;
				basicElementBuf = INFINITY;
				basicStringFound = false;
				for (int i = 1; i <= n1; i++)	//поиск опорной строки
				{
					basicElement = matr[i][2] / matr[i][m1End];
					if (basicElement < basicElementBuf && matr[i][m1End] > 0)
					{
						basicElementBuf = basicElement;
						basicString = i;
						basicStringFound = true;
						//std::cout << counterEnd << " " << basicElement << " " << basicString;
					}
				}

				if (basicStringFound == true)	//если опорная строка найдена
				{
					matr[basicString][0] = m1End - 2;			//запись номера x
					matr[basicString][1] = matr[0][m1End];		//запись номера от F
					basicElement = matr[basicString][m1End];	//запись опорного элемента
					for (int i = 1; i <= n1 + 1; i++)			//расчет симплекс таблицы относительно опорного элемента
					{
						coefficient = matr[i][m1End] / basicElement;
						if (i != basicString)
						{
							for (int j = 2; j <= m1 + n1 + 2; j++)
							{
								matr[i][j] = matr[i][j] - matr[basicString][j] * coefficient;
							}
						}
					}
					for (int i = 2; i <= m1 + n1 + 2; i++)	//деление базовой строки на опорный элемент
					{
						matr[basicString][i] = matr[basicString][i] / basicElement;
					}
					matr[n1 + 2][m1End] = 0;		//убирание индификатора проверенного элемента в индекстной строке

					std::cout << "|БП" << "\t" << "|Сб" << "\t" << "|B" << "\t";	//вывод верхней строки
					for (int i = 1; i < m1 + n1 + 1; i++)
					{
						std::cout << "|x" << i << "(" << matr[0][i + 2] << ")" << "\t";
					}
					std::cout << std::endl;

					for (int i = 1; i <= n1; i++)		//вывод матрицы
					{
						std::cout << "|x";
						for (int j = 0; j < m1 + n1 + 3; j++)
						{
							if (j == 0)
							{
								std::cout << matr[i][j] << "\t";
							}
							else
							{
								std::cout << "|" << matr[i][j] << "\t";
							}
						}
						std::cout << std::endl;
					}

					std::cout << "|delta" << "\t" << "\t";

					for (int i = 2; i <= m1 + n1 + 2; i++)	//вывод индекстной строки
					{
						std::cout << "|" << matr[n1 + 1][i] << "\t";
					}

					std::cout << std::endl;
					std::cout << std::endl;

					basicElementBuf = INFINITY;
				}
			}
			else
			{
				int count = 0;
				basicElementBuf = -INFINITY;
				for (int i = 3; i <= m1 + n1 + 2; i++)	//подсчет количества нулей в индекстной строке
				{
					if (matr[n1 + 1][i] == 0)
					{
						count = count + 1;
					}
				}

				if (count == n1 && basicStringFound == true)
				{
					std::cout << "решение получено:" << std::endl;
					std::cout << "F = " << matr[n1 + 1][2] << std::endl;
					for (int i = 1; i <= n1; i++)
					{
						if (matr[i][0] <= n)
						{
							std::cout << "X" << matr[i][0] << " = " << matr[i][2] << std::endl;
						}
					}

					bool notIntegerElementFound = false;
					for (int i = 1; i <= n; i++)
					{
						if (matr[i][2] != (int)matr[i][2] && notIntegerElementFound == false && matr[i][0] <= n)
						{
							notIntegerElementFound = true;
						}
					}
					if (notIntegerElementFound == false)
					{
						return 1;
					}
					else
					{
						return 2;
					}
				}
				else if (basicStringFound == true)
				{
					std::cout << "множество решений" << std::endl;
					return 0;
				}
				else
				{
					std::cout << "решений нет" << std::endl;
					return 0;
				}
			}

		} while (basicСolumnFound != false);
	}
	else
	{
		std::cout << "решений нет" << std::endl;
		return 0;
	}
	return 0;
}

int gomoryMethod(int n1, int m1)
{
		int m1End = 3;					//номер опорного столбца
		bool notIntegerFound;
		int notIntegerString = 0;
		double basicElement = 0;				//опорный элемент
		double basicElementBuf;
		bool basicСolumnFound = true;	//проверка найден ли опорный столбец
		bool basicStringFound = false;	//проверка найдена ли опорная строка
		double coefficient = 0;				//коэффициент для приведение опорного столбца к 0
		int basicString = 0;			//номер опорной строки
		//const int INFINITY = 9999999;

		for (int i = 2; i <= m + n + 2; i++)	//поиск отрицательной переменной в индекстной строке
		{
			matr[n + 1][i] = -matr[n + 1][i];
		}
		do
		{
			/*for (int i = 0; i <= n1; i++)
			{
				for (int j = 2; j <= m1; j++)
				{

					matr[i][j] = printf("%.1f", matr[i][j]);
					round(matr[i][j]);
				}
			}*/
			notIntegerFound = false;
			notIntegerString = 1;
			double test, test1;
			for (int i = 1; i <= n1; i++)
			{
				if (matr[i][2] != (int)matr[i][2] && matr[i][0] <= m)
				{
					test = matr[i][2];
					test1 = (int)matr[i][2];
					notIntegerFound = true;
					if (matr[notIntegerString][2] - (int)matr[notIntegerString][2] < matr[i][2] - (int)matr[i][2])
					{
						//test = matr[notIntegerString][2] - (int)matr[notIntegerString][2];
						//test1 = matr[i][2] - (int)matr[i][2];
						notIntegerString = i;
					}
				}
			}

			if (notIntegerFound == true)
			{
				matr[n1 + 1][2] = matr[n1 + 1][2];
				for (int i = 2; i <= m1 + n + 2; i++)	//поиск отрицательной переменной в индекстной строке
				{
					matr[n1 + 2][i] = matr[n1 + 1][i];
					if (matr[notIntegerString][i] > 0 || matr[notIntegerString][i] == 0)
					{
						matr[n1 + 1][i] = (int)matr[notIntegerString][i] - matr[notIntegerString][i];
					}
					else
					{
						matr[n1 + 1][i] = (int)matr[notIntegerString][i] - 1 - matr[notIntegerString][i];
					}
				}

				//matr[n1 + 1][2] = (int)matr[notIntegerString][2] - matr[notIntegerString][2];
				matr[n1 + 1][0] = 1 + m1 + n;
				matr[n1 + 1][m1 + n + 3] = 1;
				n1 = n1 + 1;
				m1 = m1 + 1;

				basicString = n1;
				basicStringFound = true;

				basicElementBuf = INFINITY;
				basicСolumnFound = false;
				for (int i = 3; i <= m1 + n + 1; i++)	//поиск отрицательной переменной в индекстной строке
				{
					if (matr[n1][i] != 0)
					{
						coefficient = matr[n1 + 1][i] / matr[n1][i];
						if (coefficient < basicElementBuf)
						{
							basicElementBuf = coefficient;
							m1End = i;
							basicСolumnFound = true;
						}
					}
				}

				matr[basicString][0] = m1End - 2;			//запись номера x
				matr[basicString][1] = matr[0][m1End];		//запись номера от F
				basicElement = matr[basicString][m1End];	//запись опорного элемента
				for (int i = 1; i <= n1 + 1; i++)			//расчет симплекс таблицы относительно опорного элемента
				{
					coefficient = matr[i][m1End] / basicElement;
					if (i != basicString)
					{
						for (int j = 2; j <= m1 + n + 2; j++)
						{
							matr[i][j] = matr[i][j] - matr[basicString][j] * coefficient;
						}
					}
				}
				for (int i = 2; i <= m1 + n + 2; i++)	//деление базовой строки на опорный элемент
				{
					matr[basicString][i] = matr[basicString][i] / basicElement;
				}

				std::cout << "|БП" << "\t" << "|Сб" << "\t" << "|B" << "\t";	//вывод верхней строки
				for (int i = 1; i < m1 + n + 1; i++)
				{
					std::cout << "|x" << i << "(" << matr[0][i + 2] << ")" << "\t";
				}
				std::cout << std::endl;

				for (int i = 1; i <= n1; i++)		//вывод матрицы
				{
					std::cout << "|x";
					for (int j = 0; j < m1 + n + 3; j++)
					{
						if (j == 0)
						{
							std::cout << matr[i][j] << "\t";
						}
						else
						{
							std::cout << "|" << matr[i][j] << "\t";
						}
					}
					std::cout << std::endl;
				}

				std::cout << "|delta" << "\t" << "\t";

				for (int i = 2; i <= m1 + n + 2; i++)	//вывод индекстной строки
				{
					std::cout << "|" << matr[n1 + 1][i] << "\t";
				}

				std::cout << std::endl;
				std::cout << std::endl;

				basicElementBuf = INFINITY;
			}
			else
			{
				int count = 0;
				basicElementBuf = -INFINITY;
				for (int i = 3; i <= m1 + n + 2; i++)	//подсчет количества нулей в индекстной строке
				{
					if (matr[n1 + 1][i] == 0)
					{
						count = count + 1;
					}
				}

				if (count == n1 && basicStringFound == true)
				{
					std::cout << "решение получено:" << std::endl;
					std::cout << "F = " << -matr[n1 + 1][2] << std::endl;
					for (int i = 1; i <= n1; i++)
					{
						if (matr[i][0] <= n)
						{
							std::cout << "X" << matr[i][0] << " = " << matr[i][2] << std::endl;
						}
					}

					bool notIntegerElementFound = false;
					for (int i = 1; i <= n; i++)
					{
						if (matr[i][2] != (int)matr[i][2] && notIntegerElementFound == false && matr[i][0] <= n)
						{
							notIntegerElementFound = true;
						}
					}
					if (notIntegerElementFound == false)
					{
						return 1;
					}
					else
					{
						return 2;
					}
				}
				else if (basicStringFound == true)
				{
					std::cout << "множество решений" << std::endl;
					return 0;
				}
				else
				{
					std::cout << "решений нет" << std::endl;
					return 0;
				}
			}
		} while (notIntegerFound != false);

	return 0;
}