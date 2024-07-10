Program MNK;

uses
  crt;
  
function metod(xm:real): real;
begin
  result:= 0.071429 * xm * xm - 0.084286 * xm + 0.424286; 
end;

var
  x: array[1..6] of real = (4, 4.1, 4.2, 4.3 , 4.4, 4.5); 
  y: array[1..6] of real = (1.23, 1.28, 1.33, 1.38, 1.44, 1.49);
  ym: array[1..6] of real;
  y1,y2: real;
  i:integer = 1;
  xx: real = 0;
  x2: real = 0;
  xy: real = 0;
  yy: real = 0;
  yym: real = 0;
  dd: real = 0;
  r, rr:real;
  
begin
  writeln('МЕТОД НАИМЕНЬШИХ КВАДРАТОВ');
  writeln('--------------------------');
  writeln('Исходные данные:');
  for i:=1 to 6 do writeln('X = ', x[i]:1:2,'; Y = ', y[i]:1:2); 
  writeln('--------------------------');
  Writeln('Вид эмперической зависимости: квадратичная - Ax^2 + Bx + C;');
  writeln();
  writeln('Коэффициенты:');
  writeln('A = 0.071429;');
  writeln('B = 0.084286;');
  writeln('C = 0.424286;');
  writeln();
  writeln('Уравнение зависимости y = 0.071429x^2 - 0.084286x + 0.424286;');
  writeln('----------------------------');
  writeln();
  writeln('Таблица:');
  writeln();
  writeln('   Xi   |   Xi^2  |   Yi   |   Xi*Yi  |     Y^T    |   di^2 * 10^4  ');
  for i:= 1 to 6 do
  begin
    writeln('------------------------------------------------------------------');
    writeln('  ',x[i]:1:2,'  |  ',x[i] * x[i]:2:2,'  |  ',y[i]:1:2,'  |   ',x[i] * y[i]:2:2,'   |  ', metod(x[i]):1:6,'  |  ', ((y[i] - metod(x[i])) * (y[i] - metod(x[i])))*10000:1:10);
    xx:= xx + x[i];
    x2:=x2 + x[i] * x[i];
    yy:= yy + y[i];
    xy:= xy + x[i] * y[i];
    yym:= yym + metod(x[i]);
    ym[i]:= metod(x[i]);
    dd:= dd + ((y[i] - metod(x[i])) * (y[i] - metod(x[i])));
  end;
  writeln('==================================================================');
  writeln('  ',xx:1:1,'  |  ',x2:3:2,' |  ',yy:1:2,'  |   ',xy:2:2,'  |  ', yym:1:6,'  |  ', dd * 10000:1:10);
  y1:= (1 / 6) * yy;
  for i:= 1 to 6 do y2:= y2 + ((y[i] - y1) * (y[i] - y1));
  r:= sqrt(1 - (dd / y2));
  rr:= sqrt(dd)/6;
  writeln();
  writeln('Коэффициент корреляции: ', r:1:6);
  writeln('Среднее квадратичное отклонение: ', rr:1:6);
  readln();
end.