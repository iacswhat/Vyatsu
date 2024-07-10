unit FUEditEv;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList, XPStyleActnCtrls, ActnMan;

type
  TFEditEv = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    ActionManager1: TActionManager;
    acAdd: TAction;
    acDel: TAction;
    acEdit: TAction;
    procedure acAddExecute(Sender: TObject);
    procedure acDelExecute(Sender: TObject);
    procedure acEditExecute(Sender: TObject);
  private
  public
    function FindSelectedEv: Integer;
  end;

var
  FEditEv: TFEditEv;

implementation
uses FUInputEv, UBD;

{$R *.dfm}

const
  DoubleName : PAnsiChar = 'Свидетельство с таким названием уже существует';


procedure TFEditEv.acAddExecute(Sender: TObject);
begin
  FInputEv.Caption := 'Новое свидетельство';
  FInputEv.Edit1.Text := '';
  FInputEv.Edit2.Text := '';
  FInputEv.Edit3.Text := '';
  if (FInputEv.ShowModal = mrOk) and (FInputEv.Edit1.Text <> '') and
    (FInputEv.Edit2.Text <> '') and (FInputEv.Edit3.Text <> '') and
    (FInputEv.Edit2.Text <> FInputEv.Edit3.Text) then begin
    try
      BD.AddEv(FInputEv.Edit1.Text,FInputEv.Edit2.Text,FInputEv.Edit3.Text);
    except
      Application.MessageBox(DoubleName,'Ошибка',0);
    end;
  end;
end;

function TFEditEv.FindSelectedEv: Integer;
var i : Integer;
begin
  Result := -1;
  for i := 0 to ListBox1.Count - 1 do
    if ListBox1.Selected[i] then begin
      Result := i;
      Break;
    end;
end;

procedure TFEditEv.acDelExecute(Sender: TObject);
var Ind: Integer;
begin
  Ind := FindSelectedEv;
  if Ind >= 0 then
    BD.DelEv(Ind);
end;

procedure TFEditEv.acEditExecute(Sender: TObject);
var
  Ind: Integer;
  Evd: TEvidence;
begin
  FInputEv.Caption := 'Изменение гипотезы';
  Ind := FindSelectedEv;
  if Ind > -1 then begin
    Evd := BD.Evd[Ind];
    FInputEv.Edit1.Text := Evd.Name;
    FInputEv.Edit2.Text := Evd.PPolus;
    FInputEv.Edit3.Text := Evd.NPolus;
    FInputEv.Edit1.SelectAll;
    if (FInputEv.ShowModal = mrOk) and (FInputEv.Edit1.Text <> '') and
      (FInputEv.Edit2.Text <> '') and (FInputEv.Edit3.Text <> '') and
      (FInputEv.Edit2.Text <> FInputEv.Edit3.Text) then begin
      try
        BD.EditEv(Ind,FInputEv.Edit1.Text,FInputEv.Edit2.Text,FInputEv.Edit3.Text);
      except
        Application.MessageBox(DoubleName,'Ошибка',0);
      end;
    end;
  end;
end;

end.
