program MATMAX;
{found max element of massiv}
uses Crt;
Const
	m = 5;{}
  n = 6;{}
type
	mas = array [0..m-1,0..n-1] of integer;{}
var
	i,j,max,lm,mu : integer;{}
	a,b,c,c1,c2 : mas;

procedure showm(mm: mas );
begin
    for i:=0 to m-1 do begin
    for j:=0 to n-1 do
	  Write(' ',mm[i,j]:6);
     Writeln(' ');
    end;
end;

procedure setm(var mm : mas);
begin
	Randomize;{}
	for i:=0 to m-1 do{}
    for j:=0 to n-1 do begin{}
    mm[i,j]:=Round(random(100));{}
    end;
end;

procedure mulK(a1:mas;k: integer;var res: mas);
begin
	for i:=0 to m-1 do
    for j:=0 to n-1 do
    res[i,j]:=a1[i,j]*k;
end;

procedure sumM(a1,a2:mas; var res: mas);
begin
	for i:=0 to m-1 do
    for j:=0 to n-1 do
    res[i,j]:=a1[i,j]+a2[i,j];
end;

begin
	ClrScr;{}
  Setm(a);	showm(a);
  Writeln;

  lm:=2;
  mu:=3;

  MulK(a,lm,b);  showm(b);
  Writeln;

  MulK(b,lm,c1);
  MulK(a,mu,c2);
  SumM(c1,c2,c);

  showm(c);

  Readln;
end.