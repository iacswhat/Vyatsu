﻿var
  f1, f2: text;
  s: string;
  i: integer;
  e: char;
  f: boolean;

begin
  e := '2';
  assign(f1, 'vvod.txt');
  assign(f2, 'vivod.txt');
  reset(f1);
  rewrite(f2);
  while not eof(f1) do 
  begin
    f := false;
    readln(f1, s);
    for i := 1 to length(s) do
    begin
      if s[i] = e then
      begin
        f := true;
        break
      end;
    end;
    if f = false then
    begin
      for i := length(s) downto 1 do
      begin
        if s[i] in ['0'..'9'] then
          delete(s, i, 1);
      end;
      writeln(f2, s);
    end;
  end;
  close(f1);
  close(f2);
end.


