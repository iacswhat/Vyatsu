#ifndef ParserH
#define ParserH

#include <SysUtils.hpp>
#include <Stlport/sstream>
#include <Stlport/string>
#include <Stlport/map>
#include <Stlport/list>
#include <Stlport/cmath>
#include <Stlport/algorithm>
#include <Stlport/vector>

using namespace std;

// анализатор арифметических выражений методом рекурсивного спуска
class Parser
{
public:
	// в выражении может встретится:
	enum token_value
        {
                NAME, NUMBER, END, FUNC,
                PLUS = '+', MINUS = '-', MUL = '*', DIV = '/', POW = '^',
                PRINT = ';', ASSIGN = '=', LP = '(', RP = ')'
        };
        
	Parser();
        ~Parser();

        // задать выражение для разбора
        void SetExpression(const string& expr);

        // вычислить значение выражения, задав переменным значения из indep_var_vals
        double Parse(const map<string, double>& indep_var_vals);
        void CheckSyntax();
private:
	istringstream *expression;
        token_value cur_tok;
        double number_value;
        string string_value;
        string indep_var_name;
        string function;
        map<string, double> var_table;
        list<string> func_list;

        double expr(bool get);
        double term(bool get);
        double prim(bool get);
        double superterm(bool get);
        double call_func(const string& name, double arg);
        token_value get_token();
};

#endif
