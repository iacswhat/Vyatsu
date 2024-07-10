unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Spin, ColorBox,
  StdCtrls, MaskEdit, ExtCtrls, LCLType;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button_vlevo: TButton;
    Button_vpravo: TButton;
    Button_vniz: TButton;
    Button_vverh: TButton;
    Button_plus: TButton;
    Button_minus: TButton;
    ComboBox_col_str: TComboBox;
    ComboBox_1: TComboBox;
    ComboBox_2: TComboBox;
    ComboBox_3: TComboBox;
    ComboBox_4: TComboBox;
    ComboBox_5: TComboBox;
    ComboBox_dop_usl: TComboBox;
    ComboBox_extr: TComboBox;
    Edit_X1_1: TEdit;
    Edit_X2_1: TEdit;
    Edit_B1: TEdit;
    Edit_X1_2: TEdit;
    Edit_X2_2: TEdit;
    Edit_B2: TEdit;
    Edit_X1_3: TEdit;
    Edit_X2_3: TEdit;
    Edit_B3: TEdit;
    Edit_X1_4: TEdit;
    Edit_X2_4: TEdit;
    Edit_B4: TEdit;
    Edit_X1_5: TEdit;
    Edit_X2_5: TEdit;
    Edit_B5: TEdit;
    Edit_X1: TEdit;
    Edit_X2: TEdit;
    Edit_X1_otvet: TEdit;
    Edit_X2_otvet: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PaintBox1: TPaintBox;
    procedure Button1Click(Sender: TObject);
    procedure Button_vverhClick(Sender: TObject);
    procedure Button_vnizClick(Sender: TObject);
    procedure Button_vlevoClick(Sender: TObject);
    procedure Button_vpravoClick(Sender: TObject);
    procedure Button_minusClick(Sender: TObject);
    procedure Button_plusClick(Sender: TObject);
    procedure ComboBox_col_strChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OSI;
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shtrixOSI;
    procedure Grad; // вектор градиент, линия уровня(перпендикуляр)и параллель к линии уровня
    procedure str_1; //отрисовка графиков и выделение области для первой строки ограничений
    procedure str_2; //для второй строки ограничений
    procedure str_3; //для третьей строки ограничений
    procedure str_4; //для четвертой строки ограничений
    procedure str_5; //для четвертой строки ограничений

  private

  public


  end;

var
  Form1: TForm1;
  mas1, mas2, mas3, mas4, mas5: array[1..2, 1..2] of real;
  cx: integer = 700;
  cy: integer = 475;
  h: integer = 30;
  hh: integer = 10;
  n: integer = 5;
  maxx: integer = 1400;
  maxy: integer = 950;
  m: real = 1; //масштаб
  flag:boolean; //отслеживание нажатия мыши
  //flag2: boolean;
  XX,YY: integer;
  px1, px2, px11, px22: real;
  color1: Tcolor;
  color2: string;

implementation

{$R *.lfm}

{ TForm1 }

//   начальное отображение
procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.ComboBox_col_str.Text:= inttostr(2);
  Form1.ComboBox_dop_usl.Text:= Form1.ComboBox_dop_usl.Items[0];

  Form1.Edit_X1_1.Enabled:= True;
  Form1.Edit_X2_1.Enabled:= True;
  Form1.Edit_X1_2.Enabled:= True;
  Form1.Edit_X2_2.Enabled:= True;

  Form1.ComboBox_1.Enabled:= True;
  Form1.ComboBox_2.Enabled:= True;

  Form1.Edit_B1.Enabled:= True;
  Form1.Edit_B2.Enabled:= True;

end;


//   активность элементов в зависомости от колличества ограничений
procedure TForm1.ComboBox_col_strChange(Sender: TObject);

begin

  if strtoint(Form1.ComboBox_col_str.Text) = 1 then
  begin
    Form1.Edit_X1_1.Enabled:= True;
    Form1.Edit_X2_1.Enabled:= True;
    Form1.Edit_X1_2.Enabled:= False;
    Form1.Edit_X2_2.Enabled:= False;
    Form1.Edit_X1_3.Enabled:= False;
    Form1.Edit_X2_3.Enabled:= False;
    Form1.Edit_X1_4.Enabled:= False;
    Form1.Edit_X2_4.Enabled:= False;
    Form1.Edit_X1_5.Enabled:= False;
    Form1.Edit_X2_5.Enabled:= False;

    Form1.ComboBox_1.Enabled:= True;
    Form1.ComboBox_2.Enabled:= False;
    Form1.ComboBox_3.Enabled:= False;
    Form1.ComboBox_4.Enabled:= False;
    Form1.ComboBox_5.Enabled:= False;

    Form1.Edit_B1.Enabled:= True;
    Form1.Edit_B2.Enabled:= False;
    Form1.Edit_B3.Enabled:= False;
    Form1.Edit_B4.Enabled:= False;
    Form1.Edit_B5.Enabled:= False;

  end;

  if strtoint(Form1.ComboBox_col_str.Text) = 2 then
  begin
    Form1.Edit_X1_1.Enabled:= True;
    Form1.Edit_X2_1.Enabled:= True;
    Form1.Edit_X1_2.Enabled:= True;
    Form1.Edit_X2_2.Enabled:= True;
    Form1.Edit_X1_3.Enabled:= False;
    Form1.Edit_X2_3.Enabled:= False;
    Form1.Edit_X1_4.Enabled:= False;
    Form1.Edit_X2_4.Enabled:= False;
    Form1.Edit_X1_5.Enabled:= False;
    Form1.Edit_X2_5.Enabled:= False;

    Form1.ComboBox_1.Enabled:= True;
    Form1.ComboBox_2.Enabled:= True;
    Form1.ComboBox_3.Enabled:= False;
    Form1.ComboBox_4.Enabled:= False;
    Form1.ComboBox_5.Enabled:= False;

    Form1.Edit_B1.Enabled:= True;
    Form1.Edit_B2.Enabled:= True;
    Form1.Edit_B3.Enabled:= False;
    Form1.Edit_B4.Enabled:= False;
    Form1.Edit_B5.Enabled:= False;
  end;

  if strtoint(Form1.ComboBox_col_str.Text) = 3 then
  begin
    Form1.Edit_X1_1.Enabled:= True;
    Form1.Edit_X2_1.Enabled:= True;
    Form1.Edit_X1_2.Enabled:= True;
    Form1.Edit_X2_2.Enabled:= True;
    Form1.Edit_X1_3.Enabled:= True;
    Form1.Edit_X2_3.Enabled:= True;
    Form1.Edit_X1_4.Enabled:= False;
    Form1.Edit_X2_4.Enabled:= False;
    Form1.Edit_X1_5.Enabled:= False;
    Form1.Edit_X2_5.Enabled:= False;

    Form1.ComboBox_1.Enabled:= True;
    Form1.ComboBox_2.Enabled:= True;
    Form1.ComboBox_3.Enabled:= True;
    Form1.ComboBox_4.Enabled:= False;
    Form1.ComboBox_5.Enabled:= False;

    Form1.Edit_B1.Enabled:= True;
    Form1.Edit_B2.Enabled:= True;
    Form1.Edit_B3.Enabled:= True;
    Form1.Edit_B4.Enabled:= False;
    Form1.Edit_B5.Enabled:= False;
  end;

  if strtoint(Form1.ComboBox_col_str.Text) = 4 then
  begin
    Form1.Edit_X1_1.Enabled:= True;
    Form1.Edit_X2_1.Enabled:= True;
    Form1.Edit_X1_2.Enabled:= True;
    Form1.Edit_X2_2.Enabled:= True;
    Form1.Edit_X1_3.Enabled:= True;
    Form1.Edit_X2_3.Enabled:= True;
    Form1.Edit_X1_4.Enabled:= True;
    Form1.Edit_X2_4.Enabled:= True;
    Form1.Edit_X1_5.Enabled:= False;
    Form1.Edit_X2_5.Enabled:= False;

    Form1.ComboBox_1.Enabled:= True;
    Form1.ComboBox_2.Enabled:= True;
    Form1.ComboBox_3.Enabled:= True;
    Form1.ComboBox_4.Enabled:= True;
    Form1.ComboBox_5.Enabled:= False;

    Form1.Edit_B1.Enabled:= True;
    Form1.Edit_B2.Enabled:= True;
    Form1.Edit_B3.Enabled:= True;
    Form1.Edit_B4.Enabled:= True;
    Form1.Edit_B5.Enabled:= False;
  end;

  if strtoint(Form1.ComboBox_col_str.Text) = 5 then
  begin
    Form1.Edit_X1_1.Enabled:= True;
    Form1.Edit_X2_1.Enabled:= True;
    Form1.Edit_X1_2.Enabled:= True;
    Form1.Edit_X2_2.Enabled:= True;
    Form1.Edit_X1_3.Enabled:= True;
    Form1.Edit_X2_3.Enabled:= True;
    Form1.Edit_X1_4.Enabled:= True;
    Form1.Edit_X2_4.Enabled:= True;
    Form1.Edit_X1_5.Enabled:= True;
    Form1.Edit_X2_5.Enabled:= True;

    Form1.ComboBox_1.Enabled:= True;
    Form1.ComboBox_2.Enabled:= True;
    Form1.ComboBox_3.Enabled:= True;
    Form1.ComboBox_4.Enabled:= True;
    Form1.ComboBox_5.Enabled:= True;

    Form1.Edit_B1.Enabled:= True;
    Form1.Edit_B2.Enabled:= True;
    Form1.Edit_B3.Enabled:= True;
    Form1.Edit_B4.Enabled:= True;
    Form1.Edit_B5.Enabled:= True;
  end;
end;


procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 //
  If button<>mbLeft Then
  flag:=false
  else flag:=true;
  color1:= Form1.PaintBox1.Canvas.Pixels[X,Y];
  color2:= ColorToString(color1);

