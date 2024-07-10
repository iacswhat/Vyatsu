program simps;

uses
  crt;

const
  resh = 0.2491420790940887;

var
  a: real = 1.4;
  a1: real;
  b: real = 2.1;
  e: real = 0.0001;
  s: real = 0;
  f: real;
  h: real = 0.0001;
  i: integer = 1;

function integral(x: real): real;
begin
  result := 1 / sqrt(3 * (x * x) - 1);
end;

procedure fsimps();
begin
  a1 := a + h;
  while a1 < b do
  begin
    if i mod 2 <> 0 then  
    begin
      s := s + 4 * integral(a1);
      writeln('  ', a1:1:4, '  |   ', integral(a1):1:4, '   |  ', 4, '  |  ', 4 * integral(a):1:4, ' |');
      //Writeln('------------------------------------------');
    end;
    if i mod 2 = 0 then 
    begin
      s := s + 2 * integral(a1);
      writeln('  ', a1:1:4, '  |   ', integral(a1):1:4, '   |  ', 2, '  |  ', 2 * integral(a):1:4, ' |'); 
      //Writeln('------------------------------------------');
    end;
    inc(i);
    a1 := a1 + h;
  end;
  s := s + integral(a) + integral(b);
  f := (h / 3) * s;
  //writeln(f);
end;

begin
  writeln('Формула Симпсона');
  Writeln('-----------------------------------');
  writeln('Опраделенный интеграл от функции: 1/sqrt(3*x^2-1)');
  writeln('Пределы интегрирования: [1,4;2,1]');  
  writeln('Шаг равен 0,00001');
  writeln('E = 0.0001');
  Writeln('-----------------------------------');
  
  writeln('    X     |    F(x)    |  k  |  k*F(x) |');
  Writeln('------------------------------------------');
  writeln('  ', a:1:4, '  |   ', integral(a):1:4, '   |  ', 1, '  |  ', integral(a):1:4, ' |');
  //Writeln('------------------------------------------');
  fsimps;
  writeln('  ', b:1:4, '  |   ', integral(b):1:4, '   |  ', 1, '  |  ', integral(b):1:4, ' |');
  Writeln('==========================================');
  writeln('Сумма всех k * F(x) = ', s:1:10);
  writeln('Интеграл численным методом равен: (', h, ' / ', 3, ') * ', s:1:4, ' = ', f:1:15);
  Writeln('Точное значение интеграла = ', resh:1:15);
  writeln('d = ', abs(resh - f):1:20);
  writeln('sig = ', abs(resh - f) / resh * 100:1:20, '%');
  readln();
end.
