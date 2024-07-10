Program Obratnaya;

uses crt;

const
  nmax = 3;

var
  n: integer;

type
  Tmass = array[1..nmax] of real;
  Tmatrix = array[1..nmax, 1..nmax] of real;
{перестановка строк при главном элементе=0}
procedure Per(k: integer; var a: Tmatrix; var p: integer);
var
  z: Real;
  j, i: integer;
begin
  z := abs(a[k, k]);{модуль главного элемента}
  i := k;{номер строки}
  p := 0;{количество перестановок}
  for j := k + 1 to n do {ищем в столбце ниже}
  begin
    if abs(a[j, k]) > z then {элемент по модулю больше}
    begin
      z := abs(a[j, k]);
      i := j;
      p := p + 1;//счетчик перестановок
    end;
  end;
  if i > k then{если нашли}
    for j := k to n do
    begin
      z := a[i, j];
      a[i, j] := a[k, j];{обмениваем строки}
      a[k, j] := z;
    end;
end;
{определение знака определителя}
function Znak(p: integer): integer;
begin
  if p mod 2 = 0 then
    Znak := 1 else Znak := -1;
end;
{вычисление определителя матрицы коэффициентов по Гауссу}
procedure Opr(var det: real; var a: tmatrix);
var
  k, i, j, p: integer;r: real;
begin
  det := 1.0;
  for k := 1 to n do
  begin
    if a[k, k] = 0 then Per(k, a, p);//перестановка строк
    det := znak(p) * det * a[k, k];//вычисление определителя
    for j := k + 1 to n do //пересчет коэффициентов
    begin
      r := a[j, k] / a[k, k];
      for i := k to n do
        a[j, i] := a[j, i] - r * a[k, i];
    end;
  end;
end;
{вычисление алгебраических дополнений}
procedure Dop(d: tmatrix; var det1: real);
var
  k, i, j, p: integer;r: real;
begin
  det1 := 1.0;
  for k := 2 to n do
  begin
    Per(k, d, p);
    det1 := znak(p) * det1 * d[k, k];
    for j := k + 1 to n do
    begin
      r := d[j, k] / d[k, k];
      for i := k to n do
        d[j, i] := (d[j, i] - r * d[k, i]);
    end;
  end;
end;
{установление знака алгебраических дополнений}
function Znak1(i, m: integer): integer;
begin
  if (i + m) mod 2 = 0 then
    Znak1 := 1 else Znak1 := -1;
end;
{формирование присоединенной матрицы}
procedure Peresch(b: Tmatrix; var e: Tmatrix);
var
  i, m, k, j: integer;z, det1: real;d, c: Tmatrix;
begin
  for i := 1 to n do
  begin
    for m := 1 to n do
    begin
      for j := 1 to n do  {перестановка строки}
      begin
        z := b[i, j];
        for k := i downto 2 do
          d[k, j] := b[k - 1, j];
        for k := i + 1 to n do
          d[k, j] := b[k, j];
        d[1, j] := z;
      end;
      for k := 1 to n do  {перестановка столбца}
      begin
        z := d[k, m];
        for j := m downto 2 do
          c[k, j] := d[k, j - 1];
        for j := m + 1 to n do
          c[k, j] := d[k, j];
        c[k, 1] := z;
      end;
      Dop(c, det1); {вычисление дополнений}
      e[i, m] := (det1) * znak1(i, m); {установление знака дополнений и }
    end;                       {формирование присоединенной матрицы }
  end;
end;

{транспонирование матрицы}
procedure Trans(b: Tmatrix; var e: Tmatrix);
var
  i, j: integer;
begin
  writeln('--------------------------');
  writeln('Матрица алгебраических дополнений:');
  for i := 1 to n do
  begin
    for j := 1 to n do
    begin
      write(' ', b[i, j]);
    end;
    writeln;
  end;
  for i := 1 to n do
    for j := 1 to n do
      e[i, j] := b[j, i];
end;

{нахождение корней умножением обратной матрицы на столбец свободных членов}
procedure Resh(n: integer; a: Tmatrix; b: Tmass; var x: Tmass);
var
  k, j, i: integer;z: real;
begin
  writeln('--------------------------');
  writeln('Обратная матрица:');
  for i := 1 to n do
  begin
    for j := 1 to n do
    begin
      write(' ', a[i, j]:4:3);
    end;
    writeln;
  end;
  writeln('--------------------------');  
  for k := 1 to n do
  begin
    x[k] := 0;
    for j := 1 to n do
    begin
      z := a[k, j] * b[j];
      x[k] := x[k] + z;
    end;
  end;
end;

var
  a, a1, at, b, c: Tmatrix;
  f, x: Tmass;
  det: Real;
  i, j: integer;

begin
  clrscr;
  {решение системы} 
  n := 3;
  
  a[1, 1] := 2; a[1, 2] := 4; a[1, 3] := 3;
  a[2, 1] := 1; a[2, 2] := 1; a[2, 3] := 4;
  a[3, 1] := 2; a[3, 2] := 3; a[3, 3] := 4;
  
  f[1] := 13; f[2] := 17; f[3] := 12;  
  
  clrscr;
  WRITELN('МЕТОД ОБРАТНОЙ МАТРИЦЫ');
  WRITELN('-----------------');
  writeln('Исходная система:');
  WRITELN;
  for i := 1 to n do
  begin
    for j := 1 to n do
      write(a[i, j]:5:1);
    writeln('  ', f[i]:7:1);
  end;
  writeln;
  a1 := a;{сделаем копию матрицы для нахождения определителя, она изменится}
  Opr(det, a1);{вычисление определителя  матрицы}
  writeln('Определитель=', det:0:0);
  if det = 0 then
  begin
    write('Решений не существует');
    readln;
    exit;
  end;
  Peresch(a, b); { вычисление присоединенной матрицы}
  Trans(b, c);{транспонирование присоединенной матрицы}
  for i := 1 to n do
    for j := 1 to n do
      c[i, j] := c[i, j] / det;{деление на определитель=обратная матрица}
  {нахождение корней}
  Resh(n, c, f, x);
  for i := 1 to n do
    writeln('x[', i, ']=', x[i]:0:3);
  readln;
end.