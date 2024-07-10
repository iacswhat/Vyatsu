unit visual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, Grids;

type
  TForm2 = class(TForm)
    SolveBtn: TBitBtn;
    StepBtn: TBitBtn;
    StopBtn: TBitBtn;
    GroupBox1: TGroupBox;
    AllRdBtn: TRadioButton;
    SimpleRdBtn: TRadioButton;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    ProgressBar2: TProgressBar;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SolveBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StepBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  rec = Array[1..1000] of integer;
const TmpFin = 0.5;

var
  Form2 : TForm2;
  WorkSolve, CurSolve : rec;
  TempBeg,Alpha : extended;
  N, IterCount : integer;
  SqHor, SqVert, Left, Top : integer;

  ActiveBoard: integer;

  finished, bystep: boolean;
  iters:integer;
  TempCur:extended;
  Solving:boolean;
  sbros: boolean;

  Cells: Array [1..100,1..100] of TShape;

implementation

uses Unit1, Protocol;

{$R *.dfm}

Procedure Delay(Time:dword);
var t:dword;
begin
  t:= GetTickCount;
  Repeat
       Application.ProcessMessages;
  Until GetTickCount-t>=Time;
end;

Procedure Init;
var i: integer;
begin
  // Заполнение нулями массивов решений
  FillChar(WorkSolve, SizeOf(WorkSolve), 0);
  FillChar(CurSolve, SizeOf(CurSolve), 0);

  // Считывание входных параметров для алгоритма
  N := StrToInt(Form1.EdN.Text);
  IterCount := StrToInt(Form1.EdIter.Text);
  TempBeg := StrToFloat(Form1.EdTmp.Text);
  Alpha :=StrToFloat(Form1.EdAlpha.Text)/100;

  // Формирование начального решения
  for i:=1 to N do begin WorkSolve[i] := i; CurSolve[i] := i; end;
//  sbros := false;
end;

Procedure ShowBoard;
var i,j: integer;
begin
  //Создание отображения шахматного поля, определение необходимых
  //для этого параметров
  SqHor := (500 div N);
  SqVert := (400 div N);
  for i:=1 to N do
    begin
      for j:=1 to N do
        begin
          Cells[i][j] := TShape.Create(Form2);
          Cells[i][j].Parent := Form2;
          Cells[i][j].Brush.Color := clWhite;
          Cells[i][j].Width := SqHor;
          Cells[i][j].Height := SqVert;
          Cells[i][j].Left := 20+(j-1)*SqHor;
          Cells[i][j].Top := (i-1)*SqVert;
        end;
    end;
end;

Procedure ShowSolve; //Процедура отображения текущего решения задачи
var i,j : integer;
begin
  For i:=1 to N do
    For j:=1 to N do
      begin
        if(CurSolve[i]=j)
        then Cells[i,j].Brush.Color := clBlack
        else Cells[i,j].Brush.Color := clWhite;
      end;
end;

Procedure ClearBoard;
var i,j : integer;
begin
  For i:=1 to N do
    For j:=1 to N do
      Cells[i,j].Brush.Color := clWhite;
end;

Procedure GetNewWork; //Получение нового рабочего решения
var x,y,t : integer;
begin
  x := random(N)+1;
  repeat
    y := random(N)+1;
  until x<>y;
  t := WorkSolve[x];
  WorkSolve[x] := WorkSolve[y];
  WorkSolve[y] := t;
  Form3.StringGrid1.Cells[4,Form3.StringGrid1.RowCount-1] := '('+IntToStr(x)+') <=> ('+IntToStr(y)+')';
end;

function GetEnergy(Ar: rec):extended;
const dx:Array[1..4] of shortint=(-1,1,-1,1);
      dy:Array[1..4] of shortint=(-1,1,1,-1);
var i,j:integer;
    conflicts:longint;
    x,y:integer;
    board : array[1..100, 1..100] of integer;
begin
  fillchar(board, SizeOf(Board), 0);
  for i:=1 to N do Board[i,Ar[i]] := 1;
  conflicts := 0;
  for i:=1 to N do
    begin
      for j:=1 to 4 do
        begin
          x:=i; y:=Ar[i];
          while true do
            begin
              inc(x,dx[j]); inc(y,dy[j]);
              if(x<1)or(x>N)or(y<1)or(y>n) then break;
              if(Board[x,y] = 1) then inc(conflicts);
            end;
        end;
    end;
  GetEnergy := conflicts;
end;

Procedure Work;
var tmp : rec;
    EnCur, EnWork, EnTmp : extended;
    p, pcalc : extended;
    perc : extended;
    flag: boolean;
