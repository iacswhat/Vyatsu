unit MForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, XPStyleActnCtrls, ActnList, ActnMan, ToolWin, ActnCtrls,
  ActnMenus, Menus, ImgList, ComCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    ActionMainMenuBar1: TActionMainMenuBar;
    ActionManager1: TActionManager;
    acExit: TAction;
    acNewBD: TAction;
    acEditHyp: TAction;
    acSaveBD: TAction;
    acSaveBDas: TAction;
    SaveDialog1: TSaveDialog;
    acOpenBD: TAction;
    OpenDialog1: TOpenDialog;
    acExpEv: TAction;
    acEditEv: TAction;
    acRepGrid: TAction;
    acRunBZ: TAction;
    acNewBZ: TAction;
    ImageList1: TImageList;
    ActionToolBar1: TActionToolBar;
    Memo1: TMemo;
    acOpenRed: TAction;
    acSaveRed: TAction;
    acCloseRed: TAction;
    OpenDialog2: TOpenDialog;
    SaveDialog2: TSaveDialog;
    acHelp: TAction;
    acAbout: TAction;
    acSettings: TAction;
    procedure acExitExecute(Sender: TObject);
    procedure acEditHypExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure acSaveBDasExecute(Sender: TObject);
    procedure acSaveBDExecute(Sender: TObject);
    procedure acNewBDExecute(Sender: TObject);
    procedure acOpenBDExecute(Sender: TObject);
    procedure acExpEvExecute(Sender: TObject);
    procedure acEditEvExecute(Sender: TObject);
    procedure acRepGridExecute(Sender: TObject);
    procedure acRunBZExecute(Sender: TObject);
    procedure acNewBZExecute(Sender: TObject);
    procedure acOpenRedExecute(Sender: TObject);
    procedure acSaveRedExecute(Sender: TObject);
    procedure acSettingsExecute(Sender: TObject);
    procedure acAboutExecute(Sender: TObject);
    procedure acHelpExecute(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

uses FUEditHyp, UBD, FUExpEv, FUEditEv, FUEditRep, UBZ, FUEditMark,
  FuOutConc, FUSett, FUAbout;

{$R *.dfm}

procedure TForm1.acExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TForm1.acEditHypExecute(Sender: TObject);
begin
  if FEditHyp.ShowModal = mrOk then
    acExpEv.Execute;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BD := TBD.Create;
  BZ := nil;
  Randomize;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  BD.Free;
  BZ.Free;
end;

procedure TForm1.acSaveBDasExecute(Sender: TObject);
begin
  if SaveDialog1.Execute then BD.Save(SaveDialog1.FileName);
end;

procedure TForm1.acSaveBDExecute(Sender: TObject);
begin
  if SaveDialog1.FileName = '' then acSaveBDas.Execute
  else BD.Save(SaveDialog1.FileName);
end;

procedure TForm1.acNewBDExecute(Sender: TObject);
begin
//  BD.New;
  BD.Clear;
  acEditHyp.Execute;
  SaveDialog1.FileName := '';
end;

procedure TForm1.acOpenBDExecute(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    BD.Open(OpenDialog1.FileName);
    SaveDialog1.FileName := OpenDialog1.FileName;
  end;
end;

procedure TForm1.acExpEvExecute(Sender: TObject);
begin
 if BD.Hyp.Count <= 3 then raise Exception.Create('Слишком мало гипотез');
 if FExpEv.ShowModal = mrOk then
   acEditEv.Execute;
end;

procedure TForm1.acEditEvExecute(Sender: TObject);
begin
  if FEditEv.ShowModal = mrOk then
    acRepGrid.Execute;
end;

procedure TForm1.acRepGridExecute(Sender: TObject);
var
  Res : TModalResult;
begin
  if (BD.Hyp.Count < 2) then raise Exception.Create('Слишком мало гипотез');
  if (BD.Evd.Count < 2) then raise Exception.Create('Слишком мало свидетельств');
  Res := FEditRep.ShowModal;
  if Res = mrOk then begin
    acRunBZ.Execute;
  end;
end;

procedure TForm1.acRunBZExecute(Sender: TObject);
var
  i   : Integer;
  Run : Boolean;
begin
  if (BD.Hyp.Count < 2) then raise Exception.Create('Слишком мало гипотез');
  if (BD.Evd.Count < 2) then raise Exception.Create('Слишком мало свидетельств');
  BZ.Free;
  BZ := TBZ.Create(BD);
  Run := True;
  for i := 0 to BD.Evd.Count - 1 do begin
    FEditMark.Evd := BD.Evd[i];
    FEditMark.Hyp := nil;
    if FEditMark.ShowModal = mrOk then begin
      BZ.InM[i] := FEditMark.TrackBar1.Position;
    end else begin
      Run := False;
      Break;
    end;
  end;
  if Run then begin
    BZ.Conclusion;
    BZ.OutResConc(FOutConc.ListBox1.Items,FOutConc.ListBox2.Items);
    FOutConc.ShowModal;
  end;
end;

procedure TForm1.acNewBZExecute(Sender: TObject);
begin
  if (BD.Hyp.Count < 2) then raise Exception.Create('Слишком мало гипотез');
  if (BD.Evd.Count < 2) then raise Exception.Create('Слишком мало свидетельств');
  BZ.Free;
  BZ := TBZ.Create(BD);
end;

procedure TForm1.acOpenRedExecute(Sender: TObject);
begin
  if OpenDialog2.Execute then begin
    Memo1.Lines.LoadFromFile(OpenDialog2.FileName);
  end;
end;

procedure TForm1.acSaveRedExecute(Sender: TObject);
begin
  if SaveDialog2.Execute then begin
    Memo1.Lines.SaveToFile(SaveDialog2.FileName);
  end;
end;

procedure TForm1.acSettingsExecute(Sender: TObject);
begin
  if MSett.ShowModal = mrOk then begin
    case MSett.RadioGroup1.ItemIndex of
      0 : BD.SetScale(5);
      1 : BD.SetScale(20);
      2 : BD.SetScale(50);
    end;
  end;
end;

procedure TForm1.acAboutExecute(Sender: TObject);
begin
  FAbout.ShowModal;
end;

procedure TForm1.acHelpExecute(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTENTS,0);
end;

end.
