unit MUTriada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls;

type
  TMTriada = class(TFrame)
    Label1: TLabel;
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
  public
    constructor Create(AOwner: TComponent); override;
    procedure RandomVars; // предложить варианты
    procedure NewEvd;     // новое свидетельство
  end;

implementation
uses Math, UBD;

{$R *.dfm}

const
  DoubleName : PAnsiChar = '—видетельство с таким названием уже существует';

{ TMTriada }

constructor TMTriada.Create(AOwner: TComponent);
begin
  inherited;
  Label1.Caption := 'ќпределите свойство, которым две из'#13 +
                    'нижеперечисленных гипотез отличаютс€ от третьей';
end;

procedure TMTriada.RandomVars;
var
  a,b,c : Integer;
begin
  if (BD.Hyp.Count < 3) then Exit;
  a := RandomRange(0,BD.Hyp.Count - 1);
  b := RandomRange(0,BD.Hyp.Count - 1);
  while b = a do b := RandomRange(0,BD.Hyp.Count - 1);
  c := RandomRange(0,BD.Hyp.Count - 1);
  while (c = a) or (c = b) do c := RandomRange(0,BD.Hyp.Count - 1);
  ListBox1.Clear;
  ListBox1.Items.Add(BD.Hyp[a].Name);
  ListBox1.Items.Add(BD.Hyp[b].Name);
  ListBox1.Items.Add(BD.Hyp[c].Name);
  LabeledEdit1.Text := '';
  LabeledEdit2.Text := '';
  LabeledEdit3.Text := '';
end;

procedure TMTriada.Button1Click(Sender: TObject);
begin
  NewEvd;
  RandomVars;
end;

procedure TMTriada.NewEvd;
begin
  if (LabeledEdit1.Text <> '') and
    (LabeledEdit2.Text <> '') and (LabeledEdit3.Text <> '') and
    (LabeledEdit2.Text <> LabeledEdit3.Text) then begin
    try
      BD.AddEv(LabeledEdit1.Text,LabeledEdit2.Text,LabeledEdit3.Text);
    except
      Application.MessageBox(DoubleName,'ќшибка',0);
    end;
  end;
end;

procedure TMTriada.Button2Click(Sender: TObject);
begin
  RandomVars;
end;

end.
