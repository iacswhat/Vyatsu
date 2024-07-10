unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type
  xy = record
    x:integer;
    y:integer;
  end;

  stack = array of xy;



  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    PaintBox1: TPaintBox;
    procedure Button1Click(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
  procedure push(a:stack; val: xy);
  procedure pop(a:stack);
  public

  end;

  const
  ColorCount = 12;
  krasas : array[1 .. ColorCount] of integer =
    (clBlack, clMaroon, clGreen, clOlive, clGray, clSilver,
     clRed, clYellow, clBlue, clAqua, clLtGray, clDkGray);

var
  Form1: TForm1;
  s: stack;


implementation

procedure TForm1.push(a:stack; val: xy);
var
  l:integer;
begin
   l:=length(a);
   setlength(a, l+1);
   a[l]:=val;
end;

procedure TForm1.pop(a:stack);
begin
   if length(a) = 0 then exit;
   setlength(a, length(a) - 1);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i:integer;
begin
   randomize;
   with form1.PaintBox1.Canvas do
   begin
   Clear;
   brush.Color:=clWhite;
   fillrect(0,0,500,500);
   Moveto(50,50);
   for i :=1 to 5 do lineto(Random(490)+10,Random(490)+10);
   lineto(50,50);
   ellipse(100,100,200,200);
   end;

end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  colorteg:Tcolor;
  colorz: Tcolor;
  vo: array [1..4] of xy;
  p:xy;
  ii, jj, w, u, v:integer;
begin
  vo[1].x:=0; vo[1].y:=1;
  vo[2].x:=0; vo[2].y:=-1;
  vo[3].x:=-1; vo[3].y:=0;
  vo[4].x:=1; vo[4].y:=0;

  p.x:=x; p.y:=y;

  colorteg:=paintbox1.Canvas.Pixels[x,y];
  colorz:=krasas[random(colorcount)+1];

  push(s,p);

  repeat
    ii:=p.x;
    jj:=p.y;
    for w:=1 to 4 do
    begin
      u:= (ii + vo[w].x)
    end;
  until length(s)<>0;

end;


{$R *.lfm}

end.

