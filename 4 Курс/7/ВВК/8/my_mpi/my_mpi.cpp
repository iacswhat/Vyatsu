#include <iostream>
#include <cmath>
#include <mpi.h>

#define N 600  // Размер сетки
#define MAX_ITER  3000

double f(int i, int j) {
    // Функция правой части уравнения Лапласа
    // В данном случае, мы используем нулевую правую часть
    return 0.0;
}

int main(int argc, char** argv) {
    MPI_Init(&argc, &argv);

    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    int local_n = N / size;
    int remainder = N % size;

    int start_row = rank * local_n;
    int end_row = start_row + local_n - 1;
    if (rank == size - 1) {
        end_row += remainder;
    }

    double** u = new double* [local_n + 2];
    for (int i = 0; i < local_n + 2; ++i) {
        u[i] = new double[N];
    }

    // Инициализация граничных условий
    for (int i = 0; i < local_n + 2; ++i) {
        for (int j = 0; j < N; ++j) {
            if (i == 0 || i == local_n + 1 || j == 0 || j == N - 1) {
                // Граничные условия, установим значения в 1.0
                u[i][j] = 1.0;
            }
            else {
                u[i][j] = 0.0;
            }
        }
    }

    MPI_Barrier(MPI_COMM_WORLD);  // Синхронизация перед измерением времени
    
    double start_time = MPI_Wtime();

    // Итерационный метод Якоби
    for (int iter = 0; iter < MAX_ITER; ++iter) {
        if (rank > 0) {
            MPI_Send(u[1], N, MPI_DOUBLE, rank - 1, 0, MPI_COMM_WORLD);
            MPI_Recv(u[0], N, MPI_DOUBLE, rank - 1, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        }
        if (rank < size - 1) {
            MPI_Send(u[local_n], N, MPI_DOUBLE, rank + 1, 0, MPI_COMM_WORLD);
            MPI_Recv(u[local_n + 1], N, MPI_DOUBLE, rank + 1, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        }

        // Обновление значений внутри локальной сетки
        for (int i = 1; i <= local_n; ++i) {
            for (int j = 1; j < N - 1; ++j) {
                u[i][j] = 0.25 * (u[i - 1][j] + u[i + 1][j] + u[i][j - 1] + u[i][j + 1] - f(start_row + i - 1, j));
            }
        }
    }

    MPI_Barrier(MPI_COMM_WORLD);  // Синхронизация перед измерением времени
    double end_time = MPI_Wtime();

    if (rank == 0) {
        std::cout << "Total execution time: " << end_time - start_time << " seconds" << std::endl;
        std::cout << "Number of processors used: " << size << std::endl;
    }

    // Освобождение памяти
    for (int i = 0; i < local_n + 2; ++i) {
        delete[] u[i];
    }
    delete[] u;

    MPI_Finalize();

    return 0;
}



//#include <iostream>
//#include <iomanip>
//#include <cmath>
//#include <mpi.h>
//
//#define N 100 // Размер сетки
//#define MAX_ITER 5000
//
//double f(int i, int j) {
//    return 0.0; // Функция правой части уравнения Лапласа
//}
//
//int main(int argc, char** argv) {
//    MPI_Init(&argc, &argv);
//
//    int rank, size;
//    MPI_Comm custom_comm; // Собственный коммуникатор
//    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
//    MPI_Comm_size(MPI_COMM_WORLD, &size);
//
//    int num_procs = 4; // Количество процессов, которые будут включены в собственный коммуникатор
//    int color = (rank < num_procs) ? 0 : MPI_UNDEFINED;
//
//    MPI_Comm_split(MPI_COMM_WORLD, color, rank, &custom_comm);
//
//    if (custom_comm != MPI_COMM_NULL) {
//        int custom_rank, custom_size;
//        MPI_Comm_rank(custom_comm, &custom_rank);
//        MPI_Comm_size(custom_comm, &custom_size);
//
//        int local_n = N / custom_size;
//        int remainder = N % custom_size;
//
//        int start_row = custom_rank * local_n;
//        int end_row = start_row + local_n - 1;
//        if (custom_rank == custom_size - 1) {
//            end_row += remainder;
//        }
//
//        double** u = new double* [local_n + 2];
//        for (int i = 0; i < local_n + 2; ++i) {
//            u[i] = new double[N];
//        }
//
//        // Инициализация граничных условий
//        for (int i = 0; i < local_n + 2; ++i) {
//            for (int j = 0; j < N; ++j) {
//                if (i == 0 || i == local_n + 1 || j == 0 || j == N - 1) {
//                    // Граничные условия, установим значения в 1.0
//                    u[i][j] = 1.0;
//                }
//                else {
//                    u[i][j] = 0.0;
//                }
//            }
//        }
//
//        MPI_Barrier(custom_comm);  // Синхронизация перед измерением времени
//        double start_time = MPI_Wtime();
//
//        // Итерационный метод Якоби
//        for (int iter = 0; iter < MAX_ITER; ++iter) {
//            if (rank > 0) {
//                MPI_Send(u[1], N, MPI_DOUBLE, rank - 1, 0, MPI_COMM_WORLD);
//                MPI_Recv(u[0], N, MPI_DOUBLE, rank - 1, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
//            }
//            if (rank < size - 1) {
//                MPI_Send(u[local_n], N, MPI_DOUBLE, rank + 1, 0, MPI_COMM_WORLD);
//                MPI_Recv(u[local_n + 1], N, MPI_DOUBLE, rank + 1, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
//            }
//
//            // Обновление значений внутри локальной сетки
//            for (int i = 1; i <= local_n; ++i) {
//                for (int j = 1; j < N - 1; ++j) {
//                    u[i][j] = 0.25 * (u[i - 1][j] + u[i + 1][j] + u[i][j - 1] + u[i][j + 1] - f(start_row + i - 1, j));
//                }
//            }
//        }
//
//        MPI_Barrier(custom_comm);  // Синхронизация перед измерением времени
//        double end_time = MPI_Wtime();
//
//        if (custom_rank == 0) {
//            std::cout << "Total execution time: " << std::fixed << std::setprecision(15) << end_time - start_time << " seconds" << std::endl;
//            std::cout << "Number of processors used: " << custom_size << std::endl;
//        }
//
//        // Освобождение памяти
//        for (int i = 0; i < local_n + 2; ++i) {
//            delete[] u[i];
//        }
//        delete[] u;
//
//        MPI_Comm_free(&custom_comm);
//    }
//
//    MPI_Finalize();
//
//    return 0;
//}


