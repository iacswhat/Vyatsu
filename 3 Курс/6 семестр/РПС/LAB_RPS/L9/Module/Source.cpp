#include"BigIntegerLib.h"
#include"big_integer.hpp"
#include<string>
#include<iostream>
#include <cstring>
#include<time.h>
#include"gmp.h"
#include <chrono>

using namespace std;



extern "C" __declspec(dllexport) const char* multiply_num(char* str1, int len1, char* str2, int len2) {


	mpz_t num1, num2, result;
	mpz_init(num1);
	mpz_init(num2);
	mpz_init(result);

	string string1(str1, len1);
	string string2(str2, len2);

	const char* number1 = string1.c_str();
	const char* number2 = string2.c_str();

	mpz_set_str(num1, number1, 10);
	mpz_set_str(num2, number2, 10);

	auto start = std::chrono::high_resolution_clock::now();
	// Умножение чисел
	mpz_mul(result, num1, num2);
	auto end = std::chrono::high_resolution_clock::now();

	size_t bufferSize = mpz_sizeinbase(result, 10) + 2;
	char* charArray = new char[bufferSize];


	mpz_get_str(charArray, 10, result);

	string arr(charArray);

	std::chrono::duration<double> duration = end - start;
	std::cout << "Время выполнения: " << duration.count() << " сек" << std::endl;

	// Освобождение памяти
	mpz_clear(num1);
	mpz_clear(num2);
	mpz_clear(result);

	const char* cstr = arr.c_str();

	return cstr;
}










//big_integer a = big_integer(string1);
	//big_integer b = big_integer(string2);

	//clock_t start = clock();
	//big_integer res = a * b;
	//clock_t end = clock();

	//double time = (end - start) / CLOCKS_PER_SEC;
	//cout << "Time = " << time << endl;

	//string result = res.operator std::string();

	////cout << result << endl;

	//const char* cstr = result.c_str();