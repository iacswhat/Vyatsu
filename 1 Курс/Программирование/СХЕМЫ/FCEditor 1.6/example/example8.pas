program MATMAX;
{found max element of massiv}
uses Crt;
Const
	m = 4;{}
  n = 5;{}
type
	mas  = array [0..m-1,0..m-1] of integer;{}
	mas1 = array [0..m-1,0..n-1] of integer;{}
  mas2 = array [0..m-1] of integer;{}
var
	i,j,k,max,lm,mu : integer;{}
	a,x,y : mas ;
  b     : mas1;
  st    : mas2;

procedure showm(mm: mas);
begin
    for i:=0 to m-1 do begin
    for j:=0 to m-1 do
	  Write(' ',mm[i,j]:6);
     Writeln(' ');
    end;
end;

procedure setm(var mm : mas);
begin
	Randomize;{}
	for i:=0 to m-1 do{}
    for j:=0 to m-1 do begin{}
    mm[i,j]:=Round(random(10))-4;{}
    end;
end;

procedure mulM(a1,a2:mas;var res: mas);
begin

 for k:=0 to m-1 do
   for j:=0 to m-1 do
	   res[k,j]:=0;

 for k:=0 to m-1 do
  for j:=0 to m-1 do
   for i:=0 to m-1 do
  	res[k,j]:=res[k,j]+a1[k,i]*a2[i,j];{}
end;

procedure sumM(a1,a2:mas; var res: mas);
begin
	for i:=0 to m-1 do
    for j:=0 to m-1 do
    res[i,j]:=a1[i,j]+a2[i,j];
end;
procedure SB;
begin
  for i:=0 to m-1 do begin
    for j:=0 to n-1 do
	  Write(' ',b[i,j]:6);
     Writeln(' ');
    end;
  Writeln;{}
end;

procedure sort(var ms: mas2);
var xx: integer;
begin
  for i:=1 to m-1 do
    for j:=m-1 downto i do begin
      if ms[j-1]>ms[j] then begin
        xx:=ms[j-1];
        ms[j-1]:=ms[j];
				ms[j]:=xx;
      end;
    end;
end;

begin
	ClrScr;{}
  Setm(x);	showm(x);  Writeln;
  Setm(y);	showm(y);  Writeln;

  MulM(y,y,y);
  MulM(y,x,y);
  MulM(x,x,x);
  MulM(x,x,x);

  SumM(x,y,a);  showm(a);Writeln;{}

	for i:=0 to m-1 do{}
    for j:=0 to n-1 do begin{}
    b[i,j]:=Round(random(10))-4;{}
    end;

  SB;
  for i:=0 to m-1 do st[i]:=b[i,1];
  Sort(st);
  for i:=0 to m-1 do b[i,1]:=st[i];
  SB;

  for i:=0 to m-1 do st[i]:=a[3,i]; Sort(st);
  for i:=0 to m-1 do a[3,i]:=st[i]; Showm(a);

  Readln;
end.