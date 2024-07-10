#include <iostream>
#include <stdio.h>
#include <process.h>
#include <locale.h>
#include <conio.h>


using namespace std;


//Основная матрица
double matrix[4][8] = { {40, 1, 3, 5, 3, 1, 0, 0},
						{50, 2, 6, 1, 0, 0, 1, 0 },
						{30, 2, 3, 2, 5, 0, 0, 1},
						{0, -7, -8, -6, -5, 0, 0, 0} };


//Значение свободных членов
double B[4] = { 40, 50, 30, 0 };

//Массив, из которого выбирается минимальный элемент
double mas[3] = { 0, 0, 0 };

// база (-1)
int base[3] = {4, 5, 6};

//Целевая функция
double F[8] = { 0, -7, -8, -6, -5, 0, 0, 0 };

int col_i = 3;
int col_j = 7;
int col_base = 2;




int main()
{
	double Copy_Matrix[4][8] = {{40, 1, 3, 5, 3, 1, 0, 0},
								{50, 2, 6, 1, 0, 0, 1, 0 },
								{30, 2, 3, 2, 5, 0, 0, 1},
								{0, -7, -8, -6, -5, 0, 0, 0}};



	double min_el = -0.001;



	while (min_el < 0)
	{
		int num = -1;

		int ii = 0;
		int jj = 0;

		double mas[3];


		for (int i = 0; i < 8; i++)
		{
			if (F[i] < min_el)
			{
				min_el = F[i];
				num = i;
			}
		}

		int j = num;

		//cout << "Leading column: " << j << endl;

		//Нахождение альф
		for (ii = 0; ii < col_i; ii++)
		{
			if ((Copy_Matrix[ii][j] <= 0) || (Copy_Matrix[ii][0] == 0))
			{
				mas[ii] = 10000000;
			}
			else
			{
				mas[ii] = matrix[ii][0] / matrix[ii][j];
			}
		}

		ii = 0;
		double min = -0.0001;
		int numm = -1;


		for (int i = 0; i < col_i; i++)
		{
			cout << mas[i] << "  ";
			if (mas[i] < min)
			{
				min = mas[i];
				numm = i;
			}
		}
		cout << endl;

		int i = numm;

		//cout << min << endl;

		cout << "Initial matrix: " << endl;

		for (int i = 0; i < 4; i++)
		{
			for (int j = 0; j < 8; j++)
			{
				printf("%4.2f\t", matrix[i][j]);
				//cout << matrix[i][j] << "  ";
			}
			printf("\n");
			//cout << endl;
		}

		





		//min_el = 1;
	}






	return 0;
}