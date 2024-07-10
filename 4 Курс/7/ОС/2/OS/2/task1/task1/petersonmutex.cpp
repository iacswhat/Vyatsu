#include "petersonmutex.h"
#include <atomic>


PetersonMutex::PetersonMutex()
{
    flag[0] = flag[1] = 0;
    turn = 0;
}

void PetersonMutex::lock(unsigned int thread_id)
{
    flag[thread_id] = true;
    turn = 1 - thread_id;
    while (flag[1 - thread_id] && turn == 1 - thread_id);
}

void PetersonMutex::unlock(unsigned int thread_id)
{
    flag[thread_id] = false;
}
