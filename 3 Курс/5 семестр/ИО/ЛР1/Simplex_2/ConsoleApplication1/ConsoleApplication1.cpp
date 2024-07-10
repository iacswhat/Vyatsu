#include <iostream>
#include <fstream>
#include <string>
#include <algorithm>




using namespace std;



struct Min_El
{
    double min;
    int index;
};


// размер
int number = 0;
int str_num = 0;

// основная матрица
double**matrix;

// дополнение к основной матрице
double**one;

// таблица
double** Table;

double** Table2;

// целевая функция
double *F;

// Свободные члены
double*B;

int* Base;

double* mas;


bool flag = true;

//Инициализация
void Start()
{
    int i, j;

    F = new double[number + str_num];

    // выделение памяти для матрицы
    matrix = new double* [str_num];
    if (matrix != NULL)
    {
        for (i = 0; i < str_num; i++)
        {
            matrix[i] = new double[number];
        }
    }

    // выделение памяти для единичной
    one = new double* [str_num];
    if (one != NULL)
    {
        for (i = 0; i < str_num; i++)
        {
            one[i] = new double[str_num];
        }
    }
    
    B = new double[str_num + 1];

    Base = new int[str_num];


    // выделение памяти для таблицы
    Table = new double* [str_num + 1];
    if (Table != NULL)
    {
        for (i = 0; i < str_num + 1; i++)
        {
            Table[i] = new double[str_num + number + 1];
        }
    }

    Table2 = new double* [str_num + 1];
    if (Table2 != NULL)
    {
        for (i = 0; i < str_num + 1; i++)
        {
            Table2[i] = new double[str_num + number + 1];
        }
    }

    mas = new double[str_num ];
    for (i = 0; i < str_num; i++)
    {
        mas[i] = 0;
    }

}

//Завершение
void Stop()
{

    int i, j;


    delete[] F;


    for (i = 0; i < str_num; i++)
    {
        delete[] matrix[i];
    }
    delete[] matrix;

    for (i = 0; i < str_num; i++)
    {
        delete[] one[i];
    }
    delete[] one;

    delete[] B;

    delete[] Base;

    for (i = 0; i < str_num + 1; i++)
    {
        delete[] Table[i];
    }
    delete[] Table;

    for (i = 0; i < str_num + 1; i++)
    {
        delete[] Table2[i];
    }
    delete[] Table2;


    delete[] mas;
}

//Чтение из файла
void Read(ifstream &inn)
{
    int i, j;

    for (i = 0; i < number + str_num; i++)
    {
        if (i < number)
        {
            inn >> F[i];
            F[i] = -F[i];
        }
        else
        {
            F[i] = 0;
        }
        
    }

    // заполнение матрицы
    for (i = 0; i < str_num; i++)
    {
        for (j = 0; j < number; j++)
        {
            inn >> matrix[i][j];
        }
    }

    // заполнение единичной
    for (i = 0; i < str_num; i++)
    {
        for (j = 0; j < str_num; j++)
        {
            if (i != j)
            {
                one[i][j] = 0;
            }
            else
            {
                one[i][j] = 1;
            }
        }
    }

    // Свободные члены
    for (i = 0; i < str_num + 1; i++)
    {
        if (i < str_num)
        {
            inn >> B[i];
        }
        else
        {
            B[i] = 0;
        }

    }


    for (i = 0; i < str_num; i++)
    {
        Base[i] = number + i;
    }

}

Min_El Minimum()
{
    Min_El min;
    
    min.min = F[0];
    min.index = 1;

    for (int i = 1; i < number + str_num; i++)
    {
        if (F[i] <= min.min)
        {
            min.min = F[i];
            min.index = i + 1;
        }
    }

    return  min;
}

//Заполнение таблицы
void Fill(int number, int str_num)
{
    int i, j;

    for (i = 0; i < str_num + 1; i++)
    {
        Table[i][0] = B[i];
        Table2[i][0] = B[i];
    }

    for (j = 1; j < (str_num + number + 1); j++)
    {
        Table[str_num][j] = F[j - 1];
        Table2[str_num][j] = F[j - 1];
    }

    for (i = 0; i < str_num; i++)
    {
        for (j = 1; j < number + 1; j++)
        {
            Table[i][j] = matrix[i][j - 1];
            Table2[i][j] = matrix[i][j - 1];
        }
    }
    for (i = 0; i < str_num; i++)
    {
        for (j = number + 1; j < (str_num + number + 1); j++)
        {
            Table[i][j] = one[i][j - number - 1];
            Table2[i][j] = one[i][j - number - 1];
        }
    }

}


