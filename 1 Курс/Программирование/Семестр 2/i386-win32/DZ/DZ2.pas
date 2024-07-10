program dz2;

type
  sch = record
    n: integer;
    val: string[4];
    mon: integer;
  end;

var
  s:sch;
  buf: array [1..5] of sch;
  f1: file of sch;
  f2: file;
  i, k: integer;


begin
  assign(f1, 'input.txt');
  assign(f2, 'output.txt');
  reset(f1);
  rewrite(f2);
  i := 0;
  while not eof(f1) do
  begin
    inc(i);
    read(f1, buf[i]);
    if i = 5 then begin
      blockwrite(f2, buf, 1);
      i := 0;
    end;
  end;

  close(f1);
  close(f2);
end.
