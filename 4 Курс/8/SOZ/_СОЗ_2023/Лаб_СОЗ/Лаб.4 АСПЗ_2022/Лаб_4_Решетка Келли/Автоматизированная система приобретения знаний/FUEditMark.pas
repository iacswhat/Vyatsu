unit FUEditMark;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, UBD;

type
  TFEditMark = class(TForm)
    TrackBar1: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure FormShow(Sender: TObject);
  private
  public
    Evd: TEvidence;
    Hyp: THypothesis;
  end;

var
  FEditMark: TFEditMark;

implementation

{$R *.dfm}

procedure TFEditMark.FormShow(Sender: TObject);
begin
  if Hyp = nil then begin
    Label1.Visible := False;
    Label3.Visible := False;
    TrackBar1.Position := 0;
  end else begin
    Label1.Visible := True;
    Label3.Visible := True;
    Label3.Caption := Hyp.Name;
  end;
  Label4.Caption := Evd.Name;
  Label5.Caption := Evd.NPolus;
  Label6.Caption := Evd.PPolus;
end;

end.