// Симплекс
void Siplex(double** Tab, double** Tab2, int str, int col)
{
    cout.setf(ios::fixed);
    cout.precision(2);
    
    
    while ((*min_element(F, F + number + str_num) < 0) && (flag == true))
    {
        int ii = 0;
        int jj = 0;


        cout << "Func:\n";
        for (int n = 0; n < str_num + number; n++)
        {
            cout << F[n] << "\t";
        }
        cout << "\n\n";


        cout << "Table:\n";
        for (int n = 0; n < str_num + 1; n++)
        {
            for (int nn = 0; nn < (str_num + number + 1); nn++)
            {
                cout << "| " << Tab[n][nn] << "\t";
            }
            cout << "\n";
        }
        cout << "\n\n";

        Min_El min;


        min = Minimum();

        int j = min.index;

        cout << "Column: " << j << "\n" << "Min: " << min.min << "\n\n";



        int num_mas = 0;

        //Вывод базиса
        cout << "Mas: ";
        for (ii = 0; ii < str; ii++)
        {
            if ((Tab[ii][j] <= 0) || (Tab[ii][j] == 0))
            {
                mas[ii] = 1000000;
                num_mas++;
            }
            else
            {
                mas[ii] = Tab[ii][0] / Tab[ii][j];
            }
            cout << "| " << mas[ii] << "\t";

        }
        cout << "\n\n";

        if (num_mas == str)
        {
            cout << "Function unlimited!" << "\n\n";
            flag = false;
        }
        else
        {
            int i = 0;
            double m = mas[0];

            for (int n = 1; n < str; n++)
            {
                if (mas[n] < m)
                {
                    i = n;
                    m = mas[n];
                }
            }

            cout << "Line: " << i << "\t" << "Min: " << m << "\n\n";


            for (jj = 0; jj < col + 1; jj++)
            {
                if ((jj != j) || (Tab[i][j] != 0))
                {
                    Tab2[i][jj] = Tab[i][jj] / Tab[i][j];

                }
            }

            for (ii = 0; ii < str + 1; ii++)
            {
                if (ii != i)
                {
                    Tab2[ii][j] = 0;
                }
            }

            if (Tab[i][j] != 0)
            {
                Tab2[i][j] = 1;
            }

            for (ii = 0; ii < str + 1; ii++)
            {
                for (jj = 0; jj < col + 1; jj++)
                {
                    if ((ii != i) && (jj != j))
                    {
                        Tab2[ii][jj] = Tab[ii][jj] - ((Tab[ii][j] * Tab[i][jj]) / Tab[i][j]);
                    }
                }
            }

            //cout << "Table2:\n";
            for (int n = 0; n < str_num + 1; n++)
            {
                for (int nn = 0; nn < (str_num + number + 1); nn++)
                {
                    cout << "| " << Tab2[n][nn] << "\t";
                }
                cout << "\n";
            }
            cout << "\n\n";


            int count = 0;

            for (int nn = 1; nn < (str_num + number + 1); nn++)
            {
                for (int n = 0; n < str_num; n++)
                {
                    if (Tab[n][nn] <= 0)
                    {
                        count++;
                    }
                }
                if (count == str_num)
                {
                    break;
                }

                count = 0;
            }


            for (int n = 0; n < str_num + 1; n++)
            {
                for (int nn = 0; nn < (str_num + number + 1); nn++)
                {
                    Tab[n][nn] = Tab2[n][nn];
                }
            }

            int count_del = 0;

            for (jj = 1; jj < col + 1; jj++)
            {
               F[jj - 1] = Tab[str][jj];
               if (F[jj - 1] == 0)
               {
                count_del++;
               }
            }

            if (count_del > str_num)
            {
                cout << "Infinite Solutions!" << "\n\n";
                flag = false;
            }
            else
            {
                Base[i] = j - 1;

                cout << "Base: ";
                for (int n = 0; n < str_num; n++)
                {
                    cout << "| " << Base[n] << "\t";
                }
                cout << "\n\n";


                for (ii = 0; ii < str_num; ii++)
                {
                    cout << "X" << Base[ii] << " = " << Tab[ii][0] << "\n";
                }

                cout << "----------------------------------------------------------\n\n";
            }
        }
    }
}



int main()
{

    int i, j;

    

    ifstream in("D:\\ЛЕКЦИИ\\LP\\3 Курс\\ИО\\ЛР1\\Simplex_2\\ConsoleApplication1\\x64\\Debug\\Input.txt");

    if (in.is_open())
    {
        // Количество переменных
        in >> number;
        in >> str_num;
        Start();
        Read(in);
    }
    in.close();


   // Заполнение таблицы
    Fill(number, str_num);

    Siplex(Table, Table2, str_num, str_num + number);

    Stop();
    return 0;
}
