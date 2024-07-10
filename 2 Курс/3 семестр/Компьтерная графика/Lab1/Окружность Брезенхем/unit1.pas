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
    Label1: TLabel;
    PaintBox1: TPaintBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  x,Rad,e,y: Integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  cx,cy: integer;
begin
  Form1.PaintBox1.Repaint;
  x:=0;
  rad:=strtoint(Form1.Edit1.Text);
  y:=rad;
  e:=3-2*rad;
  cx:=900;
  cy:=500;

  while x<y do
  begin
    Form1.PaintBox1.Canvas.Pixels[x+cx,y+cy]:=ClBlack;
    Form1.PaintBox1.Canvas.Pixels[y+cx,x+cy]:=ClBlack;
    Form1.PaintBox1.Canvas.Pixels[y+cx,-x+cy]:=ClBlack;
    Form1.PaintBox1.Canvas.Pixels[x+cx,-y+cy]:=ClBlack;
    Form1.PaintBox1.Canvas.Pixels[-x+cx,-y+cy]:=ClBlack;
    Form1.PaintBox1.Canvas.Pixels[-y+cx,-x+cy]:=ClBlack;
    Form1.PaintBox1.Canvas.Pixels[-y+cx,x+cy]:=ClBlack;
    Form1.PaintBox1.Canvas.Pixels[-x+cx,y+cy]:=ClBlack;
    if e<0 then
    e:=e+4*x+6
    else
      begin
        e:=e+4*(x-y)+10;
        y:=y-1;
      end;
    x:=x+1;
  end;
  if x=y then
  begin
    Form1.PaintBox1.Canvas.Pixels[x+cx,y+cy]:=ClBlack;
    Form1.PaintBox1.Canvas.Pixels[y+cx,x+cy]:=ClBlack;
    Form1.PaintBox1.Canvas.Pixels[y+cx,-x+cy]:=ClBlack;
    Form1.PaintBox1.Canvas.Pixels[x+cx,-y+cy]:=ClBlack;
    Form1.PaintBox1.Canvas.Pixels[-x+cx,-y+cy]:=ClBlack;
    Form1.PaintBox1.Canvas.Pixels[-y+cx,-x+cy]:=ClBlack;
    Form1.PaintBox1.Canvas.Pixels[-y+cx,x+cy]:=ClBlack;
    Form1.PaintBox1.Canvas.Pixels[-x+cx,y+cy]:=ClBlack;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var  xc,yc,x,y,d1,d2,r: integer;
begin
  Form1.PaintBox1.Repaint;
  xc:=900;
  yc:=500;
x:=0;
r:=strtoint(Form1.Edit1.Text);
y:=r;
while ( x<=round(r/sqrt(2)) ) do begin
Paintbox1.Canvas.Pixels[xc+x,yc+y]:=clBlack;
Paintbox1.Canvas.Pixels[xc+x,yc-y]:=clBlack;
Paintbox1.Canvas.Pixels[xc-x,yc+y]:=clBlack;
Paintbox1.Canvas.Pixels[xc-x,yc-y]:=clBlack;
Paintbox1.Canvas.Pixels[xc+y,yc+x]:=clBlack;
Paintbox1.Canvas.Pixels[xc+y,yc-x]:=clBlack;
Paintbox1.Canvas.Pixels[xc-y,yc+x]:=clBlack;
Paintbox1.Canvas.Pixels[xc-y,yc-x]:=clBlack;
x:=x+1;
d1:=ABS(r*r-x*x-y*y);
d2:=ABS(r*r-x*x-(y-1)*(y-1));
if(d1>d2) then
y:=y-1;
end;
end;

end.

