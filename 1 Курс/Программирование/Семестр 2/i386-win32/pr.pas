program modul_search;
uses Crt, Search;
var
mas: array[1..5] of integer;
n, j: integer; str: string;
y: char;
begin
clrscr;
writeln(`Enter the array elements');
for j:=1 to 5 do
readln(mas[j]);
write(`Enter number search: `); readln(n);
write(`This array is ordered? (y/n) `); readln(y);
if y=`y' then binary_search(n, mas, str)
else line_search(n, mas, str);
write(str);
readkey;
end.