end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     flag := false;
    // XX:=X; YY:=Y;
     if color2 = colortostring(clGray) then begin
            OSI;
            shtrixOSI; // штриховка области по осям
            //запуск процедур в зависимости от колличества строк
             if Form1.ComboBox_col_str.ItemIndex = 0 then   str_1;
             if Form1.ComboBox_col_str.ItemIndex = 1 then
                 begin
                   str_1; str_2;
                 end;
              if Form1.ComboBox_col_str.ItemIndex = 2 then
                 begin
                   str_1; str_2; str_3;
                end;
              if Form1.ComboBox_col_str.ItemIndex = 3 then
                begin
                     str_1; str_2; str_3; str_4;
                end;
              if Form1.ComboBox_col_str.ItemIndex = 4 then
                begin
                     str_1; str_2; str_3; str_4; str_5;
                end;
              Grad;

              Form1.PaintBox1.Canvas.Pen.Width:=2;
              Form1.PaintBox1.Canvas.Pen.Style:=psSolid;
              Form1.PaintBox1.Canvas.Pen.Color:=clGray;

              Form1.PaintBox1.Canvas.Line(X + round(px1*h*m), Y - round(px2*h*m), X + round(px11*h*m), Y - round(px22*h*m));

     end;

end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 // X:=X; Y:=Y;
  if (flag = true) and (color2 = colortostring(clGray)) then
        begin
        if (Edit_X1.Text<>'0') and (Edit_X2.Text<>'0') then
            begin
              mas1[1, 1]:= 20;
              mas1[2, 1]:= (0-strtofloat(Form1.Edit_X1.Text)*20) / strtofloat(Form1.Edit_X2.Text);
              mas1[1, 2]:= -20;
              mas1[2, 2]:= (0+strtofloat(Form1.Edit_X1.Text)*20) / strtofloat(Form1.Edit_X2.Text);

             Form1.PaintBox1.Canvas.Pen.Width:=1;
             Form1.PaintBox1.Canvas.Pen.Style:=psDot;
             Form1.PaintBox1.Canvas.Pen.Color:=clSilver;

              px1:= mas1[1, 1];
              px2:= mas1[2,1];
              px11:= mas1[1, 2];
              px22:=mas1[2,2];
          //    Form1.PaintBox1.Canvas.Line(X + round(px1*h*m), Y - round(px2*h*m), X + round(px11*h*m), Y - round(px22*h*m));
           end;
   end;
end;


procedure TForm1.OSI;        // PainBox, оси, числа на осях, точки
var
  i, ii, x, y, n: integer;
  t: string;
begin
  // PaintBox
  Form1.PaintBox1.Canvas.Brush.Color:= ClWhite;
  Form1.Paintbox1.Canvas.FillRect(0, 0, paintbox1.Width, paintbox1.Height);
  Form1.PaintBox1.Canvas.Pen.Width:=2;
  Form1.PaintBox1.Canvas.Pen.Style:=psSolid;
  Form1.PaintBox1.Canvas.Pen.Color:=ClBlack;
  Form1.PaintBox1.Canvas.Rectangle(1, 1, paintbox1.Width, paintbox1.Height);
  Form1.PaintBox1.Canvas.Line(1,1,2,2);

  //Точки(сетка)
  for i:= -50 to 50 do
      begin
      y:=round(cy + i*h*m);
      for ii := -50 to 50 do
          begin
          x:=round(cx + ii*h*m);
         Form1.PaintBox1.Canvas.Pixels[x, y] := ClBlack;
         Form1.PaintBox1.Canvas.Pixels[x-1, y] := ClBlack;
         Form1.PaintBox1.Canvas.Pixels[x+1, y] := ClBlack;
         Form1.PaintBox1.Canvas.Pixels[x, y-1] := ClBlack;
         Form1.PaintBox1.Canvas.Pixels[x, y+1] := ClBlack;
         // t:= '.';
         // Form1.PaintBox1.Canvas.TextOut(x-1, y-9, t);

          end;
      end;

  // Оси
  Form1.PaintBox1.Canvas.Pen.Width:=1;
  Form1.PaintBox1.Canvas.Pen.Style:=psSolid;
  Form1.PaintBox1.Canvas.Line(cx, 0, cx, maxy);
  Form1.PaintBox1.Canvas.Line(0, cy, maxx, cy);
  for i := -50 to 50 do Form1.PaintBox1.Canvas.Line(round(cx + i*h*m), cy - 5, round(cx + i*h*m), cy + 5); // OX
  for i:= -50 to 50 do Form1.PaintBox1.Canvas.Line(cx-5, round(cy + i*h*m), cx+5, round(cy + i*h*m));      // OY

  //числа на осях Ox
      n:=0;
      Form1.PaintBox1.Canvas.TextOut(cx-20, cy+5, inttostr(n));
  for i := -50 to -10 do
      begin
      n:=i;
      if i mod 2=0 then
      Form1.PaintBox1.Canvas.TextOut(round(cx + i*h*m-12), cy+20, inttostr(n));
      end;
  for i := -9 to -1 do
      begin
      n:=i;
      if i mod 2=0 then
      Form1.PaintBox1.Canvas.TextOut(round(cx + i*h*m-6), cy+20, inttostr(n));
      end;
   for i := 1 to 9 do
      begin
      n:=i;
      if i mod 2=0 then
      Form1.PaintBox1.Canvas.TextOut(round(cx + i*h*m-3), cy+20, inttostr(n));
      end;
   for i := 10 to 50 do
      begin
      n:=i;
      if i mod 2=0 then
      Form1.PaintBox1.Canvas.TextOut(round(cx + i*h*m-6), cy+20, inttostr(n));
      end;
   //числа на осях Oy
  for i := -50 to -10 do
      begin
      n:=i;
      if i mod 2=0 then
      Form1.PaintBox1.Canvas.TextOut(cx-46, round(cy - i*h*m-6), inttostr(n));
      end;
  for i := -9 to -1 do
      begin
      n:=i;
      if i mod 2=0 then
      Form1.PaintBox1.Canvas.TextOut(cx-40, round(cy - i*h*m-6), inttostr(n));
      end;
   for i := 1 to 9 do
      begin
      n:=i;
      if i mod 2=0 then
      Form1.PaintBox1.Canvas.TextOut(cx-34, round(cy - i*h*m-6), inttostr(n));
      end;
   for i := 10 to 50 do
      begin
      n:=i;
      if i mod 2=0 then
      Form1.PaintBox1.Canvas.TextOut(cx-40, round(cy - i*h*m-6), inttostr(n));
      end;
 end;

procedure TForm1.shtrixOSI;  // процедура штриховки области по осям
var
  i: integer;

begin
  Form1.PaintBox1.Canvas.Pen.Color:= ClBlue;
  Form1.PaintBox1.Canvas.Pen.Width:=2;

  // X>=0 Y>=0
  if Form1.ComboBox_dop_usl.ItemIndex = 1 then
  begin
    for i := 0 to 150 do Form1.PaintBox1.Canvas.Line(cx + i*hh, cy, cx + i*hh + 5, cy - 5);
    for i:= 0 to 150 do Form1.PaintBox1.Canvas.Line(cx, cy - i*hh, cx+5, cy - i*hh-5);
  end;

  // X<=0 Y<=0
  if Form1.ComboBox_dop_usl.ItemIndex = 2 then
  begin
    for i := 0 to 150 do Form1.PaintBox1.Canvas.Line(cx - i*hh, cy, cx - i*hh - 5, cy + 5);
    for i:= 0 to 150 do Form1.PaintBox1.Canvas.Line(cx, cy + i*hh, cx-5, cy + i*hh+5);
  end;

  // X>=0 Y<=0
  if Form1.ComboBox_dop_usl.ItemIndex = 3 then
  begin
    for i := 0 to 150 do Form1.PaintBox1.Canvas.Line(cx + i*hh, cy, cx + i*hh + 5, cy + 5);
    for i:= 0 to 150 do Form1.PaintBox1.Canvas.Line(cx, cy + i*hh, cx+5, cy + i*hh+5);
  end;

  // X<=0 Y>=0
  if Form1.ComboBox_dop_usl.ItemIndex = 4 then
  begin
    for i := 0 to 150 do Form1.PaintBox1.Canvas.Line(cx - i*hh, cy, cx - i*hh - 5, cy - 5);
    for i:= 0 to 150 do Form1.PaintBox1.Canvas.Line(cx, cy - i*hh, cx-5, cy - i*hh-5);
  end;
end;

