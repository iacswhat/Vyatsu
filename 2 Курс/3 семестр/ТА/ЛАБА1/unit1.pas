unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  StdCtrls, MaskEdit;

type

  { TForm1 }

   arr = array[0..35] of integer;
   ar = array of integer;

   Best = record
     x,y:integer;
   end;

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Edit1: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    P4: TPanel;
    S1: TPanel;
    S2: TPanel;
    Panel1: TPanel;
    P1: TPanel;
    P2: TPanel;
    P3: TPanel;
    RadioGroup1: TRadioGroup;
    SaveDialog1: TSaveDialog;
    StaticText1: TStaticText;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure P1Click(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
  private
    procedure init;
    procedure Draw_cross;
    procedure Draw_circ;
    Function iswinner(user: byte): Boolean;
    procedure hod;

    {function emptyindices(boardd: arr): ar;
    function win(board: arr; user: byte): boolean;
    function minimax(newboard: arr; player: integer):integer;  }

  public

  end;

var
  Form1: TForm1;
  isuser1,isgame,ischoose, ispause: Boolean;
  score: array[1..2,0..35] of Boolean;
  map: array [0..5,0..5] of integer;
  current: integer;
  step: byte;
  inx,iny: Integer;
  num:integer;
  Col,pol,sim: Tcolor;
  mascol: array[1..2] of Tcolor;
  s1,s2: string;
  GetTime,Fdatetime: Tdatetime;
  t: integer;
  b1, emptyboard: arr;
  scor, bestscore: integer;
  bestmove: best;
  lol:integer;
  s: integer;
implementation

{$R *.lfm}

{ TForm1 }


{function Tform1.emptyindices(boardd: arr): ar;
var
  i: integer;
  k:integer;
  e: ar;
begin
  if boardd[i] = 0 then
  begin
  setlength(e, i+1);
  e[i]:=i;
  end
  else
  begin
  setlength(e, i+1);
  e[i]:=-1;
  end;

  k:=-1;
  for i:=0 to length(e)-1 do
  begin
  if e[i] <> -1 then
  begin
    inc(k);
    setlength(emptyindices,i+1);
    emptyindices[k]:=e[i];
  end;
  end;
  setlength(emptyindices,k+1);


end;}

{function TForm1.win(board: arr; user: byte): boolean;
begin

  result:= ((board[0] = user) and (board[1] = user) and (board[2] = user) and (board[3] = user)) or ((board[1] = user) and (board[2] = user) and (board[3] = user) and (board[4] = user)) or ((board[2] = user) and (board[3] = user) and (board[4] = user) and (board[5] = user)) or
           ((board[6] = user) and (board[7] = user) and (board[8] = user) and (board[9] = user)) or ((board[7] = user) and (board[8] = user) and (board[9] = user) and (board[10] = user)) or ((board[8] = user) and (board[9] = user) and (board[10] = user) and (board[11] = user)) or
           ((board[12] = user) and (board[13] = user) and (board[14] = user) and (board[15] = user)) or ((board[13] = user) and (board[14] = user) and (board[15] = user) and (board[16] = user)) or ((board[14] = user) and (board[15] = user) and (board[16] = user) and (board[17] = user)) or
           ((board[18] = user) and (board[19] = user) and (board[20] = user) and (board[21] = user)) or ((board[19] = user) and (board[20] = user) and (board[21] = user) and (board[22] = user)) or ((board[20] = user) and (board[21] = user) and (board[22] = user) and (board[23] = user)) or
           ((board[24] = user) and (board[25] = user) and (board[26] = user) and (board[27] = user)) or ((board[25] = user) and (board[26] = user) and (board[27] = user) and (board[28] = user)) or ((board[26] = user) and (board[27] = user) and (board[28] = user) and (board[29] = user)) or
           ((board[30] = user) and (board[31] = user) and (board[32] = user) and (board[33] = user)) or ((board[31] = user) and (board[32] = user) and (board[33] = user) and (board[34] = user)) or ((board[32] = user) and (board[33] = user) and (board[34] = user) and (board[35] = user)) or

           ((board[0] = user) and (board[6] = user) and (board[12] = user) and (board[18] = user)) or ((board[6] = user) and (board[12] = user) and (board[18] = user) and (board[24] = user)) or ((board[12] = user) and (board[18] = user) and (board[24] = user) and (board[30] = user)) or
           ((board[1] = user) and (board[7] = user) and (board[13] = user) and (board[19] = user)) or ((board[7] = user) and (board[13] = user) and (board[19] = user) and (board[25] = user)) or ((board[13] = user) and (board[19] = user) and (board[25] = user) and (board[31] = user)) or
           ((board[2] = user) and (board[8] = user) and (board[14] = user) and (board[20] = user)) or ((board[8] = user) and (board[14] = user) and (board[20] = user) and (board[26] = user)) or ((board[14] = user) and (board[20] = user) and (board[26] = user) and (board[32] = user)) or
           ((board[3] = user) and (board[9] = user) and (board[15] = user) and (board[21] = user)) or ((board[9] = user) and (board[15] = user) and (board[21] = user) and (board[27] = user)) or ((board[15] = user) and (board[21] = user) and (board[27] = user) and (board[33] = user)) or
           ((board[4] = user) and (board[10] = user) and (board[16] = user) and (board[22] = user)) or ((board[10] = user) and (board[16] = user) and (board[22] = user) and (board[28] = user)) or ((board[16] = user) and (board[22] = user) and (board[28] = user) and (board[34] = user)) or
           ((board[5] = user) and (board[11] = user) and (board[17] = user) and (board[23] = user)) or ((board[11] = user) and (board[17] = user) and (board[23] = user) and (board[29] = user)) or ((board[17] = user) and (board[23] = user) and (board[29] = user) and (board[35] = user)) or

           ((board[0] = user) and (board[7] = user) and (board[14] = user) and (board[21] = user)) or ((board[7] = user) and (board[14] = user) and (board[21] = user) and (board[28] = user)) or ((board[14] = user) and (board[21] = user) and (board[28] = user) and (board[35] = user)) or
           ((board[5] = user) and (board[10] = user) and (board[15] = user) and (board[20] = user)) or ((board[10] = user) and (board[15] = user) and (board[20] = user) and (board[25] = user)) or ((board[15] = user) and (board[20] = user) and (board[25] = user) and (board[30] = user)) or

           ((board[1] = user) and (board[8] = user) and (board[15] = user) and (board[22] = user)) or ((board[8] = user) and (board[15] = user) and (board[22] = user) and (board[29] = user)) or
           ((board[2] = user) and (board[9] = user) and (board[16] = user) and (board[23] = user)) or

           ((board[6] = user) and (board[13] = user) and (board[20] = user) and (board[27] = user)) or ((board[13] = user) and (board[20] = user) and (board[27] = user) and (board[34] = user)) or
           ((board[12] = user) and (board[19] = user) and (board[26] = user) and (board[33] = user)) or

           ((board[1] = user) and (board[8] = user) and (board[15] = user) and (board[22] = user)) or ((board[8] = user) and (board[15] = user) and (board[22] = user) and (board[29] = user)) or
           ((board[2] = user) and (board[9] = user) and (board[16] = user) and (board[23] = user)) or

           ((board[4] = user) and (board[9] = user) and (board[14] = user) and (board[19] = user)) or ((board[9] = user) and (board[14] = user) and (board[19] = user) and (board[24] = user)) or
           ((board[3] = user) and (board[8] = user) and (board[13] = user) and (board[18] = user));
end; }


{function Tform1.minimax(newboard: arr; player: integer):integer;
var
  availspots: ar;
begin
  availspots:=emptyindices(newboard);

  if win(newboard,1) then minimax:= -10
  else
    if win(newboard,2) then minimax:=10
    else
      if length(availspots) = 0 then minimax:= 0;

end;}


procedure TForm1.Draw_cross;
begin
  Form1.Image1.Canvas.MoveTo(100*inx+15,100*iny+15);
  Form1.Image1.Canvas.LineTo(100*inx+85,100*iny+85);

  Form1.Image1.Canvas.MoveTo(100*inx+15,100*iny+85);
  Form1.Image1.Canvas.LineTo(100*inx+85,100*iny+15);
end;

Procedure TForm1.Draw_circ;
begin
  Form1.Image1.Canvas.Ellipse(100*inx+15,100*iny+15,100*inx+85,100*iny+85);
end;

Function TForm1.iswinner(user: byte): Boolean;

begin


  result:= (score[user,0] and score[user,1] and score[user,2] and score[user,3]) or (score[user,1] and score[user,2] and score[user,3] and score[user,4]) or (score[user,2] and score[user,3] and score[user,4] and score[user,5]) or
           (score[user,6] and score[user,7] and score[user,8] and score[user,9]) or (score[user,7] and score[user,8] and score[user,9] and score[user,10]) or (score[user,8] and score[user,9] and score[user,10] and score[user,11]) or
           (score[user,12] and score[user,13] and score[user,14] and score[user,15]) or (score[user,13] and score[user,14] and score[user,15] and score[user,16]) or (score[user,14] and score[user,15] and score[user,16] and score[user,17]) or
           (score[user,18] and score[user,19] and score[user,20] and score[user,21]) or (score[user,19] and score[user,20] and score[user,21] and score[user,22]) or (score[user,20] and score[user,21] and score[user,22] and score[user,23]) or
           (score[user,24] and score[user,25] and score[user,26] and score[user,27]) or (score[user,25] and score[user,26] and score[user,27] and score[user,28]) or (score[user,26] and score[user,27] and score[user,28] and score[user,29]) or
           (score[user,30] and score[user,31] and score[user,32] and score[user,33]) or (score[user,31] and score[user,32] and score[user,33] and score[user,34]) or (score[user,32] and score[user,33] and score[user,34] and score[user,35]) or

           (score[user,0] and score[user,6] and score[user,12] and score[user,18]) or  (score[user,6] and score[user,12] and score[user,18] and score[user,24]) or (score[user,12] and score[user,18] and score[user,24] and score[user,30]) or
           (score[user,1] and score[user,7] and score[user,13] and score[user,19]) or  (score[user,7] and score[user,13] and score[user,19] and score[user,25]) or (score[user,13] and score[user,19] and score[user,25] and score[user,31]) or
           (score[user,2] and score[user,8] and score[user,14] and score[user,20]) or  (score[user,8] and score[user,14] and score[user,20] and score[user,26]) or (score[user,14] and score[user,20] and score[user,26] and score[user,32]) or
           (score[user,3] and score[user,9] and score[user,15] and score[user,21]) or  (score[user,9] and score[user,15] and score[user,21] and score[user,27]) or (score[user,15] and score[user,21] and score[user,27] and score[user,33]) or
           (score[user,4] and score[user,10] and score[user,16] and score[user,22]) or  (score[user,10] and score[user,16] and score[user,22] and score[user,28]) or (score[user,16] and score[user,22] and score[user,28] and score[user,34]) or
           (score[user,5] and score[user,11] and score[user,17] and score[user,23]) or  (score[user,11] and score[user,17] and score[user,23] and score[user,29]) or (score[user,17] and score[user,23] and score[user,29] and score[user,35]) or

           (score[user,0] and score[user,7] and score[user,14] and score[user,21]) or  (score[user,7] and score[user,14] and score[user,21] and score[user,28]) or (score[user,14] and score[user,21] and score[user,28] and score[user,35]) or
           (score[user,5] and score[user,10] and score[user,15] and score[user,20]) or  (score[user,10] and score[user,15] and score[user,20] and score[user,25]) or (score[user,15] and score[user,20] and score[user,25] and score[user,30]) or

           (score[user,1] and score[user,8] and score[user,15] and score[user,22]) or (score[user,8] and score[user,15] and score[user,22] and score[user,29]) or
           (score[user,2] and score[user,9] and score[user,16] and score[user,23]) or

           (score[user,6] and score[user,13] and score[user,20] and score[user,27]) or (score[user,13] and score[user,20] and score[user,27] and score[user,34]) or
           (score[user,12] and score[user,19] and score[user,26] and score[user,33]) or

           (score[user,11] and score[user,16] and score[user,21] and score[user,26]) or (score[user,16] and score[user,21] and score[user,26] and score[user,31]) or
           (score[user,17] and score[user,22] and score[user,27] and score[user,32]) or

           (score[user,4] and score[user,9] and score[user,14] and score[user,19]) or (score[user,9] and score[user,14] and score[user,19] and score[user,24]) or
           (score[user,3] and score[user,8] and score[user,13] and score[user,18]);

  {result:= (score[user,0] and score[user,1] and score[user,2]) or (score[user,1] and score[user,2] and score[user,3]) or (score[user,2] and score[user,3] and score[user,4]) or (score[user,3] and score[user,4] and score[user,5]) or
           (score[user,6] and score[user,7] and score[user,8]) or (score[user,7] and score[user,8] and score[user,9]) or (score[user,8] and score[user,9] and score[user,10]) or (score[user,9] and score[user,10] and score[user,11]) or
           (score[user,12] and score[user,13] and score[user,14]) or (score[user,13] and score[user,14] and score[user,15]) or (score[user,14] and score[user,15] and score[user,16]) or (score[user,15] and score[user,16] and score[user,17]) or
           (score[user,18] and score[user,19] and score[user,20]) or (score[user,19] and score[user,20] and score[user,21]) or (score[user,20] and score[user,21] and score[user,22]) or (score[user,21] and score[user,22] and score[user,23]) or
           (score[user,24] and score[user,25] and score[user,26]) or (score[user,25] and score[user,26] and score[user,27]) or (score[user,26] and score[user,27] and score[user,28]) or (score[user,27] and score[user,28] and score[user,29]) or
           (score[user,30] and score[user,31] and score[user,32]) or (score[user,31] and score[user,32] and score[user,33]) or (score[user,32] and score[user,33] and score[user,34]) or (score[user,33] and score[user,34] and score[user,35]) or

           (score[user,0] and score[user,6] and score[user,12]) or (score[user,6] and score[user,12] and score[user,18]) or (score[user,12] and score[user,18] and score[user,24]) or (score[user,18] and score[user,24] and score[user,30]) or
           (score[user,1] and score[user,7] and score[user,13]) or (score[user,7] and score[user,13] and score[user,19]) or (score[user,13] and score[user,19] and score[user,25]) or (score[user,19] and score[user,25] and score[user,31]) or
           (score[user,2] and score[user,8] and score[user,14]) or (score[user,8] and score[user,14] and score[user,20]) or (score[user,14] and score[user,20] and score[user,26]) or (score[user,20] and score[user,26] and score[user,32]) or
           (score[user,3] and score[user,9] and score[user,15]) or (score[user,9] and score[user,15] and score[user,21]) or (score[user,15] and score[user,21] and score[user,27]) or (score[user,21] and score[user,27] and score[user,33]) or
           (score[user,4] and score[user,10] and score[user,16]) or (score[user,10] and score[user,16] and score[user,22]) or (score[user,16] and score[user,22] and score[user,28]) or (score[user,22] and score[user,28] and score[user,34]) or
           (score[user,5] and score[user,11] and score[user,17]) or (score[user,11] and score[user,17] and score[user,23]) or (score[user,17] and score[user,23] and score[user,29]) or (score[user,23] and score[user,29] and score[user,35]) or

           (score[user,0] and score[user,7] and score[user,14]) or (score[user,7] and score[user,14] and score[user,21]) or (score[user,14] and score[user,21] and score[user,28]) or (score[user,21] and score[user,28] and score[user,35]) or
           (score[user,5] and score[user,10] and score[user,15]) or (score[user,10] and score[user,15] and score[user,20]) or (score[user,15] and score[user,20] and score[user,25]) or (score[user,20] and score[user,25] and score[user,30]) or

           (score[user,1] and score[user,8] and score[user,15]) or (score[user,8] and score[user,15] and score[user,22]) or (score[user,15] and score[user,22] and score[user,29]) or
           (score[user,2] and score[user,9] and score[user,16]) or (score[user,9] and score[user,16] and score[user,23]) or
           (score[user,3] and score[user,10] and score[user,17]) or

           (score[user,6] and score[user,13] and score[user,20]) or (score[user,13] and score[user,20] and score[user,27]) or (score[user,20] and score[user,27] and score[user,34]) or
           (score[user,12] and score[user,19] and score[user,26]) or (score[user,19] and score[user,26] and score[user,33]) or
           (score[user,18] and score[user,25] and score[user,32]) or

           (score[user,4] and score[user,9] and score[user,14]) or (score[user,9] and score[user,14] and score[user,19]) or (score[user,14] and score[user,19] and score[user,24]) or
           (score[user,3] and score[user,8] and score[user,13]) or (score[user,8] and score[user,13] and score[user,18]) or
           (score[user,2] and score[user,7] and score[user,12]) or

           (score[user,11] and score[user,16] and score[user,21]) or (score[user,16] and score[user,21] and score[user,26]) or (score[user,21] and score[user,26] and score[user,31]) or
           (score[user,17] and score[user,22] and score[user,27]) or (score[user,22] and score[user,27] and score[user,32]) or
           (score[user,23] and score[user,28] and score[user,33]);}



  {result:= (score[user,0] and score[user,1] and score[user,2] and score[user,3] and score[user,4] and score[user,5]) or
           (score[user,6] and score[user,7] and score[user,8] and score[user,9] and score[user,10] and score[user,11]) or
           (score[user,12] and score[user,13] and score[user,14] and score[user,15] and score[user,16] and score[user,17]) or
           (score[user,18] and score[user,19] and score[user,20] and score[user,21] and score[user,22] and score[user,23]) or
           (score[user,24] and score[user,25] and score[user,26] and score[user,27] and score[user,28] and score[user,29]) or
           (score[user,30] and score[user,31] and score[user,32] and score[user,33] and score[user,34] and score[user,35]) or

           (score[user,0] and score[user,6] and score[user,12] and score[user,18] and score[user,24] and score[user,30]) or
           (score[user,1] and score[user,7] and score[user,13] and score[user,19] and score[user,25] and score[user,31]) or
           (score[user,2] and score[user,8] and score[user,14] and score[user,20] and score[user,26] and score[user,32]) or
           (score[user,3] and score[user,9] and score[user,15] and score[user,21] and score[user,27] and score[user,33]) or
           (score[user,4] and score[user,10] and score[user,16] and score[user,22] and score[user,28] and score[user,34]) or
           (score[user,5] and score[user,11] and score[user,17] and score[user,23] and score[user,29] and score[user,35]) or

           (score[user,0] and score[user,7] and score[user,14] and score[user,21] and score[user,28] and score[user,35]) or
           (score[user,5] and score[user,10] and score[user,15] and score[user,20] and score[user,25] and score[user,30]);}
end;



procedure Tform1.init;
var
  i,j:byte;

begin
  with Form1.Image1.Canvas do
  begin
    Brush.Color:=mascol[1];
    Brush.Style:=bssolid;
    Pen.Color:=Mascol[2];
    Pen.Width:=2;
    Rectangle(1,1,600,600);
    for i:=1 to 5 do
    begin
      moveto(100*i,0);
      Lineto(100*i,600);
      moveto(0,100*i);
      Lineto(600,100*i);
    end;
  end;
  for i:=0 to 35 do
  begin
    score[1,i]:=False;
    score[2,i]:=False;
    b1[i]:=0;
  end;
  for i:=0 to 5 do
  for j:=0 to 5 do
  map[i,j]:=0;


  current:=1;

  step:=0;
  Form1.Timer1.Enabled:=false;
  Form1.Timer2.Enabled:=false;
  ispause:=false;
  form1.Label3.Caption:=inttostr(t);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.RadioGroup1.ItemIndex:=0;
  randomize;
  t:=5;
  edit1.Text:=inttostr(t);
  mascol[1]:=ClWhite;
  mascol[2]:=ClBlack;
  init;
  isgame:=false;
  ischoose:=False;
  form1.Label8.Caption:='cек.';
end;


procedure TForm1.Button1Click(Sender: TObject);
var
  i:integer;
begin
  if isgame = false then
  begin
    form1.Image1.Enabled:=true;
    form1.Button5.Enabled:=true;
    init;
    Form1.Timer1.Enabled:=True;
    Form1.Timer2.Enabled:=True;
    Form1.Button1.Caption:='Стоп';
    isgame:= true;
    Form1.RadioGroup1.Enabled:=False;
    form1.Button5.Caption:='Пауза';
    form1.MenuItem2.Enabled:=false;
  end
  else
  if isgame = true then
  begin
    form1.Button5.Enabled:=false;
    form1.Image1.Enabled:=False;
    Form1.Timer1.Enabled:=False;
    Form1.Timer2.Enabled:=False;
    Form1.Button1.Caption:='Начать';
    isgame:= False;
    Form1.RadioGroup1.Enabled:=True;
    form1.Button5.Caption:='Пауза';
    form1.MenuItem2.Enabled:=True;
    with Form1.Image1.Canvas do
  begin
    Brush.Color:=mascol[1];
    Brush.Style:=bssolid;
    Pen.Color:=Mascol[2];
    Pen.Width:=2;
    Rectangle(1,1,600,600);
    for i:=1 to 5 do
    begin
      moveto(100*i,0);
      Lineto(100*i,600);
      moveto(0,100*i);
      Lineto(600,100*i);
    end;
  end;
    t:=strtoint(edit1.Text);
    label3.Caption:=inttostr(t);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i:integer;
begin
   {t:=strtoint(maskedit1.Text);
   if t>0 then}
  if strtoint(edit1.Text) = 0 then edit1.Text:='5';
  begin
     t:=strtoint(edit1.Text);
     label3.Caption:=edit1.Text;
     label5.Caption:='';
   label3.Caption:=inttostr(t);
  Form1.Panel1.Visible:=False;
  Form1.Memo1.Lines[0]:='';
  Form1.Memo1.Lines[1]:='';
  form1.Memo1.Lines[0]:= colortostring(mascol[1]);
  form1.Memo1.Lines[1]:= colortostring(mascol[2]);
  label3.Caption:=inttostr(t);
  with form1.Image1.Canvas do
  begin
    brush.Color:=s1.Color;
    brush.Style:=bssolid;
    pen.Color:=s2.Color;
    Pen.Width:=2;
    Rectangle(1,1,600,600);
    for i:=1 to 5 do
    begin
      moveto(100*i,0);
      Lineto(100*i,600);
      moveto(0,100*i);
      Lineto(600,100*i);
    end;
  end;
   end;

end;

procedure TForm1.Button3Click(Sender: TObject);
var
  i:integer;
begin
  {Form1.Panel1.Visible:=False;}
  edit1.Text:=inttostr(5);
  t:=5;
  form1.Label3.Caption:=inttostr(5);
  mascol[1]:=ClWhite;
  mascol[2]:=ClBlack;
  s1.Color:=Clwhite;
  s2.Color:=clBlack;
   with form1.Image1.Canvas do
  begin
    brush.Color:=s1.Color;
    brush.Style:=bssolid;
    pen.Color:=s2.Color;
    Pen.Width:=2;
    Rectangle(1,1,600,600);
    for i:=1 to 5 do
    begin
      moveto(100*i,0);
      Lineto(100*i,600);
      moveto(0,100*i);
      Lineto(600,100*i);
    end;
  end;
  //pol:= s1.Color;
  //sim:= s2.Color;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  i:integer;
begin
  Form1.Panel1.Visible:=False;
  edit1.Text:=inttostr(t);
  s1.Color:=pol;
  s2.Color:=sim;
  mascol[1]:=pol;
  mascol[2]:=sim;
  with form1.Image1.Canvas do
  begin
    brush.Color:=s1.Color;
    brush.Style:=bssolid;
    pen.Color:=s2.Color;
    Pen.Width:=2;
    Rectangle(1,1,600,600);
    for i:=1 to 5 do
    begin
      moveto(100*i,0);
      Lineto(100*i,600);
      moveto(0,100*i);
      Lineto(600,100*i);
    end;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if ispause = false then
  begin
    form1.Image1.Enabled:= false;
    Form1.Button5.caption:='Продолжить';
    ispause:= True;
    form1.Timer2.Enabled:=False;
  end
  else
  begin
    form1.Image1.Enabled:= True;
    Form1.Button5.caption:='Пауза';
    Ispause:= false;
    form1.Timer2.Enabled:=True;
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  i:integer;
begin
   if strtoint(edit1.Text) = 0 then edit1.Text:='5';
    t:=strtoint(edit1.Text);
    label5.Caption:='';
  label3.Caption:=inttostr(t);
  pol:=s1.Color;
  sim:=s2.Color;
  mascol[1]:=pol;
  mascol[2]:=sim;
  with form1.Image1.Canvas do
  begin
    brush.Color:=s1.Color;
    brush.Style:=bssolid;
    pen.Color:=s2.Color;
    Pen.Width:=2;
    Rectangle(1,1,600,600);
    for i:=1 to 5 do
    begin
      moveto(100*i,0);
      Lineto(100*i,600);
      moveto(0,100*i);
      Lineto(600,100*i);
    end;
  end;
end;


procedure TForm1.Edit1Change(Sender: TObject);
var
  i:integer;
begin
  if edit1.Text = '' then edit1.Text:='0';
  if strtoint(edit1.Text) = 0 then begin
  form1.Button2.Enabled:=false;
  form1.button6.Enabled:=false;
  end
  else
  begin
  form1.Button2.Enabled:=true;
  form1.Button6.Enabled:=true;
  end;
  if strtoint(edit1.Text) > 60 then begin
  edit1.Text:='60';
  label7.Visible:=true;
  lol:=0;
  timer3.Enabled:=true;
  end;
  if strtoint(edit1.Text) < 5 then begin
  label7.Visible:=true;
  lol:=0;
  timer3.Enabled:=true;
  end;
  for i:=0 to 60 do
  begin
    if edit1.Text='0' + inttostr(i) then edit1.Text:=inttostr(i);
  end;
end;



procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin
  inx:=x div 100;
  iny:=y div 100;
  if map[inx,iny] = 0 then
  begin
    if (Current = 1) and (Form1.RadioGroup1.ItemIndex = 0) then
    begin
      current:=2;
      map[inx,iny]:= 1;
      draw_cross;
      score[1,inx+6*iny]:= True;
      b1[inx+6*iny]:=1;
      if iswinner(1) then
      begin
        timer2.Enabled:=false;
        Image1.Enabled:=False;
        isgame:= False;
        RadioGroup1.Enabled:=True;
        Button1.caption:='Начать';
        MenuItem2.Enabled:=True;
        ShowMessage('Крестики победили!');
        form1.Button5.Enabled:=false;
        init;
      end
      else if step = 35 then
      begin
       timer2.Enabled:=false;
          Form1.Image1.Enabled:=False;
          isgame:= False;
          Form1.RadioGroup1.Enabled:=True;
          form1.Button1.caption:='Начать';
          form1.MenuItem2.Enabled:=True;
          ShowMessage('Ничья!');
          form1.Button5.Enabled:=false;
          init;
      end
      else inc(step);
    end
    else
    if (Current = 2) and (Form1.RadioGroup1.ItemIndex = 1) then
    begin
      current:=1;
      map[inx,iny]:= 2;
      draw_circ;
      score[2,inx+6*iny]:= True;
      if iswinner(2) then
      begin
          form1.timer2.Enabled:=false;
          Form1.Image1.Enabled:=False;
          isgame:= False;
          Form1.RadioGroup1.Enabled:=True;
          form1.Button1.caption:='Начать';
          form1.MenuItem2.Enabled:=True;
          ShowMessage('Нолики победили!');
          form1.Button5.Enabled:=false;
          init;
      end
      else if step = 35 then
      begin
        timer2.Enabled:=false;
          Form1.Image1.Enabled:=False;
          isgame:= False;
          Form1.RadioGroup1.Enabled:=True;
          form1.Button1.caption:='Начать';
          form1.MenuItem2.Enabled:=True;
          ShowMessage('Ничья!');
          form1.Button5.Enabled:=false;
          init;
      end
      else inc(step);
    end;
  end;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  Panel1.Visible:=True;
  pol:= s1.Color;
  sim:= s2.Color;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
var
  i:integer;
begin
  if OpenDialog1.execute then
  begin
    if Form1.OpenDialog1.FileName<>''then
    begin
      memo1.Lines.LoadFromFile(OpenDialog1.FileName);
      mascol[1]:=stringtocolor(Form1.Memo1.Lines[0]);
      mascol[2]:=stringtocolor(Form1.Memo1.Lines[1]);
      s1.Color:=mascol[1];
      s2.Color:=mascol[2];
      pol:= s1.Color;
      sim:= s2.Color;
    end;
  end;
   with form1.Image1.Canvas do
  begin
    brush.Color:=s1.Color;
    brush.Style:=bssolid;
    pen.Color:=s2.Color;
    Pen.Width:=2;
    Rectangle(1,1,600,600);
    for i:=1 to 5 do
    begin
      moveto(100*i,0);
      Lineto(100*i,600);
      moveto(0,100*i);
      Lineto(600,100*i);
    end;
  end;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  if Form1.SaveDialog1.Execute then
  Form1.Memo1.Lines.SaveToFile(Form1.SaveDialog1.FileName);
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
  Application.MessageBox('Игра "Крестики-Нолики". После запуска программы открывается игровое поле. Чтобы начать игру, нужно выбрать с помощью меток каким по счету Вы будете ходить (первым или вторым) и нажать кнопку "Начать". После этого развернется игровое поле 6х6, и начнется игра. Прогрмма завершится при 3 исходах: 1)победа крестиков; 2)победа ноликов; 3)ничья','Крестики-нолики');
  //ShowMessage('Игра "Крестики-Нолики". После запуска программы открывается игровое поле. Чтобы начать игру, нужно выбрать с помощью меток против кого Вы хотите играть (против бота или другого человека) и нажать кнопку "Начать". После этого развернется игровое поле 6х6, и начнется игра. Прогрмма завершится при 3 исходах: 1)победа крестиков; 2)победа ноликов; 3)ничья');
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  Application.MessageBox('Разработал студент группы ИВТб-21 Жеребцов К. А.','Крестики-нолики');
  //ShowMessage('Разработал студент группы ИВТб-21 Жеребцов К. А.');
end;

procedure TForm1.P1Click(Sender: TObject);
var
  i,j:integer;
  f: boolean;

begin
  if ischoose then begin
staticText1.caption:='';
f:= true;

for i:= 1 to 4 do
(FindComponent('P'+intToStr(i)) as TPanel).BevelWidth:=1;
(sender as TPanel).BevelWidth:=3;


for i:=1 to 2 do
begin
  if mascol[i] = (sender as Tpanel).Color then
  begin
    staticText1.caption:='Цвет занят';
    f:= False;
    break;
  end;
end;


for j:= 1 to 2 do
begin
  if (((sender as TPanel).Color)=((FindComponent('S'+intToStr(j)) as TPanel).color)) and
     ((FindComponent('S'+intToStr(j)) as TPanel).BevelWidth=3) then
     begin
       staticText1.caption:='Цвет уже выбран';
       f:= false;
       break;
     end;
end;


if f then
begin
  col:=(findcomponent('S' + inttostr(num)) as TPanel).Color;
  (findcomponent('S' + inttostr(num)) as TPanel).Color:=(sender as TPanel).Color;
  for i:=1 to 2 do
  if mascol[i] = col then mascol[i]:= (sender as TPanel).Color;
end;





{for i:= 1 to 4 do
begin
  if mascol[i] = (sender as TPanel).Color then
  begin
    staticText1.caption:='Цвет занят';
    break;
  end;
end;

for j:=1 to 2 do begin
if (((sender as TPanel).Color)=((FindComponent('S'+intToStr(j)) as TPanel).color)) and
   ((FindComponent('S'+intToStr(j)) as TPanel).BevelWidth=3) then begin
staticText1.caption:='Цвет уже выбран';
break;
end;
end;

if i=4 then begin
c:=(FindComponent('S'+intToStr(col)) as TPanel).Color;
(FindComponent('S'+intToStr(col)) as TPanel).Color:=(sender as TPanel).Color;
end;

for i:= 1 to 2 do
begin
  if mascol[i]= c then
  begin
    mascol[i]:=(sender as TPanel).Color;
  end;
end;}

  end;
end;

procedure TForm1.S1Click(Sender: TObject);
var
  i: byte;

begin
  For i:=1 to 2 do
  (FindComponent('S' + inttostr(i)) as TPanel).bevelWidth:= 1;
  (sender as TPanel).BevelWidth:=3;
  num:=(sender as Tpanel).Tag;
  ischoose:=true;
end;


procedure Tform1.Hod;
var
  i,j:integer;

begin
  inx:=-1;
  iny:=-1;

   if form1.RadioGroup1.ItemIndex=0 then begin
    // победный ход

   // 1 через 2 по вертикали
   for i:=0 to 5 do begin
  for j:=0 to 2 do begin
    if (map[i,j] = 2) and (map[i,j+2] = 2) and (map[i, j+3] = 2) then begin
      if map[i,j+1] = 0 then begin
      inx:=i;
      iny:=j+1;
      break;
    end;
  end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

   // 1 через 2 по горизонтали
   for j:=0 to 5 do begin
  for i:=0 to 2 do begin
    if (map[i,j] = 2) and (map[i+2,j] = 2) and (map[i+3, j] = 2) then begin
      if map[i+1,j] = 0 then begin
      inx:=i+1;
      iny:=j;
      break;
      end;
    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

   // 1 через 2 по главной диагонали
   for i:=0 to 2 do begin
   for j:=0 to 2 do begin
   if (map[i,j] = 2) and (map[i+2,j+2] = 2) and (map[i+3,j+3] = 2) then begin
        if map[i+1,j+1] = 0 then begin
          inx:=i+1;
          iny:=j+1;
          break;
        end;
        end;
   end;
   if (inx<>-1) and (iny<>-1) then exit;
   end;

   // 1 через 2 по побочной диагонали
   for i:=0 to 2 do begin
   for j:=5 downto 3 do begin
   if (map[i,j] = 2) and (map[i+2,j-2] = 2) and (map[i+3,j-3] = 2) then begin
        if map[i+1,j-1] = 0 then begin
          inx:=i+1;
          iny:=j-1;
          break;
        end;
      end;
   end;
   if (inx<>-1) and (iny<>-1) then exit;
   end;

   // 2 через 1 по главной диагонали
   for i:=0 to 2 do begin
   for j:=0 to 2 do begin
   if (map[i,j] = 2) and (map[i+1,j+1] = 2) and (map[i+3,j+3] = 2) then begin
        if map[i+2,j+2] = 0 then begin
          inx:=i+2;
          iny:=j+2;
          break;
        end;
        end;
   end;
   if (inx<>-1) and (iny<>-1) then exit;
   end;

   // 2 через 1 по побочной диагонали
   for i:=0 to 2 do begin
   for j:=5 downto 3 do begin
   if (map[i,j] = 2) and (map[i+1,j-1] = 2) and (map[i+3,j-3] = 2) then begin
        if map[i+2,j-2] = 0 then begin
          inx:=i+2;
          iny:=j-2;
          break;
        end;
      end;
   end;
   if (inx<>-1) and (iny<>-1) then exit;
   end;

  // 2 через 1 по вертикали
  for i:=0 to 5 do begin
  for j:=0 to 2 do begin
    if (map[i,j] = 2) and (map[i,j+1] = 2) and (map[i, j+3] = 2) then begin
      if map[i,j+2] = 0 then begin
      inx:=i;
      iny:=j+2;
      break;
    end;
  end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  // 2 через 1 по горизонтали
  for j:=0 to 5 do begin
  for i:=0 to 2 do begin
    if (map[i,j] = 2) and (map[i+1,j] = 2) and (map[i+3, j] = 2) then begin
      if map[i+2,j] = 0 then begin
      inx:=i+2;
      iny:=j;
      break;
      end;
    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  // проверка по 3х по вертикали
  for i:=0 to 5 do begin
  for j:=0 to 3 do begin
    if (map[i,j] = 2) and (map[i,j+1] = 2) and (map[i,j+2] = 2) then begin
      // верхняя граница
      if j = 0 then begin
        if map[i,j+3] = 0 then begin
          inx:=i;
          iny:=j+3;
          break;
        end;
      end;
      // нижняя граница
      if j = 3 then begin
        if map[i,j-1] = 0 then begin
          inx:=i;
          iny:=j-1;
          break;
        end;
      end;
      if (j <> 0) and (j<>3) then begin
        if map[i,j+3] = 0 then begin
          inx:=i;
          iny:=j+3;
          break;
        end;
        if map[i,j-1] = 0 then begin
          inx:=i;
          iny:=j-1;
          break;
        end;
      end;
    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  // проверка по 3х по горизонтали
  for j:=0 to 5 do begin
  for i:=0 to 3 do begin
    if (map[i,j] = 2) and (map[i+1,j] = 2) and (map[i+2,j] = 2) then begin
      // левая граница
      if i = 0 then begin
        if map[i+3,j] = 0 then begin
          inx:=i+3;
          iny:=j;
          break;
        end;
      end;
      // правая граница
      if i = 3 then begin
        if map[i-1,j] = 0 then begin
          inx:=i-1;
          iny:=j;
          break;
        end;
      end;
      if (i <> 0) and (i<>3) then begin
        if map[i+3,j] = 0 then begin
          inx:=i+3;
          iny:=j;
          break;
        end;
        if map[i-1,j] = 0 then begin
          inx:=i-1;
          iny:=j;
          break;
        end;
      end;
    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  //проверка главной диагонали по 3х
  for i:=0 to 2 do begin
  for j:=0 to 2 do begin
    //верхний граница
  if (map[i,j] = 2) and (map[i+1,j+1] = 2) and (map[i+2,j+2] = 2) then begin
    //верхний граница
      if (j = 0) or (i = 0) then begin
        if map[i+3,j+3] = 0 then begin
          inx:=i+3;
          iny:=j+3;
          break;
        end;
      end;
      //середина главной диагонали
      if (i <> 0) and (j <> 0) then begin
        if map[i+3,j+3] = 0 then begin
          inx:=i+3;
          iny:=j+3;
          break;
        end;
        if map[i-1,j-1] = 0 then begin
          inx:=i-1;
          iny:=j-1;
          break;
        end;
      end;

    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  //побочная диагональ по 3х
  for i:=0 to 2 do begin
  for j:=5 downto 3 do begin
  if (map[i,j] = 2) and (map[i+1,j-1] = 2) and (map[i+2,j-2] = 2) then begin
    //левая и нижнияя граница
      if (j = 5) or (i = 0) then begin
        if map[i+3,j-3] = 0 then begin
          inx:=i+3;
          iny:=j-3;
          break;
        end;
      end;
      //середина побочной диагонали
      if (i <> 0) and (j <> 5) then begin
        if map[i+3,j-3] = 0 then begin
          inx:=i+3;
          iny:=j-3;
          break;
        end;
        if map[i-1,j+1] = 0 then begin
          inx:=i-1;
          iny:=j+1;
          break;
        end;
      end;

    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;


   // защита



  //проверка главной диагонали по 3х
  for i:=0 to 2 do begin
  for j:=0 to 2 do begin
    //верхний граница
  if (map[i,j] = 1) and (map[i+1,j+1] = 1) and (map[i+2,j+2] = 1) then begin
    //верхний граница
      if (j = 0) or (i = 0) then begin
        if map[i+3,j+3] = 0 then begin
          inx:=i+3;
          iny:=j+3;
          break;
        end;
      end;
      //середина главной диагонали
      if (i <> 0) and (j <> 0) then begin
        if map[i+3,j+3] = 0 then begin
          inx:=i+3;
          iny:=j+3;
          break;
        end;
        if map[i-1,j-1] = 0 then begin
          inx:=i-1;
          iny:=j-1;
          break;
        end;
      end;

    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  //побочная диагональ по 3х
   for i:=0 to 2 do begin
  for j:=5 downto 3 do begin
  if (map[i,j] = 1) and (map[i+1,j-1] = 1) and (map[i+2,j-2] = 1) then begin
    //левая и нижнияя граница
      if (j = 5) or (i = 0) then begin
        if map[i+3,j-3] = 0 then begin
          inx:=i+3;
          iny:=j-3;
          break;
        end;
      end;
      //середина побочной диагонали
      if (i <> 0) and (j <> 5) then begin
        if map[i+3,j-3] = 0 then begin
          inx:=i+3;
          iny:=j-3;
          break;
        end;
        if map[i-1,j+1] = 0 then begin
          inx:=i-1;
          iny:=j+1;
          break;
        end;
      end;

    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  // проверка по 3х по вертикали
  for i:=0 to 5 do begin
  for j:=0 to 3 do begin
    if (map[i,j] = 1) and (map[i,j+1] = 1) and (map[i,j+2] = 1) then begin
      // верхняя граница
      if j = 0 then begin
        if map[i,j+3] = 0 then begin
          inx:=i;
          iny:=j+3;
          break;
        end;
      end;
      // нижняя граница
      if j = 3 then begin
        if map[i,j-1] = 0 then begin
          inx:=i;
          iny:=j-1;
          break;
        end;
      end;
      if (j <> 0) and (j<>3) then begin
        if map[i,j+3] = 0 then begin
          inx:=i;
          iny:=j+3;
          break;
        end;
        if map[i,j-1] = 0 then begin
          inx:=i;
          iny:=j-1;
          break;
        end;
      end;
    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  // проверка по 3х по горизонтали
  for j:=0 to 5 do begin
  for i:=0 to 3 do begin
    if (map[i,j] = 1) and (map[i+1,j] = 1) and (map[i+2,j] = 1) then begin
      // левая граница
      if i = 0 then begin
        if map[i+3,j] = 0 then begin
          inx:=i+3;
          iny:=j;
          break;
        end;
      end;
      // правая граница
      if i = 3 then begin
        if map[i-1,j] = 0 then begin
          inx:=i-1;
          iny:=j;
          break;
        end;
      end;
      if (i <> 0) and (i<>3) then begin
        if map[i+3,j] = 0 then begin
          inx:=i+3;
          iny:=j;
          break;
        end;
        if map[i-1,j] = 0 then begin
          inx:=i-1;
          iny:=j;
          break;
        end;
      end;
    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  // 1 через 2 по вертикали
  for i:=0 to 5 do begin
  for j:=0 to 2 do begin
    if (map[i,j] = 1) and (map[i,j+2] = 1) and (map[i, j+3] = 1) then begin
      if map[i,j+1] = 0 then begin
      inx:=i;
      iny:=j+1;
      break;
    end;
  end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  // 1 через 2 по горизонтали
  for j:=0 to 5 do begin
  for i:=0 to 2 do begin
    if (map[i,j] = 1) and (map[i+2,j] = 1) and (map[i+3, j] = 1) then begin
      if map[i+1,j] = 0 then begin
      inx:=i+1;
      iny:=j;
      break;
      end;
    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  // 1 через 2 по главной диагонали
   for i:=0 to 2 do begin
   for j:=0 to 2 do begin
   if (map[i,j] = 1) and (map[i+2,j+2] = 1) and (map[i+3,j+3] = 1) then begin
        if map[i+1,j+1] = 0 then begin
          inx:=i+1;
          iny:=j+1;
          break;
        end;
        end;
   end;
   if (inx<>-1) and (iny<>-1) then exit;
   end;

   // 1 через 2 по побочной диагонали
   for i:=0 to 2 do begin
   for j:=5 downto 3 do begin
   if (map[i,j] = 1) and (map[i+2,j-2] = 1) and (map[i+3,j-3] = 1) then begin
        if map[i+1,j-1] = 0 then begin
          inx:=i+1;
          iny:=j-1;
          break;
        end;
      end;
   end;
   if (inx<>-1) and (iny<>-1) then exit;
   end;

  // 2 через 1 по вертикали
  for i:=0 to 5 do begin
  for j:=0 to 2 do begin
    if (map[i,j] = 1) and (map[i,j+1] = 1) and (map[i, j+3] = 1) then begin
      if map[i,j+2] = 0 then begin
      inx:=i;
      iny:=j+2;
      break;
    end;
  end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  // 2 через 1 по горизонтали
  for j:=0 to 5 do begin
  for i:=0 to 2 do begin
    if (map[i,j] = 1) and (map[i+1,j] = 1) and (map[i+3, j] = 1) then begin
      if map[i+2,j] = 0 then begin
      inx:=i+2;
      iny:=j;
      break;
      end;
    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

   // 2 через 1 по главной диагонали
   for i:=0 to 2 do begin
   for j:=0 to 2 do begin
   if (map[i,j] = 1) and (map[i+1,j+1] = 1) and (map[i+3,j+3] = 1) then begin
        if map[i+2,j+2] = 0 then begin
          inx:=i+2;
          iny:=j+2;
          break;
        end;
        end;
   end;
   if (inx<>-1) and (iny<>-1) then exit;
   end;

   // 2 через 1 по побочной диагонали
   for i:=0 to 2 do begin
   for j:=5 downto 3 do begin
   if (map[i,j] = 1) and (map[i+1,j-1] = 1) and (map[i+3,j-3] = 1) then begin
        if map[i+2,j-2] = 0 then begin
          inx:=i+2;
          iny:=j-2;
          break;
        end;
      end;
   end;
   if (inx<>-1) and (iny<>-1) then exit;
   end;

  // проверка серий 2х по вертикали
  for i:=0 to 5 do begin
  for j:=0 to 4 do begin
    if (map[i,j] = 1) and (map[i,j+1] = 1) then begin
      // верхняя граница
      if j = 0 then begin
        if map[i,j+2] = 0 then begin
          inx:=i;
          iny:=j+2;
          break;
        end;
      end;
      // нижняя граница
      if j = 4 then begin
        if map[i,j-1] = 0 then begin
          inx:=i;
          iny:=j-1;
          break;
        end;
      end;
      if (j <>0) and (j<>4) then begin
        if map[i,j+2] = 0 then begin
          inx:=i;
          iny:=j+2;
          break;
        end;
        if map[i,j-1] = 0 then begin
          inx:=i;
          iny:=j-1;
          break;
        end;
      end;
    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  //проверка 2х по горизонтали
  for j:=0 to 5 do begin
  for i:=0 to 4 do begin
    if (map[i,j] = 1) and (map[i+1,j] = 1) then begin
      // левая граница
      if i = 0 then begin
        if map[i+2,j] = 0 then begin
          inx:=i+2;
          iny:=j;
          break;
        end;
      end;
      // правая граница
      if i = 4 then begin
        if map[i-1,j] = 0 then begin
          inx:=i-1;
          iny:=j;
          break;
        end;
      end;
      if (i <>0) and (i<>4) then begin
        if map[i+2,j] = 0 then begin
          inx:=i+2;
          iny:=j;
          break;
        end;
        if map[i-1,j] = 0 then begin
          inx:=i-1;
          iny:=j;
          break;
        end;
      end;
    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  //проверка главной диагонали по 2х
  for i:=0 to 3 do begin
  for j:=0 to 3 do begin
    //верхний граница
  if (map[i,j] = 1) and (map[i+1,j+1] = 1) then begin
    //верхний граница
      if (j = 0) or (i = 0) then begin
        if map[i+2,j+2] = 0 then begin
          inx:=i+2;
          iny:=j+2;
          break;
        end;
      end;
      //середина главной диагонали
      if (i <> 0) and (j <> 0) then begin
        if map[i+2,j+2] = 0 then begin
          inx:=i+2;
          iny:=j+2;
          break;
        end;
        if map[i-1,j-1] = 0 then begin
          inx:=i-1;
          iny:=j-1;
          break;
        end;
      end;

    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  //побочная диагональ по 2х
  for i:=0 to 3 do begin
  for j:=5 downto 2 do begin
  if (map[i,j] = 1) and (map[i+1,j-1] = 1) then begin
    //левая и нижнияя граница
      if (j = 5) or (i = 0) then begin
        if map[i+2,j-2] = 0 then begin
          inx:=i+2;
          iny:=j-2;
          break;
        end;
      end;
      //середина побочной диагонали
      if (i <> 0) and (j <> 5) then begin
        if map[i+2,j-2] = 0 then begin
          inx:=i+2;
          iny:=j-2;
          break;
        end;
        if map[i-1,j+1] = 0 then begin
          inx:=i-1;
          iny:=j+1;
          break;
        end;
      end;

    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  // 1 через 1 по горизонтали
   for j:=0 to 5 do begin
   for i:=0 to 3 do begin
     if (map[i,j] = 1) and (map[i+2,j] = 1) then begin
       if map[i+1,j]= 0 then begin
         inx:=i+1;
         iny:=j;
         break;
       end;
     end;
   end;
   if (inx<>-1) and (iny<>-1) then exit;
   end;

   // 1 через 1 по вертикали
   for i:=0 to 5 do begin
   for j:=0 to 3 do begin
     if (map[i,j] = 1) and (map[i,j+2] = 1) then begin
       if map[i,j+1]= 0 then begin
         inx:=i;
         iny:=j+1;
         break;
       end;
     end;
   end;
   if (inx<>-1) and (iny<>-1) then exit;
   end;

  //проверка одиночных символов
  for i:=0 to 5 do begin
        for j:=0 to 5 do begin
          if map[i,j]=1 then begin
            if i=0 then begin
              //левый верхний угол
              if j=0 then begin
                if map[i+1,j]=0 then begin
                inx:=i+1;
                iny:=j;
                break;
                end;
                if map[i+1,j+1]=0 then begin
                 inx:=i+1;
                iny:=j+1;
                break;
                end;
                if map[i,j+1]=0 then begin
                 inx:=i;
                iny:=j+1;
                break;
                end;
              end;

                //левыый нижний угол
                if j=5 then begin
                if map[i,j-1]=0 then begin
                inx:=i;
                iny:=j-1;
                break;
                end;
                if map[i+1,j-1]=0 then begin
                 inx:=i+1;
                iny:=j-1;
                break;
                end;
                if map[i+1,j]=0 then begin
                 inx:=i+1;
                iny:=j;
                break;
                end;
              end;

                // левая сторона
                if (j<>5) and (j<>0) then
                begin
                if map[i,j+1] = 0 then begin
                  inx:=i;
                  iny:=j+1;
                  break;
                end;
                if map[i+1,j+1] = 0 then begin
                  inx:=i+1;
                  iny:=j+1;
                  break;
                end;
                if map[i+1,j] = 0 then begin
                  inx:=i+1;
                  iny:=j;
                  break;
                end;
                if map[i+1,j-1] = 0 then begin
                  inx:=i+1;
                  iny:=j-1;
                  break;
                end;
                if map[i,j-1] = 0 then begin
                  inx:=i;
                  iny:=j-1;
                  break;
                end;
                end;
            end;

            if i = 5 then begin
               //правый верхний угол
              if j=0 then begin
                if map[i-1,j]=0 then begin
                inx:=i-1;
                iny:=j;
                break;
                end;
                if map[i-1,j+1]=0 then begin
                 inx:=i-1;
                iny:=j+1;
                break;
                end;
                if map[i,j+1]=0 then begin
                 inx:=i;
                iny:=j+1;
                break;
                end;
              end;

              //правый нижний угол
                if j=5 then begin
                if map[i,j-1]=0 then begin
                inx:=i;
                iny:=j-1;
                break;
                end;
                if map[i-1,j-1]=0 then begin
                 inx:=i-1;
                iny:=j-1;
                break;
                end;
                if map[i-1,j]=0 then begin
                 inx:=i-1;
                iny:=j;
                break;
                end;
              end;

                // левая сторона
                if (j<>5) and (j<>0) then
                begin
                if map[i,j+1] = 0 then begin
                  inx:=i;
                  iny:=j+1;
                  break;
                end;
                if map[i-1,j+1] = 0 then begin
                  inx:=i-1;
                  iny:=j+1;
                  break;
                end;
                if map[i-1,j] = 0 then begin
                  inx:=i-1;
                  iny:=j;
                  break;
                end;
                if map[i-1,j-1] = 0 then begin
                  inx:=i-1;
                  iny:=j-1;
                  break;
                end;
                if map[i,j-1] = 0 then begin
                  inx:=i;
                  iny:=j-1;
                  break;
                end;
                end;
            end;
            //верхняя сторона
            if (i<>0) and (i<>5) then begin
            if j = 0 then begin
            if map[i-1,j] = 0 then begin
              inx:=i-1;
              iny:=j;
              break;
            end;
            if map[i-1,j+1] = 0 then begin
              inx:=i-1;
              iny:=j+1;
              break;
            end;
            if map[i,j+1] = 0 then begin
              inx:=i;
              iny:=j+1;
              break;
            end;
            if map[i+1,j+1] = 0 then begin
              inx:=i+1;
              iny:=j+1;
              break;
            end;
            if map[i+1,j] = 0 then begin
              inx:=i+1;
              iny:=j;
              break;
            end;
          end;
            // нижняя сторона
            if j = 5 then begin
            if map[i-1,j] = 0 then begin
              inx:=i-1;
              iny:=j;
              break;
            end;
            if map[i-1,j-1] = 0 then begin
              inx:=i-1;
              iny:=j-1;
              break;
            end;
            if map[i,j-1] = 0 then begin
              inx:=i;
              iny:=j-1;
              break;
            end;
            if map[i+1,j-1] = 0 then begin
              inx:=i+1;
              iny:=j-1;
              break;
            end;
            if map[i+1,j] = 0 then begin
              inx:=i+1;
              iny:=j;
              break;
            end;
            end;
        end;

      //центр
    if ((i<>0) and (i<>5)) and ((j<>0) and (j<>5)) then begin
      if map[i,j-1] = 0 then begin
        inx:=i;
        iny:=j-1;
        break;
      end;
      if map[i,j+1] = 0 then begin
        inx:=i;
        iny:=j+1;
        break;
      end;
      if map[i-1,j] = 0 then begin
        inx:=i-1;
        iny:=j;
        break;
      end;
      if map[i+1,j] = 0 then begin
        inx:=i+1;
        iny:=j;
        break;
      end;
      if map[i-1,j-1] = 0 then begin
        inx:=i-1;
        iny:=j-1;
        break;
      end;
      if map[i+1,j+1] = 0 then begin
        inx:=i+1;
        iny:=j+1;
        break;
      end;
      if map[i+1,j-1] = 0 then begin
        inx:=i+1;
        iny:=j-1;
        break;
      end;
      if map[i-1,j+1] = 0 then begin
        inx:=i-1;
        iny:=j+1;
        break;
      end;
    end;
  end;
end;
  if (inx<>-1) and (iny<>-1) then break;
  end;

  end;

  if form1.RadioGroup1.ItemIndex=1 then begin
    // победный ход

   // 1 через 2 по вертикали
   for i:=0 to 5 do begin
  for j:=0 to 2 do begin
    if (map[i,j] = 1) and (map[i,j+2] = 1) and (map[i, j+3] = 1) then begin
      if map[i,j+1] = 0 then begin
      inx:=i;
      iny:=j+1;
      break;
    end;
  end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

   // 1 через 2 по горизонтали
   for j:=0 to 5 do begin
  for i:=0 to 2 do begin
    if (map[i,j] = 1) and (map[i+2,j] = 1) and (map[i+3, j] = 1) then begin
      if map[i+1,j] = 0 then begin
      inx:=i+1;
      iny:=j;
      break;
      end;
    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

   // 1 через 2 по главной диагонали
   for i:=0 to 2 do begin
   for j:=0 to 2 do begin
   if (map[i,j] =1) and (map[i+2,j+2] = 1) and (map[i+3,j+3] = 1) then begin
        if map[i+1,j+1] = 0 then begin
          inx:=i+1;
          iny:=j+1;
          break;
        end;
        end;
   end;
   if (inx<>-1) and (iny<>-1) then exit;
   end;

   // 1 через 2 по побочной диагонали
   for i:=0 to 2 do begin
   for j:=5 downto 3 do begin
   if (map[i,j] = 1) and (map[i+2,j-2] = 1) and (map[i+3,j-3] = 1) then begin
        if map[i+1,j-1] = 0 then begin
          inx:=i+1;
          iny:=j-1;
          break;
        end;
      end;
   end;
   if (inx<>-1) and (iny<>-1) then exit;
   end;

  // 2 через 1 по вертикали
  for i:=0 to 5 do begin
  for j:=0 to 2 do begin
    if (map[i,j] = 1) and (map[i,j+1] = 1) and (map[i, j+3] = 1) then begin
      if map[i,j+2] = 0 then begin
      inx:=i;
      iny:=j+2;
      break;
    end;
  end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  // 2 через 1 по горизонтали
  for j:=0 to 5 do begin
  for i:=0 to 2 do begin
    if (map[i,j] = 1) and (map[i+1,j] = 1) and (map[i+3, j] = 1) then begin
      if map[i+2,j] = 0 then begin
      inx:=i+2;
      iny:=j;
      break;
      end;
    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

   // 2 через 1 по главной диагонали
   for i:=0 to 2 do begin
   for j:=0 to 2 do begin
   if (map[i,j] = 1) and (map[i+1,j+1] = 1) and (map[i+3,j+3] = 1) then begin
        if map[i+2,j+2] = 0 then begin
          inx:=i+2;
          iny:=j+2;
          break;
        end;
        end;
   end;
   if (inx<>-1) and (iny<>-1) then exit;
   end;

   // 2 через 1 по побочной диагонали
   for i:=0 to 2 do begin
   for j:=5 downto 3 do begin
   if (map[i,j] = 1) and (map[i+1,j-1] = 1) and (map[i+3,j-3] = 1) then begin
        if map[i+2,j-2] = 0 then begin
          inx:=i+2;
          iny:=j-2;
          break;
        end;
      end;
   end;
   if (inx<>-1) and (iny<>-1) then exit;
   end;

  // проверка по 3х по вертикали
  for i:=0 to 5 do begin
  for j:=0 to 3 do begin
    if (map[i,j] = 1) and (map[i,j+1] = 1) and (map[i,j+2] = 1) then begin
      // верхняя граница
      if j = 0 then begin
        if map[i,j+3] = 0 then begin
          inx:=i;
          iny:=j+3;
          break;
        end;
      end;
      // нижняя граница
      if j = 3 then begin
        if map[i,j-1] = 0 then begin
          inx:=i;
          iny:=j-1;
          break;
        end;
      end;
      if (j <> 0) and (j<>3) then begin
        if map[i,j+3] = 0 then begin
          inx:=i;
          iny:=j+3;
          break;
        end;
        if map[i,j-1] = 0 then begin
          inx:=i;
          iny:=j-1;
          break;
        end;
      end;
    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  // проверка по 3х по горизонтали
  for j:=0 to 5 do begin
  for i:=0 to 3 do begin
    if (map[i,j] = 1) and (map[i+1,j] = 1) and (map[i+2,j] = 1) then begin
      // левая граница
      if i = 0 then begin
        if map[i+3,j] = 0 then begin
          inx:=i+3;
          iny:=j;
          break;
        end;
      end;
      // правая граница
      if i = 3 then begin
        if map[i-1,j] = 0 then begin
          inx:=i-1;
          iny:=j;
          break;
        end;
      end;
      if (i <> 0) and (i<>3) then begin
        if map[i+3,j] = 0 then begin
          inx:=i+3;
          iny:=j;
          break;
        end;
        if map[i-1,j] = 0 then begin
          inx:=i-1;
          iny:=j;
          break;
        end;
      end;
    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  //проверка главной диагонали по 3х
  for i:=0 to 2 do begin
  for j:=0 to 2 do begin
    //верхний граница
  if (map[i,j] = 1) and (map[i+1,j+1] = 1) and (map[i+2,j+2] = 1) then begin
    //верхний граница
      if (j = 0) or (i = 0) then begin
        if map[i+3,j+3] = 0 then begin
          inx:=i+3;
          iny:=j+3;
          break;
        end;
      end;
      //середина главной диагонали
      if (i <> 0) and (j <> 0) then begin
        if map[i+3,j+3] = 0 then begin
          inx:=i+3;
          iny:=j+3;
          break;
        end;
        if map[i-1,j-1] = 0 then begin
          inx:=i-1;
          iny:=j-1;
          break;
        end;
      end;

    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  //побочная диагональ по 3х
  for i:=0 to 2 do begin
  for j:=5 downto 3 do begin
  if (map[i,j] = 1) and (map[i+1,j-1] = 1) and (map[i+2,j-2] = 1) then begin
    //левая и нижнияя граница
      if (j = 5) or (i = 0) then begin
        if map[i+3,j-3] = 0 then begin
          inx:=i+3;
          iny:=j-3;
          break;
        end;
      end;
      //середина побочной диагонали
      if (i <> 0) and (j <> 5) then begin
        if map[i+3,j-3] = 0 then begin
          inx:=i+3;
          iny:=j-3;
          break;
        end;
        if map[i-1,j+1] = 0 then begin
          inx:=i-1;
          iny:=j+1;
          break;
        end;
      end;

    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;


   // защита



  //проверка главной диагонали по 3х
  for i:=0 to 2 do begin
  for j:=0 to 2 do begin
    //верхний граница
  if (map[i,j] = 2) and (map[i+1,j+1] = 2) and (map[i+2,j+2] = 2) then begin
    //верхний граница
      if (j = 0) or (i = 0) then begin
        if map[i+3,j+3] = 0 then begin
          inx:=i+3;
          iny:=j+3;
          break;
        end;
      end;
      //середина главной диагонали
      if (i <> 0) and (j <> 0) then begin
        if map[i+3,j+3] = 0 then begin
          inx:=i+3;
          iny:=j+3;
          break;
        end;
        if map[i-1,j-1] = 0 then begin
          inx:=i-1;
          iny:=j-1;
          break;
        end;
      end;

    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  //побочная диагональ по 3х
   for i:=0 to 2 do begin
  for j:=5 downto 3 do begin
  if (map[i,j] = 2) and (map[i+1,j-1] = 2) and (map[i+2,j-2] = 2) then begin
    //левая и нижнияя граница
      if (j = 5) or (i = 0) then begin
        if map[i+3,j-3] = 0 then begin
          inx:=i+3;
          iny:=j-3;
          break;
        end;
      end;
      //середина побочной диагонали
      if (i <> 0) and (j <> 5) then begin
        if map[i+3,j-3] = 0 then begin
          inx:=i+3;
          iny:=j-3;
          break;
        end;
        if map[i-1,j+1] = 0 then begin
          inx:=i-1;
          iny:=j+1;
          break;
        end;
      end;

    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  // проверка по 3х по вертикали
  for i:=0 to 5 do begin
  for j:=0 to 3 do begin
    if (map[i,j] = 2) and (map[i,j+1] = 2) and (map[i,j+2] = 2) then begin
      // верхняя граница
      if j = 0 then begin
        if map[i,j+3] = 0 then begin
          inx:=i;
          iny:=j+3;
          break;
        end;
      end;
      // нижняя граница
      if j = 3 then begin
        if map[i,j-1] = 0 then begin
          inx:=i;
          iny:=j-1;
          break;
        end;
      end;
      if (j <> 0) and (j<>3) then begin
        if map[i,j+3] = 0 then begin
          inx:=i;
          iny:=j+3;
          break;
        end;
        if map[i,j-1] = 0 then begin
          inx:=i;
          iny:=j-1;
          break;
        end;
      end;
    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  // проверка по 3х по горизонтали
  for j:=0 to 5 do begin
  for i:=0 to 3 do begin
    if (map[i,j] = 2) and (map[i+1,j] = 2) and (map[i+2,j] = 2) then begin
      // левая граница
      if i = 0 then begin
        if map[i+3,j] = 0 then begin
          inx:=i+3;
          iny:=j;
          break;
        end;
      end;
      // правая граница
      if i = 3 then begin
        if map[i-1,j] = 0 then begin
          inx:=i-1;
          iny:=j;
          break;
        end;
      end;
      if (i <> 0) and (i<>3) then begin
        if map[i+3,j] = 0 then begin
          inx:=i+3;
          iny:=j;
          break;
        end;
        if map[i-1,j] = 0 then begin
          inx:=i-1;
          iny:=j;
          break;
        end;
      end;
    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  // 1 через 2 по вертикали
  for i:=0 to 5 do begin
  for j:=0 to 2 do begin
    if (map[i,j] = 2) and (map[i,j+2] = 2) and (map[i, j+3] = 2) then begin
      if map[i,j+1] = 0 then begin
      inx:=i;
      iny:=j+1;
      break;
    end;
  end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  // 1 через 2 по горизонтали
  for j:=0 to 5 do begin
  for i:=0 to 2 do begin
    if (map[i,j] = 2) and (map[i+2,j] = 2) and (map[i+3, j] = 2) then begin
      if map[i+1,j] = 0 then begin
      inx:=i+1;
      iny:=j;
      break;
      end;
    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  // 1 через 2 по главной диагонали
   for i:=0 to 2 do begin
   for j:=0 to 2 do begin
   if (map[i,j] = 2) and (map[i+2,j+2] = 2) and (map[i+3,j+3] = 2) then begin
        if map[i+1,j+1] = 0 then begin
          inx:=i+1;
          iny:=j+1;
          break;
        end;
        end;
   end;
   if (inx<>-1) and (iny<>-1) then exit;
   end;

   // 1 через 2 по побочной диагонали
   for i:=0 to 2 do begin
   for j:=5 downto 3 do begin
   if (map[i,j] = 2) and (map[i+2,j-2] = 2) and (map[i+3,j-3] = 2) then begin
        if map[i+1,j-1] = 0 then begin
          inx:=i+1;
          iny:=j-1;
          break;
        end;
      end;
   end;
   if (inx<>-1) and (iny<>-1) then exit;
   end;

  // 2 через 1 по вертикали
  for i:=0 to 5 do begin
  for j:=0 to 2 do begin
    if (map[i,j] = 2) and (map[i,j+1] = 2) and (map[i, j+3] = 2) then begin
      if map[i,j+2] = 0 then begin
      inx:=i;
      iny:=j+2;
      break;
    end;
  end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  // 2 через 1 по горизонтали
  for j:=0 to 5 do begin
  for i:=0 to 2 do begin
    if (map[i,j] = 2) and (map[i+1,j] = 2) and (map[i+3, j] = 2) then begin
      if map[i+2,j] = 0 then begin
      inx:=i+2;
      iny:=j;
      break;
      end;
    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

   // 2 через 1 по главной диагонали
   for i:=0 to 2 do begin
   for j:=0 to 2 do begin
   if (map[i,j] = 2) and (map[i+1,j+1] = 2) and (map[i+3,j+3] = 2) then begin
        if map[i+2,j+2] = 0 then begin
          inx:=i+2;
          iny:=j+2;
          break;
        end;
        end;
   end;
   if (inx<>-1) and (iny<>-1) then exit;
   end;

   // 2 через 1 по побочной диагонали
   for i:=0 to 2 do begin
   for j:=5 downto 3 do begin
   if (map[i,j] = 2) and (map[i+1,j-1] = 2) and (map[i+3,j-3] = 2) then begin
        if map[i+2,j-2] = 0 then begin
          inx:=i+2;
          iny:=j-2;
          break;
        end;
      end;
   end;
   if (inx<>-1) and (iny<>-1) then exit;
   end;


  // проверка серий 2х по вертикали
  for i:=0 to 5 do begin
  for j:=0 to 4 do begin
    if (map[i,j] = 2) and (map[i,j+1] = 2) then begin
      // верхняя граница
      if j = 0 then begin
        if map[i,j+2] = 0 then begin
          inx:=i;
          iny:=j+2;
          break;
        end;
      end;
      // нижняя граница
      if j = 4 then begin
        if map[i,j-1] = 0 then begin
          inx:=i;
          iny:=j-1;
          break;
        end;
      end;
      if (j <>0) and (j<>4) then begin
        if map[i,j+2] = 0 then begin
          inx:=i;
          iny:=j+2;
          break;
        end;
        if map[i,j-1] = 0 then begin
          inx:=i;
          iny:=j-1;
          break;
        end;
      end;
    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  //проверка 2х по горизонтали
  for j:=0 to 5 do begin
  for i:=0 to 4 do begin
    if (map[i,j] = 2) and (map[i+1,j] = 2) then begin
      // левая граница
      if i = 0 then begin
        if map[i+2,j] = 0 then begin
          inx:=i+2;
          iny:=j;
          break;
        end;
      end;
      // правая граница
      if i = 4 then begin
        if map[i-1,j] = 0 then begin
          inx:=i-1;
          iny:=j;
          break;
        end;
      end;
      if (i <>0) and (i<>4) then begin
        if map[i+2,j] = 0 then begin
          inx:=i+2;
          iny:=j;
          break;
        end;
        if map[i-1,j] = 0 then begin
          inx:=i-1;
          iny:=j;
          break;
        end;
      end;
    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  //проверка главной диагонали по 2х
  for i:=0 to 3 do begin
  for j:=0 to 3 do begin
    //верхний граница
  if (map[i,j] = 2) and (map[i+1,j+1] = 2) then begin
    //верхний граница
      if (j = 0) or (i = 0) then begin
        if map[i+2,j+2] = 0 then begin
          inx:=i+2;
          iny:=j+2;
          break;
        end;
      end;
      //середина главной диагонали
      if (i <> 0) and (j <> 0) then begin
        if map[i+2,j+2] = 0 then begin
          inx:=i+2;
          iny:=j+2;
          break;
        end;
        if map[i-1,j-1] = 0 then begin
          inx:=i-1;
          iny:=j-1;
          break;
        end;
      end;

    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  //побочная диагональ по 2х
  for i:=0 to 3 do begin
  for j:=5 downto 2 do begin
  if (map[i,j] = 2) and (map[i+1,j-1] = 2) then begin
    //левая и нижнияя граница
      if (j = 5) or (i = 0) then begin
        if map[i+2,j-2] = 0 then begin
          inx:=i+2;
          iny:=j-2;
          break;
        end;
      end;
      //середина побочной диагонали
      if (i <> 0) and (j <> 5) then begin
        if map[i+2,j-2] = 0 then begin
          inx:=i+2;
          iny:=j-2;
          break;
        end;
        if map[i-1,j+1] = 0 then begin
          inx:=i-1;
          iny:=j+1;
          break;
        end;
      end;

    end;
  end;
  if (inx<>-1) and (iny<>-1) then exit;
  end;

  // 1 через 1 по горизонтали
   for j:=0 to 5 do begin
   for i:=0 to 3 do begin
     if (map[i,j] = 2) and (map[i+2,j] = 2) then begin
       if map[i+1,j]= 0 then begin
         inx:=i+1;
         iny:=j;
         break;
       end;
     end;
   end;
   if (inx<>-1) and (iny<>-1) then exit;
   end;

   // 1 через 1 по вертикали
   for i:=0 to 5 do begin
   for j:=0 to 3 do begin
     if (map[i,j] = 2) and (map[i,j+2] = 2) then begin
       if map[i,j+1]= 0 then begin
         inx:=i;
         iny:=j+1;
         break;
       end;
     end;
   end;
   if (inx<>-1) and (iny<>-1) then exit;
   end;


  //проверка одиночных символов
  for i:=0 to 5 do begin
        for j:=0 to 5 do begin
          if map[i,j]=2 then begin
            if i=0 then begin
              //левый верхний угол
              if j=0 then begin
                if map[i+1,j]=0 then begin
                inx:=i+1;
                iny:=j;
                break;
                end;
                if map[i+1,j+1]=0 then begin
                 inx:=i+1;
                iny:=j+1;
                break;
                end;
                if map[i,j+1]=0 then begin
                 inx:=i;
                iny:=j+1;
                break;
                end;
              end;

                //левыый нижний угол
                if j=5 then begin
                if map[i,j-1]=0 then begin
                inx:=i;
                iny:=j-1;
                break;
                end;
                if map[i+1,j-1]=0 then begin
                 inx:=i+1;
                iny:=j-1;
                break;
                end;
                if map[i+1,j]=0 then begin
                 inx:=i+1;
                iny:=j;
                break;
                end;
              end;

                // левая сторона
                if (j<>5) and (j<>0) then
                begin
                if map[i,j+1] = 0 then begin
                  inx:=i;
                  iny:=j+1;
                  break;
                end;
                if map[i+1,j+1] = 0 then begin
                  inx:=i+1;
                  iny:=j+1;
                  break;
                end;
                if map[i+1,j] = 0 then begin
                  inx:=i+1;
                  iny:=j;
                  break;
                end;
                if map[i+1,j-1] = 0 then begin
                  inx:=i+1;
                  iny:=j-1;
                  break;
                end;
                if map[i,j-1] = 0 then begin
                  inx:=i;
                  iny:=j-1;
                  break;
                end;
                end;
            end;

            if i = 5 then begin
               //правый верхний угол
              if j=0 then begin
                if map[i-1,j]=0 then begin
                inx:=i-1;
                iny:=j;
                break;
                end;
                if map[i-1,j+1]=0 then begin
                 inx:=i-1;
                iny:=j+1;
                break;
                end;
                if map[i,j+1]=0 then begin
                 inx:=i;
                iny:=j+1;
                break;
                end;
              end;

              //правый нижний угол
                if j=5 then begin
                if map[i,j-1]=0 then begin
                inx:=i;
                iny:=j-1;
                break;
                end;
                if map[i-1,j-1]=0 then begin
                 inx:=i-1;
                iny:=j-1;
                break;
                end;
                if map[i-1,j]=0 then begin
                 inx:=i-1;
                iny:=j;
                break;
                end;
              end;

                // левая сторона
                if (j<>5) and (j<>0) then
                begin
                if map[i,j+1] = 0 then begin
                  inx:=i;
                  iny:=j+1;
                  break;
                end;
                if map[i-1,j+1] = 0 then begin
                  inx:=i-1;
                  iny:=j+1;
                  break;
                end;
                if map[i-1,j] = 0 then begin
                  inx:=i-1;
                  iny:=j;
                  break;
                end;
                if map[i-1,j-1] = 0 then begin
                  inx:=i-1;
                  iny:=j-1;
                  break;
                end;
                if map[i,j-1] = 0 then begin
                  inx:=i;
                  iny:=j-1;
                  break;
                end;
                end;
            end;
            //верхняя сторона
            if (i<>0) and (i<>5) then begin
            if j = 0 then begin
            if map[i-1,j] = 0 then begin
              inx:=i-1;
              iny:=j;
              break;
            end;
            if map[i-1,j+1] = 0 then begin
              inx:=i-1;
              iny:=j+1;
              break;
            end;
            if map[i,j+1] = 0 then begin
              inx:=i;
              iny:=j+1;
              break;
            end;
            if map[i+1,j+1] = 0 then begin
              inx:=i+1;
              iny:=j+1;
              break;
            end;
            if map[i+1,j] = 0 then begin
              inx:=i+1;
              iny:=j;
              break;
            end;
          end;
            // нижняя сторона
            if j = 5 then begin
            if map[i-1,j] = 0 then begin
              inx:=i-1;
              iny:=j;
              break;
            end;
            if map[i-1,j-1] = 0 then begin
              inx:=i-1;
              iny:=j-1;
              break;
            end;
            if map[i,j-1] = 0 then begin
              inx:=i;
              iny:=j-1;
              break;
            end;
            if map[i+1,j-1] = 0 then begin
              inx:=i+1;
              iny:=j-1;
              break;
            end;
            if map[i+1,j] = 0 then begin
              inx:=i+1;
              iny:=j;
              break;
            end;
            end;
        end;

      //центр
    if ((i<>0) and (i<>5)) and ((j<>0) and (j<>5)) then begin
      if map[i,j-1] = 0 then begin
        inx:=i;
        iny:=j-1;
        break;
      end;
      if map[i,j+1] = 0 then begin
        inx:=i;
        iny:=j+1;
        break;
      end;
      if map[i-1,j] = 0 then begin
        inx:=i-1;
        iny:=j;
        break;
      end;
      if map[i+1,j] = 0 then begin
        inx:=i+1;
        iny:=j;
        break;
      end;
      if map[i-1,j-1] = 0 then begin
        inx:=i-1;
        iny:=j-1;
        break;
      end;
      if map[i+1,j+1] = 0 then begin
        inx:=i+1;
        iny:=j+1;
        break;
      end;
      if map[i+1,j-1] = 0 then begin
        inx:=i+1;
        iny:=j-1;
        break;
      end;
      if map[i-1,j+1] = 0 then begin
        inx:=i-1;
        iny:=j+1;
        break;
      end;
    end;
  end;
end;
  if (inx<>-1) and (iny<>-1) then break;
  end;

end;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

      if (Form1.RadioGroup1.ItemIndex = 0) and (current = 2) then
      begin
        hod;
        t:=strtoint(edit1.Text);
        label3.Caption:=inttostr(t);

        current:=1;
        map[inx,iny]:= 2;
        draw_circ;
        score[2,inx+6*iny]:= True;
        b1[inx+6*iny]:=2;
        if iswinner(2) then
        begin
          form1.timer2.Enabled:=false;
          Form1.Image1.Enabled:=False;
          isgame:= False;
          Form1.RadioGroup1.Enabled:=True;
          form1.Button1.caption:='Начать';
          form1.MenuItem2.Enabled:=True;
          ShowMessage('Нолики победили!');
          form1.Button5.Enabled:=false;
        end
        else if step = 35 then
        begin
          timer2.Enabled:=false;
          Form1.Image1.Enabled:=False;
          isgame:= False;
          Form1.RadioGroup1.Enabled:=True;
          form1.Button1.caption:='Начать';
          form1.MenuItem2.Enabled:=True;
          ShowMessage('Ничья!');
          form1.Button5.Enabled:=false;
        end
        else inc(step);
      end
    else
    if (Form1.RadioGroup1.ItemIndex = 1) and (current = 1) then
    begin
      if step = 0 then begin
      inx:=0;
      iny:=0;
      end
      else hod;
      t:=strtoint(edit1.Text);
      label3.Caption:=inttostr(t);

      current:=2;
      map[inx,iny]:= 1;
      draw_cross;
      score[1,inx+6*iny]:= True;
      if iswinner(1) then
      begin
        timer2.Enabled:=false;
        Image1.Enabled:=False;
        isgame:= False;
        RadioGroup1.Enabled:=True;
        Button1.caption:='Начать';
        MenuItem2.Enabled:=True;
        ShowMessage('Крестики победили!');
        form1.Button5.Enabled:=false;
      end
      else if step = 35 then
      begin
        timer2.Enabled:=false;
          Form1.Image1.Enabled:=False;
          isgame:= False;
          Form1.RadioGroup1.Enabled:=True;
          form1.Button1.caption:='Начать';
          form1.MenuItem2.Enabled:=True;
          ShowMessage('Ничья!');
          form1.Button5.Enabled:=false;
      end
      else inc(step);
    end;
  end;


  {i:=0;
  while i = 0 do
  begin
    inx:=random(6);
    iny:=random(6);
    if map[inx,iny]=0 then
    begin
      if (Form1.RadioGroup1.ItemIndex = 0) and (current = 2) then
      begin

        t:=strtoint(edit1.Text);
        label3.Caption:=inttostr(t);

        current:=1;
        map[inx,iny]:= 2;
        draw_circ;
        score[2,inx+6*iny]:= True;
        if iswinner(2) then
        begin
          form1.timer2.Enabled:=false;
          Form1.Image1.Enabled:=False;
          isgame:= False;
          Form1.RadioGroup1.Enabled:=True;
          form1.Button1.caption:='Начать';
          form1.MenuItem2.Enabled:=True;
          ShowMessage('Нолики победили!');
          form1.Button5.Enabled:=false;
        end
        else if step = 35 then
        begin
          timer2.Enabled:=false;
          Form1.Image1.Enabled:=False;
          isgame:= False;
          Form1.RadioGroup1.Enabled:=True;
          form1.Button1.caption:='Начать';
          form1.MenuItem2.Enabled:=True;
          ShowMessage('Ничья!');
          form1.Button5.Enabled:=false;
        end
        else inc(step);
      end
    else
    if (Form1.RadioGroup1.ItemIndex = 1) and (current = 1) then
    begin

      t:=strtoint(edit1.Text);
      label3.Caption:=inttostr(t);

      current:=2;
      map[inx,iny]:= 1;
      draw_cross;
      score[1,inx+6*iny]:= True;
      if iswinner(1) then
      begin
        timer2.Enabled:=false;
        Image1.Enabled:=False;
        isgame:= False;
        RadioGroup1.Enabled:=True;
        Button1.caption:='Начать';
        MenuItem2.Enabled:=True;
        ShowMessage('Крестики победили!');
        form1.Button5.Enabled:=false;
      end
      else if step = 35 then
      begin
        timer2.Enabled:=false;
          Form1.Image1.Enabled:=False;
          isgame:= False;
          Form1.RadioGroup1.Enabled:=True;
          form1.Button1.caption:='Начать';
          form1.MenuItem2.Enabled:=True;
          ShowMessage('Ничья!');
          form1.Button5.Enabled:=false;
      end
      else inc(step);
    end;
    end;
    i:=1;
  end;

end; }

procedure TForm1.Timer2Timer(Sender: TObject);

begin
  if isgame = false then timer2.Enabled:= false;
  t:=strtoint(label3.Caption);
  t:=t-1;
  label3.Caption:=inttostr(t);
  if (t = 0) and (current = 1) then
  begin
     timer2.Enabled:=false;
     Form1.Image1.Enabled:=False;
     isgame:= False;
     Form1.RadioGroup1.Enabled:=True;
     form1.Button1.caption:='Начать';
     form1.MenuItem2.Enabled:=True;
     ShowMessage('Нолики победили!');
     form1.Button5.Enabled:=false;
     t:=strtoint(edit1.Text);
     init;
  end
  else
  if (t = 0) and (current = 2) then
  begin
    timer2.Enabled:=false;
    Form1.Image1.Enabled:=False;
    isgame:= False;
    Form1.RadioGroup1.Enabled:=True;
    form1.Button1.caption:='Начать';
    form1.MenuItem2.Enabled:=True;
    ShowMessage('Крестики победили!');
    form1.Button5.Enabled:=false;
    t:=strtoint(edit1.Text);
    init;
  end;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
  inc(lol);
  if lol=100 then begin
  timer3.Enabled:=false;
  label7.Visible:=false;
  end;
end;

end.

