unit MODULE;

interface

type
    Tptr = ^Telem;
    Telem = record
        inf : int64;
        link : Tptr;
    end;

var
     top: Tptr;

procedure push(k:int64);
procedure pop;
procedure printFromTop;
procedure printRecFromEnd(pp : Tptr);
procedure delAllStack;
function getCountElem : int64;

implementation

procedure push(k: int64);
var
    p : Tptr;
begin
    new(p);
    p^.link := NIL;
    p^.inf:= k;
    p^.link := top;
    top := p;
end;

procedure pop;
var
    p : Tptr;
begin
    p := top;
    top := p^.link;
    p^.link := NIL;
    dispose(p);
end;

procedure printFromTop;
var
    p : Tptr;
begin
    p := top;
    while(p <> NIL) do
    begin
        write(p^.inf, ' ');
        p := p^.link;
    end;
end;

procedure printRecFromEnd(pp : Tptr);
begin
    if(pp <> NIL) then
    begin
        printRecFromEnd(pp^.link);
        write(pp^.inf, ' ');
    end;
end;

procedure delAllStack;
var
    p : Tptr;
begin
    p := top;
    while(p <> NIL) do
    begin
        top := p^.link;
        p^.link := NIL;
        dispose(p);
        p := top;
    end;
end;

function getCountElem : int64;
var
    p : Tptr;
    k : integer;
begin
    k := 0;
    p := top;
    while(p <> NIL) do
    begin
        k := k + 1;
        p := p^.link;
    end;
    writeln(k);
end;
end.
