unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ExtCtrls, Grids, ComCtrls, SynEdit, PrintersDlgs, UITypes, LazUTF8, LCLType;

type

  { TForm1 }

  TForm1 = class(TForm)
    FontDialog1: TFontDialog;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    PrintDialog1: TPrintDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    SaveDialog1: TSaveDialog;
    StaticText1: TStaticText;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Memo1Click(Sender: TObject);
    procedure Memo1Enter(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Memo1KeyPress(Sender: TObject; var Key: char);
    procedure Memo1UTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure StaticText1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  FileWork: String;
  k: integer;
  x,y: int64;

implementation

{$R *.lfm}

Procedure Save;
begin
  if Form1.SaveDialog1.Execute then
  begin
  Form1.Memo1.Lines.SaveToFile(Form1.SaveDialog1.FileName);
  Form1.Caption:= ExtractFileName(Form1.SaveDialog1.FileName);
  end;
  Form1.Memo1.modified:= False;
end;

procedure countspace(y:int64);
var
  i:integer;
  s:string;
begin
  s:= Form1.Memo1.Lines[y];
  for i:=1 to length(s) do
  begin
    if ord(s[i]) = 32 then
    inc(k);
  end;
end;

{ TForm1 }

procedure TForm1.Memo1Change(Sender: TObject);
begin

end;

procedure TForm1.Memo1Click(Sender: TObject);
begin
  x:= Form1.Memo1.CaretPos.x+1;
  y:= Form1.Memo1.CaretPos.Y+1;
  Form1.StaticText1.Caption:='Стр ' + IntToStr(y) + ', стлб ' + IntToStr(x);
end;

procedure TForm1.Memo1Enter(Sender: TObject);
begin

end;

procedure TForm1.Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  code: integer;
begin
  code:= ord(key);
  case code of
  13:begin {Enter}

  end;
  08:begin {BackSpace}

  end;
  09:begin  {Tab}

  end;
  37:begin {Left}

  end;
  39:begin {Right}

  end;
   38:begin {Up}

   end;
   40:begin {Down}

   end;
   32: begin {Space}

   end;
end;
end;

procedure TForm1.Memo1KeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TForm1.Memo1UTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);
begin
  x:= Memo1.CaretPos.x;
  Form1.StaticText1.Caption:='Стр ' + IntToStr(y) + ', стлб ' + IntToStr(x);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  x:= Form1.Memo1.CaretPos.x;
  y:= Form1.Memo1.CaretPos.y;
  Form1.StaticText1.Caption:='Стр ' + IntToStr(y) + ', стлб ' + IntToStr(x);
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if (Memo1.Modified = true) or
     ((Memo1.Modified = true) and (FileExists(Form1.SaveDialog1.FileName))) then
  begin
    if messagedlg('Сохранить?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Save;
  end;
end;

procedure TForm1.MenuItem10Click(Sender: TObject);
begin
  memo1.CutToClipboard;
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
  Memo1.CopyToClipboard;
end;

procedure TForm1.MenuItem12Click(Sender: TObject);
begin
  Memo1.PasteFromClipboard;
end;

procedure TForm1.MenuItem13Click(Sender: TObject);
begin
  if memo1.SelLength > 0 then
  memo1.ClearSelection
  else
  memo1.Clear;
end;

procedure TForm1.MenuItem14Click(Sender: TObject);
begin
  memo1.SelectAll;
end;

procedure TForm1.MenuItem16Click(Sender: TObject);
begin
  if memo1.WordWrap then
  begin
    memo1.WordWrap:=false;
    memo1.ScrollBars:=ssBoth;
    MenuItem16.Checked:=false;
  end
  else
  begin
    memo1.WordWrap:=true;
    memo1.ScrollBars:=ssVertical;
    MenuItem16.Checked:=true;
  end;
end;

procedure TForm1.MenuItem17Click(Sender: TObject);
begin
  if FontDialog1.execute then Memo1.Font:=FontDialog1.Font;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  if (Memo1.Modified = true) or
     ((Memo1.Modified = true) and (FileExists(Form1.SaveDialog1.FileName))) then
    begin
      if messagedlg('Сохранить?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    if FileWork = '' then
    Save
    else
      memo1.Lines.SaveToFile(FileWork);
    end;
  FileWork:='';
  memo1.Clear;
  Memo1.Modified:= false;
  end;


procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  if (Memo1.Modified = true) or
     ((Memo1.Modified = true) and (FileExists(Form1.SaveDialog1.FileName))) then
  begin
    if messagedlg('Сохранить?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  if FileWork = '' then
  Save
  else
    memo1.Lines.SaveToFile(FileWork);
  end;
  if OpenDialog1.execute then
  begin
    memo1.Lines.LoadFromFile(OpenDialog1.FileName);
    FileWork:=OpenDialog1.FileName;
    Form1.Caption:= FileWork;
  end;
  Memo1.Modified:= false;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  if FileWork = '' then
  Save
  else
    memo1.Lines.SaveToFile(FileWork);
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  Save;
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
   if (Memo1.Modified = true) or
     ((Memo1.Modified = true) and (FileExists(Form1.SaveDialog1.FileName))) then
  begin
    if messagedlg('Сохранить?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  if FileWork = '' then
  Save
  else
    memo1.Lines.SaveToFile(FileWork);
  end;
  If PrinterSetupDialog1.Execute then
  PrintDialog1.Execute;
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  Memo1.Undo;
end;

procedure TForm1.StaticText1Click(Sender: TObject);
begin

end;

end.

