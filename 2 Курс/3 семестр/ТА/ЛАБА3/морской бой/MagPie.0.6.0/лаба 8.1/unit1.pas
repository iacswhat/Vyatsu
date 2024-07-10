unit Unit1;

{$mode objfpc}{$H+}

interface

uses
Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls;

type

{ TForm1 }
TXYZ =record
X:real;
Y:real;
Z:real;
end;
DeviationsXYZ =record
DeviationsX:real;
DeviationsY:real;
DeviationsZ:real;
end;
LinePoints =record
PointsOne:integer;
PointsTwo:integer;
PointsThree:integer;
end;
PointsXY = record
X:integer;
Y:integer;
end;

TForm1 = class(TForm)
B1: TButton;
B2: TButton;
Button30: TButton;
Button20: TButton;
Button21: TButton;
B4: TButton;
B3: TButton;
MainMenu1: TMainMenu;
MenuItem1: TMenuItem;
OpenDialog1: TOpenDialog;
procedure B1Click(Sender: TObject);
procedure B2Click(Sender: TObject);
procedure B3Click(Sender: TObject);
procedure B4Click(Sender: TObject);
procedure Button20Click(Sender: TObject);
procedure Button21Click(Sender: TObject);
procedure Button2Click(Sender: TObject);
procedure Button30Click(Sender: TObject);
procedure Button3Click(Sender: TObject);
procedure Button4Click(Sender: TObject);
procedure Button5Click(Sender: TObject);
procedure Button6Click(Sender: TObject);
procedure MenuItem1Click(Sender: TObject);
procedure MenuItem2Click(Sender: TObject);
procedure proections(k, p: real);
procedure draw;
procedure proections1(k, p: real);
procedure proections2(k, p: real);
procedure proections3(k, p: real);
procedure helper;
procedure povorot(q:real);
procedure ReadFile();
private

public

end;
var
Form1: TForm1;
p: real=20;
f: real=0;
nn: integer=1;
vp: integer=1;
help:array of DeviationsXYZ;
STRCountXYZ,STRCountLine,STRCount,one,StrVarX,StrVarY,StrVarZ:string;
CountXYZ,CountLine,Count,sx,sy,b:integer;
o: integer;
q: real;
xx,xy: integer;
VarX,VarY,VarZ,MaxDeviations,MinDeviations:real;
MasDeviations:array of DeviationsXYZ;
MasDeviations2:array of DeviationsXYZ;
MasLinePoints:array of LinePoints;
MasPointsXY:array of PointsXY;
MasPointsXY2:array of PointsXY;

implementation

{$R *.lfm}

{ TForm1 }



procedure TForm1.B1Click(Sender: TObject);
begin
xy:=xy-100;
Canvas.Brush.Color:=form1.Color;
Canvas.FillRect(Canvas.ClipRect);
proections(p*Pi/180,f*Pi/180);
Canvas.Pen.Color:=clBlack;
draw;
end;

procedure TForm1.B2Click(Sender: TObject);
begin
xy:=xy+100;
Canvas.Brush.Color:=form1.Color;
Canvas.FillRect(Canvas.ClipRect);
proections(p*Pi/180,f*Pi/180);
Canvas.Pen.Color:=clBlack;
draw;
end;

procedure TForm1.B3Click(Sender: TObject);
begin
xx:=xx-100;
Canvas.Brush.Color:=form1.Color;
Canvas.FillRect(Canvas.ClipRect);
proections(p*Pi/180,f*Pi/180);
Canvas.Pen.Color:=clBlack;
draw;
end;

procedure TForm1.B4Click(Sender: TObject);
begin
xx:=xx+100;
Canvas.Brush.Color:=form1.Color;
Canvas.FillRect(Canvas.ClipRect);
proections(p*Pi/180,f*Pi/180);
Canvas.Pen.Color:=clBlack;
draw;
end;

