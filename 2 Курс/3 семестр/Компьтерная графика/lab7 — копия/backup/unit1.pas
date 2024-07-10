unit Unit1;

{$mode objfpc}{$H+}

interface

uses
Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
ExtCtrls;

type
TXYZ=record
x,y,z:real;
end;
tcub=record
x,y,z:real;
end;
TXY=record
x,y:integer;
end;
{ TForm1 }

TForm1 = class(TForm)
Button1: TButton;
Button10: TButton;
Button11: TButton;
Button13: TButton;
Button14: TButton;
Button15: TButton;
Button16: TButton;
Button17: TButton;
Button2: TButton;
Button3: TButton;
Button4: TButton;
Button5: TButton;
Button6: TButton;
Button7: TButton;
Button8: TButton;
Button9: TButton;
Label1: TLabel;
Label2: TLabel;
Label3: TLabel;
Label4: TLabel;
Label5: TLabel;
Label6: TLabel;
Timer1: TTimer;
procedure Button10Click(Sender: TObject);
procedure Button11Click(Sender: TObject);
procedure Button13Click(Sender: TObject);
procedure Button14Click(Sender: TObject);
procedure Button1Click(Sender: TObject);
procedure Button2Click(Sender: TObject);
procedure Button3Click(Sender: TObject);
procedure Button4Click(Sender: TObject);
procedure Button5Click(Sender: TObject);
procedure Button6Click(Sender: TObject);
procedure Button7Click(Sender: TObject);
procedure Button8Click(Sender: TObject);
procedure Button9Click(Sender: TObject);
procedure Button15Click(Sender: TObject);
procedure Button16Click(Sender: TObject);
procedure Button17Click(Sender: TObject);
procedure FormCreate(Sender: TObject);
private
{ private declarations }
public
procedure draw;
procedure helper;
procedure move(dx,dy,dz:integer);
procedure proections(k, p: real);
procedure Rast(kx,ky,kz:real);
procedure simetrXOY(a:integer);
procedure simetrXOZ(a:integer);
procedure simetrYOZ(a:integer);
procedure povorot(per:string; q:real);
{ public declarations }
end;
Const p=45;f=35.264;

var
ll:integer;
Form1: TForm1;
q:real;
i1,i2: integer;
xx,xy,xz,i:integer;
v1:array [0..7] of TXY;
help,temp:array[0..7] of TXYZ;
v:array[0..7] of TXYZ;
implementation

{$R *.lfm}

procedure TForm1.draw;
begin
with Canvas do
begin
Pen.Color:=clBlack;
Pen.Width:=1;
MoveTo(v1[0].x + xx, v1[0].y + xy);
LineTo(v1[1].x + xx, v1[1].y + xy);
MoveTo(v1[1].x + xx, v1[1].y + xy);
LineTo(v1[2].x + xx, v1[2].y + xy);
MoveTo(v1[2].x + xx, v1[2].y + xy);
LineTo(v1[3].x + xx, v1[3].y + xy);
MoveTo(v1[3].x + xx, v1[3].y + xy);
LineTo(v1[4].x + xx, v1[4].y + xy);
MoveTo(v1[4].x + xx, v1[4].y + xy);
LineTo(v1[5].x + xx, v1[5].y + xy);
MoveTo(v1[5].x + xx, v1[5].y + xy);
LineTo(v1[6].x + xx, v1[6].y + xy);
MoveTo(v1[6].x + xx, v1[6].y + xy);
LineTo(v1[7].x + xx, v1[7].y + xy);
MoveTo(v1[7].x + xx, v1[7].y + xy);
LineTo(v1[0].x + xx, v1[0].y + xy);
MoveTo(v1[0].x + xx, v1[0].y + xy);
LineTo(v1[3].x + xx, v1[3].y + xy);
MoveTo(v1[2].x + xx, v1[2].y + xy);
LineTo(v1[5].x + xx, v1[5].y + xy);
MoveTo(v1[1].x + xx, v1[1].y + xy);
LineTo(v1[6].x + xx, v1[6].y + xy);
MoveTo(v1[4].x + xx, v1[4].y + xy);
LineTo(v1[7].x + xx, v1[7].y + xy);
end;

end;

procedure TForm1.helper;
begin
for i:=0 to 7 do begin
help[i].x:=v[i].x;
help[i].y:=v[i].y;
help[i].z:=v[i].z;
end;
end;

