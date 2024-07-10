unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids, math;
 const
   k=1;
   n=2;
   b=3;
type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure bot2;

  public

  end;

var
  Form1: TForm1;
   Phod,Mhod: byte;
   mashod1: array[1..100]of byte;
   mashod: array[1..100] of byte;
   resmas1: array[1..100] of char;
   resmas: array[1..100] of char;
   i: integer=1;
   c: integer=1;
   j: integer;
   a: byte;
   ki,ni,bi: integer;

   kkk: integer = 0;
   nnn: integer = 0;
   bbb: integer = 0;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.bot2;
   begin

   // бот - нужное
   if i = 1 then mhod:=n;
   if (i > 1) and (i <=3) then begin
   if resmas1[i-1] = 'V' then begin
   if mashod1[i-1] = k then phod:= b;
   if mashod1[i-1] = n then phod:= k;
   if mashod1[i-1] = b then phod:= n;
   end
   else
   if resmas[i-1] = 'P' then begin
   phod:=mashod[i-1]-1;
   if phod < 1 then phod:= b;
   end;
   end;
   if i > 3 then begin
   if resmas1[i-1] = 'N' then begin
   phod:=mashod[i-1]+1;
   if phod > 3 then mhod:= k;
   end;
   if resmas1[i-1] = 'V' then begin
   if mashod1[i-1] = k then phod:= b;
   if mashod1[i-1] = n then phod:= k;
   if mashod1[i-1] = b then phod:= n;
   end
   else
   if resmas1[i-1] = 'P' then begin
   phod:=mashod[i-1]-1;
   if phod < 1 then phod:= b;
   if (mashod[i-1] = mashod[i-2]) and (mashod[i-1] = mashod[i-3]) then begin
   if mashod[i-1] = k then phod:=n;
   if mashod[i-1] = n then phod:=b;
   if mashod[i-1] = b then phod:=k;
   end;
   if i mod 3 = 0 then begin
   phod:=mashod[i - (i div 3)];
   end;
   end;
   if (resmas1[i-1] = 'P') and (resmas1[i-2] = 'P') and (resmas1[i-3] = 'P') then begin
   if (mashod[i-1] = mashod[i-2]) and (mashod[i-1] = mashod[i-3]) then begin
   if mashod[i-1] = k then phod:=n;
   if mashod[i-1] = n then phod:=b;
   if mashod[i-1] = b then phod:=k;
   end;
   end;
   end;
{begin
if c=1 then
Phod:=n
else
begin
if c = 3 then begin
if resmas1[c-1]='V' then begin
Phod:=Phod+1;
if Phod>b then
Phod:=k;
end;
if resmas1[c-1]='P' then begin
phod:=phod-1;
if phod<k then
phod:=b;
end;
end
else
if c = 2 then  begin
for j:=1 to c-1 do begin
  if mashod1[j]=k then begin
  ki:=round((ki+1)+(j*0.2));
  end;
   if mashod1[j]=n then begin
  ni:=round((ni+1)+(j*0.2));
  end;
    if mashod1[j]=b then begin
  bi:=round((bi+1)+(j*0.2));
  end;
    if (ki>ni)then begin
      if (ki>bi) then
       phod:=b;
      if (bi>ki) then
       phod:=n;
      end;
    if (ni>ki)then begin
     if (ni>bi) then
       phod:=k;
     if (bi>ni) then
       phod:=n;
    end;
    end;
  if (mashod1[c-1]=mashod1[c-2]) and (mashod1[c-2]=mashod1[c-3]) then  begin
 if  mashod1[c-1]=k then
 phod:=b;
 if  mashod1[c-1]=n then
 phod:=k;
 if  mashod1[c-1]=b then
 phod:=n;
end;
end;
if c>3 then c:= 1;
   end; }

end;

procedure TForm1.Button1Click(Sender: TObject);
var
   vv: integer = 0;
   pp: integer = 0;
   nn: integer = 0;
   pk: real = 0;
   pn: real = 0;
   pb: real = 0;
   s:integer;
   d: integer;
   m1, m2:real;
