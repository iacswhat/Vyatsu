
program List_LAB;
Uses Crt, list2;
var
    L1,L2,LB : PItem;
    ST,RT: Text;
    curdir:string;

procedure ChangeN(var List : PItem);
var n,i:integer;
    Flag: Boolean;
    Pok: TValue;
    p1,p2: PItem;
begin;
	CreateList(LB);
    While List <> nil do begin
     InsertLast(LB,DeleteLast(List));
    end;
    List:=LB;{}
end;{}

procedure Zadan(FI,FO: String;List: PItem);
var Item : PItem;
	buf: string;
begin
    Assign(ST,FI);Reset(ST);
	Assign(RT,FO);ReWrite(RT);
    CreateList(List);
    Repeat
    	Readln(ST,buf); InsertLast(List,buf);
    Until Eof(ST);
    Writeln(RT,'asfdsfdsfg - ',Size(List));
    Writeln(RT,'dsfg ');
    ChangeN(List); 		{}
    WriteList(RT,List);
    ClearList(List);	{}
    Close(ST);Close(RT);
end;

begin
	curdir:='C:';
	Zadan('FO2_1.txt',L1);{}
	Zadan('FO2_2.txt',L2);{}
end.