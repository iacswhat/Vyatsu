program lagrang;

uses
  crt;

const
  N = 5;

var
  xs: array[0..n] of real = (0.05, 0.10, 0.17, 0.25, 0.30, 0.36);
  ys: array[0..n] of real = (0.050042, 0.100335, 0.171657, 0.255342, 0.309336, 0.376403);
  tab: array[0..n, 0..n] of real;
  d, yd: array[0..n] of real;
  x: real = 0.263; 
  p: real = 1;
  l: real;
  s: real = 0;
  i, j: byte;
  e := 0.000001;

begin
  writeln('Интерполяция Лагрнажа');
  writeln('------------------------');
  writeln('Исходные данные:');
  for i := 0 to n do writeln('x = ', xs[i], '; y = ', ys[i]);
  writeln();
  writeln('Точность = ', e:1:6);
  writeln('------------------------');
  writeln('Таблица вычислений:');
  for i := 0 to n do 
  begin
    for j := 0 to n do 
    begin
      if i = j then tab[i, j] := x - xs[j] else tab[i, j] := xs[i] - xs[j]; 
    end;
  end;
  for i := 0 to n do p := p * tab[i, i];
  for i := 0 to n do
  begin
    for j := 0 to n - 1 do 
    begin
      if j = 0 then d[i] := tab[i, j] * tab[i, j + 1] else d[i] := d[i] * tab[i, j + 1];
    end;
  end;
  for i := 0 to n do 
  begin
    yd[i] := ys[i] / d[i];
    s := s + yd[i];
  end;
  writeln();
  for i := 0 to n do 
  begin
    for j := 0 to n do 
    begin
      if tab[i,j] < 0 then
      write('|',tab[i, j]:1:6)
      else
        write('| ',tab[i, j]:1:6);
    end;
    if d[i] < 0 then 
    write('|',(d[i] * 1000000):1:6, ' * 10^6')
    else
      write('| ',(d[i] * 1000000):1:6, ' * 10^6');
    if yd[i] < 0 then 
    write('|',(yd[i] / 1000000):1:6, ' * 10^-6')
    else
      write('| ',(yd[i] / 1000000):1:6, ' * 10^-6');  
    writeln();
    writeln('-----------------------------------------------------------------------------------------------');
  end;
  writeln('-----------------------------------------------------------------------------------------------');
  writeln('Сумма Yi/Di = ', (s / 1000000):1:6, ' * 10^-6'); 
  writeln('Произведение членов главное диагонали = ', (p * 1000000):1:6, ' * 10^6'); 
  writeln('------------------------'); 
  l := p * s;
  writeln('x = ', x, '; y = ', l:1:6); 
  readln();
end.