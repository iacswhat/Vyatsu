unit MUContext;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls;

type
  TMFContext = class(TFrame)
    ListBox1: TListBox;
    ListBox2: TListBox;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
  public
    constructor Create(AOwner: TComponent); override;
    procedure RandomVars; // предложить варианты
    procedure NewEvd;     // новое свидетельство
  end;

implementation
uses UBD;
{$R *.dfm}
const
  DoubleName : PAnsiChar = 'Свидетельство с таким названием уже существует';

{ TMFContext }

constructor TMFContext.Create(AOwner: TComponent);
begin
  inherited;
  Label1.Caption := 'Разбейте приведенные гипотезы на две группы'#13 +
                    'по какому-нибудь признаку';
end;

procedure TMFContext.RandomVars;
begin
  if (BD.Hyp.Count < 3) then Exit;
  ListBox1.Clear;
  ListBox2.Clear;
  BD.Hyp.Names(ListBox1.Items);
  LabeledEdit1.Text := '';
  LabeledEdit2.Text := '';
  LabeledEdit3.Text := '';
end;

procedure TMFContext.Button3Click(Sender: TObject);
var
  i     : Integer;
  L1,L2 : TListBox;
begin
  L1 := nil; L2 := nil;
  if Sender = Button3 then begin
    L1 := ListBox1;
    L2 := ListBox2;
  end;
  if Sender = Button4 then begin
    L1 := ListBox2;
    L2 := ListBox1;
  end;
  for i := 0 to L1.Count - 1 do
    if L1.Selected[i] then
      L2.Items.Add(L1.Items[i]);
  L1.DeleteSelected;
end;

procedure TMFContext.NewEvd;
begin
  if (ListBox1.Count <> 0) and (ListBox2.Count <> 0) and
    (LabeledEdit1.Text <> '') and
    (LabeledEdit2.Text <> '') and (LabeledEdit3.Text <> '') and
    (LabeledEdit2.Text <> LabeledEdit3.Text) then begin
    try
      BD.AddEv(LabeledEdit1.Text,LabeledEdit2.Text,LabeledEdit3.Text);
    except
      Application.MessageBox(DoubleName,'Ошибка',0);
    end;
  end;
end;

procedure TMFContext.Button1Click(Sender: TObject);
begin
  NewEvd;
  RandomVars;
end;

procedure TMFContext.Button2Click(Sender: TObject);
begin
  RandomVars;
end;

end.
