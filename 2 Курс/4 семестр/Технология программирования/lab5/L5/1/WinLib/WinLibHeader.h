#pragma once
#include <Windows.h>
#include <string>
#include <algorithm>
#include <iostream>
#include <wchar.h>


extern "C" __declspec(dllexport) int Win(HINSTANCE hInstance, HINSTANCE hPrevInst, PWSTR szCmdLine, int nCmdShow);