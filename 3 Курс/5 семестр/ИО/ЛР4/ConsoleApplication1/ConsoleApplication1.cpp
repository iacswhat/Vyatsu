#include <iostream>
#include <fstream>
#include <string>
#include <algorithm>
#include <vector>

using namespace std;
using std::vector;

const int INF = 1000 * 1000 * 1000;
const int inf = numeric_limits<int>::max();

typedef pair<int, int> PInt;
typedef vector<int> VInt;
typedef vector<VInt> VVInt;
typedef vector<PInt> VPInt;

void printMatrVector(VVInt const& mat)
{
    for (VInt row : mat)
    {
        for (int val : row) {
            cout << "|" << val << "\t";
        }
        cout << "\n";
    }
    cout << "\n";
}

void printVector(VPInt const& v)
{
    cout << "|Str\t|Col\n";
    for (size_t i = 0; i < size(v); i++)
    {
        cout << "|" << v[i].first << "\t|" << v[i].second << "\n";
    }
    cout << "\n";
}

VPInt hungarian(const VVInt& matrix) 
{
    cout << "Start: \n";
    int height = matrix.size(), width = matrix[0].size();
    VInt u(height, 0), v(width, 0);
    VInt markIndices(width, -1);
    for (int i = 0; i < height; i++) 
    {
        VInt links(width, -1);
        VInt mins(width, inf);
        VInt visited(width, 0);
        int markedI = i, markedJ = -1, j;
        while (markedI != -1) 
        {
            j = -1;
            for (int j1 = 0; j1 < width; j1++)
                if (!visited[j1]) 
                {
                    if (matrix[markedI][j1] - u[markedI] - v[j1] < mins[j1]) 
                    {
                        mins[j1] = matrix[markedI][j1] - u[markedI] - v[j1];
                        links[j1] = markedJ;
                    }
                    if (j == -1 || mins[j1] < mins[j])
                        j = j1;
                }
            int delta = mins[j];
            for (int j1 = 0; j1 < width; j1++)
                if (visited[j1]) 
                {
                    u[markIndices[j1]] += delta;
                    v[j1] -= delta;
                }
                else 
                {
                    mins[j1] -= delta;
                }
            u[i] += delta;
            visited[j] = 1;
            markedJ = j;
            markedI = markIndices[j];
        }
        for (;links[j] != -1; j = links[j])
            markIndices[j] = markIndices[links[j]];
        markIndices[j] = i;
        for (int i = 0; i < height; i++)
        {
            for (int j = 0; j < width; j++)
            {
                cout << "|" << matrix[i][j] - u[i] - v[j] << "\t";
            }
            cout << "\n";
        }
        cout << "\n----------------------------------------\n\n";
    }
    VPInt result;
    for (int j = 0; j < width; j++)
        if (markIndices[j] != -1)
            result.push_back(PInt(markIndices[j], j));
    return result;
}

int Res(VVInt const& matr, VPInt const& answer)
{
    int result = 0;
    for (size_t i = 0; i < answer.size(); i++)
    {
        result += matr[answer[i].first][answer[i].second];
    }
    return result;
}

int main() 
{
    VVInt a = {
    {1, 6,  3,  3,  2},
    {1, 15, 3,  9,  1},
    {1, 5, 17, 17, 18},
    {1, 4, 16, 17, 19},
    {1, 13, 19, 17, 19}
    };

    /*VVInt a =
    {
        { 1,3,3,3,7 },
        { 1,15,9,9,9 },
        { 1,11,17,18,18 },
        { 1,22,16,17,17 },
        { 1,11,19,18,19},
    };*/
    printMatrVector(a);
    VPInt ans = hungarian(a);
    printVector(ans);
    cout << "Sum: " << Res(a, ans);

    return 0;
}