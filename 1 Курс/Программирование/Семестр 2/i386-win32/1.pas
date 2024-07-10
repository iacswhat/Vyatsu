program lab5;
type
  mas = array[1..1000000] of longint;
  func = function(x,y: longint):boolean;
var
  f1,f2: text;
  str,s: ansistring;
  i,j,min,t,k,n: longint;
  flag: boolean;
  mas2: mas;
{$F+}
function compdown(x,y: longint): boolean;
  begin
    if x > y then
      flag := true
    else
      flag := false;
  end;
function compup(x,y: longint): boolean;
  begin
    if x < y then
      flag := true
    else
      flag := false;
  end;
{$F-}
procedure merge(var mas1: mas; first,last: longint;f: func);
var
  middle,start,final,j: longint;
  mas2: mas;
begin
  middle:=(first+last) div 2;
  start:=first;
  final:=middle+1;
  for j:=first to last do
  begin
  f(mas1[start], mas1[final]);
    if (start<=middle) and ((final>last) or (flag = true)) then
      begin
        mas2[j]:= mas1[start];
        inc(start);
      end
    else
      begin
        mas2[j]:=mas1[final];
        inc(final);
      end;
      end;
    for j:=first to last do
      mas1[j]:=mas2[j];
end;
procedure MergeSort(var mas1: mas; first, last: longint);
begin
  if first<last then
    begin
      MergeSort(mas1, first, (first+last) div 2);
      MergeSort(mas1, (first+last) div 2+1, last);
      Merge(mas1, first, last,@compdown);
      //Merge(mas1,first,last,@compup);
    end;
end;

procedure schit(str: ansistring);
  begin
    i := 1;
    j := 1;
    s := '';
    while j < n do
      begin
        while i <= length(str) do
          begin
            if str[i] <> ' ' then
              begin
                s := s + str[i];
                inc(i);
              end
            else
              begin
                val(s,mas2[j],k);
                s := '';
                inc(i);
                inc(j);
              end;
          end;
      end;
  end;
begin
  assign(f1,'C:\FPC\3.2.0\bin\i386-win32\input.txt');
  assign(f2,'C:\FPC\3.2.0\bin\i386-win32\output.txt');
  reset(f1);
  rewrite(f2);
  while not eof(f1) do
    begin
      while not eoln(f1) do
        begin
          readln(f1,str);
          val(str,n,k);
          break
        end;
      readln(f1,str);
    end;
  schit(str);
  mergesort(mas2,1,n);
  for i := 1 to n do
  begin
    write(f2, mas2[i], ' ');
  end;

  close(f1);
  close(f2);
end.
