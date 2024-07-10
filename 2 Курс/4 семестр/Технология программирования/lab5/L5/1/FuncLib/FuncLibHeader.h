#pragma once

int number = 10;

extern "C" __declspec(dllexport) void multy(int (&mas)[10][10], int nnum);
extern "C" __declspec(dllexport) void divide(int (&mas)[10][10], int nnum);