procedure TForm1.move(dx,dy,dz:integer);
begin
for i:=0 to 7 do begin
v[i].x:=v[i].x+dx;
v[i].y:=v[i].y+dy;
v[i].z:=v[i].z+dz;
end;
proections(p*Pi/180,f*Pi/180);
end;

procedure TForm1.proections(k, p: real);
begin
for i:=0 to 7 do begin
v1[i].x:=round(V[i].x*cos(p)+V[i].z*sin(p));
v1[i].y:=round(V[i].x*sin(k)*sin(p)+V[i].y*cos(k) - V[i].z*sin(k)*cos(p));
end;
end;

procedure TForm1.Rast(kx,ky,kz:real);
begin
for i:=0 to 7 do begin
v[i].x:=round(v[i].x*kx);
v[i].y:=round(v[i].y*ky);
v[i].z:=round(v[i].z*kz);
end;
end;

procedure TForm1.simetrXOY(a:integer);
begin
for i:=0 to 7 do begin
v[i].x:=v[i].x;
v[i].y:=v[i].y;
v[i].z:=-v[i].z;
end;
end;

procedure TForm1.simetrXOZ(a:integer);
begin
for i:=0 to 7 do begin
v[i].x:=v[i].x;
v[i].y:=-v[i].y;
v[i].z:=v[i].z;
end;
end;

procedure TForm1.simetrYOZ(a:integer);
begin
for i:=0 to 7 do begin
v[i].x:=-v[i].x;
v[i].y:=v[i].y;
v[i].z:=v[i].z;
end;
end;



procedure TForm1.povorot(per:string; q:real);
begin
case per of
'ox':begin
helper;
for i:=0 to 7 do begin
v[i].x:=help[i].x;
v[i].y:=help[i].y*Cos(q)-help[i].z*Sin(q) ;
v[i].z:=help[i].y*Sin(q)+help[i].z*Cos(q);
end;
end;
'oy':begin
helper;
for i:=0 to 7 do begin
v[i].x:=help[i].x*Cos(q)-help[i].y*Sin(q) ;
v[i].y:=help[i].x*Sin(q)+help[i].y*Cos(q) ;
v[i].z:=help[i].z;
end;
end;
'oz':begin
helper;
for i:=0 to 7 do begin
v[i].x:=help[i].x*Cos(q)+help[i].z*Sin(q) ;
v[i].y:=help[i].y;
v[i].z:=-help[i].x*Sin(q)+help[i].z*Cos(q) ;
end;
end;
end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
i1:=0;
i2:=0;
Canvas.Brush.Color:=clWhite;
Canvas.FillRect(150, 0, 1920, 1080);
v[0].x:= -100; v[0].y:= -150; v[0].z:= 0;
v[1].x:= -100; v[1].y:= 0; v[1].z:= 0;
v[2].x:= 0; v[2].y:= 0; v[2].z:= 0;
v[3].x:= 0; v[3].y:= -150; v[3].z:= 0;
v[4].x:= 0; v[4].y:= -150; v[4].z:= 200;
v[5].x:= 0; v[5].y:= 0; v[5].z:= 200;
v[6].x:= -100; v[6].y:= 0; v[6].z:= 200;
v[7].x:= -100; v[7].y:= -150; v[7].z:= 200;
xx:=1110; xy:=500;
proections(p*Pi/180,f*Pi/180);
Canvas.Pen.Color:=clBlack;
Canvas.Pen.Width:=1;
draw;

end;

//сдвиг
procedure TForm1.Button2Click(Sender: TObject);
begin
Canvas.Brush.Color:=clWhite;
Canvas.FillRect(150, 0, 1920, 1080);
Canvas.Pen.Color:=clBlack;
move(5,0,0);
draw;
end;

procedure TForm1.Button15Click(Sender: TObject);
begin
Canvas.Brush.Color:=clWhite;
Canvas.FillRect(150, 0, 1920, 1080);
Canvas.Pen.Color:=clBlack;
move(-5,0,0);
draw;
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
Canvas.Brush.Color:=clWhite;
Canvas.FillRect(150, 0, 1920, 1080);
Canvas.Pen.Color:=clBlack;
move(0,5,0);
draw;
end;

procedure TForm1.Button16Click(Sender: TObject);
begin
Canvas.Brush.Color:=clWhite;
Canvas.FillRect(150, 0, 1920, 1080);
Canvas.Pen.Color:=clBlack;
move(0,-5,0);
draw;
end;

