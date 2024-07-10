unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  MMSystem;

type

  { TForm2 }

  TForm2 = class(TForm)
    ControlButton: TButton;
    ExitButton: TButton;
    Sound: TImage;
    StartButton: TButton;
    Title: TLabel;
    procedure ControlButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SoundClick(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;
  pathfile: string;
  f: boolean;


implementation
uses
  unit1, unit3;

{$R *.lfm}

{ TForm2 }

procedure TForm2.ExitButtonClick(Sender: TObject);
begin
  Form2.Close;
end;

procedure TForm2.ControlButtonClick(Sender: TObject);
begin
  Form2.Visible:= False;
  Form3.show;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  pathfile:=ExtractFileDir(Application.ExeName);
  Form2.Sound.Picture.loadfromfile(pathfile + '\pics\SoundOn.bmp');
  sndPlaySound('Menu1.wav', SND_ASYNC or SND_LOOP);
  f:= true;
end;


procedure TForm2.SoundClick(Sender: TObject);
begin
  if f then
  begin
    Form2.Sound.Picture.loadfromfile(pathfile + '\pics\SoundOff.bmp');
    sndPlaySound(nil, SND_ASYNC);
    f:= false;
  end
  else
  begin
    Form2.Sound.Picture.loadfromfile(pathfile + '\pics\SoundOn.bmp');
    sndPlaySound('Menu1.wav', SND_ASYNC or SND_LOOP);
    f:= true;
  end;
end;


procedure TForm2.StartButtonClick(Sender: TObject);
begin
  //sndPlaysound(nil, SND_ASYNC);
  Form2.Visible:= false;
  Form1.Show;
end;

end.