procedure TForm1.Button20Click(Sender: TObject);
var i: integer;
begin
xx:=round(xx*1.1);
xy:=round(xy*1.5);
for i:=0 to CountXYZ-1 do
begin
MasDeviations[i].DeviationsX:=(MasDeviations[i].DeviationsX)*2;
MasDeviations[i].DeviationsY:=(MasDeviations[i].DeviationsY)*2;
MasDeviations[i].DeviationsZ:=(MasDeviations[i].DeviationsZ)*2;
end;
o:=o+2;
Canvas.Brush.Color:=form1.Color;
Canvas.FillRect(Canvas.ClipRect);
proections(p*Pi/180,f*Pi/180);
Canvas.Pen.Color:=clBlack;
draw;
end;

procedure TForm1.Button21Click(Sender: TObject);
var i: integer;
begin
xx:=round(xx/1.1);
xy:=round(xy/1.5);
for i:=0 to CountXYZ-1 do
begin
MasDeviations[i].DeviationsX:=(MasDeviations[i].DeviationsX)/2;
MasDeviations[i].DeviationsY:=(MasDeviations[i].DeviationsY)/2;
MasDeviations[i].DeviationsZ:=(MasDeviations[i].DeviationsZ)/2;
end;
o:=o-2;
Canvas.Brush.Color:=form1.Color;
Canvas.FillRect(Canvas.ClipRect);
proections(p*Pi/180,f*Pi/180);
Canvas.Pen.Color:=clBlack;
draw;
end;
procedure TForm1.Button30Click(Sender: TObject);
begin
  q:=0.1;
Canvas.Brush.Color:=clWhite;
Canvas.FillRect(Canvas.ClipRect);
povorot(q);
proections(p*Pi/180,f*Pi/180);
Canvas.Pen.Color:=clBlack;
draw;
end;
procedure TForm1.helper;
var i: longint;
begin
for i:=0 to countxyz-1 do begin
help[i].DeviationsX:=MasDeviations[i].DeviationsX;
help[i].DeviationsY:=MasDeviations[i].DeviationsY;
help[i].DeviationsZ:=MasDeviations[i].DeviationsZ;
end;
end;
procedure TForm1.povorot(q:real);
var i: longint;
begin
{helper;
for i:=0 to countxyz-1 do begin
MasDeviations[i].DeviationsX:=help[i].DeviationsX;
MasDeviations[i].DeviationsY:=round( help[i].DeviationsY*Cos(q)-help[i].DeviationsZ*Sin(q) );
MasDeviations[i].DeviationsZ:=round( help[i].DeviationsY*Sin(q)+help[i].DeviationsZ*Cos(q) );
end;    }


helper;
for i:=0 to countxyz-1 do begin
MasDeviations[i].DeviationsX:=round( help[i].DeviationsX*Cos(q)+help[i].DeviationsZ*Sin(q) );
MasDeviations[i].DeviationsY:=help[i].DeviationsY;
MasDeviations[i].DeviationsZ:=round( -help[i].DeviationsX*Sin(q)+help[i].DeviationsZ*Cos(q) );
end;


end;
procedure TForm1.draw;
var i:integer;
begin
for i:=0 to CountLine-1 do
begin
Canvas.Line(MasPointsXY[MasLinePoints[i].PointsOne].x*o+xx, MasPointsXY[MasLinePoints[i].PointsOne].y*o+xy, MasPointsXY[MasLinePoints[i].PointsTwo].x*o+xx, MasPointsXY[MasLinePoints[i].PointsTwo].y*o+xy);
Canvas.Line(MasPointsXY[MasLinePoints[i].PointsTwo].x*o+xx, MasPointsXY[MasLinePoints[i].PointsTwo].y*o+xy, MasPointsXY[MasLinePoints[i].PointsThree].x*o+xx, MasPointsXY[MasLinePoints[i].PointsThree].y*o+xy);
Canvas.Line(MasPointsXY[MasLinePoints[i].PointsThree].x*o+xx, MasPointsXY[MasLinePoints[i].PointsThree].y*o+xy, MasPointsXY[MasLinePoints[i].PointsOne].x*o+xx, MasPointsXY[MasLinePoints[i].PointsOne].y*o+xy);
end;
end;

