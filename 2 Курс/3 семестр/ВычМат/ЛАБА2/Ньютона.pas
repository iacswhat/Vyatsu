﻿program newton;

uses
  crt;

const
  n = 2;
  eps = 0.001;
  
type
  ss = array[1..2] of real;

var
  s: ss;
  x0, y0:real;

function f1(x, y: real): real;
begin
  f1 := x - ln(-0.9 - y);  
end;

function f2(x, y: real): real;
begin
  f2 := y - (sin(x + 0.8)/cos(x + 0.8));  
end;

function f1x(x, y: real): real;
begin
  f1x := 1;  
end;

function f1y(x, y: real): real;
begin
  f1y := 1 / (-0.9 - y);  
end;

function f2x(x, y: real): real;
begin
  f2x := -1 / (cos(x + 0.8) * cos(x + 0.8));  
end;

function f2y(x, y: real): real;
begin
  f2y := 1;  
end;

procedure newt(s1: ss);
var
  a: array[1..2,1..2] of real;
  b: array[1..2] of real;
  d,dx,dy: real;
  f:Boolean;
  q:real;
  
begin
  x0:=s1[1];
  y0:=s1[2];
  
  f:=true;
  
  while f do begin
  a[1,1]:=f1x(x0,y0);  a[1,2]:=f1y(x0,y0);  
  a[2,1]:=f2x(x0,y0);  a[2,2]:=f2y(x0,y0);  
  
  {for i:=1 to 2 do
    for j:=1 to 2 do
      write(' ', a[i,j]:0:3);
    writeln;}
  
  b[1]:=-f1(x0,y0);
  b[2]:=-f2(x0,y0);
   {for i:=1 to 2 do
      write(' ', b[i]:0:3);
    writeln;}
  
  d:=(a[1,1]*a[2,2])-(a[2,1]*a[1,2]);
  
  dx:=(b[1] * a[2,2] - b[2] * a[1,2]) / d; 
  dy:=(a[1,1] * b[2] - b[1] * a[2,1]) / d;
  
   q:=max(dx*dx,dy*dy);
  
  writeln(' ',x0:0:4,' | ',y0:0:4,' | ',a[1,1]:0:4,' | ',a[1,2]:0:4,' | ',a[2,1]:0:4,' | ',a[2,2]:0:4,' | ',dx:0:4,' | ', dy:0:4,' | ',q:0:4);
  
  
  if q < eps then f:= false
  else
    begin
      x0:=x0+dx;
      y0:=y0+dy;
    end;
  end;
end;

begin
  writeln('МЕТОД НЬЮТОНА');
  writeln('Исходная ситсема');
  writeln('x-ln(-0,9-y)=0 (f1)');
  writeln('y-tg(x+0,8)=0 (f2)');
  writeln('Частные производные:');
  writeln('f1x = 1');
  writeln('f1у = 1 / (-0.9 - y)');
  writeln('f2x = -1 / (cos(x + 0.8) * cos(x + 0.8))');
  writeln('f2у = 1');
  
  writeln('-------------------------------------------');
  
  writeln('Eps = 0.001');
  
  writeln('-------------------------------------------');
  s[1] := 1;
  s[2] := -1;
  writeln('    x   |    y    |   f1x   |   f1y   |   f2x   |   f2y   |   dx   |    dy   |  q  ');
  newt(s);
   writeln('-------------------------------------------');
  writeln('Корни: [',x0:0:4,',',y0:0:4,']');
  
  readln;
end.