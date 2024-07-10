unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
   Button10: TButton;
   Button2: TButton;
   Button3: TButton;
   Button4: TButton;
   Button5: TButton;
   Button6: TButton;
   Button7: TButton;
   Button8: TButton;
   Button9: TButton;
   procedure Button1Click(Sender: TObject);
   procedure Button2Click(Sender: TObject);
   procedure Button3Click(Sender: TObject);
   procedure Button4Click(Sender: TObject);
   procedure Button5Click(Sender: TObject);
   procedure Button6Click(Sender: TObject);
   procedure Button7Click(Sender: TObject);
   procedure Button8Click(Sender: TObject);
   procedure Button9Click(Sender: TObject);
   procedure Button10Click(Sender: TObject);
   procedure draw;
   procedure FormCreate(Sender: TObject);
   procedure formul(k,d:real);
   procedure formul2(l:real);
 private
{ private declarations }
public
{ public declarations }
end;

var
Form1: TForm1;

implementation
const o=6; oo = 400;
type

TXYZ=record
x,y,z:integer;
end;
const V:array[1..8] of TXYZ=
((x:-15;y: 25;z: -20), //нижний левый
(x:-15;y: -25;z: -20), //верхний левый
(x:15;y: -25;z: -20),//верхний правый
(x:15;y: 25;z: -20), //нижний правый
(x:15;y: 25;z: 20), //нижний правый
(x:15;y: -25;z: 20), //верхний правый
(x:-15;y: -25;z: 20), //верхний левый
(x:-15;y: 25;z: 20)); //нижний левый

var
v1:array[1..8] of TXYZ;
i,sx,sy:integer;
{$R *.lfm}

{ TForm1 }
procedure Tform1.draw;
begin
form1.Canvas.Pen.Width:=3;
Form1.Canvas.Pen.Color:=clBlack;
Form1.Canvas.Line((v1[1].x+sx)*o+oo,(v1[1].y+sy)*o,(v1[2].x+sx)*o+oo,(v1[2].y+sy)*o);
Form1.Canvas.Pen.Color:=clred;
Form1.Canvas.Line((v1[2].x+sx)*o+oo,(v1[2].y+sy)*o,(v1[3].x+sx)*o+oo,(v1[3].y+sy)*o);
Form1.Canvas.Pen.Color:=clBlue;
Form1.Canvas.Line((v1[3].x+sx)*o+oo,(v1[3].y+sy)*o,(v1[4].x+sx)*o+oo,(v1[4].y+sy)*o);
Form1.Canvas.Pen.Color:=clyellow;
Form1.Canvas.Line((v1[4].x+sx)*o+oo,(v1[4].y+sy)*o,(v1[5].x+sx)*o+oo,(v1[5].y+sy)*o);
Form1.Canvas.Pen.Color:=clgreen;
Form1.Canvas.Line((v1[5].x+sx)*o+oo,(v1[5].y+sy)*o,(v1[6].x+sx)*o+oo,(v1[6].y+sy)*o);
Form1.Canvas.Pen.Color:=cllime;
Form1.Canvas.Line((v1[6].x+sx)*o+oo,(v1[6].y+sy)*o,(v1[7].x+sx)*o+oo,(v1[7].y+sy)*o);
Form1.Canvas.Pen.Color:=clhighlight;
Form1.Canvas.Line((v1[7].x+sx)*o+oo,(v1[7].y+sy)*o,(v1[8].x+sx)*o+oo,(v1[8].y+sy)*o);
Form1.Canvas.Pen.Color:=clmaroon;
Form1.Canvas.Line((v1[8].x+sx)*o+oo,(v1[8].y+sy)*o,(v1[1].x+sx)*o+oo,(v1[1].y+sy)*o);
Form1.Canvas.Pen.Color:=claqua;
Form1.Canvas.Line((v1[1].x+sx)*o+oo,(v1[1].y+sy)*o,(v1[4].x+sx)*o+oo,(v1[4].y+sy)*o);
Form1.Canvas.Pen.Color:=clpurple;
Form1.Canvas.Line((v1[3].x+sx)*o+oo,(v1[3].y+sy)*o,(v1[6].x+sx)*o+oo,(v1[6].y+sy)*o);
Form1.Canvas.Pen.Color:=clfuchsia;
Form1.Canvas.Line((v1[2].x+sx)*o+oo,(v1[2].y+sy)*o,(v1[7].x+sx)*o+oo,(v1[7].y+sy)*o);
Form1.Canvas.Pen.Color:=clnavy;
Form1.Canvas.Line((v1[5].x+sx)*o+oo,(v1[5].y+sy)*o,(v1[8].x+sx)*o+oo,(v1[8].y+sy)*o);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Canvas.FillRect(Canvas.ClipRect);
end;
procedure TForm1.Button10Click(Sender: TObject);//одноточечные
var x,y,z,b:integer;
begin
  Canvas.FillRect(Canvas.ClipRect);
