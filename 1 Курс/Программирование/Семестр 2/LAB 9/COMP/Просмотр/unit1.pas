unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids;

type

  { TForm1 }

  TForm1 = class(TForm)
    ShowButton: TButton;
    OpenDialog1: TOpenDialog;
    Clear: TButton;
    StringGrid1: TStringGrid;
    procedure ClearClick(Sender: TObject);
    procedure ShowButtonClick(Sender: TObject);
  private

  public

  end;

  TDoc = record
    Name: string[100];
    day, month, year: integer;
    money: longint;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ShowButtonClick(Sender: TObject);
var
  r: TDoc;
  i: integer = 1;
  ff: file of TDoc;
  path: string;
begin
  If OpenDialog1.Execute then begin
    path:= OpenDialog1.FileName;
  end;
  AssignFile(ff, path);
  reset(ff);
  While not EOF(ff) do begin
    read(ff,r);
    with r do begin
       StringGrid1.Cells[0,i]:=inttostr(i);
       StringGrid1.Cells[1,i]:=Name;
       StringGrid1.Cells[2,i]:=inttostr(Day);
       StringGrid1.Cells[3,i]:=inttostr(Month);
       StringGrid1.Cells[4,i]:=inttostr(Year);
       StringGrid1.Cells[5,i]:=inttostr(Money);
    end;
    Inc(i);
  end;
  CloseFile(ff);
end;

procedure TForm1.ClearClick(Sender: TObject);
var
  i:longint;
begin
  with StringGrid1 do
  for i:=1 to RowCount-1 do
  Rows[i].Clear;
end;
end.

