Program difur;

uses
  crt;
  
var
  alf: real = 0.5;                {альфа}
  x0: real = 0; y0: real = 0;     {начальное условие}
  hh: real = 0.1;                  {шаг}
  a: real = 0;                    {левая граница}
  b: real = 1;                    {правая граница}
  tab: array[0..49, 0..8] of real; {таблица}
  i: integer;
  n: integer;
  
  Yt1: array[0..10] of real = (0, 
                               0.0007198, 
                               0.0062398, 
                               0.0229042, 
                               0.0592766, 
                               0.126917, 
                               0.241429, 
                               0.423877, 
                               0.702693, 
                               1.11626, 
                               1.71638);
                               
 Yt2: array[0..20] of real = (0,
                              0.0000865545,
                              0.0007198,
                              0.00252773,
                              0.0062398,
                              0.0127037,
                              0.0229042,
                              0.0379854,
                              0.0592766,
                              0.0883223,
                              0.126917,
                              0.177145,
                              0.241429,
                              0.322583,
                              0.423877,
                              0.549109,
                              0.702693,
                              0.889756,
                              1.11626,
                              1.38912,
                              1.71638);
                              
  
function f(x, y: real): real;  {правая часть уравнения}
begin
  //result:= sqrt(x) + (y * y);
  result:= 2 * x * x + 3 * y;
end;


procedure dif(h: real);
var
  i, j: integer;
  x: real;
  
begin
  tab[0,0]:= x0;
  tab[0,1]:= y0;
  tab[0,2]:= f(tab[0,0], tab[0,1]);
  tab[0,3]:= tab[0,0] + h;
  tab[0,4]:= tab[0,1] + h * tab[0,2];
  tab[0,5]:= f(tab[0,3], tab[0,4]);
  tab[0,6]:= (h/2) * (tab[0,5] + tab[0,2]);
  x:= x0;
  for i:= 1 to n do
  begin
    x:= x + h;
    for j:= 0 to 8 do
    begin
      if j = 0 then tab[i,j]:= x;  {вычисление Х}
      if j = 1 then tab[i,j]:= tab[i-1, j] + ((h/2) * ( f(tab[i-1,j-1], tab[i-1, j]) + f(tab[i-1,j-1] + h, tab[i-1, j] + (h * f(tab[i-1,j-1], tab[i-1, j]))) )); {вычисление Y}
      if j = 2 then tab[i,j]:= f(tab[i,j-2], tab[i,j-1]);
      if j = 3 then tab[i,j]:= tab[i, j-3] + h;
      if j = 4 then tab[i,j]:= tab[i,j-3] + h * tab[i,j-2];
      if j = 5 then tab[i,j]:= f(tab[i,j-2], tab[i,j-1]);
      if j = 6 then tab[i,j]:= (h/2) * (tab[i,j-1] + tab[i,j-4]);
   end;
  end;
  for i:=0 to n do tab[i,8]:= abs(tab[i,1] - tab[i,7]);
  
  for j:=2 to 6 do
  begin
    tab[n,j]:=0;
  end;
  
  writeln(' k |     Xk    |     Yk    | f(Xk, Yk) |   Xk+h    | Yk + h*fk |f(5ст, 6ст)|     dy    |     Yт    |      E    |');
  writeln(' ----------------------------------------------------------------------------------------------------------------');
  for i:= 0 to n do 
  begin
    write(' ',i,' |');
    for j:= 0 to 8 do 
    begin
      write(' ', tab[i,j]:0:7, ' |');
    end;
    writeln;
    writeln(' ----------------------------------------------------------------------------------------------------------------');
  end;
end;


begin
  writeln(' Метод Эйлера-Коши 2-го порядка точности');
  writeln(' =======================================');
  writeln(' Уравнение: y`= 2*x^2+3*y');
  writeln(' a=1/2;  y(0)=0; h=0.1; 0<=x<=1');
  writeln(' =======================================');
  writeln();
  writeln(' Для шага h = 0.1');
  n:= round((b - a)/hh); 
  for i:= 0 to n do tab[i,7]:= yt1[i];
  dif(hh);
  writeln();
  writeln();
  writeln();
  writeln(' Для шага h/2 = 0.05');
  n:= round((b - a)/(hh/2));
  for i:= 0 to n do tab[i,7]:= yt2[i];
  dif(hh/2);
  readln();
end.





