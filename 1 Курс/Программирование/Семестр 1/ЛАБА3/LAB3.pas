program lab4;
uses
 Crt,graph;
var
 m,gd,gm:integer;
 x1,x2,g,o,p,i1,s1,x,y,mx,my,d,xx2,y1,y2,h:real;
 f1,f2,f3:boolean;
 n:integer;
function Fx(x:real):real;
 begin
  Fx:=c;
 end;
function Px(x:real):real;
 begin
  Px:=(x*x*x*x)/2+(-2/3)*(x*x*x)+x*x+3*x;
 end;
procedure integral;
 var
  xx1,s,h:real;
  c:integer;
 begin
  h:=(x2-x1)/n;
  s:=0;
  xx1:=x1+h/2;
 for c:=1 to n do
   begin
      s:=s+((Fx(xx1))*(h));
      xx1:=xx1+h;
      s1:=s;
    end;
    writeln('Integral = ',s);
 end;
procedure integral1;
 var
  xx1,xx2,i2:real;
 begin
  xx1:=Px(x1);
  xx2:=Px(x2);
  i2:=xx2-xx1;
  i1:=i2;
 end;
 
 procedure graphick;
 begin
   y1:=Fx(x1);
   y2:=Fx(x2);
   mx:=640/(x2-x1);
   my:=480/(y2-y1);
   if mx<my then
     d:=my;
   h:=1/d;
   x:=x1;
   gd:=detect;
   initgraph(gd,gm,'c:/bp');
   setcolor(5);
   line(0,240,640,240);
   line(320,0,320,480);
   while x<=x2 do
   begin
     y:=-Fx(x);
     putpixel(x*d+320,y*d+240,15);
     x:=x+h;
   end;
 end;
begin
 o:=-0.69;
 g:=0;
 f1:=false;
 f2:=false;
 f3:=false;
 repeat
 clrscr;
 writeln('Choose an action');
 writeln('1-Job Information');
 writeln('2-Set limits of integration');
 writeln('3-Enter the number of segments to split');
 writeln('4-Calculate the area of a shape');
 writeln('5-Estimate the error');
 writeln('6-Graph');
 writeln('0-Exit');
 writeln('-----------------------------------------------------------------------');
 readln(m);
case m of
 1: begin
   write('The graph of the function is in the positive part along the OY axis at x>-0.69');
   readln;
    end;
 2:begin
  write('Initial value x=');
  readln(x1);
  write('End value x=');
  readln(x2);
  f1:=true;
  if x2<x1 then
   begin
  g:=x1;
  x1:=x2;
  x2:=g;
   end;
  if (x1<o) and (x2<o) then
  begin
    writeln('For these values, it is impossible to calculate the integral');
    writeln('Enter values of X>=-0.69');
    f1:=false;
    readln;
  end
  else
  if x1<o then begin
    x1:=-0.69;
    end;
 end;
 3:begin
  writeln('Enter the number of segments to split');
  readln(n);
  f2:=true;
  if n<0 then begin
    repeat
    writeln('Enter values greater than 0');
    readln(n);
    until n>0;
  end;
 end;
 4:begin
  if (f1) and (f2) then
   begin
    integral;
    readln;
    f3:=true;
   end
  else
  begin
   write('First, set the limits and the number of split segments');
   readln;
  end;
 end;
 5: begin
  if (f1) and (f2)and (f3) then
   begin
     integral1;
     writeln('Result through antiderivatives= ',i1);
     writeln('Result using the medium rectangles method= ',s1);
     writeln('-----------------------------------------------------------------------');
    writeln('The error');
    p:=i1-s1;
    writeln(p);
    readln;
    end
   else
  begin
   write('First, set the limits and the number of split segments and calculate the area of the shape');
   readln;
  end;
end;
6:begin
  graphick;
  end;
end;
 until m = 0;
end.