begin
    flag := false;

    while(not flag)do
    begin
      //Итерация - начало
      inc(Iters);
      tmp := WorkSolve;
      EnCur := GetEnergy(CurSolve);
      EnTmp := GetEnergy(Tmp);
      Form3.StringGrid1.RowCount := Form3.StringGrid1.RowCount+1;
      Form3.StringGrid1.Cells[0,Form3.StringGrid1.RowCount-1] := IntToStr(iters);
      Form3.StringGrid1.Cells[1,Form3.StringGrid1.RowCount-1] := FloatToStr(TempCur);
//      Form3.StringGrid1.Cells[2,Form3.StringGrid1.RowCount-1] := IntToStr(i);
      Form3.StringGrid1.Cells[3,Form3.StringGrid1.RowCount-1] := IntToStr(trunc(EnCur/2));
      GetNewWork;
      EnWork := GetEnergy(WorkSolve);
      Form3.StringGrid1.Cells[5,Form3.StringGrid1.RowCount-1] := IntToStr(trunc(EnWork));
      if(EnWork-EnTmp < 0)
      then begin
             if(EnWork < EnCur)
             then begin
                    Form3.StringGrid1.Cells[6,Form3.StringGrid1.RowCount-1] := IntToStr(1);
                    Form3.StringGrid1.Cells[7,Form3.StringGrid1.RowCount-1] := 'Да';
                    CurSolve := WorkSolve;
                    EnCur := EnWork;
                    ShowSolve;
                    Form2.Label2.Caption := 'Осталось конфликтов: '+IntToStr(trunc(EnCur));
                    flag := true;
                  end;
           end
      else begin
             p := random(1000001)/1000000;
             pcalc := exp((EnCur-EnWork)/TempCur);
             Form3.StringGrid1.Cells[6,Form3.StringGrid1.RowCount-1] := FloatToStr(pcalc);
             if(p-pcalc < 0)
             then begin
                     Form3.StringGrid1.Cells[7,Form3.StringGrid1.RowCount-1] := 'Да';
                     CurSolve := Tmp;
                     EnCur := EnTmp;
                     ShowSolve;
                     Form2.Label2.Caption := 'Осталось конфликтов: '+IntToStr(trunc(EnCur));
                     flag := true;
                  end
             else begin Form3.StringGrid1.Cells[7,Form3.StringGrid1.RowCount-1] := 'Нет'; WorkSolve := Tmp; end;
           end;
      //Итерация - конец
      if(Iters > IterCount)
      then begin
             TempCur := TempCur*Alpha;
           end;
      if(TempCur < TmpFin)
      then begin
             flag := true;
             ShowSolve;
             Form3.ShowModal;
             Form3.Free;
             bystep := false;
             Form2.StepBtn.Caption := 'Пошагово';
             Form2.ProgressBar1.Visible := false;
             Form2.SolveBtn.Enabled := false;
             Form2.Label1.Visible := false;
             Form2.Label2.Caption := '';
           end;
    end;


{    TempCur := TempCur*Alpha;
    if(TempCur < TmpFin)
    then begin
           ShowSolve;
           Delay(1000);

           Form2.ProgressBar1.Visible := false;
           Form2.Label1.Visible := false;

         end
    else begin
      Perc := (TempBeg-TempCur)/(TempBeg-TmpFin)*100;
      Form2.ProgressBar1.Position := round(Perc);
   end;}
end;

Procedure Work2;
var tmp : rec;
    EnCur, EnWork, EnTmp : extended;
    p, pcalc : extended;
    perc : extended;
    i:integer;
    k: integer;