procedure TForm1.str_1;
var
  x1, x2, x11, x22: real;
  ii: integer;
  a1,a2,b1,b2: real;
  k,x,y,b: real;
  begin
    Form1.PaintBox1.Canvas.Pen.Width:=2;
    Form1.PaintBox1.Canvas.Pen.Style:=psSolid; //сплошная линия
    Form1.PaintBox1.Canvas.Pen.Color:=clGreen;

      if (Edit_X1_1.Text<>'0') and (Edit_X2_1.Text<>'0') and (Edit_B1.Text<>'0') then
      begin
        mas1[1, 1]:= 20;
        mas1[2, 1]:= (strtofloat(Form1.Edit_B1.Text)-strtofloat(Form1.Edit_X1_1.Text)*20) / strtofloat(Form1.Edit_X2_1.Text);
        mas1[1, 2]:= -20;
        mas1[2, 2]:= (strtofloat(Form1.Edit_B1.Text)+strtofloat(Form1.Edit_X1_1.Text)*20) / strtofloat(Form1.Edit_X2_1.Text);

        x1:= mas1[1, 1];
        x2:= mas1[2,1];
        x11:= mas1[1, 2];
        x22:=mas1[2,2];
        Form1.PaintBox1.Canvas.Line(cx + round(x1*h*m), cy - round(x2*h*m), cx + round(x11*h*m), cy - round(x22*h*m));

        // находим уравнение прямой (y=kx+b) по двум точкам A(a1,a2), B(b1,b2)
        //присваиваем ранее найденные значения
        a1:=cx + round(x1*h*m);
        a2:=cy - round(x2*h*m);
        b1:=cx + round(x11*h*m);
        b2:=cy - round(x22*h*m);

        k:=(a2-b2)/(a1-b1);
        b:=b2-k*b1;
        //решаем в какую сторону будет штриховка, находим точку пересечения координатных прямых(пересекает положительный или отрицательный х),
        //x выражаем из уравнения прямой (y=kx+b)при y=0 (475)

        x:=(cy-b)/k;
        if x>cx then
        begin
           if Form1.ComboBox_1.ItemIndex = 0 then //>=
               begin
               //подставляем 0 вместо x1,x2
                  if strtofloat(Edit_X1_1.Text)*0 + strtofloat(Edit_X2_1.Text)*0 >= strtofloat(Edit_B1.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b));
               end;

           if Form1.ComboBox_1.ItemIndex = 2 then //<=
               begin
                  if strtofloat(Edit_X1_1.Text)*0 + strtofloat(Edit_X2_1.Text)*0 <= strtofloat(Edit_B1.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b));
               end;
        end;

        if x<cx then
        begin
           if Form1.ComboBox_1.ItemIndex = 0 then  //>=
               begin
               //подставляем 0 вместо x1,x2
                  if strtofloat(Edit_X1_1.Text)*0 + strtofloat(Edit_X2_1.Text)*0 >= strtofloat(Edit_B1.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b));
               end;

           if Form1.ComboBox_1.ItemIndex = 2 then   //<=
               begin
                  if strtofloat(Edit_X1_1.Text)*0 + strtofloat(Edit_X2_1.Text)*0 <= strtofloat(Edit_B1.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b));
               end;
        end;

        end;

      if (Edit_X1_1.Text<>'0') and (Edit_X2_1.Text='0') then     //прямоя вдоль Оy
      begin
        x1:= strtofloat(Form1.Edit_B1.Text) / strtofloat(Form1.Edit_X1_1.Text);
        Form1.PaintBox1.Canvas.Line(cx + round(x1*h*m), 1, cx + round(x1*h*m), maxy-1);

        x:=cx + round(x1*h*m);

        if x > cx then   // x>0
        begin
           if Form1.ComboBox_1.ItemIndex = 0 then //>=
               begin
               //подставляем 0 вместо x1
                  if strtofloat(Edit_X1_1.Text)*0 >= strtofloat(Edit_B1.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh);
               end;

           if Form1.ComboBox_1.ItemIndex = 2 then//<=
               begin
                  if strtofloat(Edit_X1_1.Text)*0 <= strtofloat(Edit_B1.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh);
               end;
        end;

        if x<cx then
        begin
           if Form1.ComboBox_1.ItemIndex = 0 then  //>=
               begin
               //подставляем 0 вместо x1
                  if strtofloat(Edit_X1_1.Text)*0 >= strtofloat(Edit_B1.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh);
               end;

           if Form1.ComboBox_1.ItemIndex = 2 then
               begin
                  if strtofloat(Edit_X1_1.Text)*0 <= strtofloat(Edit_B1.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh);
               end;
        end;

         if x=cx then
        begin
           if Form1.ComboBox_1.ItemIndex = 0 then  //>=
               begin
               //подставляем 0 вместо x1
                  if strtofloat(Edit_X1_1.Text)*1 >= strtofloat(Edit_B1.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh);
               end;

           if Form1.ComboBox_1.ItemIndex = 2 then
               begin
                  if strtofloat(Edit_X1_1.Text)*1 <= strtofloat(Edit_B1.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh);
               end;
        end;

      end;

      if (Edit_X1_1.Text='0') and (Edit_X2_1.Text<>'0') then     //прямоя вдоль Оx
      begin
        x2:= strtofloat(Form1.Edit_B1.Text) / strtofloat(Form1.Edit_X2_1.Text);
        Form1.PaintBox1.Canvas.Line(1, cy - round(x2*h), maxx-1, cy - round(x2*h));

        y:= cy - round(x2*h*m);

         if y > cy then   // y<0 в обычной системе координат
        begin
           if Form1.ComboBox_1.ItemIndex = 0 then  //>=
               begin
               //подставляем 0 вместо x2
                  if strtofloat(Edit_X2_1.Text)*0 >= strtofloat(Edit_B1.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y-10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y+10));
               end;


           if Form1.ComboBox_1.ItemIndex = 2 then  //<=
               begin
                  if strtofloat(Edit_X2_1.Text)*0 <= strtofloat(Edit_B1.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y-10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y+10));
               end;
        end;

        if y < cy then
        begin
           if Form1.ComboBox_1.ItemIndex = 0 then   //>=
               begin
               //подставляем 0 вместо x2
                  if strtofloat(Edit_X2_1.Text)*0 >= strtofloat(Edit_B1.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y+10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y-10));
               end;

           if Form1.ComboBox_1.ItemIndex = 2 then  //<=
               begin
                  if strtofloat(Edit_X2_1.Text)*0 <= strtofloat(Edit_B1.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y+10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y-10));
               end;
        end;

        if y = cy then
        begin
           if Form1.ComboBox_1.ItemIndex = 0 then   //>=
               begin
               //подставляем 0 вместо x2
                  if strtofloat(Edit_X2_1.Text)*1 >= strtofloat(Edit_B1.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y-10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y+10));
               end;

           if Form1.ComboBox_1.ItemIndex = 2 then  //<=
               begin
                  if strtofloat(Edit_X2_1.Text)*1 <= strtofloat(Edit_B1.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y-10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y+10));
               end;
        end;

      end;

      if (Edit_B1.Text='0') and (Edit_X1_1.Text<>'0') and (Edit_X2_1.Text<>'0') then
      begin
        mas1[1, 1]:= 20;
        mas1[2, 1]:= -strtofloat(Form1.Edit_X1_1.Text)*20 / strtofloat(Form1.Edit_X2_1.Text);
        mas1[1, 2]:= -20;
        mas1[2, 2]:= strtofloat(Form1.Edit_X1_1.Text)*20 / strtofloat(Form1.Edit_X2_1.Text);

        x1:= mas1[1, 1];
        x2:= mas1[2,1];
        x11:= mas1[1, 2];
        x22:=mas1[2,2];
        Form1.PaintBox1.Canvas.Line(cx + round(x1*h*m), cy - round(x2*h*m), cx + round(x11*h*m), cy - round(x22*h*m));

        a1:=cx + round(x1*h*m);
        a2:=cy - round(x2*h*m);
        b1:=cx + round(x11*h*m);
        b2:=cy - round(x22*h*m);

        k:=(a2-b2)/(a1-b1);
        b:=b2-k*b1;

        x:=(cy-h*m-b)/k;

        if x>cx then
        begin
           if Form1.ComboBox_1.ItemIndex = 0 then //>=
               begin
               //подставляем 0,1 вместо x1,x2
                  if strtofloat(Edit_X1_1.Text)*0 + strtofloat(Edit_X2_1.Text)*1 >= strtofloat(Edit_B1.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b));
               end;

           if Form1.ComboBox_1.ItemIndex = 2 then //<=
               begin
                  if strtofloat(Edit_X1_1.Text)*0 + strtofloat(Edit_X2_1.Text)*1 <= strtofloat(Edit_B1.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b));
               end;
        end;

        if x<cx then
        begin
           if Form1.ComboBox_1.ItemIndex = 0 then  //>=
               begin
               //подставляем 0,1 вместо x1,x2
                  if strtofloat(Edit_X1_1.Text)*0 + strtofloat(Edit_X2_1.Text)*1 >= strtofloat(Edit_B1.Text) then
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b));
               end;
           if Form1.ComboBox_1.ItemIndex = 2 then   //<=
               begin
                  if strtofloat(Edit_X1_1.Text)*0 + strtofloat(Edit_X2_1.Text)*1 <= strtofloat(Edit_B1.Text) then
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b));
               end;
        end;

      end;

  end;

