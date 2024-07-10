#include "FuncLibHeader.h"


void multy(int (&mas)[10][10], int nnum)
{
	for (int i = 0; i < number; i++)
	{
		for (int j = 0; j < number; j++)
		{
			mas[i][j] *= nnum;
		}
	}
}


void divide(int (&mas)[10][10], int nnum)
{
	for (int i = 0; i < number; i++)
	{
		for (int j = 0; j < number; j++)
		{
			mas[i][j] /= nnum;
		}
	}
}
