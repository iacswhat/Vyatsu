unit FUEditRep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls;

type
  TFEditRep = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
  public
  end;

var
  FEditRep: TFEditRep;

implementation
uses UBD, FUEditMark;

{$R *.dfm}

procedure TFEditRep.FormShow(Sender: TObject);
begin
  BD.VisualRepGrid;
end;

procedure TFEditRep.StringGrid1DblClick(Sender: TObject);
var
  col,row : Integer;
begin
  col := StringGrid1.Selection.Left - 1;
  row := StringGrid1.Selection.Top - 1;
  FEditMark.TrackBar1.Position := BD.Mark[row,col];
  FEditMark.Evd := BD.Evd[col];
  FEditMark.Hyp := BD.Hyp[row];
  if FEditMark.ShowModal = mrOk then
    BD.Mark[row,col] := FEditMark.TrackBar1.Position;
end;

procedure TFEditRep.Button1Click(Sender: TObject);
var Str: String;
begin
  if not BD.TestRepGrid(Str) then begin
    ModalResult := mrNone;
    Application.MessageBox(@(Str[1]),'Ошибка',0);
  end;
end;

procedure TFEditRep.Button2Click(Sender: TObject);
var Str: String;
begin
  if not BD.TestRepGrid(Str) then begin
    ModalResult := mrNone;
    Application.MessageBox(@(Str[1]),'Ошибка',0);
  end;
end;

end.
