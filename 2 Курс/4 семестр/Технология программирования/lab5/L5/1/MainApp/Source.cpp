#include <Windows.h>

#include"D:\������\LP\2 ����\4 �������\���������� ����������������\lab5\L5\1\WinLib\WinLibHeader.h"


extern "C" __declspec(dllimport) int Win(HINSTANCE hInstance, HINSTANCE hPrevInst, PWSTR szCmdLine, int nCmdShow);

int CALLBACK wWinMain(HINSTANCE hInstance, HINSTANCE hPrevInst, PWSTR szCmdLine, int nCmdShow)
{
	return Win(hInstance,hPrevInst, szCmdLine, nCmdShow);
}	