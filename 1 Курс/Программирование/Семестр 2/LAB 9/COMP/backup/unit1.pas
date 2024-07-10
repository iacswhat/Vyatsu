unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids;

type

  { TForm1 }

  TForm1 = class(TForm)
    Cleartab: TButton;
    OpenDialog2: TOpenDialog;
    Sort: TButton;
    Last: TButton;
    ShowButton: TButton;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    Start: TButton;
    generator: TButton;
    StringGrid1: TStringGrid;
    procedure CleartabClick(Sender: TObject);
    procedure LastClick(Sender: TObject);
    procedure generatorClick(Sender: TObject);
    procedure ShowButtonClick(Sender: TObject);
    procedure SortClick(Sender: TObject);
    procedure StartClick(Sender: TObject);

  private

  public
    PathStart: string;
    PathLast: string;
  end;

  TDoc = record
    Name: string[100];
    day, month, year: integer;
    money: longint;
  end;



var
  Form1: TForm1;
  zap: array [1..3] of TDOc;
implementation

{$R *.lfm}

{ TForm1 }

procedure QSort(NStart, NEnd: integer; d:TDoc);
var
  l, r: integer;
  X, c: TDoc;
begin
  randomize;
  if NStart>=NEnd then exit;
  l:= NStart;
  r:= NEnd;
  x:= zap[l+random(r-l+1)];
  while l<r do begin
    while zap[l].year < x.year do Inc(l);
    while zap[r].year < x.year do Dec(r);
    if L<=R then begin
      c:= zap[l];
      zap[l]:= zap[r];
      zap[r]:= c;
      Inc(l);
      Dec(r);
    end;
  end;
 // QSort(NStart, r);
  //QSort(l,NEnd);
end;


procedure TForm1.StartClick(Sender: TObject);
begin
  Form1.Label1.Visible:=False;
  if opendialog1.Execute then begin
    PathStart:= OpenDialog1.FileName;
  end;
end;

procedure TForm1.generatorClick(Sender: TObject);
const
char: array[1..26] of char = ('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z');
var
  Doc: Tdoc;
  a: integer;
  f: file of TDoc;
  i,j: longint;
begin
  randomize;
  AssignFile(f, PathStart);
  Rewrite(f);
  For i := 1 to 120 do begin
    a:= random(99)+1;
    for j:= 1 to a do begin
      Doc.Name[j]:= char[random(length(char))+1];
    end;
    Doc.day:= random(31)+1;
    Doc.month:=random(12)+1;
    Doc.year:=random(2021)+1;
    Doc.money:= random(13999999)+1;
    write(f, Doc);
  end;
  closefile(f);
  Form1.Label1.Visible:=True;
end;

procedure TForm1.LastClick(Sender: TObject);
begin
  if OpenDialog2.Execute then begin
     PathLast:= OpenDialog1.FileName;
  end;
end;

procedure TForm1.CleartabClick(Sender: TObject);
var
  i:longint;
begin
  with StringGrid1 do
  for i:=1 to RowCount-1 do
  Rows[i].Clear;
end;

procedure TForm1.ShowButtonClick(Sender: TObject);
var
  r: TDoc;
  i: integer = 1;
  ff: file of TDoc;
  path: string;
begin
  If OpenDialog1.Execute then begin
    path:= OpenDialog1.FileName;
  end;
  AssignFile(ff, path);
  reset(ff);
  While not EOF(ff) do begin
    read(ff,r);
    with r do begin
       StringGrid1.Cells[0,i]:=inttostr(i);
       StringGrid1.Cells[1,i]:=Name;
       StringGrid1.Cells[2,i]:=inttostr(Day);
       StringGrid1.Cells[3,i]:=inttostr(Month);
       StringGrid1.Cells[4,i]:=inttostr(Year);
       StringGrid1.Cells[5,i]:=inttostr(Money);
    end;
    Inc(i);
  end;
  CloseFile(ff);
end;

procedure TForm1.SortClick(Sender: TObject);
var
  fil: array [1..30] of file of TDoc;
  fs, fl: file of Tdoc;
  i:integer = 1;
  temp: TDoc;

begin
  if opendialog1.Execute then begin
    PathStart:= OpenDialog1.FileName;
    AssignFile(fs,PathStart);
    reset(fs);
  end;
  if opendialog1.Execute then begin
    PathLast:= OpenDialog1.FileName;
    AssignFile(fl,PathLast);
    rewrite(fl);
  end;
  for i:= 1 to 30 do begin
    AssignFile(fil[i], 'C:\Users\Кирилл\Desktop\ЛЕКЦИИ\LP\Программирование\Семестр 2\LAB 9\Files\f'+inttostr(i)+'.txt');
    rewrite(fil[i]);
  end;
  i:=0;
  while not EOF(fs) do begin
    while i <= 20 do begin
      read(fs, temp);
      Inc(i);
      write(fil[i], temp);
      if i = 20 then
      i:=0;
    end;
  end;

//for i:= 1 to 20 do begin


  for i:= 1 to 30 do begin
      CloseFile(fil[i]);
   end;
  Closefile(fs);
  Closefile(fl);
end;

end.

