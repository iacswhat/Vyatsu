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
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  b:tbitmap;
  i:integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  i,j,count:integer;
begin
  {count:=0;
  b:=tbitmap.Create;
  b.LoadFromFile('C:\Users\Кирилл\Desktop\День 1\Новая папка\task1.bmp');
  for i:=1 to b.Width-1 do
  for j:=1 to b.Height-1 do
  if b.Canvas.Pixels[i,j]=clBlack then inc(count);
  b.Free;
  Caption:=IntToStr(count div 400)};
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i,j,count:integer;
begin
  {count:=0;
  b:=tbitmap.Create;
  b.LoadFromFile('C:\Users\Кирилл\Desktop\День 1\Новая папка\task1.bmp');
  for i:=1 to b.Width-1 do
  for j:=1 to b.Height-1 do
  if (b.Canvas.Pixels[i,j]=clBlack) and (b.Canvas.Pixels[i+20,j]=clBlack) and
  (b.Canvas.Pixels[i,j+20]=clBlack) and (b.Canvas.Pixels[i+20,j+20]=clBlack) then
  inc(count);


  b.Free;
  Caption:=IntToStr(count);}
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 i:=0;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
  inc(i);
  Form1.Caption:=inttostr(i);
  Form1.Canvas.DrawPixel(mouse.CursorPos.X,mouse.CursorPos.y,tcolortofpcolor(CLWhite));

end;

end.