begin

if i = 1 then Mhod:= n
else
begin
if i mod 2 = 0 then begin
kkk:=0;
nnn:=0;
bbb:=0;

for d:=1 to i do begin
if mashod[d]=k then inc(kkk);
if mashod[d]=n then inc(nnn);
if mashod[d]=b then inc(bbb);
end;

pk:=kkk/i;
pn:=nnn/i;
pb:=bbb/i;

m1:=min(pk,pn);
m2:=min(m1,pb);

if m2 = pk then mhod:= b;
if m2 = pn then mhod:= k;
if m2 = pb then mhod:= n;

if (pk = pn) and (pk < pb) then mhod:=k;
if (pn = pb) and (pn < pk) then mhod:=n;
if (pk = pb) and (pk < pn) then mhod:=b;
if (pk = pb) and (pk = pn) then mhod:=2;

if (resmas[i-1] = 'P') and (resmas[i-2] = 'P') and (resmas[i-3] = 'P') then begin
if (mashod[i-1] = mashod[i-2]) and (mashod[i-1] = mashod[i-3]) then begin
if mashod[i-1] = k then mhod:=b;
if mashod[i-1] = n then mhod:=k;
if mashod[i-1] = b then mhod:=n;
end;
end;
end
else
begin
 if (resmas[i-1] = 'P') or (resmas[i-1] = 'V')  then begin
 if mashod1[i-1] = k then mhod:= n;
 if mashod1[i-1] = n then mhod:= b;
 if mashod1[i-1] = b then mhod:= k;
 end;
 if (resmas[i-1] = 'N') then begin
 if mashod1[i-1] = k then mhod:= b;
 if mashod1[i-1] = n then mhod:= k;
 if mashod1[i-1] = b then mhod:= n;
 end;
end;
end;



// бот - нужное


// сохранение массива(бот+) - нужное
//phod:=strtoint(form1.Edit1.Text);
phod:=random(3)+1;
//Phod:=strtoint(Edit1.text);
mashod[i]:=Phod;
mashod1[i]:=mhod;

//таблица
//stringgrid1.RowCount:=stringgrid1.RowCount+1;
stringgrid1.Cells[0,i]:=inttostr(i);
stringgrid1.Cells[1,i]:=inttostr(Phod);
stringgrid1.Cells[2,i]:=inttostr(Mhod);
Edit1.text:='';



// результат
if ((Mhod=k) and (Phod=n)) or ((Mhod=n)and(Phod=b)) or ((Mhod=b) and (Phod=k)) then begin
stringgrid1.Cells[3,i]:=('Победа');
resmas[i]:='V';
end;
if ((Mhod=n) and (Phod=k)) or ((Mhod=b)and(Phod=n)) or ((Mhod=k)and(Phod=b)) then begin
stringgrid1.Cells[b,i]:=('Поражение');
resmas[i]:='P';
end;
if Mhod=Phod then   begin
stringgrid1.Cells[b,i]:=('Ничья');
resmas[i]:='N';
end;

for j:=1 to i do begin
if resmas[j] = 'V' then inc(vv);
if resmas[j] = 'P' then inc(pp);
if resmas[j] = 'N' then inc(nn);
end;

form1.Label2.Caption:=floattostr(vv);
form1.Label3.Caption:=floattostr(pp);
form1.Label4.Caption:=floattostr(nn);
form1.Label5.Caption:=floattostr(m1);
form1.Label6.Caption:=floattostr(m2);

//статистика
Label1.Caption:='Length(mashod):'+inttostr(Length(mashod))+'-ход:'+inttostr(i);
for j:= 1 to i do begin
//stringgrid2.RowCount:=stringgrid2.RowCount+1;
stringgrid2.Cells[0,j]:=inttostr(j);
stringgrid2.Cells[1,j]:=inttostr(mashod[j]);
stringgrid2.Cells[2,j]:=resmas[j];
 end;


// i+1(бот+) - нужное
i:=i+1;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
randomize;
  //SetLength(mashod,1);
  //SetLength(resmas,1);
end;

end.

