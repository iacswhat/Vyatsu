unit Search;
Interface
type arr = array[1..5] of integer;
var s: string;
procedure binary_search(x: integer; Ar: arr; var s: string);
procedure line_search(x: integer; Ar: arr; var s: string);
Implementation
var a, b, c, i: integer;
procedure binary_search(x: integer; Ar: arr; var s: string);
begin
a:=1; b:=5; s:='NO';
while a<=b do
begin
c:=a+(b-a) div 2;
if (x<Ar[c]) then
b:=c-1
else if (x>Ar[c]) then
a:=c+1
else
begin s:='YES'; break; end;
end;
end;
procedure line_search(x: integer; Ar: arr; var s: string);
begin
s:='NO';
for i:=1 to 5 do
begin
if (Ar[i]=x) then
begin
s:='YES'; break;
end;
end;
end;
end.
