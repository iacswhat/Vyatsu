program Main;

uses summ, Crt;
type
  TMatrix = array [0..RowCount-1] of TStroka;

var
  M: TMatrix;

  procedure SetRandomMatrix(var AMatrix: TMatrix);
  var
	i,j: integer;
  begin
	Randomize;
	for i:=0 to ColCount-1 do
	  for j:=0 to RowCount-1 do
		AMatrix[j][i] := Random(5)+1;
  end;

  procedure WriteMatrix(AMatrix: TMatrix);
  var
	i,j: integer;
  begin
	for j:=0 to RowCount-1 do
	  begin
		for i:=0 to ColCount-1 do
		   Write(AMatrix[j][i]:5);
		writeln;
	  end
  end;

  function SummMatrix(AMatrix: TMatrix): integer;
  var
	j,res: integer;
	str: TStroka;
  begin
	res := 0;
	for j:=0 to RowCount-1 do
	  begin
		str := AMatrix[j];
		res := res + SummStroka(str);
	  end;

	SummMatrix := res;
  end;

begin
  Writeln('Work Unit');
  Writeln('Summ of matrix');

  SetRandomMatrix(M);
  Writeln('Matrix:');
  WriteMatrix(M);
  Write('Summ of matrix: ', SummMatrix(M):5);
end.