procedure TForm1.Button14Click(Sender: TObject);
begin
Canvas.Brush.Color:=clWhite;
Canvas.FillRect(150, 0, 1920, 1080);
Canvas.Pen.Color:=clBlack;
move(0,0,5);
draw;
end;

procedure TForm1.Button17Click(Sender: TObject);
begin
Canvas.Brush.Color:=clWhite;
Canvas.FillRect(150, 0, 1920, 1080);
Canvas.Pen.Color:=clBlack;
move(0,0,-5);
draw;
end;

//отражение
procedure TForm1.Button3Click(Sender: TObject);
begin
ll:=1;
simetrXOY(1);

Canvas.Brush.Color:=clWhite;
Canvas.FillRect(150, 0, 1920, 1080);
proections(p*Pi/180,f*Pi/180);


Canvas.Brush.Color:=clWhite;
Canvas.FillRect(150, 0, 1920, 1080);
draw;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
simetrXOZ(1);

Canvas.Brush.Color:=clWhite;
Canvas.FillRect(150, 0, 1920, 1080);
proections(p*Pi/180,f*Pi/180);

Canvas.Brush.Color:=clWhite;
Canvas.FillRect(150, 0, 1920, 1080);
draw;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
simetrYOZ(1);

Canvas.Brush.Color:=clWhite;
Canvas.FillRect(150, 0, 1920, 1080);

proections(p*Pi/180,f*Pi/180);
Canvas.Brush.Color:=clWhite;
Canvas.FillRect(150, 0, 1920, 1080);
draw;
end;

//растяжение
procedure TForm1.Button6Click(Sender: TObject);
begin
if i1<10 then  begin
Canvas.Brush.Color:=clWhite;
Canvas.FillRect(150, 0, 1920, 1080);
Canvas.Pen.Color:=clBlack;
Rast(1.1,1.1,1.1);
proections(p*Pi/180,f*Pi/180);
Canvas.Brush.Color:=clWhite;
Canvas.FillRect(150, 0, 1920, 1080);
draw;
i1:=i1+1;
i2:=i2-1;
end;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
if i2<10 then  begin
Canvas.Brush.Color:=clWhite;
Canvas.FillRect(150, 0, 1920, 1080);
Canvas.Pen.Color:=clBlack;
Rast(0.9,0.9,0.9);
proections(p*Pi/180,f*Pi/180);
Canvas.Brush.Color:=clWhite;
Canvas.FillRect(150, 0, 1920, 1080);
draw;
i1:=i1-1;
i2:=i2+1;
end;
end;

//поворот
procedure TForm1.Button8Click(Sender: TObject);
begin
q:=pi/180;
Canvas.Brush.Color:=clWhite;
Canvas.FillRect(150, 0, 1920, 1080);
povorot('ox',q);
proections(p*Pi/180,f*Pi/180);
Canvas.Pen.Color:=clRed;
draw;
Canvas.Pen.Color:=clred;
draw;
end;

procedure TForm1.Button9Click(Sender:TObject);
begin
q:=pi/180;
Canvas.Brush.Color:=clWhite;
Canvas.FillRect(150, 0, 1920, 1080);
povorot('oy',q);
proections(p*Pi/180,f*Pi/180);
Canvas.Pen.Color:=clRed;
draw;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
q:=pi/180;
Canvas.Brush.Color:=clWhite;
Canvas.FillRect(150, 0, 1920, 1080);
povorot('oz',q);
proections(p*Pi/180,f*Pi/180);
Canvas.Pen.Color:=clRed;
draw;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
ll:=0;
end;

procedure TForm1.Button11Click(Sender: TObject);
var i: integer;
begin
q:=pi/180;
i:=1;
while i<=1080 do begin
sleep(1);
if i <=360  then Form1.Button10.Click;
if (i > 360) and (i <= 720) then Form1.Button9.Click;
if (i > 720) and (i <= 1080) then Form1.Button8.Click;
i:=i+1;
end;
q:=pi/180;
i:=1;
while i<=1080 do begin
sleep(1);
if i <=360  then Form1.Button10.Click;
if (i > 360) and (i <= 720) then Form1.Button9.Click;
if (i > 720) and (i <= 1080) then Form1.Button8.Click;
i:=i+1;
end;
end;


end.

