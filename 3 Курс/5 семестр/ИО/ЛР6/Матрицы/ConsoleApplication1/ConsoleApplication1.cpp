#include <iostream>
#include <vector>
#include <climits>
using namespace std;



int matrixChainMultiplication(vector<int> const& dims, int i, int j, vector<vector<int>> & lookup, vector<vector<int>> & s)
{
    // базовый вариант: одна матрица
    if (j <= i + 1) 
    {
        cout << "!!!\n\n";
        return 0;
    }

    // сохраняет минимальное количество скалярных умножений (т.е. стоимость)
    // необходимо вычислить матрицу M[i+1] … M[j] = M[i…j]
    int min = INT_MAX;
   

    if (lookup[i][j] == 0)
    {
        for (int k = i + 1; k <= j - 1; k++)
        {
           
            // повторить для M[i+1]…M[k], чтобы получить матрицу i × k
            int cost = matrixChainMultiplication(dims, i, k, lookup, s);

            // повторить для M[k+1]…M[j], чтобы получить матрицу k × j
            cost += matrixChainMultiplication(dims, k, j, lookup, s);

            // стоимость умножения двух матриц i × k и k × j
            cost += dims[i] * dims[k] * dims[j];


            cout << i << "\t" << k << "\t" << j << "\n";
            cout << dims[i] << "\t" << dims[k] << "\t" << dims[j] << "\n";
           
            cout << cost << "\n";

            if (cost < min) {
                min = cost;
            }
            s[i][j] = k;
        }

        lookup[i][j] = min;

        for (int i = 0; i < dims.size() + 1; i++)
        {
            for (int j = 0; j < dims.size() + 1; j++)
            {
                cout << lookup[i][j] << " |\t";
            }
            cout << "\n";
        }

        cout << "\n\n";

        for (int i = 0; i < dims.size() + 1; i++)
        {
            for (int j = 0; j < dims.size() + 1; j++)
            {
                cout << s[i][j] << " |\t";
            }
            cout << "\n";
        }
        
       
    }

    cout << lookup[i][j] << "\n";
    // вернуть минимальную стоимость для умножения M[j+1]…M[j]

    cout << i << "\t" << j << "\n";

  

    cout << "----------------------------------------------------\n";
    return lookup[i][j];
}

// Задача умножения цепочки матриц
int main()
{
    vector<int> dims = { 30, 15, 5, 60 };
    int n = dims.size();

    // таблица поиска для хранения решения уже вычисленных подзадач
    vector<vector<int>> lookup(n + 1, vector<int>(n + 1));
    vector<vector<int>> s(n + 1, vector<int>(n + 1));


    cout << "The minimum cost is " << matrixChainMultiplication(dims, 0, n - 1, lookup, s) << "\n";

    cout << n << "\n";

   


    return 0;
}
