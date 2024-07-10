program STACK;
uses
    crt;
type
    Tptr = ^Telem;
    Telem = record
        inf : integer;
        link : Tptr;
    end;
var
    top : Tptr;

procedure push;
var
    p : Tptr;
begin
    new(p);
    p^.link := NIL;
    write('Enter the value of the added element: ');
    readln(p^.inf);
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
    write('Stack elements look like: ');
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

function getCountElem : integer;
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
    getCountElem := k;
end;

function menu : integer;
var
    sel : integer;
begin
    repeat
        clrscr;
        writeln('1 - ADD ITEM TO STACK TOP');
        writeln('2 - REMOVE ITEM FROM STACK TOP');
        writeln('3 - PRINTING STACK ELEMENTS ON SCREEN FROM TOP TO DOWN');
        writeln('4 - PRINTING STACK ON SCREEN FROM BOTTOM TO TOP');
        writeln('5 - TOTAL NUMBER OF ELEMENTS IN A STACK');
        writeln('6 - REMOVING ALL ITEMS FROM THE STACK');
        writeln('7 - EXIT');
        writeln;
        write('Choose one of the suggested items: ');
        readln(sel);
    until((sel >= 1) and (sel <= 7));
    writeln;
    menu := sel;
end;
var
    sel : integer;
begin
    clrscr;
    textColor(WHITE);
    top := NIL;
    repeat
        sel := menu;
        case sel of
            1:
            begin
                push;
                writeln;
                write('New item added successfully!');
                readln;
            end;
            2:
            begin
                if(top = NIL) then
                    writeln('There are no items on the stack to remove!')
                else
                begin
                    pop;
                    writeln;
                    write('Removing an element from the top of the Stack has been successfully completed!');
                end;
                readln;
            end;
            3:
            begin
                if(top = NIL) then
                    write('Items cannot be printed because the Stack is empty!')
                else
                    printFromTop;
                readln;
            end;
            4:
            begin
                if(top = NIL) then
                    write('Items cannot be printed because the Stack is empty!')
                else
                begin
                    write('Stack elements look like: ');
                    printRecFromEnd(top);
                end;
                readln;
            end;
            5:
            begin
                write('Number of Stack Elements: ', getCountElem);
                readln;
            end;
            6:
            begin
                delAllStack;
                write('All Stack elements have been successfully removed!');
                readln;
            end;
        end;
    until(sel = 7);
    delAllStack;
end.
