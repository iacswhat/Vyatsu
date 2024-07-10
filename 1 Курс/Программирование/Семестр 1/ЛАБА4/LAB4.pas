program lab4;
uses
 Crt,graph, wincrt;
var
 m,gd,gm,d:integer;
 x1,x2,g,o,p,i1,s1,h,i,mx,my:real;
 f1,f2,f3:boolean;
 n,gx,gy,x0,y0:integer;

function Fx(x:real):real;
 begin
  Fx:=2*(x*x*x)-2*(x*x)+2*x+3;
 end;
function Px(x:real):real;
 begin
  Px:=(x*x*x*x)/2+(-2/3)*(x*x*x)+x*x+3*x;
 end;
procedure integral;
 var
  xx1,s:real;
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
    writeln('Integral = ',s:6:4);
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

procedure graph;
var
  x1,y1,k:integer;
  x,y:real;
  s:string;

begin
line(0,y0,gx,y0);
line(gx,y0,gx-10,y0+10);
line(gx,y0,gx-10,y0-10);
outtextxy(gx-15,y0+15,'X');

line(x0,0,x0,gy);
line(x0,0,x0-10,10);
line(x0,0,x0+10,10);
outtextxy(x0+15,15,'Y');

k:=-10;
while k<=10 do
 begin
   line(x0+2,round(y0+k*my),x0-2,round(y0+k*my));
   str(k,s);
   outtextxy(x0+10,round(y0-k*my),s);

   if k<>0 then
     begin
      str(k,s);
      line(round(x0+k*mx),y0+2,round(x0+k*mx),y0-2);
      outtextxy(round(x0+k*mx),y0+10,s);
     end;
   inc(k);
 end;

x:=-2;
while x<3 do
  begin
     y:=2*(x*x*x)-2*(x*x)+2*x+3;

     x1:=x0+round(x*mx);
     y1:=y0-round(y*my);

     putpixel(x1,y1,red);
     x:=x+0.0001;
  end;
end;

procedure strih;
var
j:real;
begin
j:=x1;
while j<=x2 do
begin
line(x0+round(j*mx),y0,x0+round(j*mx),y0-round(round(Fx(j)*my)));
j:=j+0.1;
end;
end;

procedure info;
begin
outtextxy(10,10,'Press "+" to zoom in and "-" to zoom out');
outtextxy(10,30,'Use the arrow keys to zoom analog the axes');
outtextxy(10,50,'Up, Down for OY and Left, Right for OX');
outtextxy(10,70,'Press <Enter> to close the graphics window');
end;

procedure mashtab;
var
ch:char;
begin
clrscr;

gd:=detect;
initgraph(gd,gm,'');
SetBkColor (0);
SetColor (15);

i:=45;
mx:=i;
my:=i;
gx:=1920;
gy:=1080;

x0:=gx div 2;
y0:=gy div 2;

graph;
info;

repeat
    ch:=readkey;
    if ch = #0 then
    ch := wincrt.readkey;
  case ch of
    #43:
      begin
        SetBkColor (0);
        clearviewport;
        mx:= mx*1.3;
        my:=my*1.3;
        setcolor(15);
        graph;
        info;
      end;
    #45:
      begin
       SetBkColor (0);
        clearviewport;
        mx:=mx*0.8;
        my:=my*0.8;
        setcolor(15);
        graph;
        info;
       end;
     #72:
      begin
       SetBkColor (0);
        clearviewport;
        my:= my*1.3;
        setcolor(15);
        graph;
        info;
      end;
     #80:
       begin
        SetBkColor (0);
        clearviewport;
        my:= my*0.8;
        setcolor(15);
        graph;
        info;
       end;
     #77:
      begin
        SetBkColor (0);
        clearviewport;
        mx:=mx*1.3;
        setcolor(15);
        graph;
        info;
      end;
    #75:
      begin
        SetBkColor (0);
        clearviewport;
        mx:=mx*0.8;
        setcolor(15);
        graph;
        info;
      end;
    #9:
    begin
      if f1 then
      begin
      graph;
      strih;
      info;
      end
      else
      outtextxy(10,100,'Set the limits of integration');
      end;
    end;
  until ch = #13;
closegraph;
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
     writeln('Result through antiderivatives= ',i1:6:4);
     writeln('Result using the medium rectangles method= ',s1:6:4);
     writeln('-----------------------------------------------------------------------');
    writeln('The error');
    p:=i1-s1;
    writeln(p:6:4);
    readln;
    end
   else
  begin
   write('First, set the limits and the number of split segments and calculate the area of the shape');
   readln;
  end;
end;
6:begin
  mashtab;
  end;
end;
 until m = 0;
end.