program lab5;

type
  fun = function(x, y: longint): boolean;
  aa = array [1..1001] of longint;

var
  sr: boolean;
  b: aa;
  n, i: longint;
  f1, f2: text;

{$F+}
function sravnup(x, y: longint): boolean;
begin
  if x > y then
    sr := true
  else
    sr := false;
end;

function sravndown(x, y: longint): boolean;
begin
  if x < y then
    sr := true
  else
    sr := false;
end;
{$F-}
procedure vub(a: aa; f: fun);
var
  i, j, min, t: longint;

begin
  for i := 1 to n-1 do
  begin
    min := i;
    for j := i + 1 to n do
    begin
      f(a[min], a[j]);
      if sr then
        min := j;
    end;
    if min <> i then begin
      t := a[i];
      a[i] := a[min];
      a[min] := t;
    end;
  end;
  for i := 1 to n do
    begin
    write(f2, a[i],' ');
    end;
end;

begin
  assign(f1, 'input.txt');
  assign(f2, 'output.txt');
  reset(f1);
  rewrite(f2);
  readln(f1,n);
  i:=1;
  repeat
    read(f1,b[i]);
    inc(i);
  until eof(f1) ;
  vub(b, @sravnup);
  //vub(b, @sravndown);
  close(f1);
  close(f2);
end.