procedure TForm1.str_2;
 var
 x1, x2, x11, x22: real;
 ii: integer;
 a1,a2,b1,b2: real;
 k,x,y,b: real;
   begin
     Form1.PaintBox1.Canvas.Pen.Width:=2;
     Form1.PaintBox1.Canvas.Pen.Style:=psSolid;
     Form1.PaintBox1.Canvas.Pen.Color:=clYellow;

    if (Edit_X1_2.Text<>'0') and (Edit_X2_2.Text<>'0') and (Edit_B2.Text<>'0') then
    begin
      mas2[1, 1]:= 20;
      mas2[2, 1]:= (strtofloat(Form1.Edit_B2.Text)-strtofloat(Form1.Edit_X1_2.Text)*20) / strtofloat(Form1.Edit_X2_2.Text);
      mas2[1, 2]:= -20;
      mas2[2, 2]:= (strtofloat(Form1.Edit_B2.Text)+strtofloat(Form1.Edit_X1_2.Text)*20) / strtofloat(Form1.Edit_X2_2.Text);

      x1:= mas2[1, 1];
      x2:= mas2[2,1];
      x11:= mas2[1, 2];
      x22:=mas2[2,2];
      Form1.PaintBox1.Canvas.Line(cx + round(x1*h*m), cy - round(x2*h*m), cx + round(x11*h*m), cy - round(x22*h*m));

      // находим уравнение прямой (y=kx+b) по двум точкам A(a1,a2), B(b1,b2)..............................///////////////////////////////////////////
      //присваиваем ранее найденные значения
      a1:=cx + round(x1*h*m);
      a2:=cy - round(x2*h*m);
      b1:=cx + round(x11*h*m);
      b2:=cy - round(x22*h*m);

      k:=(a2-b2)/(a1-b1);
      b:=b2-k*b1;

      //решаем в какую сторону будет штриховка, находим точки пересечения координатных прямых, пересекает положительный или отрицательный х,
      //x выражаем из уравнения прямой (y=kx+b)при y=0

      x:=(cy-b)/k;
      if x>cx then
      begin
         if Form1.ComboBox_2.ItemIndex = 0 then
             begin
             //подставляем 0 координаты вместо x1,x2
                if strtofloat(Edit_X1_2.Text)*0 + strtofloat(Edit_X2_2.Text)*0 >= strtofloat(Edit_B2.Text) then

                     for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b))
                else
                     for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b));
             end;

         if Form1.ComboBox_2.ItemIndex = 2 then
             begin
                if strtofloat(Edit_X1_2.Text)*0 + strtofloat(Edit_X2_2.Text)*0 <= strtofloat(Edit_B2.Text) then

                     for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b))
                else
                     for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b));
             end;
      end;


      if x<cx then
      begin
         if Form1.ComboBox_2.ItemIndex = 0 then
             begin
             //подставляем 0 вместо x1,x2
                if strtofloat(Edit_X1_2.Text)*0 + strtofloat(Edit_X2_2.Text)*0 >= strtofloat(Edit_B2.Text) then

                     for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b))
                else
                     for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b));
             end;

         if Form1.ComboBox_2.ItemIndex = 2 then
             begin
                if strtofloat(Edit_X1_2.Text)*0 + strtofloat(Edit_X2_2.Text)*0 <= strtofloat(Edit_B2.Text) then

                     for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b))
                else
                     for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b));
             end;
      end;

    end;

    if (Edit_X1_2.Text<>'0') and (Edit_X2_2.Text='0') then
    begin
      x1:= strtofloat(Form1.Edit_B2.Text) / strtofloat(Form1.Edit_X1_2.Text);
      Form1.PaintBox1.Canvas.Line(cx + round(x1*h*m), 1, cx + round(x1*h*m), maxy-1);

           x:=cx + round(x1*h*m);

        if x > cx then   // x>0
        begin
           if Form1.ComboBox_2.ItemIndex = 0 then //>=
               begin
               //подставляем 0 вместо x1
                  if strtofloat(Edit_X1_2.Text)*0 >= strtofloat(Edit_B2.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh);
               end;


           if Form1.ComboBox_2.ItemIndex = 2 then//<=
               begin
                  if strtofloat(Edit_X1_2.Text)*0*0 <= strtoint(Edit_B2.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh);
               end;
        end;

        if x<cx then
        begin
           if Form1.ComboBox_2.ItemIndex = 0 then  //>=
               begin
               //подставляем 0 вместо x1
                  if strtofloat(Edit_X1_2.Text)*0 >= strtofloat(Edit_B2.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh);
               end;

           if Form1.ComboBox_2.ItemIndex = 2 then  //<=
               begin
                  if strtofloat(Edit_X1_2.Text)*0 <= strtofloat(Edit_B2.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh);
               end;
        end;

        if x=cx then
        begin
           if Form1.ComboBox_2.ItemIndex = 0 then  //>=
               begin
               //подставляем 0 вместо x1
                  if strtofloat(Edit_X1_2.Text)*1 >= strtofloat(Edit_B2.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh);
               end;

           if Form1.ComboBox_2.ItemIndex = 2 then  //<=
               begin
                  if strtofloat(Edit_X1_2.Text)*1 <= strtofloat(Edit_B2.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh);
               end;
        end;

    end;

    if (Edit_X1_2.Text='0') and (Edit_X2_2.Text<>'0') then
    begin

      x2:= strtofloat(Form1.Edit_B2.Text) / strtofloat(Form1.Edit_X2_2.Text);
      Form1.PaintBox1.Canvas.Line(1, cy - round(x2*h*m), maxx-1, cy - round(x2*h*m));

      y:= cy - round(x2*h*m);

         if y > cy then   // y<0 в обычной системе координат
        begin
           if Form1.ComboBox_2.ItemIndex = 0 then  //>=
               begin
               //подставляем 0 вместо x2
                  if strtofloat(Edit_X2_2.Text)*0 >= strtofloat(Edit_B2.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y-10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y+10));
               end;


           if Form1.ComboBox_2.ItemIndex = 2 then  //<=
               begin
                  if strtofloat(Edit_X2_2.Text)*0 <= strtofloat(Edit_B2.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y-10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y+10));
               end;
        end;

        if y < cy then
        begin
           if Form1.ComboBox_2.ItemIndex = 0 then   //>=
               begin
               //подставляем 0 вместо x2
                  if strtofloat(Edit_X2_2.Text)*0 >= strtofloat(Edit_B2.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y+10))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y-10), cx + ii*hh, round(y));
               end;

           if Form1.ComboBox_2.ItemIndex = 2 then  //<=
               begin
                  if strtofloat(Edit_X2_2.Text)*0 <= strtofloat(Edit_B2.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y+10))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y-10), cx + ii*hh, round(y));
               end;
        end;

          if y = cy then
        begin
           if Form1.ComboBox_2.ItemIndex = 0 then   //>=
               begin
               //подставляем 0 вместо x2
                  if strtofloat(Edit_X2_2.Text)*1 >= strtofloat(Edit_B2.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y-10))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y+10), cx + ii*hh, round(y));
               end;

           if Form1.ComboBox_2.ItemIndex = 2 then  //<=
               begin
                  if strtofloat(Edit_X2_2.Text)*1 <= strtofloat(Edit_B2.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y-10))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y+10), cx + ii*hh, round(y));
               end;
        end;

    end;

    if (Edit_B2.Text='0') and (Edit_X1_2.Text<>'0') and (Edit_X2_2.Text<>'0') then
    begin
      mas2[1, 1]:= 20;
      mas2[2, 1]:= -strtofloat(Form1.Edit_X1_2.Text)*20 / strtofloat(Form1.Edit_X2_2.Text);
      mas2[1, 2]:= -20;
      mas2[2, 2]:= strtofloat(Form1.Edit_X1_2.Text)*20 / strtofloat(Form1.Edit_X2_2.Text);

      x1:= mas2[1, 1];
      x2:= mas2[2,1];
      x11:= mas2[1, 2];
      x22:=mas2[2,2];
      Form1.PaintBox1.Canvas.Line(cx + round(x1*h*m), cy - round(x2*h*m), cx + round(x11*h*m), cy - round(x22*h*m));
       a1:=cx + round(x1*h);
        a2:=cy - round(x2*h);
        b1:=cx + round(x11*h);
        b2:=cy - round(x22*h);

        k:=(a2-b2)/(a1-b1);
        b:=b2-k*b1;


         x:=(cy-h*m-b)/k;

        if x>cx then
        begin
           if Form1.ComboBox_2.ItemIndex = 0 then //>=
               begin
               //подставляем 0,1 вместо x1,x2
                  if strtofloat(Edit_X1_2.Text)*0 + strtofloat(Edit_X2_2.Text)*1 >= strtofloat(Edit_B2.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b));
               end;

           if Form1.ComboBox_2.ItemIndex = 2 then //<=
               begin
                  if strtofloat(Edit_X1_2.Text)*0 + strtofloat(Edit_X2_2.Text)*1 <= strtofloat(Edit_B2.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b));
               end;
        end;

        if x<cx then
        begin
           if Form1.ComboBox_2.ItemIndex = 0 then  //>=
               begin
               //подставляем 0,1 вместо x1,x2
                  if strtofloat(Edit_X1_2.Text)*0 + strtofloat(Edit_X2_2.Text)*1 >= strtofloat(Edit_B2.Text) then
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b));
               end;
           if Form1.ComboBox_2.ItemIndex = 2 then   //<=
               begin
                  if strtofloat(Edit_X1_2.Text)*0 + strtofloat(Edit_X2_2.Text)*1 <= strtofloat(Edit_B2.Text) then
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b));
               end;
        end;

    end;

   end;

