const
  R = 1000;

var
  f,o : text;
  n, k, s: integer; {вершины, ребра, счетчики}
  i, j, c: integer;
  mas: array[1..R] of integer; {vesa vershin}
  g: array of integer;
  smez: array[1..R, 1..R] of integer;{matrica smezhnosti}

begin
  assign(f, 'C:\Users\Кирилл\Desktop\День 4\task3.txt');
  reset(f);
   assign(o, 'C:\Users\Кирилл\Desktop\День 4\ans3.txt');
  rewrite(o);
  
  readln(f, n);
  for i := 1 to n do 
   // while not EOLN(f) do 
  begin
    read(f, mas[i]);
    write(i, ')', mas[i], ' ');
  end;
  writeln('------------------------------------------------------------');
  
  readln(f, k);
  // writeln(k);
  for c := 1 to k do 
  begin
    read(f, i);
    read(f, j);
    smez[i, j] := 1;
    smez[j, i] := 1;
  end;
  
  for i := 1 to n do
    for j := 1 to n do
      if smez[i, j] <> 1 then smez[i, j] := 0;
    
  {for i := 1 to n do
  begin
    for j := 1 to n do
      write(smez[i, j], ' ');
    writeln;
  end;}
  writeln('------------------------------------------------------------');
  
  setlength(g, 1);
  c := 0;
  g[c]:= 1;
  for i := 1 to n do
  begin
    for j := 0 to c do
    begin
      if smez[i, g[j]] = 1 then break;
      if (j = c) and (smez[i, g[j]] = 0) then
      begin
        inc(c);
        inc(s);
        setlength(g, length(g) + 1);
        g[c]:= i;
      end;
    end;
  end;
  
  {write(1,' ');
  for i:=1 to n do
  begin
    for j:=i+1 to n do
    begin
      if smez[i,j] = 0 then
        begin
        write(j,' ');
        break;
        end;
    end;
  end;}
  writeln(o, s);
  for i := 1 to length(g)-1 do write(o, g[i], ' ');
  close(f);
  close(o);
end.