sx:=100;
sy:=80;
b:=200;
for i:=1 to 8 do begin //Для получения проекции точки в пространстве с координатами (x,y,z,1) необходимо найти ее новые однородные, а затем - новые координаты (x'y')
x:=v[i].x;
y:=v[i].y;
z:=v[i].z;
v1[i].x:=round(x/((z/b)+1));
v1[i].y:=round(y/((z/b)+1));
v1[i].z:=0;
end;
draw;
end;

procedure Tform1.formul(k,d:real);
begin
for i:=1 to 8 do begin
v1[i].x:=round(V[i].x*cos(d)+V[i].z*sin(d));
v1[i].y:=round(V[i].x*sin(k)*sin(d)+V[i].y*cos(k)-V[i].z*sin(k)*cos(d));
end;
end;

procedure Tform1.formul2(l:real);
begin
for i:=1 to 8 do
begin
v1[i].x:=round(v[i].x+v[i].z*l*cos(Pi/4)); //pi=3.14159 Для получения координат проекции любой точки изображения необходимо
v1[i].y:=round(v[i].y+v[i].z*l*cos(Pi/4)); //pi=3.14159 исходные координаты этой точки перемножить с соответствующей матрицей.
end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
Canvas.Brush.Color:=form1.Color;
Canvas.FillRect(Canvas.ClipRect);
sx:=100;
sy:=150;
formul(30*Pi/180,50*Pi/180);
Canvas.Pen.Color:=clRed;
draw;
end;

procedure TForm1.Button2Click(Sender: TObject);//Вид спереди(вдоль z)
begin
Canvas.FillRect(Canvas.ClipRect);
sx:=100;
sy:=80;
for i:=1 to 8 do
begin
v1[i].x:=v[i].x; // координата z отбрасывается
v1[i].y:=v[i].y;
end;
draw;
end;

procedure TForm1.Button3Click(Sender: TObject);//Вид сверху(вдоль y)
begin
Canvas.FillRect(Canvas.ClipRect);
sx:=100;
sy:=80;
for i:=1 to 8 do
begin //сверху
v1[i].x:=v[i].x; //x - координата остается без изменения. y - координату заменяют на z
v1[i].y:=v[i].z;
end;
draw;
end;

procedure TForm1.Button7Click(Sender: TObject); //Вид сбоку(вдоль x)
begin
Canvas.FillRect(Canvas.ClipRect);
sx:=100;
sy:=80;
for i:=1 to 8 do
begin
v1[i].x:=v[i].z; //х-координату точки проекции заменяют координатой z. y - координата остается без изменения
v1[i].y:=v[i].y;
end;
draw;
end;

procedure TForm1.Button8Click(Sender: TObject);     //кавалье
var l:real;
begin
Canvas.FillRect(Canvas.ClipRect);
l:=1;
sx:=100;
sy:=80;
formul2(l);
draw;
end;

procedure TForm1.Button9Click(Sender: TObject);     //кабине
var l:real;
begin
Canvas.FillRect(Canvas.ClipRect);
l:=0.5;
sx:=100;
sy:=80;
formul2(l);
draw;
end;

procedure TForm1.Button4Click(Sender: TObject);//изометрия
var p,k:real;
begin
Canvas.FillRect(Canvas.ClipRect);
p:=45; //k и p - углы, которые нормаль к картинной плоскости образует
k:=35.264;
sx:=100;
sy:=80;
formul(p*pi/180,k*pi/180);
draw;
end;

procedure TForm1.Button5Click(Sender: TObject);//диметpия
var p,k:real;
begin
Canvas.FillRect(Canvas.ClipRect);
p:=22.208; //k и p - углы, которые нормаль к картинной плоскости образует
k:=20.705;
sx:=100;
sy:=80;
formul(p*pi/180,k*pi/180);
draw;
end;

procedure TForm1.Button6Click(Sender: TObject);//триметрия
var p,k:real;
begin
Canvas.FillRect(Canvas.ClipRect);
p:=60;//k и p - углы, которые нормаль к картинной плоскости образует
k:=20;
sx:=100;
sy:=80;
formul(p*pi/180,k*pi/180);
draw;
end;
end.