procedure TForm1.str_3;

 var
  x1, x2, x11, x22: real;
  ii: integer;
  a1,a2,b1,b2: real;
  k,x,y,b: real;
      begin
     Form1.PaintBox1.Canvas.Pen.Width:=2;
     Form1.PaintBox1.Canvas.Pen.Style:=psSolid;
     Form1.PaintBox1.Canvas.Pen.Color:=clAqua;

    if (Edit_X1_3.Text<>'0') and (Edit_X2_3.Text<>'0') and (Edit_B3.Text<>'0') then
    begin
      mas2[1, 1]:= 20;
      mas2[2, 1]:= (strtofloat(Form1.Edit_B3.Text)-strtofloat(Form1.Edit_X1_3.Text)*20) / strtofloat(Form1.Edit_X2_3.Text);
      mas2[1, 2]:= -20;
      mas2[2, 2]:= (strtofloat(Form1.Edit_B3.Text)+strtofloat(Form1.Edit_X1_3.Text)*20) / strtofloat(Form1.Edit_X2_3.Text);

      x1:= mas2[1, 1];
      x2:= mas2[2,1];
      x11:= mas2[1, 2];
      x22:=mas2[2,2];
      Form1.PaintBox1.Canvas.Line(cx + round(x1*h*m), cy - round(x2*h*m), cx + round(x11*h*m), cy - round(x22*h*m));

      // находим уравнение прямой (y=kx+b) по двум точкам A(a1,a2), B(b1,b2)..............................///////////////////////////////////////////
      //присваиваем ранее найденные значения
      a1:=cx + round(x1*h*m);
      a2:=cy - round(x2*h*m);
      b1:=cx + round(x11*h*m);
      b2:=cy - round(x22*h*m);

      k:=(a2-b2)/(a1-b1);
      b:=b2-k*b1;

      //решаем в какую сторону будет штриховка, находим точки пересечения координатных прямых, пересекает положительный или отрицательный х,
      //x выражаем из уравнения прямой (y=kx+b)при y=0

      x:=(cy-b)/k;
      if x>cx then
      begin
         if Form1.ComboBox_3.ItemIndex = 0 then
             begin
             //подставляем 0 координаты вместо x1,x2
                if strtofloat(Edit_X1_3.Text)*0 + strtofloat(Edit_X2_3.Text)*0 >= strtofloat(Edit_B3.Text) then

                     for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b))
                else
                     for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b));
             end;

         if Form1.ComboBox_3.ItemIndex = 2 then
             begin
                if strtofloat(Edit_X1_3.Text)*0 + strtofloat(Edit_X2_3.Text)*0 <= strtofloat(Edit_B3.Text) then

                     for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b))
                else
                     for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b));
             end;
      end;


      if x<cx then  // в обычной системе координат
      begin
         if Form1.ComboBox_3.ItemIndex = 0 then
             begin
             //подставляем 0 вместо x1,x2
                if strtofloat(Edit_X1_3.Text)*0 + strtofloat(Edit_X2_3.Text)*0 >= strtofloat(Edit_B3.Text) then

                     for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b))
                else
                     for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b));
             end;
         if Form1.ComboBox_3.ItemIndex = 2 then
             begin
                if strtofloat(Edit_X1_3.Text)*0 + strtofloat(Edit_X2_3.Text)*0 <= strtofloat(Edit_B3.Text) then

                     for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b))
                else
                     for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b));
             end;
      end;

    end;

    if (Edit_X1_3.Text<>'0') and (Edit_X2_3.Text='0') then
    begin
      x1:= strtofloat(Form1.Edit_B3.Text) / strtofloat(Form1.Edit_X1_3.Text);
      Form1.PaintBox1.Canvas.Line(cx + round(x1*h*m), 1, cx + round(x1*h*m), maxy-1);

      x:=cx + round(x1*h*m);

        if x > cx then   // x>0
        begin
           if Form1.ComboBox_3.ItemIndex = 0 then //>=
               begin
               //подставляем 0 вместо x1
                  if strtofloat(Edit_X1_3.Text)*0 >= strtofloat(Edit_B3.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh);
               end;


           if Form1.ComboBox_3.ItemIndex = 2 then//<=
               begin
                  if strtofloat(Edit_X1_3.Text)*0*0 <= strtofloat(Edit_B3.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh);
               end;
        end;

        if x<cx then
        begin
           if Form1.ComboBox_3.ItemIndex = 0 then  //>=
               begin
               //подставляем 0 вместо x1
                  if strtofloat(Edit_X1_3.Text)*0 >= strtofloat(Edit_B3.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh);
               end;

           if Form1.ComboBox_3.ItemIndex = 2 then
               begin
                  if strtofloat(Edit_X1_3.Text)*0 <= strtofloat(Edit_B3.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh);
               end;
        end;

         if x=cx then
        begin
           if Form1.ComboBox_3.ItemIndex = 0 then  //>=
               begin
               //подставляем 0 вместо x1
                  if strtofloat(Edit_X1_3.Text)*1 >= strtofloat(Edit_B3.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh);
               end;

           if Form1.ComboBox_3.ItemIndex = 2 then
               begin
                  if strtofloat(Edit_X1_3.Text)*1 <= strtofloat(Edit_B3.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh);
               end;
        end;

    end;

    if (Edit_X1_3.Text='0') and (Edit_X2_3.Text<>'0') then
    begin

      x2:= strtofloat(Form1.Edit_B3.Text) / strtofloat(Form1.Edit_X2_3.Text);
      Form1.PaintBox1.Canvas.Line(1, cy - round(x2*h*m), maxx-1, cy - round(x2*h*m));

      y:= cy - round(x2*h*m);

         if y > cy then   // y<0 в обычной системе координат
        begin
           if Form1.ComboBox_3.ItemIndex = 0 then  //>=
               begin
               //подставляем 0 вместо x2
                  if strtofloat(Edit_X2_3.Text)*0 >= strtofloat(Edit_B3.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y-10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y+10));
               end;


           if Form1.ComboBox_3.ItemIndex = 2 then  //<=
               begin
                  if strtofloat(Edit_X2_3.Text)*0 <= strtofloat(Edit_B3.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y-10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y+10));
               end;
        end;

        if y < cy then
        begin
           if Form1.ComboBox_3.ItemIndex = 0 then   //>=
               begin
               //подставляем 0 вместо x2
                  if strtofloat(Edit_X2_3.Text)*0 >= strtofloat(Edit_B3.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y+10))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y-10), cx + ii*hh, round(y));
               end;

           if Form1.ComboBox_3.ItemIndex = 2 then  //<=
               begin
                  if strtofloat(Edit_X2_3.Text)*0 <= strtofloat(Edit_B3.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y+10))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y-10), cx + ii*hh, round(y));
               end;
        end;

         if y = cy then
        begin
           if Form1.ComboBox_3.ItemIndex = 0 then   //>=
               begin
               //подставляем 0 вместо x2
                  if strtofloat(Edit_X2_3.Text)*1 >= strtofloat(Edit_B3.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y-10))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y+10), cx + ii*hh, round(y));
               end;

           if Form1.ComboBox_3.ItemIndex = 1 then  //<=
               begin
                  if strtofloat(Edit_X2_3.Text)*0 <= strtofloat(Edit_B3.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y-10))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y+10), cx + ii*hh, round(y));
               end;
        end;

    end;

    if (Edit_B3.Text='0') and (Edit_X1_3.Text<>'0') and (Edit_X2_3.Text<>'0') then
    begin
      mas2[1, 1]:= 20;
      mas2[2, 1]:= -strtofloat(Form1.Edit_X1_3.Text)*20 / strtofloat(Form1.Edit_X2_3.Text);
      mas2[1, 2]:= -20;
      mas2[2, 2]:= strtofloat(Form1.Edit_X1_3.Text)*20 / strtofloat(Form1.Edit_X2_3.Text);

      x1:= mas2[1, 1];
      x2:= mas2[2,1];
      x11:= mas2[1, 2];
      x22:=mas2[2,2];
      Form1.PaintBox1.Canvas.Line(cx + round(x1*h*m), cy - round(x2*h*m), cx + round(x11*h*m), cy - round(x22*h*m));
       a1:=cx + round(x1*h*m);
        a2:=cy - round(x2*h*m);
        b1:=cx + round(x11*h*m);
        b2:=cy - round(x22*h*m);

        k:=(a2-b2)/(a1-b1);
        b:=b2-k*b1;

       x:=(cy-h*m-b)/k;

        if x>cx then
        begin
           if Form1.ComboBox_3.ItemIndex = 0 then //>=
               begin
               //подставляем 0,1 вместо x1,x2
                  if strtofloat(Edit_X1_3.Text)*0 + strtofloat(Edit_X2_3.Text)*1 >= strtofloat(Edit_B3.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b));
               end;

           if Form1.ComboBox_3.ItemIndex = 2 then //<=
               begin
                  if strtofloat(Edit_X1_3.Text)*0 + strtofloat(Edit_X2_3.Text)*1 <= strtofloat(Edit_B3.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b));
               end;
        end;

        if x<cx then
        begin
           if Form1.ComboBox_3.ItemIndex = 0 then  //>=
               begin
               //подставляем 0,1 вместо x1,x2
                  if strtofloat(Edit_X1_3.Text)*0 + strtofloat(Edit_X2_3.Text)*1 >= strtofloat(Edit_B3.Text) then
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b));
               end;
           if Form1.ComboBox_3.ItemIndex = 2 then   //<=
               begin
                  if strtofloat(Edit_X1_3.Text)*0 + strtofloat(Edit_X2_3.Text)*1 <= strtofloat(Edit_B3.Text) then
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b));
               end;
        end;
     end;

   end;

