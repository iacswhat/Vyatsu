unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ActnList, ComCtrls, Clipbrd, PrintersDlgs;

type

  { TForm1 }

  TForm1 = class(TForm)
    InfAction: TAction;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    PrintAction: TAction;
    ApplicationProperties1: TApplicationProperties;
    FontAction: TAction;
    FontDialog1: TFontDialog;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    PrintDialog1: TPrintDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    WordWrapAction: TAction;
    FindAction: TAction;
    FindDialog1: TFindDialog;
    MenuItem15: TMenuItem;
    SelectAllAction: TAction;
    DeleteAction: TAction;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    PasteAction: TAction;
    CopyAction: TAction;
    CutAction: TAction;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    UndoAction: TAction;
    NewAction: TAction;
    SaveAction: TAction;
    SaveAsAction: TAction;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenAction: TAction;
    ExitAction: TAction;
    ActionList1: TActionList;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    StatusBar1: TStatusBar;
    procedure ApplicationProperties1Hint(Sender: TObject);
    procedure ApplicationProperties1Idle(Sender: TObject; var Done: Boolean);
    procedure CopyActionExecute(Sender: TObject);
    procedure CutActionExecute(Sender: TObject);
    procedure CutActionUpdate(Sender: TObject);
    procedure DeleteActionExecute(Sender: TObject);
    procedure DeleteActionUpdate(Sender: TObject);
    procedure FindActionExecute(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure FontActionExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure InfActionExecute(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure NewActionExecute(Sender: TObject);
    procedure PasteActionExecute(Sender: TObject);
    procedure PasteActionUpdate(Sender: TObject);
    procedure PrintActionExecute(Sender: TObject);
    procedure SaveActionExecute(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure SaveAsActionExecute(Sender: TObject);
    procedure ExitActionExecute(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure OpenActionExecute(Sender: TObject);
    procedure SelectAllActionExecute(Sender: TObject);
    procedure UndoActionExecute(Sender: TObject);
    procedure UndoActionUpdate(Sender: TObject);
    procedure WordWrapActionExecute(Sender: TObject);

  private
    FLastSearch: integer;
    FOpenFile: string;
    function CloseCurrentDocument: Boolean;

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}
function TForm1.CloseCurrentDocument: Boolean;
  begin
   CloseCurrentDocument:= True;
   if Memo1.Modified then
   begin
     case messagedlg('Сохранить изменения?', mtConfirmation,  mbYesNoCancel,0) of
     mrYes: SaveAction.Execute;
     mrCancel: CloseCurrentDocument:= False;
     end;
     end;
   end;

{ TForm1 }

procedure TForm1.ExitActionExecute(Sender: TObject);
begin
  Close;
end;

procedure TForm1.SaveAsActionExecute(Sender: TObject);
begin
  If SaveDialog1.Execute then
  begin
    FOpenFile:= SaveDialog1.FileName;
    Memo1.Lines.savetofile(FOpenFile);
    Memo1.Modified:= False;
  end;
end;

procedure TForm1.SaveActionExecute(Sender: TObject);
begin
    If FOpenFile <> '' then
    begin
      Memo1.Lines.SaveToFile(FOpenFile);
      Memo1.Modified:= False;
    end
    else
    SaveAsAction.Execute;
    Form1.Caption:= FOpenFile;
    Memo1.Modified:= False;
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin

end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose:= CloseCurrentDocument;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.Caption:= 'Безымянный - Блокнот';
end;

procedure TForm1.InfActionExecute(Sender: TObject);
begin
  MessageDlg('Разработал студент ИВТ-11 Жеребцов К. А. 2021', mtInformation, [mbOk], 0);
end;

procedure TForm1.CopyActionExecute(Sender: TObject);
begin
  Memo1.CopyToClipboard;
end;

procedure TForm1.ApplicationProperties1Idle(Sender: TObject; var Done: Boolean);
Const
  modified: array[Boolean] of string = ('', 'Modified');
begin
  StatusBar1.Panels[0].Text:=Format('Стр %d, стлб %d',
                           [succ(Memo1.CaretPos.Y),succ(Memo1.CaretPos.X)]);
  StatusBar1.Panels[1].Text:= modified[Memo1.Modified];
end;

procedure TForm1.ApplicationProperties1Hint(Sender: TObject);
begin
  StatusBar1.Panels[2].Text:= Application.Hint;
end;

procedure TForm1.CutActionExecute(Sender: TObject);
begin
  Memo1.CutToClipboard;
end;

procedure TForm1.CutActionUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled:= Memo1.SelLength > 0;
end;

procedure TForm1.DeleteActionExecute(Sender: TObject);
begin
  Memo1.ClearSelection;
end;

procedure TForm1.DeleteActionUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled:= Memo1.SelLength > 0;
end;

procedure TForm1.FindActionExecute(Sender: TObject);
begin
  FLastSearch:= 0;
  FindDialog1.Execute;
end;

procedure TForm1.FindDialog1Find(Sender: TObject);
var
  memoText: string;
  searchPos: integer;
  Dialog: TFindDialog;
begin
  Dialog:= TFinddialog(Sender);
  memoText:= Memo1.Lines.Text;
  if FLastSearch <> 0 then
  Delete(memoText, 1, FLastSearch);
  searchPos:= Pos(Dialog.FindText, memoText);
  If searchPos = 0 then
  MessageDlg(Format('Не могу найти "%s"',[dialog.FindText]), mtinformation, [mbOk], 0)
  else
    begin
      inc(FLastSearch,searchPos);
      Memo1.SelStart:=Pred(FLastSearch);
      Memo1.SetFocus;
    end;
end;

procedure TForm1.FontActionExecute(Sender: TObject);

begin
  FontDialog1.Font.Assign(Memo1.Font);
  if FontDialog1.Execute then
  Memo1.Font.Assign(FontDialog1.Font);
end;



procedure TForm1.WordWrapActionExecute(Sender: TObject);
const
  scrolls: array[Boolean] of TScrollStyle = (ssBoth, ssVertical);
begin
  Memo1.WordWrap:= WordWrapAction.Checked;
  Memo1.ScrollBars:= scrolls[Memo1.WordWrap];
end;

procedure TForm1.NewActionExecute(Sender: TObject);
begin
  If CloseCurrentDocument then
  begin
    Memo1.Lines.clear;
    FOpenFile:= '';
    Form1.Caption:= 'Безымянный - Блокнот';
    Memo1.Modified:= False;
  end;
end;

procedure TForm1.PasteActionExecute(Sender: TObject);
begin
  Memo1.PasteFromClipboard;
end;

procedure TForm1.PasteActionUpdate(Sender: TObject);
begin
  PasteAction.Enabled:= Clipboard.HasFormat(CF_TEXT);
end;

procedure TForm1.PrintActionExecute(Sender: TObject);
begin
  If CloseCurrentDocument then
  begin
  If PrinterSetupDialog1.Execute then
  PrintDialog1.Execute;
  end;
end;

procedure TForm1.Memo1Change(Sender: TObject);
begin

end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin

end;

procedure TForm1.OpenActionExecute(Sender: TObject);
begin
  If CloseCurrentDocument and OpenDialog1.Execute then
  begin
    FOpenFile:= OpenDialog1.FileName;
    Memo1.Lines.LoadFromFile(FOpenFile);
    Form1.Caption:= FOpenFile;
    Memo1.Modified:= False;
  end;
end;

procedure TForm1.SelectAllActionExecute(Sender: TObject);
begin
  Memo1.SelectAll;
end;

procedure TForm1.UndoActionExecute(Sender: TObject);
begin
  Memo1.Undo;
end;

procedure TForm1.UndoActionUpdate(Sender: TObject);
begin
  UndoAction.Enabled:= memo1.CanUndo;
end;

end.

