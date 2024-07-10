program olga_Gauss;

uses crt;
Const
     n = 2;
Type
	Data = array [0..n,0..n+1] of extended;
Const
	A : Data =
   (( 4.42,12.64,-5.77,-1.56),
     (0.16,-3.82, 6.41, 4.42),
     (-7.14,4.98,-8.73,-2.67));
var
    M:Data;                   
    X,Z,B: array [1..3] of extended; 
    i,j,l,k:integer;
    c: extended;
    max,max1: extended;
begin
	ClrScr;
	for k:=0 to n do
	for i:=0 to n do begin
		if i=k then
        	begin c:=A[i,k];
		    for j:=0 to n+1 do
        		A[i,j]:=A[i,j]/c;
            end
        else
        	begin c:=A[k,k]/A[i,k];
	        for j:=0 to n+1 do
        		A[i,j]:=A[i,j]*c-A[k,j];
                end;
    end;



	for i:=0 to n do {вывод результатов итерации}
    Writeln('x',i,' = ',A[i,n+1]/A[i,i]);

end.