procedure TForm1.str_4;
var
  x1, x2, x11, x22: real;
  ii: integer;
  a1,a2,b1,b2: real;
  k,x,y,b: real;
  begin
    Form1.PaintBox1.Canvas.Pen.Width:=2;
    Form1.PaintBox1.Canvas.Pen.Style:=psSolid; //сплошная линия
    Form1.PaintBox1.Canvas.Pen.Color:=clFuchsia;

      if (Edit_X1_4.Text<>'0') and (Edit_X2_4.Text<>'0') and (Edit_B4.Text<>'0') then
      begin
        mas1[1, 1]:= 20;
        mas1[2, 1]:= (strtofloat(Form1.Edit_B4.Text)-strtofloat(Form1.Edit_X1_4.Text)*20) / strtofloat(Form1.Edit_X2_4.Text);
        mas1[1, 2]:= -20;
        mas1[2, 2]:= (strtofloat(Form1.Edit_B4.Text)+strtofloat(Form1.Edit_X1_4.Text)*20) / strtofloat(Form1.Edit_X2_4.Text);

        x1:= mas1[1, 1];
        x2:= mas1[2,1];
        x11:= mas1[1, 2];
        x22:=mas1[2,2];
        Form1.PaintBox1.Canvas.Line(cx + round(x1*h), cy - round(x2*h), cx + round(x11*h), cy - round(x22*h));

        // находим уравнение прямой (y=kx+b) по двум точкам A(a1,a2), B(b1,b2)
        //присваиваем ранее найденные значения
        a1:=cx + round(x1*h*m);
        a2:=cy - round(x2*h*m);
        b1:=cx + round(x11*h*m);
        b2:=cy - round(x22*h*m);

        k:=(a2-b2)/(a1-b1);
        b:=b2-k*b1;
        //решаем в какую сторону будет штриховка, находим точку пересечения координатных прямых(пересекает положительный или отрицательный х),
        //x выражаем из уравнения прямой (y=kx+b)при y=0 (475)

        x:=(cy-b)/k;
        if x>cx then
        begin
           if Form1.ComboBox_4.ItemIndex = 0 then //>=
               begin
               //подставляем 0 вместо x1,x2
                  if strtofloat(Edit_X1_4.Text)*0 + strtofloat(Edit_X2_4.Text)*0 >= strtofloat(Edit_B4.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b));
               end;

           if Form1.ComboBox_4.ItemIndex = 2 then //<=
               begin
                  if strtofloat(Edit_X1_4.Text)*0 + strtofloat(Edit_X2_4.Text)*0 <= strtofloat(Edit_B4.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b));
               end;
        end;

        if x<cx then
        begin
           if Form1.ComboBox_4.ItemIndex = 0 then  //>=
               begin
               //подставляем 0 вместо x1,x2
                  if strtofloat(Edit_X1_4.Text)*0 + strtofloat(Edit_X2_4.Text)*0 >= strtofloat(Edit_B4.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b));
               end;

           if Form1.ComboBox_4.ItemIndex = 2 then   //<=
               begin
                  if strtofloat(Edit_X1_4.Text)*0 + strtofloat(Edit_X2_4.Text)*0 <= strtofloat(Edit_B4.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b));
               end;
        end;

        end;

      if (Edit_X1_4.Text<>'0') and (Edit_X2_4.Text='0') then     //прямоя вдоль Оy
      begin
        x1:= strtofloat(Form1.Edit_B4.Text) / strtofloat(Form1.Edit_X1_4.Text);
        Form1.PaintBox1.Canvas.Line(cx + round(x1*h*m), 1, cx + round(x1*h*m), maxy-1);

        x:=cx + round(x1*h*m);

        if x > cx then   // x>0
        begin
           if Form1.ComboBox_4.ItemIndex = 0 then //>=
               begin
               //подставляем 0 вместо x1
                  if strtofloat(Edit_X1_4.Text)*0 >= strtofloat(Edit_B4.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh);
               end;

           if Form1.ComboBox_4.ItemIndex = 2 then//<=
               begin
                  if strtofloat(Edit_X1_4.Text)*0 <= strtofloat(Edit_B4.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh);
               end;
        end;

        if x<cx then
        begin
           if Form1.ComboBox_4.ItemIndex = 0 then  //>=
               begin
               //подставляем 0 вместо x1
                  if strtofloat(Edit_X1_4.Text)*0 >= strtofloat(Edit_B4.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh);
               end;

           if Form1.ComboBox_4.ItemIndex = 2 then
               begin
                  if strtofloat(Edit_X1_4.Text)*0 <= strtofloat(Edit_B4.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh);
               end;
        end;

         if x=cx then
        begin
           if Form1.ComboBox_4.ItemIndex = 0 then  //>=
               begin
               //подставляем 0 вместо x1
                  if strtofloat(Edit_X1_4.Text)*1 >= strtofloat(Edit_B4.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh);
               end;

           if Form1.ComboBox_4.ItemIndex = 2 then
               begin
                  if strtofloat(Edit_X1_4.Text)*1 <= strtofloat(Edit_B4.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh);
               end;
        end;

      end;

      if (Edit_X1_4.Text='0') and (Edit_X2_4.Text<>'0') then     //прямоя вдоль Оx
      begin
        x2:= strtofloat(Form1.Edit_B4.Text) / strtofloat(Form1.Edit_X2_4.Text);
        Form1.PaintBox1.Canvas.Line(1, cy - round(x2*h*m), maxx-1, cy - round(x2*h*m));

        y:= cy - round(x2*h*m);

         if y > cy then   // y<0 в обычной системе координат
        begin
           if Form1.ComboBox_4.ItemIndex = 0 then  //>=
               begin
               //подставляем 0 вместо x2
                  if strtofloat(Edit_X2_4.Text)*0 >= strtofloat(Edit_B4.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y-10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y+10));
               end;


           if Form1.ComboBox_4.ItemIndex = 2 then  //<=
               begin
                  if strtofloat(Edit_X2_4.Text)*0 <= strtofloat(Edit_B4.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y-10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y+10));
               end;
        end;

        if y < cy then
        begin
           if Form1.ComboBox_4.ItemIndex = 0 then   //>=
               begin
               //подставляем 0 вместо x2
                  if strtofloat(Edit_X2_4.Text)*0 >= strtofloat(Edit_B4.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y+10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y-10));
               end;

           if Form1.ComboBox_4.ItemIndex = 2 then  //<=
               begin
                  if strtofloat(Edit_X2_4.Text)*0 <= strtofloat(Edit_B4.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y+10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y-10));
               end;
        end;

        if y = cy then
        begin
           if Form1.ComboBox_4.ItemIndex = 0 then   //>=
               begin
               //подставляем 0 вместо x2
                  if strtofloat(Edit_X2_4.Text)*1 >= strtofloat(Edit_B4.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y-10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y+10));
               end;

           if Form1.ComboBox_4.ItemIndex = 2 then  //<=
               begin
                  if strtofloat(Edit_X2_4.Text)*1 <= strtofloat(Edit_B4.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y-10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y+10));
               end;
        end;

      end;

      if (Edit_B1.Text='0') and (Edit_X1_4.Text<>'0') and (Edit_X2_4.Text<>'0') then
      begin
        mas1[1, 1]:= 20;
        mas1[2, 1]:= -strtofloat(Form1.Edit_X1_4.Text)*20 / strtofloat(Form1.Edit_X2_4.Text);
        mas1[1, 2]:= -20;
        mas1[2, 2]:= strtofloat(Form1.Edit_X1_4.Text)*20 / strtofloat(Form1.Edit_X2_4.Text);

        x1:= mas1[1, 1];
        x2:= mas1[2,1];
        x11:= mas1[1, 2];
        x22:=mas1[2,2];
        Form1.PaintBox1.Canvas.Line(cx + round(x1*h*m), cy - round(x2*h*m), cx + round(x11*h*m), cy - round(x22*h*m));

        a1:=cx + round(x1*h*m);
        a2:=cy - round(x2*h*m);
        b1:=cx + round(x11*h*m);
        b2:=cy - round(x22*h*m);

        k:=(a2-b2)/(a1-b1);
        b:=b2-k*b1;

        x:=(cy-h*m-b)/k;

        if x>cx then
        begin
           if Form1.ComboBox_4.ItemIndex = 0 then //>=
               begin
               //подставляем 0,1 вместо x1,x2
                  if strtofloat(Edit_X1_4.Text)*0 + strtofloat(Edit_X2_4.Text)*1 >= strtofloat(Edit_B4.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b));
               end;

           if Form1.ComboBox_4.ItemIndex = 2 then //<=
               begin
                  if strtofloat(Edit_X1_4.Text)*0 + strtofloat(Edit_X2_4.Text)*1 <= strtofloat(Edit_B4.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b));
               end;
        end;

        if x<cx then
        begin
           if Form1.ComboBox_4.ItemIndex = 0 then  //>=
               begin
               //подставляем 0,1 вместо x1,x2
                  if strtofloat(Edit_X1_4.Text)*0 + strtofloat(Edit_X2_4.Text)*1 >= strtofloat(Edit_B4.Text) then
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b));
               end;
           if Form1.ComboBox_4.ItemIndex = 2 then   //<=
               begin
                  if strtofloat(Edit_X1_4.Text)*0 + strtofloat(Edit_X2_4.Text)*1 <= strtofloat(Edit_B4.Text) then
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b));
               end;
        end;

      end;

  end;

