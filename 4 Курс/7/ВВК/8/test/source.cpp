#include <iostream>

int main() {
    setlocale(LC_ALL, "Russian");

    int grid_size = 2000; // Размер сетки
    int num_iterations = 5000; // Количество итераций
    int num_procs = 24; // Количество процессоров

    long long total_updates = static_cast<long long>(grid_size) * grid_size * num_iterations;
    int parallelism_percentage = static_cast<int>((total_updates / num_iterations) * 100 / num_procs);

    std::cout << "Степень параллелизма: " << parallelism_percentage << "%" << std::endl;

    return 0;
}
