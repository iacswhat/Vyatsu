#pragma hdrstop

#include "Parser.h"

#pragma package(smart_init)


Parser::Parser()
{
	cur_tok = PRINT;

        var_table["pi"] = M_PI;
        var_table["e"] = M_E;

        func_list.push_back("sin");
	func_list.push_back("cos");
	func_list.push_back("tg");
	func_list.push_back("ctg");
	func_list.push_back("arcsin");
	func_list.push_back("arccos");
	func_list.push_back("arctg");
	func_list.push_back("arcctg");
	func_list.push_back("ln");
	func_list.push_back("lg");
	func_list.push_back("sh");
	func_list.push_back("ch");
	func_list.push_back("th");
	func_list.push_back("cth");
	func_list.push_back("abs");
}

Parser::~Parser()
{
}

void Parser::SetExpression(const string& expr)
{
	function = expr;
}

/*void Parser::SetIndepVarName(const string& name)
{
	var_table[name] = 0.0;
        indep_var_name = name;
} */

double Parser::Parse(const map<string, double>& indep_var_vals)
{
	for (map<string, double>::const_iterator i = indep_var_vals.begin();
        	i != indep_var_vals.end(); ++i)
        {
		var_table[i->first] = i->second;
        }

        expression = new istringstream(function);

	get_token();
        double result = expr(false);

        delete expression;

        return result;
}

double Parser::expr(bool get)
{
	double left = term(get);

	for (;;)
	{
		switch (cur_tok)
		{
		case PLUS:
			left += term(true);
			break;
		case MINUS:
			left -= term(true);
			break;
		default:
			return left;
		}
	}
}

double Parser::term(bool get)
{
	double left = superterm(get);

	for (;;)
	{
		switch (cur_tok)
		{
		case MUL:
			left *= superterm(true);
			break;
		case DIV:
			if (double d = superterm(true))
			{
				left /= d;
				break;
			}

			throw Exception("Попытка деления на нуль.");
		default:
			return left;
		}
	}
}

double Parser::superterm(bool get)
{
	double left = prim(get);

	for (;;)
	{
		switch (cur_tok)
		{
		case POW:
		{
			double p = pow(left, prim(true));

			if (!errno)
			{
				left = p;
				break;
			}

			throw Exception("Переполнение разрядной сетки.");
		}
		default:
			return left;
		}
	}
}

double Parser::prim(bool get)
{
	if (get)
		get_token();

	switch (cur_tok)
	{
	case NUMBER:
	{
		double v = number_value;

		get_token();

		return v;
	}
	case NAME:
	{
		double& v = var_table[string_value];

		if (get_token() == ASSIGN)
			v = expr(true);

		return v;
	}
	case FUNC:
	{
		string func = string_value;

		if (get_token() == LP)
		{
			double v = expr(true);
			
			if (cur_tok == RP)
			{
				get_token();
				return call_func(func, v);
			}

			throw Exception("Ожидалась \')\'.");
		}

		throw Exception("Ожидалась \'(\'.");
	}
	case MINUS:
        {
        	char ch;
                unsigned pos = expression->tellg();

                for (unsigned i = pos; i < function.length(); ++i)
                {
                	ch = function[i];

                	if (!isalnum(ch) && ch != '.')
                        	break;
                }

		return (ch != '^') ? -prim(true) : -expr(true);
        }
	case LP:
	{
		double e = expr(true);

		if (cur_tok != RP)
			throw Exception("Ожидалась \')\'.");

		get_token();

		return e;
	}
	default:
		throw Exception("Primary expression expected.");
	}
}

double Parser::call_func(const string& name, double arg)
{
	if (name == "sin")
		return sin(arg);
	else if (name == "cos")
		return cos(arg);
	else if (name == "tg")
		return tan(arg);
	else if (name == "ctg")
		return 1.0 / tan(arg);
	else if (name == "arcsin")
		return asin(arg);
	else if (name == "arccos")
		return acos(arg);
	else if (name == "arctg")
		return atan(arg);
	else if (name == "arcctg")
		return M_PI / 2.0 - atan(arg);
	else if (name == "ln")
		return log(arg);
	else if (name == "lg")
		return log10(arg);
	else if (name == "sh")
		return sinh(arg);
	else if (name == "ch")
		return cosh(arg);
	else if (name == "th")
		return tanh(arg);
	else if (name == "cth")
		return 1.0 / tanh(arg);
	else if (name == "abs")
		return fabs(arg);
	else
		throw Exception("Неизвестная функция: " +
                	AnsiString(name.c_str()));
}

Parser::token_value Parser::get_token()
{
	char ch;

	do
	{
		if (!expression->get(ch))
			return cur_tok = END;
	}
	while (ch != '\n' && isspace(ch));

	switch (ch)
	{
	case ';': case '\n':
		return cur_tok = PRINT;
	case 0:
		return cur_tok = END;
	case '0': case '1': case '2': case '3': case '4':
	case '5': case '6': case '7': case '8': case '9':
	case '.':
		expression->putback(ch);
		*expression >> number_value;
		return cur_tok = NUMBER;
	case '*': case '+': case '-': case '/':
	case '^': case '=': case '(': case ')':
		return cur_tok = token_value(ch);
	default:
		if (isalpha(ch))
		{
			string_value = ch;

			while (expression->get(ch) && isalnum(ch))
				string_value.push_back(ch);

			expression->putback(ch);

			return cur_tok = find(func_list.begin(),
                        	func_list.end(), string_value) !=
                                	func_list.end() ? FUNC : NAME;
		}

                cur_tok = PRINT;
		throw Exception("Неправильная лексема: " + AnsiString(ch));
	}
}

void Parser::CheckSyntax()
{
	
}