procedure TForm1.str_5;
var
  x1, x2, x11, x22: real;
  ii: integer;
  a1,a2,b1,b2: real;
  k,x,y,b: real;
  begin
    Form1.PaintBox1.Canvas.Pen.Width:=2;
    Form1.PaintBox1.Canvas.Pen.Style:=psSolid; //сплошная линия
    Form1.PaintBox1.Canvas.Pen.Color:=clBlue;

      if (Edit_X1_5.Text<>'0') and (Edit_X2_5.Text<>'0') and (Edit_B5.Text<>'0') then
      begin
        mas1[1, 1]:= 20;
        mas1[2, 1]:= (strtofloat(Form1.Edit_B5.Text)-strtofloat(Form1.Edit_X1_5.Text)*20) / strtofloat(Form1.Edit_X2_5.Text);
        mas1[1, 2]:= -20;
        mas1[2, 2]:= (strtofloat(Form1.Edit_B5.Text)+strtofloat(Form1.Edit_X1_5.Text)*20) / strtofloat(Form1.Edit_X2_5.Text);

        x1:= mas1[1, 1];
        x2:= mas1[2,1];
        x11:= mas1[1, 2];
        x22:=mas1[2,2];
        Form1.PaintBox1.Canvas.Line(cx + round(x1*h*m), cy - round(x2*h*m), cx + round(x11*h*m), cy - round(x22*h*m));

        // находим уравнение прямой (y=kx+b) по двум точкам A(a1,a2), B(b1,b2)
        //присваиваем ранее найденные значения
        a1:=cx + round(x1*h*m);
        a2:=cy - round(x2*h*m);
        b1:=cx + round(x11*h*m);
        b2:=cy - round(x22*h*m);

        k:=(a2-b2)/(a1-b1);
        b:=b2-k*b1;
        //решаем в какую сторону будет штриховка, находим точку пересечения координатных прямых(пересекает положительный или отрицательный х),
        //x выражаем из уравнения прямой (y=kx+b)при y=0 (475)

        x:=(cy-b)/k;
        if x>cx then
        begin
           if Form1.ComboBox_5.ItemIndex = 0 then //>=
               begin
               //подставляем 0 вместо x1,x2
                  if strtofloat(Edit_X1_5.Text)*0 + strtofloat(Edit_X2_5.Text)*0 >= strtofloat(Edit_B5.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b));
               end;

           if Form1.ComboBox_5.ItemIndex = 2 then //<=
               begin
                  if strtofloat(Edit_X1_5.Text)*0 + strtofloat(Edit_X2_5.Text)*0 <= strtofloat(Edit_B5.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b));
               end;
        end;

        if x<cx then
        begin
           if Form1.ComboBox_5.ItemIndex = 0 then  //>=
               begin
               //подставляем 0 вместо x1,x2
                  if strtofloat(Edit_X1_5.Text)*0 + strtofloat(Edit_X2_5.Text)*0 >= strtofloat(Edit_B5.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b));
               end;

           if Form1.ComboBox_5.ItemIndex = 2 then   //<=
               begin
                  if strtofloat(Edit_X1_5.Text)*0 + strtofloat(Edit_X2_5.Text)*0 <= strtofloat(Edit_B5.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b));
               end;
        end;

        end;

      if (Edit_X1_5.Text<>'0') and (Edit_X2_5.Text='0') then     //прямоя вдоль Оy
      begin
        x1:= strtofloat(Form1.Edit_B5.Text) / strtofloat(Form1.Edit_X1_5.Text);
        Form1.PaintBox1.Canvas.Line(cx + round(x1*h*m), 1, cx + round(x1*h*m), maxy-1);

        x:=cx + round(x1*h*m);

        if x > cx then   // x>0
        begin
           if Form1.ComboBox_5.ItemIndex = 0 then //>=
               begin
               //подставляем 0 вместо x1
                  if strtofloat(Edit_X1_5.Text)*0 >= strtofloat(Edit_B5.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh);
               end;

           if Form1.ComboBox_5.ItemIndex = 2 then//<=
               begin
                  if strtofloat(Edit_X1_5.Text)*0 <= strtofloat(Edit_B5.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh);
               end;
        end;

        if x<cx then
        begin
           if Form1.ComboBox_5.ItemIndex = 0 then  //>=
               begin
               //подставляем 0 вместо x1
                  if strtofloat(Edit_X1_5.Text)*0 >= strtofloat(Edit_B5.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh);
               end;

           if Form1.ComboBox_5.ItemIndex = 2 then
               begin
                  if strtofloat(Edit_X1_5.Text)*0 <= strtofloat(Edit_B5.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh);
               end;
        end;

         if x=cx then
        begin
           if Form1.ComboBox_5.ItemIndex = 0 then  //>=
               begin
               //подставляем 0 вместо x1
                  if strtofloat(Edit_X1_5.Text)*1 >= strtofloat(Edit_B5.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh);
               end;

           if Form1.ComboBox_5.ItemIndex = 2 then
               begin
                  if strtofloat(Edit_X1_5.Text)*1 <= strtofloat(Edit_B5.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x), cy + ii*hh, round(x+10), cy + ii*hh)
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(round(x-10), cy + ii*hh, round(x), cy + ii*hh);
               end;
        end;

      end;

      if (Edit_X1_5.Text='0') and (Edit_X2_5.Text<>'0') then     //прямоя вдоль Оx
      begin
        x2:= strtofloat(Form1.Edit_B5.Text) / strtofloat(Form1.Edit_X2_5.Text);
        Form1.PaintBox1.Canvas.Line(1, cy - round(x2*h*m), maxx-1, cy - round(x2*h*m));

        y:= cy - round(x2*h*m);

         if y > cy then   // y<0 в обычной системе координат
        begin
           if Form1.ComboBox_5.ItemIndex = 0 then  //>=
               begin
               //подставляем 0 вместо x2
                  if strtofloat(Edit_X2_5.Text)*0 >= strtofloat(Edit_B5.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y-10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y+10));
               end;


           if Form1.ComboBox_5.ItemIndex = 2 then  //<=
               begin
                  if strtofloat(Edit_X2_5.Text)*0 <= strtofloat(Edit_B5.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y-10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y+10));
               end;
        end;

        if y < cy then
        begin
           if Form1.ComboBox_5.ItemIndex = 0 then   //>=
               begin
               //подставляем 0 вместо x2
                  if strtofloat(Edit_X2_5.Text)*0 >= strtofloat(Edit_B5.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y+10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y-10));
               end;

           if Form1.ComboBox_5.ItemIndex = 2 then  //<=
               begin
                  if strtofloat(Edit_X2_5.Text)*0 <= strtofloat(Edit_B5.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y+10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y-10));
               end;
        end;

        if y = cy then
        begin
           if Form1.ComboBox_5.ItemIndex = 0 then   //>=
               begin
               //подставляем 0 вместо x2
                  if strtofloat(Edit_X2_5.Text)*1 >= strtofloat(Edit_B5.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y-10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y+10));
               end;

           if Form1.ComboBox_5.ItemIndex = 2 then  //<=
               begin
                  if strtofloat(Edit_X2_5.Text)*1 <= strtofloat(Edit_B5.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y-10), cx + ii*hh, round(y))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*hh, round(y), cx + ii*hh, round(y+10));
               end;
        end;

      end;

      if (Edit_B5.Text='0') and (Edit_X1_5.Text<>'0') and (Edit_X2_5.Text<>'0') then
      begin
        mas1[1, 1]:= 20;
        mas1[2, 1]:= -strtofloat(Form1.Edit_X1_5.Text)*20 / strtofloat(Form1.Edit_X2_5.Text);
        mas1[1, 2]:= -20;
        mas1[2, 2]:= strtofloat(Form1.Edit_X1_5.Text)*20 / strtofloat(Form1.Edit_X2_5.Text);

        x1:= mas1[1, 1];
        x2:= mas1[2,1];
        x11:= mas1[1, 2];
        x22:=mas1[2,2];
        Form1.PaintBox1.Canvas.Line(cx + round(x1*h*m), cy - round(x2*h*m), cx + round(x11*h*m), cy - round(x22*h*m));

        a1:=cx + round(x1*h*m);
        a2:=cy - round(x2*h*m);
        b1:=cx + round(x11*h*m);
        b2:=cy - round(x22*h*m);

        k:=(a2-b2)/(a1-b1);
        b:=b2-k*b1;

        x:=(cy-h*m-b)/k;

        if x>cx then
        begin
           if Form1.ComboBox_5.ItemIndex = 0 then //>=
               begin
               //подставляем 0,1 вместо x1,x2
                  if strtofloat(Edit_X1_5.Text)*0 + strtofloat(Edit_X2_5.Text)*1 >= strtofloat(Edit_B5.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b));
               end;

           if Form1.ComboBox_5.ItemIndex = 2 then //<=
               begin
                  if strtofloat(Edit_X1_5.Text)*0 + strtofloat(Edit_X2_5.Text)*1 <= strtofloat(Edit_B5.Text) then

                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b));
               end;
        end;

        if x<cx then
        begin
           if Form1.ComboBox_5.ItemIndex = 0 then  //>=
               begin
               //подставляем 0,1 вместо x1,x2
                  if strtofloat(Edit_X1_5.Text)*0 + strtofloat(Edit_X2_5.Text)*1 >= strtofloat(Edit_B5.Text) then
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b));
               end;
           if Form1.ComboBox_5.ItemIndex = 2 then   //<=
               begin
                  if strtofloat(Edit_X1_5.Text)*0 + strtofloat(Edit_X2_5.Text)*1 <= strtofloat(Edit_B5.Text) then
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n, round(k*(cx + ii*n)+b), cx + ii*n+10, round(k*(cx + ii*n)+b))
                  else
                       for ii := -100 to 100 do Form1.PaintBox1.Canvas.Line(cx + ii*n-10, round(k*(cx + ii*n)+b), cx + ii*n, round(k*(cx + ii*n)+b));
               end;
        end;

      end;

  end;


//вектор-градиент и линия уровня
procedure TForm1.Grad;
var
x1, x2, x11, x22: real;
g1, g2, cx1, cy1: real;
xt, yt: integer;
begin
  //вектор-градиент
  g1:=strtoint(Form1.Edit_X1.Text);
  g2:=strtoint(Form1.Edit_X2.Text);

  //Продолжение вектора
  Form1.PaintBox1.Canvas.Pen.Color:=clSilver;
  Form1.PaintBox1.Canvas.Pen.Style:=psDash;
  Form1.PaintBox1.Canvas.Pen.Width:=2;
  Form1.PaintBox1.Canvas.Line(cx,cy,cx+round(g1*h*m)*10,cy-round(g2*h*m)*10);
  Form1.PaintBox1.Canvas.Line(cx,cy,cx-round(g1*h*m)*10,cy+round(g2*h*m)*10);

  //Вектор
  Form1.PaintBox1.Canvas.Pen.Color:= clRed;
  Form1.PaintBox1.Canvas.Pen.Style:=psSolid;
  Form1.PaintBox1.Canvas.Pen.Width:=2;
  Form1.PaintBox1.Canvas.Line(cx,cy,cx+round(g1*h*m),cy-round(g2*h*m));


  //Линия уровня(перпендикуляр  к вектору)
  if (Edit_X1.Text<>'0') and (Edit_X2.Text<>'0') then
    begin
      mas1[1, 1]:= 20;
      mas1[2, 1]:= (0-strtofloat(Form1.Edit_X1.Text)*20) / strtofloat(Form1.Edit_X2.Text);
      mas1[1, 2]:= -20;
      mas1[2, 2]:= (0+strtofloat(Form1.Edit_X1.Text)*20) / strtofloat(Form1.Edit_X2.Text);

      Form1.PaintBox1.Canvas.Pen.Width:=2;
      Form1.PaintBox1.Canvas.Pen.Style:=psSolid;
      Form1.PaintBox1.Canvas.Pen.Color:=clGray;

      x1:= mas1[1, 1];
      x2:= mas1[2,1];
      x11:= mas1[1, 2];
      x22:=mas1[2,2];
      Form1.PaintBox1.Canvas.Line(cx + round(x1*h*m), cy - round(x2*h*m), cx + round(x11*h*m), cy - round(x22*h*m));

  //Параллель к линии уровня через точку ответа
   (* cx1:= strtofloat(Form1.Edit_X1_otvet.Text);
    cy1:= strtofloat(Form1.Edit_X2_otvet.Text);
    Form1.PaintBox1.Canvas.Line(cx + round((x1+cx1)*h*m), cy - round((x2+cy1)*h*m), cx + round((x11+cx1)*h*m), cy - round((x22+cy1)*h*m)); *)


  //Линии к точке
      Form1.PaintBox1.Canvas.Pen.Width:=2;
      Form1.PaintBox1.Canvas.Pen.Style:=psDash;
      Form1.PaintBox1.Canvas.Pen.Color:=clOlive;
      cx1:= strtofloat(Form1.Edit_X1_otvet.Text);
      cy1:= strtofloat(Form1.Edit_X2_otvet.Text);
      Form1.PaintBox1.Canvas.Line(cx + round(cx1*h*m), cy, cx+round(cx1*h*m), cy - round(cy1*h*m));
      Form1.PaintBox1.Canvas.Line(cx, cy - round(cy1*h*m),cx+round(cx1*h*m), cy - round(cy1*h*m));
      //выделение точки
      xt:=cx + round(cx1*h*m);
      yt:=cy - round(cy1*h*m);

         Form1.PaintBox1.Canvas.Pen.Width:=2;
         Form1.PaintBox1.Canvas.Pen.Style:=psSolid;
         Form1.PaintBox1.Canvas.Pen.Color:=clRed;
         Form1.PaintBox1.Canvas.Ellipse(xt-5, yt-5, xt+5,yt+5);
         Form1.PaintBox1.Canvas.Pixels[xt, yt] := ClRed;
         Form1.PaintBox1.Canvas.Pixels[xt-1, yt] := ClRed;
         Form1.PaintBox1.Canvas.Pixels[xt+1, yt] := ClRed;
         Form1.PaintBox1.Canvas.Pixels[xt, yt-1] := ClRed;
         Form1.PaintBox1.Canvas.Pixels[xt, yt+1] := ClRed;

   end;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  cx:=700;
  cy:=475;
 // m:=1;
  OSI;
  shtrixOSI; // штриховка области по осям
   //запуск процедур в зависимости от колличества строк
  if Form1.ComboBox_col_str.ItemIndex = 0 then   str_1;
  if Form1.ComboBox_col_str.ItemIndex = 1 then
    begin
    str_1; str_2;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 2 then
    begin
    str_1; str_2; str_3;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 3 then
    begin
    str_1; str_2; str_3; str_4;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 4 then
    begin
    str_1; str_2; str_3; str_4; str_5;
    end;
  Grad;//вектор-градиент, линия уровня и параллель к линии уровня

