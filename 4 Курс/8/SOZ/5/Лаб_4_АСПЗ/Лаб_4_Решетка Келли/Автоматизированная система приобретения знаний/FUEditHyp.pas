unit FUEditHyp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, XPStyleActnCtrls, ActnMan, StdCtrls;

type
  TFEditHyp = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ActionManager1: TActionManager;
    acAdd: TAction;
    acDel: TAction;
    acEdit: TAction;
    Button5: TButton;
    procedure acAddExecute(Sender: TObject);
    procedure acDelExecute(Sender: TObject);
    procedure acEditExecute(Sender: TObject);
  private
  public
    function FindSelectedHyp: Integer;
  end;

var
  FEditHyp: TFEditHyp;

implementation

uses FUInputHyp, UBD, MForm;

{$R *.dfm}

const
  DoubleName : PAnsiChar = 'Гипотеза с таким названием уже существует';

procedure TFEditHyp.acAddExecute(Sender: TObject);
begin
  FInputHyp.Caption := 'Новая гипотеза';
  FInputHyp.Edit1.Text := '';
  if (FInputHyp.ShowModal = mrOk) and (FInputHyp.Edit1.Text <> '') then begin
    try
      BD.AddHyp(FInputHyp.Edit1.Text);
    except
      on EStringListError do
        Application.MessageBox(DoubleName,'Ошибка',0);
    end;
  end;
end;

procedure TFEditHyp.acDelExecute(Sender: TObject);
var Ind: Integer;
begin
  Ind := FindSelectedHyp;
  if Ind >= 0 then
    BD.DelHyp(Ind);
end;

procedure TFEditHyp.acEditExecute(Sender: TObject);
var Ind: Integer;
begin
  FInputHyp.Caption := 'Изменение гипотезы';
  Ind := FindSelectedHyp;
  if Ind > -1 then begin
    FInputHyp.Edit1.Text := ListBox1.Items[Ind];
    FInputHyp.Edit1.SelectAll;
    if (FInputHyp.ShowModal = mrOk) and (FInputHyp.Edit1.Text <> '') and
       (FInputHyp.Edit1.Text <> ListBox1.Items[Ind]) then begin
      try
        BD.EditHyp(Ind,FInputHyp.Edit1.Text);
      except
        on EStringListError do
          Application.MessageBox(DoubleName,'Ошибка',0);
      end;
    end;
  end;
end;

function TFEditHyp.FindSelectedHyp: Integer;
var i : Integer;
begin
  Result := -1;
  for i := 0 to ListBox1.Count - 1 do
    if ListBox1.Selected[i] then begin
      Result := i;
      Break;
    end;
end;

end.
