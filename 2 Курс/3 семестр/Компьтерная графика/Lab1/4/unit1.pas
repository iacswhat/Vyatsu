unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    PaintBox1: TPaintBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  x1,x2,y1,y2,x,y,dx,dy,s1,s2,i,e,t,r: integer;
  f: boolean;
  u:real;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.PaintBox1Click(Sender: TObject);
begin

end;

function sign(a:integer):integer;
begin
  if a < 0 then sign:=-1 else sign:= 1;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  repaint;
  x1:=strtoint(Edit1.Text);
  y1:=strtoint(Edit2.Text);
  x2:=strtoint(Edit3.Text);
  y2:=strtoint(Edit4.Text);

  x:=x1;
  y:=y1;
  dx:=abs(x2-x1);
  dy:=abs(y2-y1);
  s1:=sign(x2-x1);
  s2:=sign(y2-y1);

  if dy < dx then f:= false
  else
    begin
      t:=dx;
      dx:=dy;
      dy:=t;
      f:=true;
    end;

  e:=2*dy-dx;

  for i:=1 to (dx+dy) do
  begin
    Form1.PaintBox1.Canvas.Pixels[x,y]:=ClBlack;
    if e<0 then
    begin
      if f then y:=y+s2 else x:=x+s1;
      e:=e+2*dy;
    end
    else
    begin
      if f then x:=x+s1 else y:=y+s2;
      e:=e-2*dx;
    end;
  end;
  Form1.PaintBox1.Canvas.Pixels[x,y]:=ClBlack;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  u:=0;
  r:=200;

  while u<2*pi do
  begin
  x1:=900;
  y1:=500;

  x2:=x1+round(r*cos(u));
  y2:=y1-round(r*sin(u));

  x:=x1;
  y:=y1;
  dx:=abs(x2-x1);
  dy:=abs(y2-y1);
  s1:=sign(x2-x1);
  s2:=sign(y2-y1);

  if dy < dx then f:= false
  else
    begin
      t:=dx;
      dx:=dy;
      dy:=t;
      f:=true;
    end;

  e:=2*dy-dx;

  for i:=1 to (dx+dy) do
  begin
    Form1.PaintBox1.Canvas.Pixels[x,y]:=ClBlack;
    if e<0 then
    begin
      if f then y:=y+s2 else x:=x+s1;
      e:=e+2*dy;
    end
    else
    begin
      if f then x:=x+s1 else y:=y+s2;
      e:=e-2*dx;
    end;
  end;
  Form1.PaintBox1.Canvas.Pixels[x,y]:=ClBlack;
  u:=u+pi/12;
  end;
end;

end.

