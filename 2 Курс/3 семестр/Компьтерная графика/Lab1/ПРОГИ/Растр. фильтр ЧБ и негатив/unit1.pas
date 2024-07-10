unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, Windows;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Image1: TImage;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    Function RGBtoGray(RGBColor: TColor): TColor;
    Function negative(RGBColor: TColor): TColor;
    Function RGBToWB(RGBColor: TColor): TColor;
    Function RGBToRED(RGBColor: TColor): TColor;
    Function RGBToGREEN(RGBColor: TColor): TColor;
    Function RGBToBLUE(RGBColor: TColor): TColor;
  private

  public

  end;

var
  Form1: TForm1;


implementation

{$R *.lfm}

Function TForm1.RGBToGray(RGBColor: TColor): TColor;
var
  gray: byte;

begin
  Gray:=Round((0.30*GetRValue(RGBColor))+(0.59*GetGValue(RGBColor))+(0.11*GetBValue(RGBColor)));
  Result:=RGB(Gray, Gray, Gray);
end;

Function TForm1.negative(RGBColor: TColor): TColor;
var
  r,g,b: byte;

begin
  r:=255-getrvalue(rgbcolor);
  g:=255-getgvalue(rgbcolor);
  b:=255-getbvalue(rgbcolor);
  result:= rgb(r,g,b);
end;

procedure TForm1.Button1Click(Sender: TObject);
var i,j: integer;

    c,d: TColor;

begin
  for i:=Image1.Left to Image1.Left+Image1.Width do
  for j:=Image1.Top to Image1.Top+Image1.Height do
  begin
    c:=Image1.Picture.Bitmap.Canvas.Pixels[i-Image1.Left,j-Image1.Top];
    d:=RgbToWB(c);
    Image1.Picture.Bitmap.Canvas.Pixels[i-Image1.Left,j-Image1.Top]:=d;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
    filename: string;
begin
  opendialog1.Execute;
  filename:= opendialog1.FileName;
  image1.Picture.LoadFromFile(filename);

end;

procedure TForm1.Button3Click(Sender: TObject);
var i,j: integer;

    c,d: TColor;

    begin
      for i:=Image1.Left to Image1.Left+Image1.Width do
      for j:=Image1.Top to +Image1.Top+Image1.Height do
      begin
        c:=Image1.Picture.Bitmap.Canvas.Pixels[i-Image1.Left,j-Image1.Top];
        d:=negative(c);
        Image1.Picture.Bitmap.Canvas.Pixels[i-Image1.Left,j-Image1.Top]:=d;
      end;
    end;

procedure TForm1.Button4Click(Sender: TObject);
var i,j: integer;

    c,d: TColor;

    begin
      for i:=Image1.Left to Image1.Left+Image1.Width do
      for j:=Image1.Top to +Image1.Top+Image1.Height do
      begin
        c:=Image1.Picture.Bitmap.Canvas.Pixels[i-Image1.Left,j-Image1.Top];
        d:=RGBtoGray(c);
        Image1.Picture.Bitmap.Canvas.Pixels[i-Image1.Left,j-Image1.Top]:=d;
      end;
    end;

procedure TForm1.Button5Click(Sender: TObject);
var i,j: integer;

    c,d: TColor;

    begin
      for i:=Image1.Left to Image1.Left+Image1.Width do
      for j:=Image1.Top to +Image1.Top+Image1.Height do
      begin
        c:=Image1.Picture.Bitmap.Canvas.Pixels[i-Image1.Left,j-Image1.Top];
        d:=RGBtoRED(c);
        Image1.Picture.Bitmap.Canvas.Pixels[i-Image1.Left,j-Image1.Top]:=d;
      end;
    end;

procedure TForm1.Button6Click(Sender: TObject);
var i,j: integer;

    c,d: TColor;

    begin
      for i:=Image1.Left to Image1.Left+Image1.Width do
      for j:=Image1.Top to +Image1.Top+Image1.Height do
      begin
        c:=Image1.Picture.Bitmap.Canvas.Pixels[i-Image1.Left,j-Image1.Top];
        d:=RGBtoGREEN(c);
        Image1.Picture.Bitmap.Canvas.Pixels[i-Image1.Left,j-Image1.Top]:=d;
      end;
    end;

procedure TForm1.Button7Click(Sender: TObject);
var i,j: integer;

    c,d: TColor;

    begin
      for i:=Image1.Left to Image1.Left+Image1.Width do
      for j:=Image1.Top to +Image1.Top+Image1.Height do
      begin
        c:=Image1.Picture.Bitmap.Canvas.Pixels[i-Image1.Left,j-Image1.Top];
        d:=RGBtoBLUE(c);
        Image1.Picture.Bitmap.Canvas.Pixels[i-Image1.Left,j-Image1.Top]:=d;
      end;
    end;

Function TForm1.RGBToBLUE(RGBColor: TColor): TColor;

var
  r,g,b: byte;

begin
  r:=0;
  g:=0;
  b:=getbvalue(rgbcolor);
  result:= rgb(r,g,b);
end;

Function TForm1.RGBToGREEN(RGBColor: TColor): TColor;

var
  r,g,b: byte;

begin
  r:=0;
  g:=getgvalue(rgbcolor);
  b:=0;
  result:= rgb(r,g,b);
end;


Function TForm1.RGBToRED(RGBColor: TColor): TColor;

var
  r,g,b: byte;

begin
  r:=getrvalue(rgbcolor);
  g:=0;
  b:=0;
  result:= rgb(r,g,b);
end;

Function TForm1.RGBToWB(RGBColor: TColor): TColor;
var
  gray: byte;

begin
  Gray:=Round((0.30*GetRValue(RGBColor))+(0.59*GetGValue(RGBColor))+(0.11*GetBValue(RGBColor)));
  if gray > 128 then Result:=RGB(255, 255, 255) else  Result:=RGB(0, 0, 0);
end;

end.

