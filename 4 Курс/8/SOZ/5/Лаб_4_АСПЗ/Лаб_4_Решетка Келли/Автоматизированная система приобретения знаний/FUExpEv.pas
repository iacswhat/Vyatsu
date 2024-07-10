unit FUExpEv;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, MUTriada, MUDiada, MUContext;

type
  TFExpEv = class(TForm)
    RadioGroup1: TRadioGroup;
    ListBox1: TListBox;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  public
    MTriada  : TMTriada;
    MDiada   : TMDiada;
    MContext : TMFContext;
    procedure OpenMetod;
  end;

var
  FExpEv: TFExpEv;

implementation

{$R *.dfm}

procedure TFExpEv.FormCreate(Sender: TObject);
begin
  MTriada := TMTriada.Create(Self);
  MTriada.Left := 240;
  MTriada.Parent := Self;
  MDiada := TMDiada.Create(Self);
  MDiada.Left := 240;
  MDiada.Parent := Self;
  MContext := TMFContext.Create(Self);
  MContext.Left := 240;
  MContext.Parent := Self;
end;

procedure TFExpEv.FormDestroy(Sender: TObject);
begin
  MTriada.Free;
  MDiada.Free;
  MContext.Free;
end;

procedure TFExpEv.OpenMetod;
begin
  case RadioGroup1.ItemIndex of
    0 : begin
      MDiada.Visible := False;
      MContext.Visible := False;
      MTriada.Visible := True;
      MTriada.RandomVars;
    end;
    1 : begin
      MTriada.Visible := False;
      MContext.Visible := False;
      MDiada.Visible := True;
      MDiada.RandomVars;
    end;
    2 : begin
      MTriada.Visible := False;
      MDiada.Visible := False;
      MContext.Visible := True;
      MContext.RandomVars;
    end;
  end;

end;

procedure TFExpEv.RadioGroup1Click(Sender: TObject);
begin
  OpenMetod;
end;

procedure TFExpEv.FormShow(Sender: TObject);
begin
  OpenMetod;
end;

end.
