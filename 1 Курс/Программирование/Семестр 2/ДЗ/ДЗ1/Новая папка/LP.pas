uses
  crt;

procedure vvod;
var
  s: string;
  f1: text;
  i, c, n: integer;
begin
  writeln('Input the number of students');
  readln(n);
  assign(f1, 'vvod.txt');
  rewrite(f1);
  for c := 1 to n do
  begin
    write('Input fam and ocenki(6): ');
    readln(s);
    writeln(f1, s);
  end;
  close(f1);
end;

procedure vivod;
var
  f1, f2: text;
  s: string;
  i, k: integer;
  e: char;

begin
  e := '2';
  assign(f1, 'vvod.txt');
  assign(f2, 'vivod.txt');
  reset(f1);
  rewrite(f2);
  while not eof(f1) do 
  begin
    while not eoln(f1) do 
    begin
      k := 0;
      readln(f1, s);
      for i := 1 to length(s) do
      begin
        if s[i] = e then
          k := k + 1;
      end;
      if k = 0 then
      begin
        writeln(s);
        writeln(f2, s);
      end;
    end;
  end;
  close(f1);
  close(f2);
  readln();
end;

var
  ch: integer;

begin
  repeat
    clrscr;
    writeln('1:Vvod');
    writeln('2:Vivod');
    writeln('0:Exit');
    readln(ch);
    case ch of
      1: vvod;
      2: vivod;
    end;
  until ch = 0;
end.