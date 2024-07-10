#ifndef PETERSONMUTEX_H
#define PETERSONMUTEX_H


#include <atomic>

const int N = 2;

class PetersonMutex
{
private:
    std::atomic_int turn;
    std::atomic_bool flag[N];

public:
    PetersonMutex();

    void lock(unsigned int thread_id);

    void unlock(unsigned int thread_id);

};

#endif // PETERSONMUTEX_H
