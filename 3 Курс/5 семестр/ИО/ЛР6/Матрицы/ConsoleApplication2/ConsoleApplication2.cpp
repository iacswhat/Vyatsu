#include <iostream>
#include <vector>
#include <climits>
using namespace std;

// Функция для поиска наиболее эффективного способа умножения
// заданная последовательность матриц
int matrixChainMultiplication(vector<int> const& dims)
{
    int n = dims.size();

    // c[i, j] = минимальное количество скалярных умножений (т. е. стоимость)
    // необходимо вычислить матрицу `M[i] M[i+1] … M[j] = M[i…j]`
    // Стоимость равна нулю при умножении одной матрицы
    int c[n + 1][n + 1];

    for (int i = 1; i <= n; i++) {
        c[i][i] = 0;
    }

    for (int len = 2; len <= n; len++)        // длина подпоследовательности
    {
        for (int i = 1; i <= n - len + 1; i++)
        {
            int j = i + len - 1;
            c[i][j] = INT_MAX;

            for (int k = i; j < n && k <= j - 1; k++)
            {
                int cost = c[i][k] + c[k + 1][j] + dims[i - 1] * dims[k] * dims[j];
                if (cost < c[i][j]) {
                    c[i][j] = cost;
                }
            }
        }
    }
    return c[1][n - 1];
}

// Задача умножения цепочки матриц
int main()
{
    // Матрица `M[i]` имеет размерность `dims[i-1] × dims[i]` для `i=1…n`
    // ввод: матрица 10 × 30, матрица 30 × 5, матрица 5 × 60
    vector<int> dims = { 10, 30, 5, 60 };

    cout << "The minimum cost is " << matrixChainMultiplication(dims);

    return 0;
}
