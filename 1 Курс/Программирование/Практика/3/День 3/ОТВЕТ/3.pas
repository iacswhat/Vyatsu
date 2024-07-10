const
  nd = 15;
 
type
  arr = array[1..nd] of integer;
 
const
  d: arr = (1297, 5651, 6959, 10799, 12547, 15161, 16223, 16417, 17681, 18541, 20411, 23563, 26591, 27943, 28513);
  p: arr = (6, 2, 5, 2, 1, 4, 1, 4, 4, 4, 6, 6, 7, 1, 3);
  n = 17;
  m = 100000000000000;
  mn = 2963520000;
  s: string=' ';
 
 
var
  f:text;
  a: array[1..n] of uint64;
  i, j, c, k: integer;
  q, b, v: longword;
  r: arr;
 
begin
  assign(f, 'C:\Users\Кирилл\Desktop\День 3\ОТВЕТ\ans2.txt');
  rewrite(f);
  write('Start number (1..', mn, '): ');
  readln(b);
  write('Count (1..', mn, '): ');
  readln(q);
  v := b - 1;
  for i := 1 to nd do
    begin
      r[i] := v mod (p[i] + 1);
      v := v div (p[i] + 1)
    end;
  dec(r[1]);
  repeat {начало цикла вычисления делителей}
    //write(b:10, ' |'); //раскомментировать для печати номеров делителей
    inc(b);
    {вычисляем и печатаем очередной набор степеней для простых делителей}
    dec(q);
    c := 1; {перенос}
    for i := 1 to nd do
      begin
        r[i] += c;
        if r[i] > p[i] then
          begin
            r[i] := 0;
            c := 1
          end
        else c := 0;
        //write(r[i]:2) //раскоментировать для печати набора степеней
      end;
    //writeln; раскомментировать для печати набора степеней
    {пока очередной делитель равен 1}
    a[1] := 1;
    for i := 2 to n do a[i] := 0;
    {перемножаем очередной делитель на каждый простой делитель d[i], r[i] раз}
    for i := 1 to nd do
      for j := 1 to r[i] do
        begin
          for k := 1 to n do a[k] := a[k] * d[i];
          for k := 1 to n - 1 do
            begin
              a[k + 1] := a[k + 1] + a[k] div m;
              a[k] := a[k] mod m
            end
        end;
    {печатаем найденный делитель}
    k := n;
    while a[k] = 0 do dec(k);
    write(f,a[k]);
    // write(a[k]);  
    
    for k := k - 1 downto 1 do
      begin
        c := m div 10;
        while (c > 10) and (c > a[k]) do
          begin
            write(f,'0');
            c := c div 10
          end;
      //  write(a[k]);  
        write(f,a[k]);
      end;
    //writeln;
    writeln(f,s);
  until (q = 0) or (b > mn); {конец цикла вычисления делителей}
  close(f);
  readln
end.