program lab5;

type
  fun = function(x, y: longint): boolean;
  massiv = array[1..1000001] of longint;

var
  sr: boolean;
  n, i: longint;
  A, mas: massiv;
  f1, f2: text;

{$F+}
function sravndown(x, y: longint): boolean;
begin
  if x < y then
    sr := false
  else
    sr := true;
end;

function sravnup(x, y: longint): boolean;
begin
  if x < y then
    sr := true
  else
    sr := false;
end;
{$F-}

procedure Merge(var A: massiv; first, last: longint);
var
  middle, start, final, j: longint;
begin
  middle := (first + last) div 2;
  start := first;
  final := middle + 1;
  for
  j := first to last do
    begin
    if (start <= middle) and ((final > last) or (A[start] < A[final])) then
    begin
      mas[j] := A[start];
      inc(start);
    end
    else
    begin
      mas[j] := A[final];
      inc(final);
    end;
    end;
  for j := first to last do A[j] := mas[j];
end;

procedure MergeSort(var A: massiv; first, last: longint);
begin
  if first < last then
  begin
    MergeSort(A, first, (first + last) div 2);
    MergeSort(A, (first + last) div 2 + 1, last);
    Merge(A, first, last);
  end;
end;



procedure vuvod(a: massiv; f: fun);
var
i: longint;
begin
f(A[1],A[2]);
  if sr = true then
  begin
  for i := 1 to n do
  begin
    write(f2, a[i], ' ');
  end;
  end
  else
  begin
  for i := n downto 1 do
  begin
    write(f2, a[i], ' ');
  end;
  end;
end;

begin
  assign(f1, 'input.txt' );
  assign(f2, 'output.txt' );
  reset(f1);
  readln(f1,n);
  i:=1;
  while not eof(f1) do
  begin
    read(f1,A[i]);
    inc(i);
  end;
  close(f1);
  mergesort(a, 1, n);
  rewrite(f2);
  vuvod(a, @sravnup);
  //vuvod(a, @sravndown);
  close(f2);
end.
