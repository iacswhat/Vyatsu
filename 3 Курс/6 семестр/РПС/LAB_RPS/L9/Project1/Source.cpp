#include<iostream>
#include<time.h>
#include"gmp.h"
#include<string>
#include <cstring>
#include <chrono>

#pragma warning(disable: 4146)


using namespace std;




int main() {
    //setlocale(LC_ALL, "en_US.UTF-8");

    mpz_t num1, num2, result;
    mpz_init(num1);
    mpz_init(num2);
    mpz_init(result);

    std::string number_str(10000000, '1');

    const char* number = number_str.c_str();

    // Установка значений чисел
    mpz_set_str(num1, number, 10);
    mpz_set_str(num2, number, 10);

    auto start = std::chrono::high_resolution_clock::now();
    // Умножение чисел
    mpz_mul(result, num1, num2);
    auto end = std::chrono::high_resolution_clock::now();

    std::chrono::duration<double> duration = end - start;
    std::cout << "Время выполнения: " << duration.count() << " сек" << std::endl;

    // Вывод результата
    //char* result_str = mpz_get_str(NULL, 10, result);
    //printf("Результат умножения: %s\n", result_str);


    // Освобождение памяти
    mpz_clear(num1);
    mpz_clear(num2);
    mpz_clear(result);

    return 0;
}