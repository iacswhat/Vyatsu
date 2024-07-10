#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>

#include <iostream>
#include <algorithm>
#include <vector>
#include <cmath>
#include <fstream>

using namespace std;
float inf = 1e10;
int n = 5;

vector<vector<float>>d((1 << n), vector<float>(n));
vector<int> path;


void findway(vector<vector<float>> g)
{
    int i = 0;
    int mask = (1 << n) - 1;
    path.push_back(0);
    while (mask != 0)
    {
        for (int j = 0; j < n; j++)
        {
            if (g[i][j])
                if ((mask & (1 << j)))
                    if (d[mask][i] == g[i][j] + d[mask ^ (1 << j)][j])
                    {
                        path.push_back(j);
                        i = j;
                        mask = mask ^ (1 << j);
                    }
        }
    }
}

float findcheapest(int i, int mask, vector<vector<float>> g)
{
    if (d[mask][i] != inf)
    {
        return d[mask][i];
    }
    for (int j = 0; j < n; j++)
    {
        if (g[i][j])
            if ((mask & (1 << j)))
            {

                d[mask][i] = min(d[mask][i], findcheapest(j, mask - (1 << j), g) + g[i][j]);
            }
    }
    return d[mask][i];
}

int main()
{
    system("chcp 1251");
    system("cls");
    
    //int n;
    //cin >> n;
    //vector<pair<float, float>> coords(n);
    //for (int i = 0; i < n; ++i)
        //cin >> coords[i].first >> coords[i].second;

    ifstream fin("in.txt");
    //fin >> n;
    vector<vector<float>> g(n, vector<float>(n));

    for (int i = 0; i < n; ++i)
    {
        for (int j = 0; j < n; ++j)
        {
            cin >> g[i][j];
            //if (g[i][j] == 0) g[i][j] = inf;
            //if (i == j) g[i][j] = DBL_MAX;
            //else g[i][j] = dist(coords[i], coords[j]);
        }
    }

    /*int temp;
    for (int i = 0; i < n; i++)
    {
        g[i][i] = 0;
        for (int j = i + 1; j < n; j++) {
            printf("Введите расстояние между вершинами %d - %d: ", i + 1, j + 1);
            scanf("%d", &temp);
            g[i][j] = temp;
            g[j][i] = temp;
        }
    }*/

    printf("\nТаблица:\n");

    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            //printf("%5d ", g[i][j]);
            cout << "\t" << g[i][j] << " |";
        }
        printf("\n");
    }


    for (int i = 0; i < n; i++)
        for (int mask = 0; mask < (1 << n); mask++)
            d[mask][i] = inf;
    d[0][0] = 0;
    float ans = findcheapest(0, (1 << n) - 1, g);
    cout << ans << endl;
    findway(g);
    for (int i = 0; i < n; i++)
        cout << path[i] << endl;
    return 0;
}