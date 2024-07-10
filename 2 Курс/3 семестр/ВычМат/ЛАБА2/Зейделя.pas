﻿Program Zeidel;

const
  eps = 0.0001;

type
  mas = array [1..4] of real;
  matr = array [1..4, 1..4] of real;



var
  x1, x0: mas;
  m: matr;
  i, j, k: integer;
  p, q: real;
  o: real;
  smax, smax1: real;
   s: mas;


procedure norm;
var
  i, j: integer;
  
 
begin
  
  m[1,1]:=0.17; m[1,2]:=0.27; m[1,3]:=-0.13; m[1,4]:=-0.11;
  m[2,1]:=0.13; m[2,2]:=-0.12; m[2,3]:=0.09; m[2,4]:=-0.06;
  m[3,1]:=0.11; m[3,2]:=0.05; m[3,3]:=-0.02; m[3,4]:=0.12;
  m[4,1]:=0.13; m[4,2]:=0.18; m[4,3]:=0.24; m[4,4]:=0.43;
  
  writeln('Проверка 1 нормы');
  for i := 1 to 4 do 
  begin
    for j := 1 to 4 do
    begin
      s[i] := s[i] + abs(m[i, j]); 
    end;
    writeln(' ',s[i]);
  end;
  
  smax := max(s[1], s[2], s[3], s[4]);
  if smax < 1 then 
  begin
    writeln('1 норма = ', smax);
    writeln('Условие сходимости: ||a||1 < 1');
    exit
  end;
  
  
  writeln('Проверка 2 нормы');
  for j := 1 to 4 do 
  begin
    for i := 1 to 4 do
    begin
      s[i] := s[i] + abs(m[i, j]);    
    end;
  end;
  
  smax := max(s[1], s[2], s[3], s[4]);
  if smax < 1 then 
  begin
    writeln('2 норма = ', smax);
    writeln('Условие сходимости: ||a||2 < 1');
    exit
  end;
  
  
   writeln('Проверка 3 нормы');
  for j := 1 to 4 do 
  begin
    for i := 1 to 4 do
    begin
      smax := smax + abs(m[i, j] * m[i, j]);    
    end;
  end;
  smax1 := sqrt(smax);
  if smax1 < 1 then 
  begin
     writeln('3 норма = ', smax);
    writeln('Условие сходимости: ||a||3 < 1');
    exit
  end;
  
end;

begin
  for i := 1 to 4 do
    s[i] := 0;
  Writeln('МЕТОД ЗЕЙДЕЛЯ');
  
  writeln('Исходная система:');
  writeln('x1=0,17*x1+0,27*x2-0,13*x3-0,11*x4-1,42 ');
  writeln('x2=0,13*x1-0,12*x2+0,09*x3-0,06*x4+0,48 ');
  writeln('x3=0,11*x1+0,05*x2-0,02*x3+0,12*x4-2,34');
  writeln('x4=0,13*x1+0,18*x2+0,24*x3+0,43*x4+0,72');
  
  writeln('Eps = 0,0001');
  
  Writeln('-----------------'); 
  norm;
  Writeln('-----------------'); 
  
  writeln('    X1    |    X`1    |    X2    |    X`2    |    X3    |    X`3    |    X4    |    X`4    |    q ');
  repeat
    for i := 1 to 4 do
      x0[i] := x1[i];
    
    x1[1] := -1.42 - 0.17 * x0[1] + 0.27 * x0[2] - 0.13 * x0[3] - 0.11 * x0[4];
    x1[2] := 0.48 + 0.13 * x1[1] - 0.12 * x0[2] + 0.09 * x0[3] - 0.06 * x0[4];
    x1[3] := -2.34 - 0.11 * x1[1] + 0.05 * x1[2] - 0.02 * x0[3] + 0.12 * x0[4];
    x1[4] := 0.72 + 0.13 * x1[1] + 0.18 * x1[2] - 0.24 * x1[3] + 0.43 * x0[4]; 
    
    q := Max(abs(x1[1] - x0[1]), abs(x1[2] - x0[2]), abs(x1[3] - x0[3]), abs(x1[4] - x0[4]));
    
    writeln('  ',x0[1]:0:4,'  |  ',x1[1]:0:4,'  |  ',x0[2]:0:4,'  |  ',x1[2]:0:4,'  |  ',x0[3]:0:4,'  |  ',x1[3]:0:4,'  |  ',x0[4]:0:4,'  |  ',x1[4]:0:4,'  |  ',q:0:5);
    
    inc(k)
  until(q < eps);
  
  Writeln('-----------------');
  for i := 1 to 4 do
    writeln('x[', i, ']= ', x1[i]:0:4);
  //writeln('Погрешность = ', q:0:4);
  //writeln('Кол-во итераций = ', k);
  readln;
end.