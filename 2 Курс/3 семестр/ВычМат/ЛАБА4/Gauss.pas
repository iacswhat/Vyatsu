program Gauss;

uses 
  CRT;

const
  A: Real = 0.2;           {Нижний предел}
  B: Real = 2.4;           {Верхний предел}
  
  resh: real = 1.10891382735557;  {точное решение}
  
  {таблица для 5 узлов}
  tab1: array[1..5, 1..2] of real = (
                                (-0.90618,   0.23698), 
                                (-0.538469,  0.47863),
                                (0,         0.56889),
                                (0.538469,  0.23698),
                                (0.90618,   0.47863));
 
 {таблица для 8 узлов}
  tab2: array[1..8, 1..2] of real = (
                                (-0.96028986, 0.10122854), 
                                (-0.79666648, 0.22238103),
                                (-0.52553242, 0.31370664),
                                (-0.18343464, 0.36268378),
                                (0.18343464, 0.36268378),
                                (0.52553242, 0.31370664),
                                (0.79666648, 0.22238103),
                                (0.96028986, 0.10122854));


var
  i, j: integer;

function F(X: real): real;  {подинтегральная функция}
begin
  F := sqrt((x * x) + 1) / (x + 2);
end;

function arg(X: real): real; {аргументы}
begin
  arg := ((b - a) / 2) * x + (a + b) / 2;
end;


procedure node5(); {процедура для 5 узлов}
var
  s: real = 0;
  TabFor5: array[1..5, 1..5] of real;
  i, j: integer;
  integral: real;
  
begin
  for i := 1 to 5 do  {копирование точек в таблицу}
  begin
    for j := 1 to 2 do
    begin
      TabFor5[i, j] := tab1[i, j]; 
    end;
  end;
  
  for i := 1 to 5 do  {вычисление остальных столбцов и подсчет суммы элементов последнего}
  begin
    TabFor5[i, 3] := arg(tab1[i, 1]); 
    TabFor5[i, 4] := F(TabFor5[i, 3]);
    TabFor5[i, 5] := TabFor5[i, 4] * Tab1[i, 2];
    s:= s + TabFor5[i, 5];
  end;
  
  
  writeln(' Для 5 узлов:');
  writeln(' i |     xi     |     Ai     |     Argi   |   F(Argi)  | Ai*F(Argi) |');
  writeln(' ---------------------------------------------------------------------');
  for i:=1 to 5 do
  begin
    write(' ', i, ' | ');
    for j:= 1 to 5 do
    begin
      if tabfor5[i, j] < 0 then
      write(' ', tabfor5[i, j]:0:6, ' | ')
      else
      write('  ', tabfor5[i, j]:0:6, ' | ')
    end;
    writeln();
  end;
  
  writeln();
  
  writeln(' Сумма = ', s:0:6);
  writeln(' (B - A) / 2 = ', (b - a)/2:0:6);
  integral:= s * ((b - a)/2);
  writeln(' Результат для 5 узлов = ', integral:0:8); 
end;


procedure node8();  {процедура для 8 узлов}
var
  s: real = 0;
  TabFor8: array[1..8, 1..5] of real;
  i, j: integer;
  integral: real;
  
begin
  for i := 1 to 8 do
  begin
    for j := 1 to 2 do
    begin
      TabFor8[i, j] := tab2[i, j]; 
    end;
  end;
  
  for i := 1 to 8 do
  begin
    TabFor8[i, 3] := arg(tab2[i, 1]); 
    TabFor8[i, 4] := F(TabFor8[i, 3]);
    TabFor8[i, 5] := TabFor8[i, 4] * Tab2[i, 2];
    s:= s + TabFor8[i, 5];
  end;
  
  
  writeln(' Для 8 узлов:');
  writeln(' i |      xi      |      Ai      |     Argi     |    F(Argi)   |   Ai*F(Argi) |');
  writeln(' ------------------------------------------------------------------------------');
  for i:=1 to 8 do
  begin
    write(' ', i, ' | ');
    for j:= 1 to 5 do
    begin
      if tabfor8[i, j] < 0 then
      write(' ', tabfor8[i, j]:0:8, ' | ')
      else
      write('  ', tabfor8[i, j]:0:8, ' | ')
    end;
    writeln();
  end;
  
  writeln();
  
  writeln(' Сумма = ', s:0:6);
  writeln(' (B - A) / 2 = ', (b - a)/2:0:6);
  integral:= s * ((b - a)/2);
  writeln(' Результат для 8 узлов = ', integral:0:8); 
end;


begin
  writeln(' МЕТОД ГАУССА:');
  writeln(' ===============================================');
  writeln(' F = sqrt(x^2+1)/(x+2)'); 
  writeln(' Пределы интегрирования:  [0,2;2,4]');
  writeln(' ===============================================');;
  
  writeln(' 5 узлов:');
  for i := 1 to 5 do
  begin
    for j := 1 to 2 do 
    begin
      if tab1[i, j] < 0 then
        write(' ', tab1[i, j]:0:6, ' |')
      else
        write('  ', tab1[i, j]:0:6, ' |')
    end;
    writeln;
  end;
  
  writeln();
  
  writeln(' 8 узлов:');
  for i := 1 to 8 do
  begin
    for j := 1 to 2 do 
    begin
      if tab2[i, j] < 0 then
        write(' ', tab2[i, j]:0:8, ' |')
      else
        write('  ', tab2[i, j]:0:8, ' |')
    end;
    writeln;
  end;
  writeln(' ===============================================');
  writeln();
  
  node5();
  writeln();
  writeln();
  node8();
  writeln();
  Writeln('Точное решение = ', resh:0:8);
  readln();
end.