#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <windows.h>
#include <ctime>
#include <iostream>

using namespace std;

const int n = 5, // длина буфера

m = 2, // количество читателей

k = 5; // количество писателей

int buf[n], front = 0, rear = 0;

HANDLE hSemFull, hSemEmpty, // семафоры дл€ условной синхронизации

hMutexD, hMutexF; // мьютексы дл€ исключительного доступа


HANDLE hWrite, hRead, c1, c2;

int Full = 0, Empty = 5;


//процесс, пополн€ющий буфер

DWORD WINAPI Producer(PVOID pvParam)

{
	//srand(time(NULL));
	int num; long prev;
	num = *((int*)pvParam);
	//printf("thread %d (producer): start!\n", num);
	
	while (true)
	{

		//if (Empty != 0)
		//{
			//WaitForSingleObject(hSemEmpty, INFINITE);
			//WaitForSingleObject(hMutexD, INFINITE);
			WaitForSingleObject(hWrite, INFINITE);

			if (Empty > 0)
			{
				buf[rear] = rand() % n;

				
				//printf("\nWriter %d: data = %d to %d", num, buf[rear], rear);

				//WaitForSingleObject(c1, INFINITE);
				Full++;
				Empty--;
				//SetEvent(c1);
				
				cout << "\nWriter " << num << ": data = " << buf[rear] << " to " << rear << "\nEmpty: " << Empty << " Full: " << Full << "\n----------------------------";

				rear = (rear + 1) % n;
				
				
				//cout << "\nEmpty: " << Empty << "  Full: " << Full;
				//cout << "\n----------------------------";
				Sleep(5000);
				

				SetEvent(hRead);
				SetEvent(hWrite);
				
				//ReleaseMutex(hMutexD);
				//ReleaseSemaphore(hSemFull, 1, &prev);
			}
			else
			{
				WaitForSingleObject(hWrite, INFINITE);
				buf[rear] = rand() % n;
				//printf("\nWriter %d: data = %d to %d", num, buf[rear], rear);
				//cout << "\nEmpty: " << Empty << "  Full: " << Full;
				//cout << "\n----------------------------";
				
				//WaitForSingleObject(c1, INFINITE);
				Full++;
				Empty--;
				//SetEvent(c1);

				cout << "\nWriter " << num << ": data = " << buf[rear] << " to " << rear << "\nEmpty: " << Empty << "  Full: " << Full << "\n----------------------------";
				rear = (rear + 1) % n;
				//ReleaseMutex(hMutexD);
				//ReleaseSemaphore(hSemFull, 1, &prev);
				
				Sleep(5000);
				//SetEvent(hWrite);
				SetEvent(hRead);
			}
			

		
	}
	return 0;
}

//процесс, берущий данные из буфера
DWORD WINAPI Consumer(PVOID pvParam)

{
	int num, data; long prev;
	num = *((int*)pvParam);
	//printf("thread %d (consumer): start!\n", num);
	while (true)
	{
		//if (Full != 0)
		//{
			//WaitForSingleObject(hSemFull, INFINITE);
			//WaitForSingleObject(hMutexF, INFINITE);
			
			WaitForSingleObject(hRead, INFINITE);
			if (Full > 0)
			{
				data = buf[front];
				//printf("\nReader %d: data = %d from %d", num, data, front);

				//WaitForSingleObject(c2, INFINITE);
				Full--;
				Empty++;
				//SetEvent(c2);

				cout << "\nReader " << num << ": data = " << buf[front] << " from " << front << "\nEmpty: " << Empty << "  Full: " << Full << "\n----------------------------";

				front = (front + 1) % n;
				
				//cout << "\nEmpty: " << Empty << "  Full: " << Full;
				//cout << "\n----------------------------";
				
				Sleep(5000);
				
				SetEvent(hWrite);
				SetEvent(hRead);
				
				//ReleaseMutex(hMutexF);
				//ReleaseSemaphore(hSemEmpty, 1, &prev);
			}
			else
			{
				WaitForSingleObject(hRead, INFINITE);
				data = buf[front];
				//printf("\nReader %d: data = %d from %d", num, data, front);
				
				//WaitForSingleObject(c2, INFINITE);
				Full--;
				Empty++;
				//SetEvent(c2);

				cout << "\nReader " << num << ": data = " << buf[front] << " from " << front << "\nEmpty: " << Empty << "  Full: " << Full << "\n----------------------------";
				front = (front + 1) % n;
				
				//cout << "\nEmpty: " << Empty << "  Full: " << Full;
				//cout << "\n----------------------------";
				//ReleaseMutex(hMutexF);
				//ReleaseSemaphore(hSemEmpty, 1, &prev);
				//Sleep(5000);
				SetEvent(hWrite);
				//SetEvent(hRead);

			}
			
		
	}
	return 0;
}

int main(int argc, char* argv)
{
	

	int i, xWR[k], xRE[m];
	DWORD dwThreadId[k + m];
	HANDLE hThreadWR[k], hThreadRE[m];

	hSemEmpty = CreateSemaphore(NULL, n, n, L"Empty");
	hSemFull = CreateSemaphore(NULL, 0, n, L"Full");
	hMutexD = CreateMutex(NULL, FALSE, L"MutexD");
	hMutexF = CreateMutex(NULL, FALSE, L"MutexF");

	hWrite = CreateEvent(NULL, FALSE, TRUE, NULL);
	hRead = CreateEvent(NULL, FALSE, FALSE, NULL);
	
	
	
	c1 = CreateEvent(NULL, FALSE, TRUE, NULL);
	c2 = CreateEvent(NULL, FALSE, TRUE, NULL);



	for (i = 0; i < k; i++)
	{
		xWR[i] = i;
		hThreadWR[i] = CreateThread(NULL, 0, Producer, (PVOID)&xWR[i], 0, &dwThreadId[i]);
	}

	for (i = 0; i < m; i++)
	{
		xRE[i] = i;
		hThreadRE[i] = CreateThread(NULL, 0, Consumer, (PVOID)&xRE[i], 0, &dwThreadId[i]);
	}

	WaitForMultipleObjects(k, hThreadWR, TRUE, INFINITE);
	WaitForMultipleObjects(m, hThreadRE, TRUE, INFINITE);

	// закрытие описателей событий
	CloseHandle(hSemFull);
	CloseHandle(hSemEmpty);
	CloseHandle(hMutexF);
	CloseHandle(hMutexD);

	CloseHandle(hWrite);
	CloseHandle(hRead);
	CloseHandle(c1);
	CloseHandle(c2);

	return 0;

}

