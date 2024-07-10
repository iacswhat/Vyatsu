program vub;

var
  i, j, min, t: integer;
  a: array [1..10] of integer;

begin
  for i := 1 to 10 do
  begin
    a[i] := random(100);
    write(a[i], ' ')
  end;
  writeln();
  for i := 1 to 9 do
  begin
    min := i;
    for j := i + 1 to 10 do
      if a[min] > a[j] then
        min := j;
    if min <> i then begin
      t := a[i];
      a[i] := a[min];
      a[min] := t;
    end;
  end;
  for i := 1 to 10 do
    write(a[i], ' ')
end.