end;

procedure TForm1.Button_minusClick(Sender: TObject);

begin
  if m<>1 then m:=m-1;
  OSI;
  shtrixOSI; // штриховка области по осям
   //запуск процедур в зависимости от колличества строк
  if Form1.ComboBox_col_str.ItemIndex = 0 then   str_1;
  if Form1.ComboBox_col_str.ItemIndex = 1 then
    begin
    str_1; str_2;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 2 then
    begin
    str_1; str_2; str_3;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 3 then
    begin
    str_1; str_2; str_3; str_4;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 4 then
    begin
    str_1; str_2; str_3; str_4; str_5;
    end;
  Grad;//вектор-градиент, линия уровня и параллель к линии уровня

end;

procedure TForm1.Button_plusClick(Sender: TObject);

begin
  if m<>3 then m:=m+1;
  OSI;
  shtrixOSI; // штриховка области по осям
   //запуск процедур в зависимости от колличества строк
  if Form1.ComboBox_col_str.ItemIndex = 0 then   str_1;
  if Form1.ComboBox_col_str.ItemIndex = 1 then
    begin
    str_1; str_2;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 2 then
    begin
    str_1; str_2; str_3;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 3 then
    begin
    str_1; str_2; str_3; str_4;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 4 then
    begin
    str_1; str_2; str_3; str_4; str_5;
    end;
  Grad;//вектор-градиент, линия уровня и параллель к линии уровня

end;

procedure TForm1.Button_vverhClick(Sender: TObject);
begin
  cy:= cy-150;
  OSI;
  shtrixOSI; // штриховка области по осям
   //запуск процедур в зависимости от колличества строк
  if Form1.ComboBox_col_str.ItemIndex = 0 then   str_1;
  if Form1.ComboBox_col_str.ItemIndex = 1 then
    begin
    str_1; str_2;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 2 then
    begin
    str_1; str_2; str_3;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 3 then
    begin
    str_1; str_2; str_3; str_4;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 4 then
    begin
    str_1; str_2; str_3; str_4; str_5;
    end;
  Grad;//вектор-градиент, линия уровня и параллель к линии уровня
end;

procedure TForm1.Button_vnizClick(Sender: TObject);
begin
  cy:= cy+150;
  OSI;
  shtrixOSI; // штриховка области по осям
   //запуск процедур в зависимости от колличества строк
  if Form1.ComboBox_col_str.ItemIndex = 0 then   str_1;
  if Form1.ComboBox_col_str.ItemIndex = 1 then
    begin
    str_1; str_2;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 2 then
    begin
    str_1; str_2; str_3;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 3 then
    begin
    str_1; str_2; str_3; str_4;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 4 then
    begin
    str_1; str_2; str_3; str_4; str_5;
    end;
  Grad;//вектор-градиент, линия уровня и параллель к линии уровня
end;

procedure TForm1.Button_vlevoClick(Sender: TObject);
begin
  cx:= cx-150;
  OSI;
  shtrixOSI; // штриховка области по осям
   //запуск процедур в зависимости от колличества строк
  if Form1.ComboBox_col_str.ItemIndex = 0 then   str_1;
  if Form1.ComboBox_col_str.ItemIndex = 1 then
    begin
    str_1; str_2;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 2 then
    begin
    str_1; str_2; str_3;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 3 then
    begin
    str_1; str_2; str_3; str_4;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 4 then
    begin
    str_1; str_2; str_3; str_4; str_5;
    end;
  Grad;//вектор-градиент, линия уровня и параллель к линии уровня
end;

procedure TForm1.Button_vpravoClick(Sender: TObject);
begin
  cx:= cx+150;
  OSI;
  shtrixOSI; // штриховка области по осям
   //запуск процедур в зависимости от колличества строк
  if Form1.ComboBox_col_str.ItemIndex = 0 then   str_1;
  if Form1.ComboBox_col_str.ItemIndex = 1 then
    begin
    str_1; str_2;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 2 then
    begin
    str_1; str_2; str_3;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 3 then
    begin
    str_1; str_2; str_3; str_4;
    end;
  if Form1.ComboBox_col_str.ItemIndex = 4 then
    begin
    str_1; str_2; str_3; str_4; str_5;
    end;
  Grad;//вектор-градиент, линия уровня и параллель к линии уровня
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if Key = VK_UP then
      begin
        if cy > 175 then cy:= cy-150;
            OSI;
            shtrixOSI; // штриховка области по осям
            //запуск процедур в зависимости от колличества строк
             if Form1.ComboBox_col_str.ItemIndex = 0 then   str_1;
             if Form1.ComboBox_col_str.ItemIndex = 1 then
                 begin
                   str_1; str_2;
                 end;
              if Form1.ComboBox_col_str.ItemIndex = 2 then
                 begin
                   str_1; str_2; str_3;
                end;
              if Form1.ComboBox_col_str.ItemIndex = 3 then
                begin
                     str_1; str_2; str_3; str_4;
                end;
              if Form1.ComboBox_col_str.ItemIndex = 4 then
                begin
                     str_1; str_2; str_3; str_4; str_5;
                end;
              Grad;//вектор-градиент, линия уровня и параллель к линии уровня
      end;
    if Key = VK_DOWN then
      begin
        if cy < 775 then cy:= cy+150;
            OSI;
            shtrixOSI; // штриховка области по осям
            //запуск процедур в зависимости от колличества строк
             if Form1.ComboBox_col_str.ItemIndex = 0 then   str_1;
             if Form1.ComboBox_col_str.ItemIndex = 1 then
                 begin
                   str_1; str_2;
                 end;
              if Form1.ComboBox_col_str.ItemIndex = 2 then
                 begin
                   str_1; str_2; str_3;
                end;
              if Form1.ComboBox_col_str.ItemIndex = 3 then
                begin
                     str_1; str_2; str_3; str_4;
                end;
              if Form1.ComboBox_col_str.ItemIndex = 4 then
                begin
                     str_1; str_2; str_3; str_4; str_5;
                end;
              Grad;//вектор-градиент, линия уровня и параллель к линии уровня
      end;
    if Key = VK_LEFT then
       begin
        if cx > 400 then cx:= cx-150;
            OSI;
            shtrixOSI; // штриховка области по осям
            //запуск процедур в зависимости от колличества строк
             if Form1.ComboBox_col_str.ItemIndex = 0 then   str_1;
             if Form1.ComboBox_col_str.ItemIndex = 1 then
                 begin
                   str_1; str_2;
                 end;
              if Form1.ComboBox_col_str.ItemIndex = 2 then
                 begin
                   str_1; str_2; str_3;
                end;
              if Form1.ComboBox_col_str.ItemIndex = 3 then
                begin
                     str_1; str_2; str_3; str_4;
                end;
              if Form1.ComboBox_col_str.ItemIndex = 4 then
                begin
                     str_1; str_2; str_3; str_4; str_5;
                end;
              Grad;//вектор-градиент, линия уровня и параллель к линии уровня
      end;
    if Key = VK_RIGHT then
      begin
       if cx < 1000 then cx:= cx+150;
            OSI;
            shtrixOSI; // штриховка области по осям
            //запуск процедур в зависимости от колличества строк
             if Form1.ComboBox_col_str.ItemIndex = 0 then   str_1;
             if Form1.ComboBox_col_str.ItemIndex = 1 then
                 begin
                   str_1; str_2;
                 end;
              if Form1.ComboBox_col_str.ItemIndex = 2 then
                 begin
                   str_1; str_2; str_3;
                end;
              if Form1.ComboBox_col_str.ItemIndex = 3 then
                begin
                     str_1; str_2; str_3; str_4;
                end;
              if Form1.ComboBox_col_str.ItemIndex = 4 then
                begin
                     str_1; str_2; str_3; str_4; str_5;
                end;
              Grad;//вектор-градиент, линия уровня и параллель к линии уровня
      end;

    if Key = VK_ADD then // +
      begin
        if m<>3 then m:=m+1;
            OSI;
            shtrixOSI; // штриховка области по осям
            //запуск процедур в зависимости от колличества строк
             if Form1.ComboBox_col_str.ItemIndex = 0 then   str_1;
             if Form1.ComboBox_col_str.ItemIndex = 1 then
                 begin
                   str_1; str_2;
                 end;
              if Form1.ComboBox_col_str.ItemIndex = 2 then
                 begin
                   str_1; str_2; str_3;
                end;
              if Form1.ComboBox_col_str.ItemIndex = 3 then
                begin
                     str_1; str_2; str_3; str_4;
                end;
              if Form1.ComboBox_col_str.ItemIndex = 4 then
                begin
                     str_1; str_2; str_3; str_4; str_5;
                end;
              Grad;//вектор-градиент, линия уровня и параллель к линии уровня
      end;

    if Key = VK_SUBTRACT then  // -
      begin
        if m<>1 then m:=m-1;
            OSI;
            shtrixOSI; // штриховка области по осям
            //запуск процедур в зависимости от колличества строк
             if Form1.ComboBox_col_str.ItemIndex = 0 then   str_1;
             if Form1.ComboBox_col_str.ItemIndex = 1 then
                 begin
                   str_1; str_2;
                 end;
              if Form1.ComboBox_col_str.ItemIndex = 2 then
                 begin
                   str_1; str_2; str_3;
                end;
              if Form1.ComboBox_col_str.ItemIndex = 3 then
                begin
                     str_1; str_2; str_3; str_4;
                end;
              if Form1.ComboBox_col_str.ItemIndex = 4 then
                begin
                     str_1; str_2; str_3; str_4; str_5;
                end;
              Grad;//вектор-градиент, линия уровня и параллель к линии уровня
      end;



end;

end.

