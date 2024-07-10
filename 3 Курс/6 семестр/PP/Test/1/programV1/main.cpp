#include <iostream>
#include <fstream>
#include <vector>
#include <chrono>

typedef std::vector<std::vector<int>> matrix;

void read_matrix(std::ifstream &in, matrix &m, int64_t n) {
    for (int64_t i = 0; i < n; ++i) {
        for (int64_t j = 0; j < n; ++j) {
            in >> m[i][j];
        }
    }
}

void toFile(matrix &data, int64_t topA, int64_t leftA, int n) {
    std::ofstream out("debug.txt");

    for (int64_t i = 0; i < n; ++i) {
        for (int64_t j = 0; j < n; ++j) {
            out << data[i + topA][j + leftA] << " ";
        }
        out << std::endl;
    }
    out.close();
}

void matrix_multiply(matrix &a, matrix &b, matrix &c, int64_t topA, int64_t leftA, int64_t topB, int64_t leftB, int64_t topC, int64_t leftC, int64_t n) {
    int i, j, k;
    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {
            c[i + topC][j + leftC] = 0;
            for (k = 0; k < n; k++)
                c[i + topC][j + leftC] += a[i + topA][k + leftA] * b[k + topB][j + leftB];
        }
    }
}

void addMatrix(matrix &a, matrix &b, matrix &c, int64_t topA, int64_t leftA, int64_t topB, int64_t leftB, int64_t topC, int64_t leftC, int64_t n) {
    for (int64_t i = 0; i < n; ++i) {
        for (int64_t j = 0; j < n; ++j) {
            c[i + topC][j + leftC] = a[i + topA][j + leftA] + b[i + topB][j + leftB];
        }
    }
}

void subMatrix(matrix &a, matrix &b, matrix &c, int64_t topA, int64_t leftA, int64_t topB, int64_t leftB, int64_t topC, int64_t leftC, int64_t n) {
    for (int64_t i = 0; i < n; ++i) {
        for (int64_t j = 0; j < n; ++j) {
            c[i + topC][j + leftC] = a[i + topA][j + leftA] - b[i + topB][j + leftB];
        }
    }
}

int64_t new_size(int64_t n) {
    int64_t r = 1;
    while((n >>= 1) != 0) {
        r++;
    }
    return 1 << r;
}

bool isPowerOfTwo(int64_t v) {
    return v && !(v & (v - 1));
}

void strassen(matrix &a, matrix &b, matrix &c, int64_t topA, int64_t leftA, int64_t topB, int64_t leftB, int64_t topC, int64_t leftC, int64_t n) {
    if (n <= 32) {
        matrix_multiply(a, b, c, topA, leftA, topB, leftB, topC, leftC, n);
    } else {
        
        n = n >> 1;

        // C12 = A21 - A11
        subMatrix(a, a, c, topA + n, leftA, topA, leftA, topC, leftC + n, n);
        // C21 = B11 + B12
        addMatrix(b,b,c,topB,leftB,topB,leftB + n,topC + n,leftC,n);      
        // C22 = C12 * C21
        // P6
        strassen(c,c,c,topC,leftC + n,topC + n,leftC,topC + n,leftC + n,n);



        //C12 = A12 - A22
        subMatrix(a,a,c,topA,leftA + n,topA + n,leftA + n,topC,leftC + n,n);        
        //C21 = B21 + B22
        addMatrix(b, b, c, topB + n,leftB,topB + n,leftB + n,topC + n,leftC,n);
        //C11 = C12 * C21
        // P7
        strassen(c,c,c,topC,leftC + n,topC + n,leftC,topC,leftC,n);


        
        //C12 = A11 + A22
        addMatrix(a, a, c, topA, leftA, topA + n, leftA + n, topC, leftC + n, n);
        //C21 = B11 + B22
        addMatrix(b,b,c,topB,leftB,topB + n,leftB + n,topC + n,leftC,n);
        matrix t1(n, std::vector<int>(n));
        //t1 = C12*C21
        // P1
        strassen(c,c,t1,topC,leftC + n,topC + n,leftC,0,0,n);

        //C11 = t1 + C11
        addMatrix(t1,c,c,0,0,topC,leftC,topC,leftC,n);
        //C22 = t1 + C22
        addMatrix(t1,c,c,0,0,topC + n,leftC + n,topC + n,leftC + n,n);



        //C12 = A21 + A22
        addMatrix(a,a,c,topA + n,leftA,topA + n,leftA + n,topC, leftC + n,n);
        //C21 = C12 * B11
        // P2
        strassen(c,b,c,topC, leftC + n,topB,leftB,topC + n,leftC,n);

        //C22 = C22 - C21
        subMatrix(c,c,c,topC + n,leftC + n,topC + n,leftC,topC + n,leftC + n,n);



        //t1 = B21 - B11
        subMatrix(b,b,t1,topB + n,leftB,topB,leftB,0,0,n);
        //C12 = A22 * t1
        // P4
        strassen(a,t1,c,topA + n,leftA + n,0,0,topC, leftC + n,n);

        //C21 = C21 + C12
        addMatrix(c,c,c,topC + n,leftC,topC, leftC + n,topC + n,leftC,n);
        //C11 = C11 + C12
        addMatrix(c,c,c,topC,leftC,topC, leftC + n,topC,leftC,n);



        //t1 = B12 - B22
        subMatrix(b,b,t1,topB,leftB + n,topB + n,leftB + n,0,0,n);
        //C12 = A11 * t1
        // P3
        strassen(a,t1,c,topA,leftA,0,0,topC,leftC + n,n);

        //C22 = C22 + C12
        addMatrix(c,c,c,topC + n,leftC + n,topC,leftC + n,topC + n,leftC + n,n);


        matrix t2(n, std::vector<int>(n));
        //t2 = A11 + A12
        addMatrix(a,a,t2,topA,leftA,topA,leftA + n,0,0,n);
        //t1 = t2 * B22
        // P5
        strassen(t2,b,t1,0,0,topB + n,leftB + n,0,0,n);

        //C12 = C12 + t1
        addMatrix(c,t1,c,topC,leftC + n,0,0,topC,leftC + n,n);
        //C11 = C11 - t1
        subMatrix(c,t1,c,topC,leftC,0,0,topC,leftC,n);
    }
}

int main() {
    int64_t n, real_n;
    std::ifstream in("matrix.txt");

    if (!in.is_open()) {
        std::cout << "matrix.txt open error";
        return 1;
    }

    in >> real_n;
    n = real_n;
    
    if (!isPowerOfTwo(real_n) || real_n == 1) {
        n = new_size(real_n);
    }

    matrix a(n, std::vector<int>(n, 0));
    matrix b(n, std::vector<int>(n, 0));
    matrix result(n, std::vector<int>(n));

    read_matrix(in, a, real_n);
    read_matrix(in, b, real_n);

    in.close();

    auto begin = std::chrono::steady_clock::now();
    
    strassen(a, b, result, 0, 0, 0, 0, 0, 0, n);

    auto end = std::chrono::steady_clock::now();
    auto elapsed_ms = std::chrono::duration_cast<std::chrono::milliseconds>(end - begin).count();


    std::ofstream out("result.txt");
    if (!out.is_open()) {
        std::cout << "Result file open error";
        return 1;
    }


    for (int64_t i = 0; i < real_n; ++i) {
        for (int64_t j = 0; j < real_n; ++j) {
            out << result[i][j] << " ";
        }
        out << std::endl;
    }


    out.close();
    std::cout << "Ok" << std::endl;
    std::cout << "Time (s): " << (double) elapsed_ms/1000;

    return 0;
}