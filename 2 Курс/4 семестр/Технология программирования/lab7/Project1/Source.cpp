#include<iostream>



namespace Jack
{
	int pal;
}

namespace Jill
{
	int pal;
}


using namespace Jack;

int main()
{
	Jack::pal = 4;
	Jill::pal = 5;
	std::cout << pal << "\n";
	std::cout << Jill::pal << "\n";

	


	return 0;
}