program vub;

var
  i, j, max, t: integer;
  a: array [1..10] of integer;

begin
  for i := 1 to 10 do
  begin
    a[i] := random(100);
    write(a[i], ' ')
  end;
  writeln();
  for i := 10 downto 2 do
  begin
    max := i;
    for j := i - 1 downto 1 do
      if a[max] > a[j] then
        max := j;
    if max <> i then begin
      t := a[i];
      a[i] := a[max];
      a[max] := t;
    end;
  end;
  for i := 1 to 10 do
    write(a[i], ' ')
end.
