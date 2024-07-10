program STACK;
uses
    crt;
type
    commands = array of string;
    strr = record
    	text: string;
 	countspaces: integer;
    end;
    Tptr = ^Telem;
    Telem = record
        inf : integer;
        link : Tptr;
    end;

const
    max:integer = 255;
    cmdlist: array of string = (
    	'exit',
	'help',
	'insert',
	'delete',
	'down',
	'up',
	'count',
	'clear'
	);
    windowSize=80;

var
    top : Tptr;
    sel : integer;
    buffer: commands;
    cmdEl: commands;
    curCom: integer = -1;
    bs:string;
    ch: Char;
    s: String;
    x, y: Integer;
    curY: Integer;
    w:boolean = true;
    h:string = '>';

procedure push(k: integer);
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
    writeln(k);
end;

Procedure WriteCom(Var s:String;y:integer);
var i:integer=0;
    a,b,c:integer;
Begin
    gotoxy(1,curY);
    clreol();
    while i<y Do
    begin
        gotoxy(1,wherey()+1);
        clreol();
        inc(i);
    end;

    a:=(x+length(h)+2) mod windowSize;
    if a=0 then
    begin
        a:=x+length(h)+2;
        b:=0;
    end
    else
    begin
        b:=(x+length(h)+2) div windowSize;
    end;

    c:=(x+length(h)+3) div windowSize;
    if curY+c > 25 then
    begin
        curY:=curY-c;
        i:=0;
        while i<c do
        begin
            writeln();
            inc(i);
        end;
    end;
    gotoxy(1,curY);
    write(h,' ');
    write(s);

    gotoxy(a,curY+b);
End;

Procedure DeleteChar(var s:string);
var y:integer;
Begin
    if x>=length(h) then
    begin
        x:=x-1;
        delete(s,x+1,1);
        y:=(length(h)+length(s)+2) div windowSize;
        WriteCom(s,y);
    end;
End;

Procedure AddChar(var s:string;ch:char);
var y:integer;
Begin
    if length(s)<max then
    begin
        x:=x+1;
        s:=copy(s,1,x-1)+ch+copy(s,x,length(s));
        y:=(length(h)+length(s)+2) div windowSize;
        WriteCom(s,y);
    end;
end;

procedure SaveCommand();
var c:integer;
begin
    c:=length(buffer);
    buffer[c-1]:=s;
    setlength(buffer,c+1);
    curCom:=c;
end;

procedure ChangeCommand(c:integer);
var l:integer;
begin
    if curCom >= 0 then
    begin
        y:=(length(h)+length(s)+2) div windowSize;
        buffer[curCom]:=s;
        if (c = 1) and (curCom > 0) then
        begin
            curCom:=curCom-1;
        end
        else if (c = 2) and (curCom < length(buffer)-1) then
        begin
            curCom:=curCom+1;
        end;
        s:=buffer[curCom];
        x:=length(s);
        WriteCom(s,y);
    end;
end;

function RemoveSpaces(s:string):strr;
var i:integer;
    str:strr;
begin
    i:=0;
    while s[i+1]=' ' do i:=i+1;
    delete(s,1,i);
    str.text := s;
    str.countSpaces := i;
    Exit(str);
end;

procedure ParseString(str:string);
var i:integer = 2;
    c:integer = 0;
    s:strr;
begin
    s:=RemoveSpaces(str);
    if length(s.text)>0 then
    begin
        setLength(cmdEl,1);
        cmdEl[c]:=s.text[1];
    end;
    while i <= length(s.text) do
    begin
        if (s.text[i-1]=' ') and (s.text[i]<>' ') then
        begin
            Inc(c);
            setLength(cmdEl,length(cmdEl)+1);
            cmdEl[c]:=s.text[i];
        end
        else if s.text[i]<>' ' then
        begin
            cmdEl[c]:=cmdEl[c]+s.text[i];
        end;
        Inc(i);
    end;
end;

procedure Info();
begin
    writeln('Commands: ');
    writeln('help - shaw all commands;');
    writeln('count - total number of elements in the stack;');
    Writeln('exit - exit the program;');
    Writeln('clear - clear the stack;');
    Writeln('insert <element> - inserting an item at the top of the stack;');
    Writeln('down - printing stack elements on screen from top to down;');
    Writeln('up - printing stack elements on screen from bottom to top;');
    Writeln('delete - removes an item from the top of the stack;');
end;

function NeedArgs(c:integer):boolean;
var i:integer;
begin
    if length(cmdEl)-1 = c then
    begin
        Exit(true);
    end
    else
    begin
        for i:=c+1 to length(cmdEl)-1 do
        begin
            writeln('Unknown argument: ', cmdEl[i]);
        end;
    end;
    Exit(false);