begin
  Form2.StepBtn.Enabled := false;
  Form2.ProgressBar2.Max := IterCount;
  Application.CreateForm(TForm3, Form3);
  k:=0;
  while(TempCur >=TmpFin)do
  begin
    if sbros then break;
    Form2.ProgressBar2.Position:=0;
    for i:=1 to IterCount do
      begin
        //Итерация - начало
        inc(k);
        Form2.ProgressBar2.Position:=i;
        if sbros then break;
        tmp := WorkSolve;
        EnCur := GetEnergy(CurSolve);
        EnTmp := GetEnergy(Tmp);
        Form3.StringGrid1.RowCount := Form3.StringGrid1.RowCount+1;
        Form3.StringGrid1.Cells[0,Form3.StringGrid1.RowCount-1] := IntToStr(k);
        Form3.StringGrid1.Cells[1,Form3.StringGrid1.RowCount-1] := FloatToStr(TempCur);
        Form3.StringGrid1.Cells[2,Form3.StringGrid1.RowCount-1] := IntToStr(i);
        Form3.StringGrid1.Cells[3,Form3.StringGrid1.RowCount-1] := IntToStr(trunc(EnCur/2));
        GetNewWork;
        EnWork := GetEnergy(WorkSolve);
        Form3.StringGrid1.Cells[5,Form3.StringGrid1.RowCount-1] := IntToStr(trunc(EnWork));
        if(EnWork-EnTmp < 0)
        then begin
               if(EnWork < EnCur)
               then begin
                      Form3.StringGrid1.Cells[6,Form3.StringGrid1.RowCount-1] := IntToStr(1);
                      Form3.StringGrid1.Cells[7,Form3.StringGrid1.RowCount-1] := 'Да';
                      CurSolve := WorkSolve;
                      EnCur := EnWork;
                      if(Form2.AllRdBtn.Checked)
                      then begin
                             ShowSolve;
                             Form2.Label2.Caption := 'Осталось конфликтов: '+IntToStr(trunc(EnCur/2));
                             Delay(500);
                           end;
                    end;
             end
        else begin
               p := random(1000001)/1000000;
               pcalc := exp((EnCur-EnWork)/TempCur);
               Form3.StringGrid1.Cells[6,Form3.StringGrid1.RowCount-1] := FloatToStr(pcalc);
               if(p-pcalc < 0)
               then begin
                       Form3.StringGrid1.Cells[7,Form3.StringGrid1.RowCount-1] := 'Да';
                       CurSolve := Tmp;
                       EnCur := EnTmp;
                       if(Form2.AllRdBtn.Checked)
                       then begin
                              ShowSolve;
                              Form2.Label2.Caption := 'Осталось конфликтов: '+IntToStr(trunc(EnCur/2));
                              Delay(500);
                            end;
                    end
               else begin
                      WorkSolve := Tmp;
                      Form3.StringGrid1.Cells[7,Form3.StringGrid1.RowCount-1] := 'Нет';
                    end;
             end;
        //Итерация - конец
      end;
      TempCur := TempCur*Alpha;
      Perc := (TempBeg-TempCur)/(TempBeg-TmpFin)*100;
      Form2.ProgressBar1.Position := round(Perc);
  end;
//  ClearBoard(ActiveBoard);
  if not sbros
  then begin
    ShowSolve;
    Delay(1000);
    Form2.ProgressBar1.Visible := false;
    Form2.Label1.Visible := false;
  end;
  if not sbros
  then i:=MessageBox(0, PChar('Осталось конфликтов: '+IntToStr(trunc(EnCur/2))), PChar('Решение завершено'), MB_OK);
  Form2.StepBtn.Enabled := true;
  if not sbros then Form3.ShowModal;
  Form3.Free;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form2.StopBtn.Click;
  Form1.Show;
//  Application.Terminate;
end;

procedure TForm2.SolveBtnClick(Sender: TObject);
begin
  Randomize;
  Init;
  TempCur := TempBeg;
  Form2.ProgressBar1.Position := 0;
  Form2.ProgressBar1.Visible := true;
  Form2.Label1.Visible := true;
  if(Form2.AllRdBtn.Checked) then begin Form2.ProgressBar2.Visible := true; end;
  sbros := false;
  Form2.AllRdBtn.Enabled := false;
  Form2.SimpleRdBtn.Enabled := false;
  Work2;
  Form2.AllRdBtn.Enabled := true;
  Form2.SimpleRdBtn.Enabled := true;
  Form2.Label1.Visible := false;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  Init;
  ShowBoard;
  Form2.ProgressBar1.Visible := false;
  Form2.Label1.Visible := false;
end;

procedure TForm2.StepBtnClick(Sender: TObject);
begin
  if(not bystep)
  then begin
         bystep := true;
         ShowSolve;
         Form2.StepBtn.Caption := 'Следующий шаг';
         Form2.SolveBtn.Enabled := false;
         Form2.ProgressBar1.Visible := true;
         Form2.ProgressBar2.Visible := false;
         Form2.Label1.Visible := true;
         Iters := 0;
         TempCur := TempBeg;
         Application.CreateForm(TForm3, Form3);
       end
  else Work;
end;

procedure TForm2.StopBtnClick(Sender: TObject);
begin
  sbros := true;
  Form2.ProgressBar1.Visible := false;
  Form2.ProgressBar2.Visible := false;
  Form2.Label1.Visible := false;
  Form2.Label2.Caption := '';
  Form2.StepBtn.Caption := 'Пошагово';
  Form2.SolveBtn.Enabled := true;
  Init;
  ClearBoard;
  TempCur := TempBeg;
  Form3.Free;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
  Form2.Close;
end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
  Sbros := true;
  Application.Terminate;
end;

end.