procedure TForm1.proections(k, p: real);
Var i:integer;
begin
for i:=0 to CountXYZ-1 do begin
MasPointsXY[i].X:=round(MasDeviations[i].DeviationsX*cos(p)+MasDeviations[i].DeviationsZ*sin(p));
MasPointsXY[i].Y:=round(-MasDeviations[i].DeviationsX*sin(k)*sin(p)+MasDeviations[i].DeviationsY*cos(k) +MasDeviations[i].DeviationsZ*sin(k)*cos(p));
end;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
var filename:string;
    txt1:text;
    pp: string;
n,i:integer;
Transform:string;
begin
MaxDeviations:=0;
MinDeviations:=0;
If OpenDialog1.Execute then begin
filename:=OpenDialog1.FileName;
AssignFile(txt1,filename);
reset(txt1);
readln(txt1,pp);
readln(txt1,Transform);
n:=Pos(' ',Transform);
STRCountXYZ:=Copy (Transform, 0, n-1);
Delete(Transform,1,n);
n:=Pos(' ',Transform);
STRCountLine:=Copy(Transform, 0, n-1);
Delete (Transform, 1,n);
STRCount:=Copy (Transform, 0, Transform.Length);
CountXYZ:=strtoint(STRCountXYZ);
CountLine:=strtoint(STRCountLine);
Count:=strtoint(STRCount);

SetLength(MasDeviations,CountXYZ);SetLength(MasDeviations2,CountXYZ); SetLength(help,CountXYZ);
SetLength(MasPointsXY,CountXYZ);

for i:=0 to CountXYZ-1 do
begin
readln(txt1,Transform);
n:=Pos(' ',Transform);
StrVarX:=Copy (Transform, 0, n-1);
Delete(Transform,1,n);
n:=Pos(' ',Transform);
StrVarY:=Copy(Transform, 0, n-1);
Delete (Transform,1,n);
StrVarZ:=Copy (Transform, 0, Transform.Length);
VarX:=strtoFloat(StrVarX);
VarY:=strtoFloat(StrVarY);
VarZ:=strtoFloat(StrVarZ);
if VarX >MaxDeviations then MaxDeviations:=VarX;
if VarY >MaxDeviations then MaxDeviations:=VarY;
if VarZ >MaxDeviations then MaxDeviations:=VarZ;
if VarX <MinDeviations then MinDeviations:=VarX;
if VarY <MinDeviations then MinDeviations:=VarY;
if VarZ <MinDeviations then MinDeviations:=VarZ;
MasDeviations[i].DeviationsX:=VarX*300;
MasDeviations[i].DeviationsY:=-VarY*300;
MasDeviations[i].DeviationsZ:=VarZ*300;
end;

SetLength(MasLinePoints,CountLine);
for i:=0 to CountLine-1 do
begin
readln(txt1,Transform);
n:=Pos(' ',Transform);
StrVarX:=Copy (Transform, 0, n-1);
Delete(Transform,1,n);

n:=Pos(' ',Transform);
StrVarX:=Copy(Transform, 0, n-1);
Delete (Transform,1,n);
MasLinePoints[i].PointsOne:=strtoint(StrVarX);

n:=Pos(' ',Transform);
StrVarY:=Copy(Transform, 0, n-1);
Delete (Transform,1,n);
MasLinePoints[i].PointsTwo:=strtoint(StrVarY);

StrVarZ:=Copy (Transform, 0, Transform.Length);
MasLinePoints[i].PointsThree:=strtoint(StrVarZ);
end;
closefile(txt1);
end;
xx:=450;xy:=450;
o:=3;
Canvas.Brush.Color:=form1.Color;
Canvas.FillRect(Canvas.ClipRect);
proections(p*Pi/180,f*Pi/180);
Canvas.Pen.Color:=clBlack;
draw;
end;
procedure TForm1.MenuItem2Click(Sender: TObject);
begin
if opendialog1.Execute then
ReadFile();
end;
procedure Tform1.ReadFile();
var i:byte;
    f1:text;
    a,b,c:real;
    j: integer;
    tg,tg1: string;
begin
j:=0;
assignfile(f1,opendialog1.filename);
reset(f1);
readln(f1,tg);
read(f1,CountXYZ);
readln(f1, CountLine);
SetLength(MasDeviations,CountXYZ);
SetLength(MasLinePoints,CountLine);
SetLength(MasDeviations2,CountXYZ);
SetLength(MasPointsXY,CountXYZ);
while j<CountXYZ do
  begin
   read(f1,varx);
   read(f1,vary);
   readln(f1,varz);
