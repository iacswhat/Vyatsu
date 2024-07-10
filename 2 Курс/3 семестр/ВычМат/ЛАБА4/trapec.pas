program trapec;

uses
  crt;

const
  resh = 0.2539702731612316;

var
  a: real = 0.8;
  a1: real;
  b: real = 1.6;
  e: real = 0.0001;
  s: real = 0;
  ss: real = 0;
  f, ff: real;
  h: real = 0.01;
  hh: real;
  i: integer = 1;

function integral(x: real): real;
begin
  result := (ln((x * x) + 1) / ln(10)) / x;
end;

procedure ftrapec;
begin
  hh := h / 2;
  repeat
    a1 := a + h;
    writeln('  ', a:1:3, '  |   ', integral(a):1:5, '  |  ', 0.5 * integral(a):1:5, '  |');
    while a1 < b do
    begin
      s := s + integral(a1);
      writeln('  ', a1:1:3, '  |   ', integral(a1):1:5, '  |  ', integral(a1):1:5, '  |');
      a1 := a1 + h;
    end;
    writeln('  ', b:1:3, '  |   ', integral(b):1:5, '  |  ', 0.5 * integral(b):1:5, '  |');
    s := s + 0.5 * integral(a) + 0.5 * integral(b);
    f := h * s;
    Writeln('===================================');  
    s := 0;
    a1 := a + hh;
    writeln('  ', a:1:3, '  |   ', integral(a):1:5, '  |  ', 0.5 * integral(a):1:5, '  |');
    while a1 < b - 0.001 do
    begin
      s := s + integral(a1);
      writeln('  ', a1:1:3, '  |   ', integral(a1):1:5, '  |  ', integral(a1):1:5, '  |');
      a1 := a1 + hh;
    end;
    writeln('  ', b:1:3, '  |   ', integral(b):1:5, '  |  ', 0.5 * integral(b):1:5, '  |');
    s := s + 0.5 * integral(a) + 0.5 * integral(b);
    ff := hh * s; 
    if abs(f - ff) > e then
    begin
      h := hh;
      hh := hh / 2;
    end;
  until abs(f - ff) < e;
end;

begin
  writeln('Формула трапеций');
  Writeln('-----------------------------------');
  writeln('Опраделенный интеграл от функции: lg(x^2 + 1) / x');
  writeln('Пределы интегрирования: [0.8;1.6]');  
  writeln('E = 0.0001');
  writeln('Шаг равен E^(1/2) = 0.01'); 
  Writeln('-----------------------------------');
  writeln('    X    |    F(x)    |    Fтр    |');
  //writeln('  ',a:1:3, '  |   ', integral(a):1:5, '  |  ', 0.5 * integral(a):1:5, '  |');
  ftrapec;
  //writeln('  ',b:1:3, '  |   ', integral(b):1:5, '  |  ', 0.5 * integral(b):1:5, '  |');
  Writeln('===================================');
  writeln('Точное значение = ', resh);
  writeln('Значение с шагом h = ', f);
  writeln('Значение с шагом h / 2 = ', ff);
  writeln('E = 0.0001');
  writeln('|In - I2n| = ', Abs(f - ff):1:10);
  writeln('d = ', abs(resh - ff):1:10);
  writeln('sig = ', abs(resh - ff) / resh * 100:1:10, '%');
  readln();
end.