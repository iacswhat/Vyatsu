unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, math;

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
    Label5: TLabel;
    PaintBox1: TPaintBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  x1,x2,y1,y2,x,t1,t2,yy,y0: integer;
  m,y,u,x0: real;
implementation

{$R *.lfm}



{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  form1.Repaint;
  Form1.Label5.Caption:='';
    x1:= strtoint(Edit1.Text);
    y1:= strtoint(Edit2.Text);
    x2:= strtoint(Edit3.Text);
    y2:= strtoint(Edit4.Text);

  if x1>x2 then
  begin
  t1:=x1;
  x1:=x2;
  x2:=t1;

  t2:=y1;
  y1:=y2;
  y2:=t2;
  end;

    if x1 <> x2 then
    begin
      m:=(y2-y1)/(x2-x1);
      y:=y1;
    for x:=x1 to x2 do
    begin
    sleep(1);
      Form1.PaintBox1.Canvas.Pixels[x,Round(y)]:= ClBlack;
      y:=y + m;
    end;
    end
    else
    if y1 = y2 then
    begin
    sleep(1);
    Form1.PaintBox1.Canvas.Pixels[x1,y1]:=ClBlack;
    end
    else
      Label5.Caption:='Вертикаль';
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  r:integer;
begin
  form1.Repaint;
  r:=450;
  u:=0;
  While u<2*pi do
  begin

  x1:= 900;
  y1:= 500;

  x2:=x1+round(r*cos(u));
  y2:=y1-round(r*sin(u));

  {if x1>x2 then
  begin
  t1:=x1;
  x1:=x2;
  x2:=t1;

  t2:=y1;
  y1:=y2;
  y2:=t2;
  end;}

  if x1 <> x2 then
  begin
    m:=(y2-y1)/(x2-x1);
    if (abs(m)<=1)  then
    begin

    if x1>x2 then
    begin
    t1:=x1;
    x1:=x2;
    x2:=t1;

    t2:=y1;
    y1:=y2;
    y2:=t2;
    end;

    y:=y1;
  for x:=x1 to x2 do
  begin
  //sleep(1);
    Form1.PaintBox1.Canvas.Pixels[x,Round(y)]:= ClBlack;
    y:=y + m;
    end;
    end;

    if (abs(m)>1) then
    begin

    if y1>y2 then
    begin
    t1:=x1;
    x1:=x2;
    x2:=t1;

    t2:=y1;
    y1:=y2;
    y2:=t2;
    end;

    x0:=x1;
    for y0:=y1 to y2 do
    begin
      Form1.PaintBox1.Canvas.Pixels[Round(x0),y0]:= ClBlack;
      x0:=x0+1/m;
    end;
    end;


  end
  else
  if y1 = y2 then
  begin
  //sleep(1);
  Form1.PaintBox1.Canvas.Pixels[x1,y1]:=ClBlack;
  end
  else
  if x1 = x2 then
    begin
      for yy:=y1+r downto y1-r do
      begin
      //sleep(1);
      Form1.PaintBox1.Canvas.Pixels[x1,yy]:=ClBlack;
      end;
    end;

  u:=u+pi/12;
end;
end;

end.

