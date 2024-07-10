unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    PaintBox1: TPaintBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

type z = record
     x,y:integer;
     end;

var
  Form1: TForm1;
  m: integer;
  xn,yn,i,j: integer;
  step,t: real;

  p,r: array [1..3] of z;



implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  k:integer;

begin
  {m:=3;
  t := 0;
  step := 0.01;
  paintbox1.Canvas.Brush.Color := clWhite;
  paintbox1.Canvas.FillRect(0,0,paintbox1.Width,paintbox1.Height);

  for i:=0 to 2 do
  begin
  p[i].x := random(600)+1;
  p[i].y := random(600)+1;
  end;

  paintbox1.Canvas.Pen.Color := clRed;
  paintbox1.Canvas.Pen.Width := 3;
  for i:=0 to 1 do
  begin
  paintbox1.Canvas.Line(a[i].x,a[i].y,a[i+1].x,a[i+1].y);
  end;

  paintbox1.Canvas.Pen.Color := clBlack;
  paintbox1.Canvas.Pen.Width := 1;
  paintbox1.Canvas.Pen.Style := pssolid;

  //xn := P[0].x;
  //yn := P[0].y;
  for k:=0 to 2 do
  begin
  xn := P[0].x;
  yn := P[0].y;
  while t < 1 do
  begin
    r:=p;
    for j:=m downto 2 do
    for i:=1 to (j-1) do
    begin
      R[i].x := R[i].x + round(t * (R[i + 1].x-R[i].x));
      R[i].y := R[i].y + round(t*(R[i + 1].y-R[i].y));
    end;
    Form1.PaintBox1.Canvas.Line(xn,yn,R[1].x,R[1].y);
    t:=t+step;
    xn:=R[k].x;
    yn:=R[k].y;
  end;
  end;}
end;

procedure TForm1.FormCreate(Sender: TObject);
  var
  t: real;
  i,j: integer;
begin
  randomize;
  t := 0;
  step:=0.01;
  paintbox1.Canvas.Brush.Color := clWhite;
  paintbox1.Canvas.FillRect(0,0,paintbox1.Width,paintbox1.Height);

    {p[1].y := random(850)+1;
    p[2].y := random(850)+1;
    p[3].y := random(850)+1;

    while (abs(p[1].y - p[2].y) < 300) and
          (abs(p[3].y - p[2].y) < 300) do
          begin
    p[1].x := random(1500)+1;
    p[1].y := random(850)+1;
    while (p[1].x > 640) do
      begin
        p[1].x := random(1500)+1;
        p[1].y := random(850)+1;
      end;

    p[2].x := random(1500)+1;
    p[2].y := random(850)+1;
    while (p[2].x <= 640) and (p[2].x > 1280) do
      begin
        p[2].x := random(1500)+1;
        p[2].y := random(850)+1;
      end;

    p[3].x := random(1500)+1;
    p[3].y := random(850)+1;
    while (p[3].x <= 1280) do
      begin
        p[3].x := random(1500)+1;
        p[3].y := random(850)+1;
      end;
      end;}

  m:=3;
  p[1].x :=400; p[1].y :=800;
  p[2].x :=600; p[2].y :=400;
  p[3].x :=900; p[3].y :=400;
  //p[4].x :=600; p[4].y :=100;
  paintbox1.Canvas.Pen.Color := clRed;
  paintbox1.Canvas.Pen.Width := 3;
  paintbox1.Canvas.Pen.Style := pssolid;
  for i:=1 to 2 do
  begin
  paintbox1.Canvas.Line(p[i].x,p[i].y,p[i+1].x,p[i+1].y);
  end;


  paintbox1.Canvas.Pen.Color := clBlack;
  paintbox1.Canvas.Pen.Width := 1;
  paintbox1.Canvas.Pen.Style := pssolid;

  xn:=p[1].x; yn:=p[1].y;
  t := 0;
  step:=0.01;
  while t < 1 do

    begin
    r:=p;

      for j:=m downto 2 do
      for i := 1 to (j-1) do
      begin
        r[i].x := r[i].x + round(t * (r[i + 1].x - r[i].x));
        r[i].y := r[i].y + round(t * (r[i + 1].y - r[i].y));
      end;

      paintbox1.Canvas.Line(xn,yn,r[2].x,r[2].y);

      t := t + step;
      xn:=r[1].x; yn:=r[1].y;
      sleep(1);
    end;

end;

end.

