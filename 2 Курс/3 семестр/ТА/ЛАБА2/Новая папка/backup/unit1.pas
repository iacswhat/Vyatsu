unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function choose(previousOpponentChoice: integer): integer;
  private

  public

  end;

const
    ROCK: integer = 1; // Камень
    PAPER: integer = 2; // Бумага
    SCISSORS: integer = 3; // Ножницы

    VIN: integer = 1;
    LOSE: integer = -1;
    DRAW: integer = 0;

var
  Form1: TForm1;
  Phod, phodd, Mhod: integer;
    mashod: array of integer;
    mashod1: array of integer;
    resmas: array of integer;
    n: longint;
    prevRes: integer;
    i: longint = 1;
    kkk: longint = 0;
    nnn: longint = 0;
    bbb: longint = 0;
    pk: real = 0;
    pn: real = 0;
    pb: real = 0;
    d,j: longint;
    m1, m2: real;
    setCount: integer;
    winsPerSet: integer;


implementation

{$R *.lfm}

{ TForm1 }


function Tform1.choose(previousOpponentChoice: integer): integer;
begin
  if i = 1 then begin
    choose := 3;
    mashod1[i]:= choose;
  end
    else
  begin
    Phod:=previousOpponentChoice;
    mashod[i-1] := Phod;
    if i mod 2 = 0 then begin
      kkk := 0;
      nnn := 0;
      bbb := 0;

      for d := 1 to i-1 do
      begin
        if mashod[d] = 1 then inc(kkk);
        if mashod[d] = 3 then inc(nnn);
        if mashod[d] = 2 then inc(bbb);
      end;

      pk := kkk / i;
      pn := nnn / i;
      pb := bbb / i;

      m1 := min(pk, pn);
      m2 := min(m1, pb);

      if m2 = pk then choose := 1;
      if m2 = pn then choose := 3;
      if m2 = pb then choose := 2;

      if (pk = pn) and (pk < pb) then choose := 1;
      if (pn = pb) and (pn < pk) then choose := 3;
      if (pk = pb) and (pk < pn) then choose := 2;
      if (pk = pb) and (pk = pn) then choose := 3;
    end
    else
    begin
      if (resmas[i - 1] = LOSE) or (resmas[i - 1] = VIN)  then begin
        if mashod1[i - 1] = 1 then choose := 3;
        if mashod1[i - 1] = 3 then choose := 2;
        if mashod1[i - 1] = 2 then choose := 1;
      end;
      if (resmas[i - 1] = DRAW) then begin
        if mashod1[i - 1] = 1 then choose := 3;
        if mashod1[i - 1] = 3 then choose := 1;
        if mashod1[i - 1] = 2 then choose := 2;
      end;
    end;
    if (resmas[i - 1] = LOSE) and (resmas[i - 2] = LOSE) and (resmas[i - 3] = LOSE) then begin
      if (mashod[i - 1] = mashod[i - 2]) and (mashod[i - 1] = mashod[i - 3]) then begin
        if mashod[i - 1] = 1 then choose := 3;
        if mashod[i - 1] = 3 then choose := 1;
        if mashod[i - 1] = 2 then choose := 2;
      end;
    end;
  end;
  //mashod[i] := Phod;
  mashod1[i]:= choose;
  //writeln('OP ', i-1,' ', mashod[i-1]);
  //writeln('BOT ', mashod1[i]);
  if previousOpponentChoice <> 0 then
  begin
    if ((Mhod=1) and (Phod=3)) or ((Mhod=3)and(Phod=2)) or ((Mhod=2) and (Phod=1)) then
    resmas[i]:= VIN;
    if ((Mhod=3) and (Phod=1)) or ((Mhod=2)and(Phod=3)) or ((Mhod=1)and(Phod=2)) then
    resmas[i]:= LOSE;
    if Mhod=Phod then
    resmas[i]:=DRAW;
  end;
  inc(i);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
setCount:= strtoint(form1.edit1.text);
winsperset:= strtoint(form1.edit2.text);
n:= (setCount * winsPerSet) * 10;
setlength(mashod,n);
setlength(mashod1,n);
setlength(resmas,n);
label1.Caption:=inttostr(n);
for j:=1 to round(length(mashod)/2) do begin
phodd:=random(3)+1;
choose(phodd);
end;

d:=0;
for j:=1 to n do begin
if (mashod[j] = 1) or (mashod[j] = 2) or (mashod[j] = 3) then inc(d);
end;
label2.Caption:=inttostr(d);

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  randomize;
end;

end.

