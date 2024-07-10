unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    PaintBox1: TPaintBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function kod(x,y,xf,yf,xd,yd:integer):byte;
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1Paint(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  xa,ya,xb,yb: integer; //прямоугольник
  x1,y1,x2,y2, x11,y11,x22,y22: integer;   // отрезок
  p1,p2, p11,p22: integer;
  f: boolean=true;
    f1: boolean;
  c:integer = 1;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
label l1;
label 22;
  var x,y: integer;

begin

paintbox1.Canvas.Brush.Color := clwindow;
paintbox1.Canvas.FillRect(0,0,paintbox1.Width,paintbox1.Height);
paintbox1.Canvas.Pen.Color := clblack;
//paintbox1.Canvas.Pen.width := 2;
paintbox1.Canvas.Rectangle(xa,ya,xb,yb);
paintbox1.Canvas.Pen.width := 1;
l1:
p1:=kod(x1,y1,xa,ya,xb,yb);
p2:=kod(x2,y2,xa,ya,xb,yb);
//p11:=kod(x11,y11,xa,ya,xb,yb);
//p22:=kod(x22,y22,xa,ya,xb,yb);
if (p1 and p2<>0) then
exit
else
if (p1 = 0) and (p2 = 0) then begin
paintbox1.Canvas.Brush.Color := clwindow;
paintbox1.Canvas.FillRect(0,0,paintbox1.Width,paintbox1.Height);
paintbox1.Canvas.Pen.Color := clblack;
//paintbox1.Canvas.Pen.width := 2;
paintbox1.Canvas.Rectangle(xa,ya,xb,yb);
paintbox1.Canvas.Pen.Color := clblack;
paintbox1.Canvas.Pen.width := 1;
paintbox1.canvas.line(x1,y1,x2,y2);
//paintbox1.canvas.line(x11,y11,x22,y22);
exit
end
else
if (p1=0) then
begin
x:=x1;
x1:=x2;
x2:=x;
y:=y1;
y1:=y2;
y2:=y;
p1:=p2;
end;
if((p1=1)or(p1=9)or(p1=3))then begin
y1:=(y1+(y2-y1)*(xa-x1)div(x2-x1));
x1:=xa;
end;
if ((p1=2)or(p1=9)or(p1=6))then
begin
x1:=(x1+(x2-x1)*(ya-y1)div(y2-y1));
y1:=ya;
end;
if(p1=4)or(p1=6)or(p1=12) then
begin
  y1:=(y1+(y2-y1)*(xb-x1)div(x2-x1));
  x1:=xb;
  end;
if (p1=8)or(p1=9)or(p1=12) then
begin
x1:=(x1+(x2-x1)*(yb-y1)div(y2-y1));
y1:=yb
end;


{if (p11=0) then
begin
x:=x11;
x11:=x22;
x22:=x;
y:=y11;
y11:=y22;
y22:=y;
p11:=p22;
end;
if((p11=1)or(p11=9)or(p11=3))then begin
y11:=(y11+(y22-y11)*(xa-x11)div(x22-x11));
x11:=xa;
end;
if ((p11=2)or(p11=9)or(p11=6))then
begin
x11:=(x11+(x22-x11)*(ya-y11)div(y22-y11));
y11:=ya;
end;
if(p11=4)or(p11=6)or(p11=12) then
begin
  y11:=(y11+(y22-y11)*(xb-x11)div(x22-x11));
  x11:=xb;
  end;
if (p11=8)or(p11=9)or(p11=12) then
begin
x11:=(x11+(x22-x11)*(yb-y11)div(y22-y11));
y11:=yb
end; }


goto l1;


{22:
p11:=kod(x11,y11,xa,ya,xb,yb);
p22:=kod(x22,y22,xa,ya,xb,yb);
if (p11 and p22<>0) then
exit
else
if (p11 = 0) and (p22 = 0) then begin
paintbox1.Canvas.Pen.Color := clblack;
paintbox1.canvas.line(x11,y11,x22,y22);
exit
end
else
if (p11=0) then
begin
x:=x11;
x11:=x22;
x22:=x;
y:=y11;
y11:=y22;
y22:=y;
p11:=p22;
end;
if((p11=1)or(p11=9)or(p11=3))then begin
y11:=(y11+(y22-y11)*(xa-x11)div(x22-x11));
x11:=xa;
end;
if ((p11=2)or(p11=9)or(p11=6))then
begin
x11:=(x11+(x22-x11)*(ya-y11)div(y22-y11));
y11:=ya;
end;
if(p11=4)or(p11=6)or(p11=12) then
begin
  y11:=(y11+(y22-y11)*(xb-x11)div(x22-x11));
  x11:=xb;
  end;
if (p11=8)or(p11=9)or(p11=12) then
begin
x11:=(x11+(x22-x11)*(yb-y11)div(y22-y11));
y11:=yb
end;
goto 22;}
end;


function Tform1.kod(x,y,xf,yf,xd,yd:integer):byte;
var kp:byte;
begin
kp:=0;
if x<xf then kp:=kp or $01;
if y<yf then kp:=kp or $02;
if x>xd then kp:=kp or $04;
if y>yd then kp:=kp or $08;
kod:=kp
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin
  if c = 1 then begin
  x1:=x;
  y1:=y;
  paintbox1.Canvas.MoveTo(x,y);
  end
  else
  if c = 2 then begin
  x11:=x;
  y11:=y;
  paintbox1.Canvas.MoveTo(x,y);
  end;
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if c = 1 then begin
  x2:=x;
  y2:=y;
  paintbox1.Canvas.Pen.Color := clblack;
  paintbox1.Canvas.LineTo(x,y);
  inc(c);
  end
  else
  {if c = 2 then begin
  x22:=x;
  y22:=y;
  paintbox1.Canvas.Pen.Color := clblack;
  paintbox1.Canvas.LineTo(x,y);
  inc(c);
  end }
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
paintbox1.Canvas.Brush.Color := clwindow;
paintbox1.Canvas.FillRect(0,0,paintbox1.Width,paintbox1.Height);
paintbox1.Canvas.Pen.Color := clblack;
//paintbox1.Canvas.Pen.width := 2;
paintbox1.Canvas.Rectangle(xa,ya,xb,yb);
paintbox1.Canvas.Pen.Color := clblack;
paintbox1.Canvas.Pen.width := 1;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
paintbox1.Canvas.Brush.Color := clwindow;
paintbox1.Canvas.FillRect(0,0,paintbox1.Width,paintbox1.Height);
paintbox1.Canvas.Pen.Color := clblack;
//paintbox1.Canvas.Pen.width := 2;
paintbox1.Canvas.Rectangle(xa,ya,xb,yb);
randomize;
x1:=random(400)+50;
x2:=random(400)+50;
y1:=random(400)+50;
y2:=random(400)+50;
{x11:=random(400)+50;
x22:=random(400)+50;
y11:=random(400)+50;
y22:=random(400)+50;}
paintbox1.Canvas.Pen.Color := clBlack;
paintbox1.Canvas.Pen.width := 1;
paintbox1.canvas.line(x1,y1,x2,y2);
//paintbox1.canvas.line(x11,y11,x22,y22);

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
paintbox1.Canvas.Brush.Color := clwindow;
paintbox1.Canvas.FillRect(0,0,paintbox1.Width,paintbox1.Height);
paintbox1.Canvas.Pen.Color := clblack;
//paintbox1.Canvas.Pen.width := 2;
paintbox1.Canvas.Rectangle(xa,ya,xb,yb);
paintbox1.Canvas.Pen.width := 1;
x1:=0;
y1:=0;
x2:=0;
y2:=0;
x11:=0;
y11:=0;
x22:=0;
y22:=0;
c:=1;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
xa:=200;
ya:=100;
xb:=500;
yb:=400;
end;


end.


