program newton;

uses
  crt;

const
  N = 11;

var
  xs: array[0..n] of real = (1.340, 1.345, 1.350, 1.355, 1.360, 1.365, 1.370, 1.375, 1.380, 1.385, 1.390, 1.395);
  ys: array[0..n] of real = (4.25562, 4.35325, 4.45522, 4.56184, 4.67344, 4.79038, 
                             4.91306, 5.04192, 5.17744, 5.32016, 5.47069, 5.62968);
  x: array[0..3] of real = (1.3617, 1.3921, 1.3359, 1.400);
  dy1, dy2: array[0..n - 1] of real;
  k: byte = 12;
  q: array[0..3] of real;
  h: real = 0.005;
  P: real;
  e := 0.000001;
  tab: array[0..n, 0..n + 1] of real;
  i, j: byte;

function fac(a: byte): integer;
var
  k, f: integer;

begin
  f := 1;
  k := 0;
  while k <> a do
  begin
    inc(k);
    f := f * k;
  end;
  result := f;
end;
  

begin
  
  writeln('Интерполяция Ньютона');
  writeln('----------------------------------------------------');
  writeln('Исходные данные:');
  for i := 0 to n do writeln('x = ', xs[i]:1:3, '; y = ', ys[i]:1:5);
  writeln();
  writeln('Точность = ', e:1:6);
  writeln('----------------------------------------------------');
  writeln('Таблица вычислений:');
  writeln();
  
  for i := 0 to n do 
    for j := 0 to 1 do 
      if j = 0 then tab[i, j] := xs[i] else if j = 1 then tab[i, j] := ys[i]; 
  
  for j := 2 to n + 1 do
  begin
    k := k - 1;
    for i := 0 to k - 1 do 
    begin
      tab[i, j] := tab[i + 1, j - 1] - tab[i, j - 1];
      if i = 0 then dy1[j - 2] := tab[i, j];
      if i = k - 1 then dy2[j - 2] := tab[i, j];
    end;
  end;
  
  q[0] := (x[0] - xs[0]) / h;
  q[1] := (x[1] - xs[n]) / h;
  q[2] := (x[2] - xs[0]) / h;
  q[3] := (x[3] - xs[n]) / h;
  
  for i := 0 to n do 
  begin
    for j := 0 to n + 1 do 
    begin
      if tab[i,j] <> 0 then 
        begin
          if tab[i,j] < 0 then 
          write('|',tab[i, j]:1:6)
          else
            write('| ',tab[i, j]:1:6);  
        end
      else
        write(' |        ')  
    end;
    writeln;
    writeln('------------------------------------------------------------------------------------------------------------------------------------');
  end;
  writeln('------------------------------------------------------------------------------------------------------------------------------------');
  writeln('Результаты:');
  
  p := ys[0] + q[0] * dy1[0] + ((q[0] * (q[0] - 1)) / fac(2)) * dy1[1] + ((q[0] * (q[0] - 1) * (q[0] - 2)) / fac(3)) * dy1[2] + ((q[0] * (q[0] - 1) * (q[0] - 2) * (q[0] - 3)) / fac(4)) * dy1[3] + ((q[0] * (q[0] - 1) * (q[0] - 2) * (q[0] - 3) * (q[0] - 4)) / fac(5)) * dy1[4];
  writeln('x = ', x[0]:1:4, '; y = ', p:2:6);
  
  p := ys[n] + q[1] * dy2[0] + ((q[1] * (q[1] - 1)) / fac(2)) * dy2[1] + ((q[1] * (q[1] - 1) * (q[1] - 2)) / fac(3)) * dy2[2] + ((q[1] * (q[1] - 1) * (q[1] - 2) * (q[1] - 3)) / fac(4)) * dy2[3] + ((q[1] * (q[1] - 1) * (q[1] - 2) * (q[1] - 3) * (q[1] - 4)) / fac(5)) * dy2[4];
  writeln('x = ', x[1]:1:4, '; y = ', p:2:6);
  
  p := ys[0] + q[2] * dy1[0] + ((q[2] * (q[2] - 1)) / fac(2)) * dy1[1] + ((q[2] * (q[2] - 1) * (q[2] - 2)) / fac(3)) * dy1[2] + ((q[2] * (q[2] - 1) * (q[2] - 2) * (q[2] - 3)) / fac(4)) * dy1[3] + ((q[2] * (q[2] - 1) * (q[2] - 2) * (q[2] - 3) * (q[2] - 4)) / fac(5)) * dy1[4];
  writeln('x = ', x[2]:1:4, '; y = ', p:2:6);
  
  p := ys[n] + q[3] * dy2[0] + ((q[3] * (q[3] - 1)) / fac(2)) * dy2[1] + ((q[3] * (q[3] - 1) * (q[3] - 2)) / fac(3)) * dy2[2] + ((q[3] * (q[3] - 1) * (q[3] - 2) * (q[3] - 3)) / fac(4)) * dy2[3] + ((q[3] * (q[3] - 1) * (q[3] - 2) * (q[3] - 3) * (q[3] - 4)) / fac(5)) * dy2[4];
  writeln('x = ', x[3]:1:4, '; y = ', p:2:6);
  readln();
end.