program lab6;
uses Graph,crt;
const
  min=-10;
  max=10;
  D1=-0.013577;
  D2=-0.119558;
  A=0.755;
type
  l = ^list;
  list = record
    InX : real;
    InY : real;
    Next: L;
  end;
var
  g,h:integer;
  Head:l;
 
//Функция преобразования значения х,у в их пиксельные значения
function PixToX (x:real):real;
begin
    PixToX:=(x/50)-10
end;
 
 
//Процедура формирования осей
procedure OCI;
begin
  SetBkColor (0);
  ClearDevice;
  SetColor (15);
  rectangle (0,0,1000,1000);
  line (0,500,1000,500);  {Ось ОУ}
  line (500, 0, 500, 1000);     {Ось ОХ}
  line (475, 25, 500, 0);    {Стрелка ОУ}
  line (500, 0, 525,25);
  OutTextXY (550,25,'Y');  {Знак Y}
  line (975,475,1000,500);     {Стрелка ОХ}
  line (1000,500,975,525);
  OutTextXY (975, 550,'X')      {Знак Х}
end;
 
//Процедура нумерации
procedure Nom;
const
  dxy = 50 ;
var
  x,x1,y,y1: integer;
  st: string;
begin
  x:=0;
  y:=0;
  x1:=min;
  y1:=max;
  while (x <= 1000) and (y <= 1000) do begin
    line (x ,495,x,505);
    if (x1<=max) then
      begin
      str (x1 , st);
      OutTextXY (x ,490 , st) ;;
    end;
    inc(x1);
    x:=x+dxy;
    line (495 , y,505,y);  {Y}
    if (y1>=min) then
      if y1<>0 then
      begin
        str (y1 , st);
        OutTextXY(510,y, st ) ;
      end;
    dec(y1);
    y:=y+dxy
  end;
end;
 
 
//Процедура Построения Легенды Графика
procedure Legend;
var
  i,j:integer;
begin
  for i:=1190 to 1200 do begin
    for j:=790 to 800 do
      putpixel (i,j,6);
    for j:=805 to 815 do
      putpixel (i,j,2);
  end;
  SetTextStyle (DefaultFont, HorizDir, 2);
  OutTextXY (1205,785, 'Graph* F1');
  OutTextXY (1205,805, 'Graph* F2');
end;
 
procedure Graph_f1_f2 ; {Графики фунций ф1,ф1}
var
  i,j,s : integer;
 
  function F1(x,y:real):real;
  begin
  F1:=sin(0.2*x*x-y)+0.1*y*y-0.25*x*y+d1;
  end;
 
  function F2 (x,y:real):real;
  begin
    F2:=x*x*x+y*y*y-3*A*x*y+D2;
  end;
 
  procedure  pic(i,j,c:integer ; x,y:real);
  begin
  if x*y<0 then putpixel (i,j,c);
  end;
 
begin
  s:=1;
  for i:=1 to 1000 do begin
    for j:=1 to 1000 do  begin
      pic (i,j,6,F1  (PixToX(i) , PixToX(j)),  F1 (PixToX(i),PixToX(j+1)));
      pic (i,j,6,F1  (PixToX(i) , PixToX(j)),  F1 (PixToX(i+1),PixToX(j)));
      pic (i,j,6,F1  (PixToX(i) , PixToX(j)),  F1 (PixToX(i+1),PixToX(j+1)));
    end;
    for j:=1 to 1000 do begin
      pic (i,j,2,F2  (PixToX(i) , PixToX(j)),  F2 (PixToX(i),PixToX(j+1)));
      pic (i,j,2,F2  (PixToX(i) , PixToX(j)),  F2 (PixToX(i+1),PixToX(j)));
      pic (i,j,2,F2  (PixToX(i) , PixToX(j)),  F2 (PixToX(i+1),PixToX(j+1)));
    end;
  end;
end;
 
procedure keys (var Head: L);
var
  i,j:integer;
  p : L;
 
  procedure NewEl (var Head,P:L;i,j:integer);
  begin
    New (P);
    P^.Next:=Head;
    P^.InX:=PixToX(i);
    P^.InY:=(-1)*PixToX(j);
    Head:=P;
  end;
begin
  New (Head);
  Head:=nil;
  for i:=10 to 990 do
    for j:=10 to 990 do begin
      case (GetPixel (i,j)) of
         2 : if (GetPixel (i+1,j)=6) or (GetPixel(i+1,j)=6) then  NewEl(Head,P,i,j);
         6 : if (GetPixel (i+1,j)=2) or (GetPixel(i+1,j)=2) then  NewEl(Head,P,i,j);
      end;
 
    end;
end;
 
 
 
procedure outputk (Head : L);
const
  dxy = 50;
var
  s,x,y : integer;
  st:string;
  p:L;
begin
  OutTextXY (1250 , 50 , 'Korni:');
  P:=Head;
  y:=100;       s:=1;
  x:=1250;
  SetTextStyle (DefaultFont, HorizDir, 1);
  while P^.next<>nil do begin
    setcolor (1);
    str (p^.InX :2:3 , st );
    st:='x: '+st;
    OutTextXY (x , y, st);
    str (P^.InY:2:3 , st);
    setcolor(4);
    st:='y: '+st;
    OutTextXY (x+150,y,st);
    y:=y+dxy;
    P:=P^.Next;
  end;
  SetTextStyle (DefaultFont, HorizDir, 2);
  SetColor (8);
  OutTextXY (1250,y,'Spisok Okonchilsya');
  readkey;
end;
 
 
begin
  clrscr;
  g:=detect;
  initgraph (g,h,'');
  OCI;
  NOM;
  Legend;
  graph_f1_f2;
  Keys (Head);
  OutputK(Head);
  readkey;
  closegraph;
end.