if VarX >MaxDeviations then MaxDeviations:=VarX;
if VarY >MaxDeviations then MaxDeviations:=VarY;
if VarZ >MaxDeviations then MaxDeviations:=VarZ;
if VarX <MinDeviations then MinDeviations:=VarX;
if VarY <MinDeviations then MinDeviations:=VarY;
if VarZ <MinDeviations then MinDeviations:=VarZ;
     MasDeviations[j].DeviationsX:=varx*10;
     MasDeviations[j].DeviationsY:=vary*10;
     MasDeviations[j].DeviationsZ:=varz*10;
      j:=j+1;
  end;
j:=0;
while j<(CountLine) do
  begin
  read(f1,tg1);
   read(f1,MasLinePoints[j].PointsOne);
   read(f1,MasLinePoints[j].PointsTwo);
   readln(f1,MasLinePoints[j].PointsThree);
      j:=j+1;
  end;
closefile(f1);
end;


procedure TForm1.proections1(k, p: real);
Var i:integer;
begin
for i:=0 to CountXYZ-1 do begin
MasPointsXY[i].X:=round(MasDeviations[i].DeviationsZ*cos(p));
MasPointsXY[i].Y:=round(-MasDeviations[i].DeviationsZ*sin(k)*sin(p)+MasDeviations[i].DeviationsY*cos(k));
end;
end;

procedure TForm1.proections2(k, p: real);
Var i:integer;
begin
for i:=0 to CountXYZ-1 do begin
MasPointsXY[i].X:=round(MasDeviations[i].DeviationsX*cos(p)+MasDeviations[i].DeviationsZ*sin(p));
MasPointsXY[i].Y:=round(-MasDeviations[i].DeviationsX*sin(k)*sin(p)+MasDeviations[i].DeviationsZ*cos(k) +MasDeviations[i].DeviationsZ*sin(k)*cos(p));

end;
end;

procedure TForm1.proections3(k, p: real);
Var i:integer;
begin
for i:=0 to CountXYZ-1 do begin
MasPointsXY[i].X:=round(MasDeviations[i].DeviationsX*cos(p));
MasPointsXY[i].Y:=round(-MasDeviations[i].DeviationsX*sin(k)*sin(p)+MasDeviations[i].DeviationsY*cos(k));
end;
end;

procedure TForm1.Button3Click(Sender: TObject);
Var i:integer;
begin
proections3(p*Pi/180,f*Pi/180);
Canvas.Pen.Color:=clBlack;
draw;
end;

procedure TForm1.Button4Click(Sender: TObject);
Var i:integer;
begin
proections2(p*Pi/180,f*Pi/180);
Canvas.Pen.Color:=clBlack;
draw;
end;

procedure TForm1.Button5Click(Sender: TObject);
Var i:integer;
begin

proections1(p*Pi/180,f*Pi/180);
Canvas.Pen.Color:=clBlack;
draw;
end;

procedure TForm1.Button6Click(Sender: TObject);
var i:integer;
begin
//sx:=350;sy:=360;
b:=200;
for i:=0 to CountXYZ-1 do begin
MasDeviations2[i].DeviationsX:=MasDeviations[i].DeviationsX;
MasDeviations2[i].DeviationsY:=MasDeviations[i].DeviationsY;
MasDeviations2[i].DeviationsZ:=MasDeviations[i].DeviationsZ;
end;
for i:=0 to CountXYZ-1 do begin
MasDeviations[i].DeviationsX:=round(MasDeviations2[i].DeviationsX/((MasDeviations[i].DeviationsZ/b)+1));
MasDeviations[i].DeviationsY:=round(MasDeviations2[i].DeviationsY/((MasDeviations[i].DeviationsZ/b)+1));
MasDeviations[i].DeviationsZ:=0;
end;

proections(p*Pi/180,f*Pi/180);
draw;
end;
procedure TForm1.Button2Click(Sender: TObject);
begin
Canvas.Pen.Color:=clWhite;
draw;
end;



end.

