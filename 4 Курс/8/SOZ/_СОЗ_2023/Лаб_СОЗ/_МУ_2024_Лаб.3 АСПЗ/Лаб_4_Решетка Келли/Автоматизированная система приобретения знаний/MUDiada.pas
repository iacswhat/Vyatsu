unit MUDiada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls;

type
  TMDiada = class(TFrame)
    Label1: TLabel;
    ListBox1: TListBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
  public
    procedure RandomVars; // предложить варианты
    procedure NewEvd;     // новое свидетельство
  end;

implementation
uses UBD, Math;
{$R *.dfm}

const
  DoubleName : PAnsiChar = 'Свидетельство с таким названием уже существует';

{ TMDiada }

procedure TMDiada.NewEvd;
begin
  if (LabeledEdit1.Text <> '') and
    (LabeledEdit2.Text <> '') and (LabeledEdit3.Text <> '') and
    (LabeledEdit2.Text <> LabeledEdit3.Text) then begin
    try
      BD.AddEv(LabeledEdit1.Text,LabeledEdit2.Text,LabeledEdit3.Text);
    except
      Application.MessageBox(DoubleName,'Ошибка',0);
    end;
  end;
end;

procedure TMDiada.RandomVars;
var
  a,b : Integer;
begin
  if (BD.Hyp.Count < 2) then Exit;
  a := RandomRange(0,BD.Hyp.Count - 1);
  b := RandomRange(0,BD.Hyp.Count - 1);
  while b = a do b := RandomRange(0,BD.Hyp.Count - 1);
  ListBox1.Clear;
  ListBox1.Items.Add(BD.Hyp[a].Name);
  ListBox1.Items.Add(BD.Hyp[b].Name);
  LabeledEdit1.Text := '';
  LabeledEdit2.Text := '';
  LabeledEdit3.Text := '';
end;

procedure TMDiada.Button1Click(Sender: TObject);
begin
  NewEvd;
  RandomVars;
end;

procedure TMDiada.Button2Click(Sender: TObject);
begin
  RandomVars;
end;

end.
