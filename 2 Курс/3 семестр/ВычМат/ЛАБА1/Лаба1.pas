program metod;

uses crt;

var
  a, b: real;
  e: real;
  p: integer;

function f(var x: real): real;
begin
  f := X + ln(x) - 0.5;
end;

function f1(var x: real): real;
begin
  f1 := 1 + 1 / X; 
end;

function f2(var x: real): real;
begin
  f2 := -1 / (X * X);
end;

function phi(var x, k: real): real;
begin
  phi := x - (x + ln(x) - 0.5) / k;
end;

function phi1(var x: real): real;
begin
  phi1 := 5 / 6 - 1 / (6 * x)
end;

procedure ostanov(t, tt: real);
begin
  if tt <= 2 * t then writeln('M = ', tt, ', m = ', t, '; M <= 2m >> Критерий останова: |Bn - An| < E  ') else
    writeln('M = ', tt, ', m = ', t, '; M > 2m >> Критерий останова: (|f(Xn+1)|/m <= E');
end;

procedure iter(a, b, e: real);
var
  c1, c2: real;
  x1, x2: real;
  q, qq, n, k: real;
  i: integer;
    
begin
  writeln('Исходное уравнение x+ln(x)-0,5=0; Интервал [',a,';',b,']');
  c1 := abs(f1(a));
  c2 := abs(f1(b));
  if c1 < c2 then n := c2 else n := c1;
  i := sign(f1(a));
  if i = -1 then k := -(n / 2 + 0.5) else k := n / 2 + 0.5;
  writeln('Канонический вид phi(x) = x - (x + ln(x)-0,5)/', k, ';');
  writeln('phi`(x) = 5/6 - 1/6x; phi`(',a,') = ', phi1(a):3:2, '; phi`(',b,') = ',phi1(b):3:2);
  writeln('|phi`(x)| < 1 и sign(phi`(',a,'))<>sign(phi`(',b,')) -> монотонная сходимость');
  q := max(abs(phi1(a)), abs(phi1(b)));
  qq := 1 / (1 - q);
  writeln('Критерий останова: ', qq:3:2, '*|Xn+1 - Xn| <= E');
  writeln('------------------------------------------------------------');  
  writeln('n |    Xn    |    phi(Xn)   |  ', qq:3:2, ' * |Xn+1 - Xn|   '); 
  x1 := a;
  x2 := phi(x1, k);
  writeln(p, ' | ', X1:6:5, '  |    ', x2:6:5, '   | ', qq * abs(x2 - x1):6:5); 
  p := p + 1;
  while qq * abs(x2 - x1) > e do
  begin
    x1 := x2;
    x2 := phi(x1, k);
    writeln(p, ' | ', X1:6:5, '  |    ', x2:6:5, '   | ', qq * abs(x2 - x1):6:5); 
    p := p + 1;;
  end;
  writeln('Корень: ', x2:6:5)
end;


procedure komb(a, b, e: real);

var
  x0: real;
  x11, x12: real;
  m, mm: real;

begin
  writeln('Исходное уравнение x+ln(x)-0,5=0; Интервал [',a,';',b,']');
  writeln('f`(x)=1+1/x; f`(',a,')=', f1(a), '; f`(',b,')=', f1(b), ';');
  writeln('f``(x)=-1/x^2; f``(',a,')=', f2(a), '; f``(',b,')=', f2(b), ';');
  m := min(abs(f1(a)), abs(f1(b)));
  mm := max(abs(f2(a)), abs(f2(b)));
  ostanov(m, mm);
  if f(a) * f2(a) > 0 then writeln('Значение по недостатку вычисляется методом хорд, а по избытку методом касательных') else if f(b) * f2(a) > 0 then writeln('Значение по недостатку вычисляется методом касательных, а по избытку методом хорд');
  writeln('------------------------------------------------------------');
  writeln('n |    Bn    |    f(Bn)   |  f(An)-f(Bn)  |  f(An)*(An-Bn)  |      h      |    Bn+1   ');
  
  if f(a) * f2(a  ) > 0 then begin
    
    x12 := b - f(b) / f1(b);
    x11 := a - ((a - b) * f(a) / (f(a) - f(b)));
    
    writeln(p, ' | ', b:6:5, '  |  ', f(b):6:5, '  |    ', f(a) - f(b):6:5, '    |     ', f(a) * (a - b):6:5, '     |   ', (f(a) * (a - b)) / (f(a) - f(b)):6:5, '  | ', x12:6:5, '   |  ', abs(x12 - x11):6:9);
    inc(p);
    while abs(x12 - x11) >= e do
    begin
      a := x11;
      b := x12;
      
      x12 := b - f(b) / f1(b);
      x11 := a - ((a - b) * f(a) / (f(a) - f(b)));
      
      writeln(p, ' | ', b:6:5, '  |  ', f(b):6:5, '  |    ', f(a) - f(b):6:5, '    |     ', f(a) * (a - b):6:5, '     |   ', (f(a) * (a - b)) / (f(a) - f(b)):6:5, '  | ', x12:6:5, '   |  ', abs(x12 - x11):6:9);
      inc(p);
    end;
    writeln('Корень: ', x12:6:5)
  end
  else
    if f(b) * f2(a) > 0 then begin
    
    x11 := a - f(a) / f1(a);
    x12 := b - ((b - a) * f(b) / (f(b) - f(a)));
    
    writeln(p, ' | ', a:6:5, '  |  ', f(a):6:5, '  |    ', f(b) - f(a):6:5, '    |     ', f(b) * (b - a):6:5, '     |   ', (f(b) * (b- a)) / (f(b) - f(a)):6:5, '  | ', x12:6:5, '   |  ', abs(x12 - x11):6:9);
    inc(p);
    while abs(x12 - x11) >= e do
    begin
      a := x11;
      b := x12;
      
      x12 := b - f(b) / f1(b);
      x11 := a - ((a - b) * f(a) / (f(a) - f(b)));
      
      writeln(p, ' | ', a:6:5, '  |  ', f(a):6:5, '  |    ', f(b) - f(a):6:5, '    |     ', f(b) * (b - a):6:5, '     |   ', (f(b) * (b- a)) / (f(b) - f(a)):6:5, '  | ', x12:6:5, '   |  ', abs(x12 - x11):6:9);
      inc(p);
    end;
    writeln('Корень: ', x12:6:5)
  end;
end;

begin
  clrscr;
  a := 0.1;
  b := 1;
  e := 0.00001;  
  p := 0;
  Writeln('Комбинированный метод:');
  komb(a, b, e);
  Writeln('------------------------------------------------------------------------');
  Writeln('------------------------------------------------------------------------');
  Writeln('------------------------------------------------------------------------');
  Writeln('Метод простых итераций:');
  iter(0.1,1,e);
  readln();
end.