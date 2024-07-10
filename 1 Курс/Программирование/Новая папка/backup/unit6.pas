unit Unit6;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ColorBox,
  ValEdit, Grids, ExtCtrls, Menus, Buttons;

type

  { TForm5 }

  TForm5 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    RadioGroup3: TRadioGroup;
    RadioGroup4: TRadioGroup;
    procedure ApplicationProperties1Activate(Sender: TObject);
    procedure DrawGrid1Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure ValueListEditor1Click(Sender: TObject);
  private

  public

  end;

var
  Form5: TForm5;

implementation

{$R *.lfm}

{ TForm5 }

procedure TForm5.ValueListEditor1Click(Sender: TObject);
begin

end;

procedure TForm5.DrawGrid1Click(Sender: TObject);
begin

end;

procedure TForm5.Label4Click(Sender: TObject);
begin

end;

procedure TForm5.ApplicationProperties1Activate(Sender: TObject);
begin

end;

end.

