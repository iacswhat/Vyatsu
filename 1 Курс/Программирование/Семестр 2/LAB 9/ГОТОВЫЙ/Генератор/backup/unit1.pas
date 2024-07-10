unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Choose: TButton;
    Generate: TButton;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    procedure ChooseClick(Sender: TObject);
    procedure GenerateClick(Sender: TObject);
  private

  public

  end;

  TDoc = record
    Name: string[100];
    day, month, year: integer;
    money: longint;
  end;


var
  Form1: TForm1;
  path: string;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ChooseClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  path:= OpenDialog1.FileName;
end;

procedure TForm1.GenerateClick(Sender: TObject);
const
char: array[1..26] of char = ('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z');
var
  Doc: Tdoc;
  a: integer;
  f: file of TDoc;
  i,j: longint;
begin
  randomize;
  AssignFile(f, Path);
  Rewrite(f);
  For i := 1 to 160 do begin
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

end.

