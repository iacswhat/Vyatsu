﻿program MetodGaussa;

Uses Crt;

const
  n = 4;

var
  a, a1: array[1..10, 1..10] of real;
  aa, bb: array[1..10] of real;
  b, b1: array[1..10] of real;
  x: array[1..10] of real;
  i, j, k: integer;
  r, g: real;


function ShowMatrix(n: Integer): real;
var
  i, j: integer;
begin
  writeln('Исходная система:');
  writeln('2,00*x1-1,00*x2+1,00*x3-1,00*x4=1,00');
  writeln('2,00*x1-1,00*x2-3,00*x4=2,00');
  writeln('3,00*x1-1,00*x3+1,00*x4=-3,00');
  writeln('2,00*x1+2,00*x2-2,00*x3+5,00*x4=-6,00');
  writeln('Eps = 0.001'); 
  writeln('------------------');
  WriteLn('Матрица A:');
  for i := 1 to n do
  begin
    for j := 1 to n do
    begin
      write('  ', a1[i, j]);
      if j = n then
        writeln
    end;
  end;
  WriteLn('Матрица B:');
  for i := 1 to n do
    writeln('  ', b[i]);
  writeln('------------------');
end;

procedure switch(aaa, bbb: integer);
var
  i, j: byte;
begin
  i := aaa;
  for j := 1 to n do 
  begin
    aa[j] := a[i, j];
    a[i, j] := a[bbb, j];
    a[bbb, j] := aa[j];
  end;
  bb[bbb] := b[i];
  b[i] := b[bbb];
  b[bbb] := bb[bbb];
end;

function Metod: real;
var
  k, j, i, z, val: integer;
begin
  writeln('Прямой ход');
  
  for k := 1 to n do { прямой ход Гаусса }
  begin
    z := k;
    while (z < n) and (a[z, k] = 0) do inc(z);
    switch(k, z); 
    for j := k + 1 to n do
    begin
      // write(' ',a[j-1,k+1]);
      r := a[j, k] / a[k, k];
      for i := k to n do
      begin
        a[j, i] := a[j, i] - r * a[k, i];
        write(' ', a[j, i]);
      end;
      b[j] := b[j] - r * b[k];
      writeln('|', b[j]);
    end;
    if k < n then
      writeln('------------------');
  end;
  
  
  for k := n downto 1 do { обратный ход Гаусса }
  begin
    r := 0;
    for j := k + 1 to n do
    begin
      g := a[k, j] * x[j];
      r := r + g;
    end;
    x[k] := (b[k] - r) / a[k, k];
  end;
  writeln('Корни:');
  for i := 1 to n do
    writeln('x[', i, ']=', x[i]:0:4, '   ');
end;

function Check: real;
var
  i, j: integer;
begin
  clrscr;
  writeln('Проверка в соответсвии с матрицой B: ');
  for i := 1 to n do
  begin
    for j := 1 to n do
      b1[i] := b1[i] + a1[i, j] * x[j];
    writeln(b1[i]:4:4, ' ');
  end;
  readln;
end;


begin
  WRITELN('МЕТОД ГАУССА');
  writeln('------------------');
  a1[1, 1] := 2; a1[1, 2] := -1; a1[1, 3] := 1; a1[1, 4] := -1; b[1] := 1; 
  a1[2, 1] := 2; a1[2, 2] := -1; a1[2, 3] := 0; a1[2, 4] := -3; b[2] := 2;
  a1[3, 1] := 3; a1[3, 2] := 0; a1[3, 3] := -1; a1[3, 4] := 1; b[3] := -3;
  a1[4, 1] := 2; a1[4, 2] := 2; a1[4, 3] := -2; a1[4, 4] := 5; b[4] := -6;
  for i := 1 to n do 
  begin
    for j := 1 to n do
    begin
      a[i, j] := a1[i, j];
    end;
  end;
  ShowMatrix(n);
  writeln;
  Metod;
  //Check;
  Readln;
end.