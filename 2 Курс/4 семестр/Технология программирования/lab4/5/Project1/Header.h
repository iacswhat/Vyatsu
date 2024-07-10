#pragma once

#include <Windows.h>
#include <string>
#include <algorithm>
#include <iostream>
#include <wchar.h>
#include <stdio.h>


using namespace std;

#pragma comment(linker,"\"/manifestdependency:type='win32' \
name='Microsoft.Windows.Common-Controls' version='6.0.0.0' \
processorArchitecture='*' publicKeyToken='6595b64144ccf1df' language='*'\"")

#define OnButtonChoooseClick           1
#define OnButtonClearClick             2
#define OnButtonBackClick              3
#define OnButtonMultiplyClick          4
#define OnButtonDivideClick            5
#define OnButtonOKClick                6



const int N = 5;





//Main
HWND Static;
HWND ButtonChoose;
HWND ButtonClear;
HWND hEdit[10*10];
HWND hEditSC;
HWND EditRes[10*10];
HWND EditNum;
HWND ButtonOK;
HWND StaticEr;

//Child
HWND Static1;
HWND Static2;
HWND ButtonBack;
HWND ButtonDivide;
HWND ButtonMultiply;

int a[10][10];
int scal = 0;

int number = 10;
int past = 0;

int f = 0;

bool ff = true;






void Clear(HWND edit) 
{
	SetWindowText(edit, L"");
}


void MainWndAddWidjets(HWND hWnd)
{
	Static = CreateWindow(L"static", L"Enter initial data:", WS_VISIBLE | WS_CHILD | ES_CENTER,
		5, 5, 490, 20, hWnd, NULL, NULL, NULL);

	ButtonChoose = CreateWindow(L"button", L"Choose an action", WS_CHILD | WS_VISIBLE,
		175, 550, 150, 30, hWnd, (HMENU)OnButtonChoooseClick, NULL, NULL);

	ButtonClear = CreateWindow(L"button", L"Clear", WS_CHILD | WS_VISIBLE,
		175, 600, 150, 30, hWnd, (HMENU)OnButtonClearClick, NULL, NULL);

	

	hEditSC = CreateWindow(L"edit", NULL, WS_VISIBLE | WS_CHILD | WS_BORDER,
		200, 400, 40, 20, hWnd, NULL, NULL, NULL);

	

	EditNum = CreateWindow(L"edit", NULL, WS_VISIBLE | WS_CHILD | WS_BORDER | ES_NUMBER,
		200, 500, 40, 20, hWnd, NULL, NULL, NULL);

	ButtonOK = CreateWindow(L"button", L"OK", WS_CHILD | WS_VISIBLE,
		260, 500, 75, 30, hWnd, (HMENU)OnButtonOKClick, NULL, NULL);

	StaticEr = CreateWindow(L"static", NULL, WS_VISIBLE | WS_CHILD | ES_CENTER,
		200, 450, 490, 20, hWnd, NULL, NULL, NULL);


	int k = 0;
	for (int i = 0; i < 10; i++)
	{
		for (int j = 0; j < 10; j++)
		{
			hEdit[k] = CreateWindow(L"edit", NULL, WS_VISIBLE | WS_CHILD | WS_BORDER,
				i * 80 + 40, j * 30 + 50, 50, 20, hWnd, NULL, NULL, NULL);
			k++;
		}
	}

	k = 0;
	for (int i = 0; i < 10; i++)
	{
		for (int j = 0; j < 10; j++)
		{
			EditRes[k] = CreateWindow(L"edit", NULL, WS_VISIBLE | WS_CHILD | WS_BORDER | ES_READONLY,
				i * 100 + 900, j * 30 + 50, 90, 20, hWnd, NULL, NULL, NULL);
			k++;
		}
	}
}


void ChildWndAddWidjets(HWND hWnd)
{
	Static1 = CreateWindow(L"static", L"Choose an action:", WS_VISIBLE | WS_CHILD | ES_CENTER,
		5, 5, 240, 20, hWnd, NULL, NULL, NULL);

	ButtonBack = CreateWindow(L"button", L"Back", WS_CHILD | WS_VISIBLE,
		75, 170, 100, 30, hWnd, (HMENU)OnButtonBackClick, NULL, NULL);

	ButtonDivide = CreateWindow(L"button", L"Divide", WS_CHILD | WS_VISIBLE,
		75, 80, 100, 30, hWnd, (HMENU)OnButtonDivideClick, NULL, NULL);

	ButtonMultiply = CreateWindow(L"button", L"Multiply", WS_CHILD | WS_VISIBLE,
		75, 40, 100, 30, hWnd, (HMENU)OnButtonMultiplyClick, NULL, NULL);

	Static2 = CreateWindow(L"static", L"", WS_VISIBLE | WS_CHILD | ES_CENTER,
		5, 120, 240, 20, hWnd, NULL, NULL, NULL);
}


void function(int (&mas)[10][10], int nnum, int (&flag))
{
	if ((nnum == 0) && (flag == 2))
	{	
		flag = 0;
		exit;
	};

	for (int i = 0; i < number; i++)
	{
		for (int j = 0; j < number; j++)
		{
			if (flag == 1)
			{
				mas[i][j] *= nnum;
			}
			if (flag == 2)
			{
				mas[i][j] /= nnum;
			}
		}
	}
}




