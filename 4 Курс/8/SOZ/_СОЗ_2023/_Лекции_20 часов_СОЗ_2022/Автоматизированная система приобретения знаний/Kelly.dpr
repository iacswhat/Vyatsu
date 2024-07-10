program Kelly;

uses
  Forms,
  MForm in 'MForm.pas' {Form1},
  UBD in 'UBD.pas',
  FUEditHyp in 'FUEditHyp.pas' {FEditHyp},
  FUInputHyp in 'FUInputHyp.pas' {FInputHyp},
  FUExpEv in 'FUExpEv.pas' {FExpEv},
  FUEditEv in 'FUEditEv.pas' {FEditEv},
  FUInputEv in 'FUInputEv.pas' {FInputEv},
  FUEditRep in 'FUEditRep.pas' {FEditRep},
  FUEditMark in 'FUEditMark.pas' {FEditMark},
  UBZ in 'UBZ.pas',
  FuOutConc in 'FuOutConc.pas' {FOutConc},
  MUTriada in 'MUTriada.pas' {MTriada: TFrame},
  MUDiada in 'MUDiada.pas' {MDiada: TFrame},
  MUContext in 'MUContext.pas' {MFContext: TFrame},
  FUSett in 'FUSett.pas' {MSett},
  FUAbout in 'FUAbout.pas' {FAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.HelpFile := 'G:\Program Files\Borland\Delphi7\Projects\Univer\Kelly\Release\HELP.HLP';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFEditHyp, FEditHyp);
  Application.CreateForm(TFInputHyp, FInputHyp);
  Application.CreateForm(TFExpEv, FExpEv);
  Application.CreateForm(TFEditEv, FEditEv);
  Application.CreateForm(TFInputEv, FInputEv);
  Application.CreateForm(TFEditRep, FEditRep);
  Application.CreateForm(TFEditMark, FEditMark);
  Application.CreateForm(TFOutConc, FOutConc);
  Application.CreateForm(TMSett, MSett);
  Application.CreateForm(TFAbout, FAbout);
  Application.Run;
end.
