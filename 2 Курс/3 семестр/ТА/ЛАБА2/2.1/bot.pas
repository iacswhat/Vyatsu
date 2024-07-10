unit bot;

interface

const
  ROCK: integer = 1;
  PAPER: integer = 2;
  SCISSORS: integer = 3;

  VIN: integer = 1;
  LOSE: integer = -1;
  DRAW: integer = 0;

var
  Phod, Mhod: byte;
  mashod: array[1..100] of byte;
  mashod1: array[1..100]of byte;
  resmas: array[1..100] of byte;
  res: char;
  i: integer = 1;
  kkk: integer = 0;
  nnn: integer = 0;
  bbb: integer = 0;
  pk: real = 0;
  pn: real = 0;
  pb: real = 0;
  d: integer;
  m1, m2: real;


procedure setParameters(setCount: integer; winsperset: integer);

procedure onGameStart();

function choose(prevOppChoice: integer; prevRes: byte): integer;

procedure onGameEnd();

implementation

uses
  math;

procedure setParameters(setCount: integer; winsperset: integer);
begin

end;

procedure onGameStart();
begin

end;

function choose(prevOppChoice: integer; prevRes: byte): integer;
begin
  if i = 1 then choose := 3
    else
  begin
    resmas[i] := prevRes;
    mashod[i] := prevOppChoice;

    if i mod 2 = 0 then begin
      kkk := 0;
      nnn := 0;
      bbb := 0;

      for d := 1 to i do
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
  mashod1[i]:= choose;
  inc(i);
end;


procedure onGameEnd();
begin

end;

end.
