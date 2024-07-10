unit summ;

interface

Const
  ColCount = 5;
  RowCount = 4;

type
  TStroka = array [0..Colcount-1] of integer;

function SummStroka(AStroka: TStroka): integer;

implementation

function SummStroka(AStroka: TStroka): integer;
var
  i, r: integer;
begin
  r := 0;
  for i := 0 to ColCount-1 do
	r := r + AStroka[i];
  SummStroka := r;
end;

begin
end.