end;

procedure Action(cmd:string);
var a,b:integer;
begin
    case cmd of
        'clear':
            begin
                if NeedArgs(0) then
                begin
                   delAllStack;
                end;
            end;
        'exit':
            begin
                if NeedArgs(0) then
                begin
                    writeln();
                    halt();
                end;
            end;
        'count':
            begin
                if NeedArgs(0) then
                begin
                    getCountElem();
                end;
            end;
        'help':
            begin
                if NeedArgs(0) then
                begin
                    Info();
                end;
            end;
        'insert':
            begin
                if NeedArgs(1) then
                begin
                    val(cmdEl[1],a,b);
                    if b = 0 then
                    begin
                        push(a);
                    end
                    else
                    begin
                        writeln('The argument must be a number!');
                    end;
                end;
            end;
        'down':
            begin
                if NeedArgs(0) then
                begin
                    printFromTop;
                    writeln();
                end;
            end;
         'up':
            begin
                if NeedArgs(0) then
                begin
                    printRecFromEnd(top);
                    writeln();
                end;
            end;
        'delete':
            begin
                if NeedArgs(0) then
                begin
                    pop;
                end;
            end;
        else
            begin
                writeln('There is no such command!');
            end;
    end;
end;

procedure RunCommand();
begin
    ParseString(s);
    if length(cmdEl) > 0 then
    begin
        Action(cmdEl[0]);
    end;
end;

function EnterCommand(y:integer):integer;
var a,b:integer;
begin
    if y<25 then begin
        y:=wherey+1;
    end;
    x:=0;
    b:=(length(s)+length(h)+2) div windowSize;
    if b>0 then
    begin
        a:=(length(s)+length(h)+2) mod windowSize;
    end
    else
    begin
        a:=length(s)+length(h)+2;
    end;
    gotoxy(a,curY+b);
    writeln();
    RunCommand();
    cmdEl:=nil;
    SaveCommand();
    s:='';
    write(h,' ');
    Exit(y);
end;

procedure AutoCompletion();
var
    i:integer;
    str:strr;
begin
    str:=RemoveSpaces(s);
    for i:=0 to length(cmdList)-1 do
    begin
        if pos(str.text,cmdList[i]) = 1 then
        begin
            Delete(s,str.countSpaces+1,Length(s));
            Insert(cmdList[i],s,str.countSpaces+1);
            x:=length(s);
            WriteCom(s,1);
            break;
        end;
    end;
end;

procedure cursorLeft();
var y: integer;
    a,b:integer;
begin
    if x > 0 then begin
        x:=x-1;
        a:=(x+length(h)+2) mod windowSize;
        b:=(x+length(h)+2) div windowSize;
        if a = 0 then
        begin

            a:=(x+length(h)+2) div b;
            b:=b-1;
        end;
        gotoxy(a,curY+b);
    end;
end;

procedure cursorRight(s:string);
var y: integer;
    a,b:integer;
begin
    if x < length(s) then begin
        x:=x+1;
        a:=(x+length(h)+2) mod windowSize;
        b:=(x+length(h)+2) div windowSize;
        if a = 0 then
        begin
            a:=(x+length(h)+2) div b;
            b:=b-1;
        end;
        gotoxy(a,curY+b);
    end;
end;

procedure SpecialKey(s:string);
var code:integer;
    ch:char;
begin
    ch:=ReadKey();
    code:=ord(ch);
    Case code of
        75: //<-
            begin
                cursorLeft();
            end;
        77://->
            begin
                cursorRight(s);
            end;
        72: //up
            begin
                ChangeCommand(1);
            end;
        80: //down
            begin
                ChangeCommand(2);
            end;
    end;
end;

function choiceCommand(ch:char;var y:integer):boolean;
var
    code: Integer;
begin
    code := ord(ch);
    Case code Of
        13: //Enter
            begin
                y:=EnterCommand(y);
                curY:=wherey();
            end;
        8: //Backspace
            begin
                DeleteChar(s);
            end;
        9: //Tab
            begin
                AutoCompletion();
            end;
        0: SpecialKey(s);
        Else
            begin
                AddChar(s,ch);
            end;
    End;
    Exit(true);
end;

begin
    clrscr;
    top := NIL;
    write(h,' ');
    s := '';
    x := 0;
    setlength(buffer,1);
    curY := WhereY();
    While w Do
        Begin

            ch := ReadKey;
            w:=choiceCommand(ch,curY);
        End;
    buffer:=nil;
End.
delAllStack;
end.

