unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, LCLType,
  StdCtrls, MMSystem;

type

  { TForm1 }

  TForm1 = class(TForm)
    PauseLab: TLabel;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  Buf, Car, Stena, crash: TBitMap;
  path: string;
  steni: array[1..10] of TPoint;
  avto: TPoint;
  new, score, speed, i, YY: integer;
  m, ff: boolean;

implementation

uses
  unit2;

{$R *.lfm}

{ TForm1 }


procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_Left) and (Avto.X > 0) then Avto.X:= Avto.X - 1;
  if (Key = VK_right) and (Avto.X < 2) then Avto.X:= Avto.X + 1;
  if Key = VK_up then
  begin
    if ff then ff:=false else ff:= true;
  end;
  if key = VK_P then
  begin
    if timer1.Enabled then
    begin
      Form1.PauseLab.Visible:=True;
      timer1.Enabled:= False;
      timer2.Enabled:= False
    end
    else
    begin
      Form1.PauseLab.Visible:=False;
      timer1.Enabled:= True;
      timer2.Enabled:= True;
    end;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin

  ff:=false;

  timer1.Enabled:= True;
  Timer2.Enabled:= True;

  path:= ExtractFileDir(Application.ExeName);

  Buf:= TBitmap.Create;
  buf.Width:=384;
  Buf.Height:=640;


  car:=TBitmap.Create;
  Car.TransparentColor:=clWhite;
  Car.Transparent:= True;
  Car.LoadFromFile(path + '\pics\new.bmp');

  Stena:= TBitmap.Create;
  Stena.TransparentColor:=clWhite;
  Stena.Transparent:= True;
  Stena.LoadFromFile(path + '\pics\wall2.bmp');

  crash:=TBitmap.Create;
  Crash.TransparentColor:=clWhite;
  Crash.Transparent:= True;
  Crash.LoadFromFile(path + '\pics\crash1.bmp');

  Avto.X:=1;
  Avto.Y:=4;
  Score:=0;

  new:=0;
  speed:=0;

  For i:=1 to 10 do
  begin
   steni[i].X:=-1;
   steni[i].Y:=-1;
  end;
  if f then
  sndPlaySound('Main1.wav', SND_ASYNC or SND_LOOP);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  bs, j: integer;
begin
  if (speed > 80) and (Timer1.Interval > 10) then
  begin
    speed:= 0;
    Timer1.Interval:= Timer1.Interval - 10;
  end;


  randomize;
  Buf.Canvas.Brush.Color:=clCream;
  Buf.Canvas.Rectangle(0, 0, 384, 640);

  //steni
  for i:= 1 to 10 do
  begin
   if steni[i].X >= 0 then
   begin
     Buf.Canvas.Draw(steni[i].X*128, steni[i].Y, Stena);
     steni[i].Y:= steni[i].Y+16; //!!!!!!!!
     if steni[i].Y > 640 then
     steni[i].X:= -1;
   end;
  end;

  YY:=Avto.Y*128;
  if not ff then
  begin
  Car.LoadFromFile(path + '\pics\new.bmp');
  Buf.Canvas.Draw(Avto.X*128, YY, car);
  end
  else
  begin
    Car.LoadFromFile(path + '\pics\newTurbo.bmp');
    YY:=256;
    Buf.Canvas.Draw(Avto.X*128, YY, car);
    Buf.Canvas.Font.Color:= clBlue;
    Buf.Canvas.Font.Size:=15;
    Buf.Canvas.TextOut(320, 0, 'TURBO');
  end;

  Buf.Canvas.Font.Color:= clBlack;
  Buf.Canvas.Font.Size:=15;
  Buf.Canvas.TextOut(0, 0, 'Score = ' + IntToStr(score));

  Form1.Canvas.StretchDraw(Rect(0, 0, Form1.ClientWidth, Form1.ClientHeight), Buf);

  //pregrady
  inc(new);
  if new >= 15 then
  begin
    m:=false;
    for i:=1 to 10 do
    begin
     if (m = false) and (steni[i].X < 0) then
     begin
       steni[i].X:=Random(3);
       steni[i].Y:=0;
       m:= true;
     end;
    end;
    if not ff then inc(score) else inc(score,5);
    new:=0;
  end;

  //porozhenie
  for i:= 1 to 10 do
  begin
   if ((steni[i].X >= 0) and (avto.X = steni[i].X) and (YY <= Steni[i].Y+32) and (YY > steni[i].Y))
   or ((steni[i].X >= 0) and (avto.X = steni[i].X) and (YY+80 <= Steni[i].Y+32) and (YY+80 > steni[i].Y)) then
   begin

     Buf.Canvas.Draw(avto.X*128+35, YY+27, Crash);
     Form1.Canvas.StretchDraw(Rect(0, 0, Form1.ClientWidth, Form1.ClientHeight), Buf);

     Form1.Timer1.Enabled:= False;
     Form1.Timer2.Enabled:= False;
     if f then
     sndPlaySound('Hit1.wav', SND_ASYNC);
     bs:= MessageDlg('GAME OVER!', mtCustom, [mbRetry, mbCancel], 0);

     if bs = mrRetry then
     begin
       if Timer1.Enabled = False then
       begin

         ff:=false;
         Avto.X:=1;
         Avto.Y:=4;
         YY:= Avto.y*128;
         Score:=0;

         New:=0;
         Speed:=0;
         Timer1.Interval:= 100;
         Timer2.Interval:= 80;

         for j:=1 to 10 do
         begin
           steni[j].X:= -1;
           steni[j].Y:= -1;
         end;
         Timer1.Enabled:= True;
         Timer2.Enabled:= True;
         if f then
         sndPlaySound('Main1.wav', SND_ASYNC or SND_LOOP);
         end;
     end;

     if bs = mrCancel then
     begin
       ff:=false;
       Timer1.Interval:= 100;
       Form1.Close;
       Form2.Visible:= True;
       if f then
       sndPlaySound('Menu1.wav', SND_ASYNC or SND_LOOP);
     end;
   end;
  end;

end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  inc(speed);
end;

end.

