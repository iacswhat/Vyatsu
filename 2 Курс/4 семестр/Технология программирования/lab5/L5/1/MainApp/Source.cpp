#include <Windows.h>

#include"D:\ЛЕКЦИИ\LP\2 Курс\4 семестр\Технология программирования\lab5\L5\1\WinLib\WinLibHeader.h"


extern "C" __declspec(dllimport) int Win(HINSTANCE hInstance, HINSTANCE hPrevInst, PWSTR szCmdLine, int nCmdShow);

int CALLBACK wWinMain(HINSTANCE hInstance, HINSTANCE hPrevInst, PWSTR szCmdLine, int nCmdShow)
{
	return Win(hInstance,hPrevInst, szCmdLine, nCmdShow);
}	