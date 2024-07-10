unit FUInputHyp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFInputHyp = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
  private
  public
  end;

var
  FInputHyp: TFInputHyp;

implementation

{$R *.dfm}

procedure TFInputHyp.FormShow(Sender: TObject);
begin
  Edit1.SetFocus;
end;

end.
