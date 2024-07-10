unit un;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Check: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Start: TButton;
    Last: TButton;
    SortButton: TButton;
    OpenDialog1: TOpenDialog;
    procedure CheckClick(Sender: TObject);
    procedure LastClick(Sender: TObject);
    procedure SortButtonClick(Sender: TObject);
    procedure StartClick(Sender: TObject);
  private

  public
  PathStart: string;
  PathLast: string;

  end;

  TDoc = record
    Name: string[100];
    day, month, year: integer;
    money: integer;
  end;

  mas = array [1..5] of TDoc;

var
  FileStart, FileLast: File of TDoc;
  fil: array [1..62] of file of TDoc;
  zap, b: mas;
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure Sliv(a,b: integer);
var
  i, j: integer;
  t1, t2, tmp: TDoc;
begin

 for i:= a to b do begin
    AssignFile(fil[i], 'C:\Users\Кирилл\Desktop\ЛЕКЦИИ\LP\Программирование\Семестр 2\LAB 9\Files\f'+inttostr(i)+'.txt');
    rewrite(fil[i]);
  end;

 i:=1;
 j:=1;
  while i < 32 do begin

    read(fil[i], t1);
    read(fil[i+1], t2);

    While (not EOF(fil[i])) and (not EOF(fil[i+1])) do
      begin
        if t1.year < t2.year then
        begin
         write(fil[a-1+j], t1);
         read(fil[i], t1);
        end
        else
        if t1.year > t2.year then
        begin
         write(fil[a-1+j], t2);
         read(fil[i+1], t2);
        end
        else
        if t1.year = t2.year then
        begin
          if t1.month < t2.month then
          begin
           write(fil[a-1+j], t1);
           read(fil[i], t1);
          end
          else
          if t1.month > t2.month then
          begin
            write(fil[a-1+j], t2);
            read(fil[i+1], t2);
          end
          else
          if t1.month = t2.month then
          begin
          if t1.day < t2.day then
          begin
            write(fil[a-1+j], t1);
            read(fil[i], t1);
          end
          else
          if t1.day > t2.day then
          begin
            write(fil[a-1+j], t2);
            read(fil[i+1], t2);
          end
          else
          if t1.day = t2.day then
          begin
          if t1.money < t2.money then
          begin
            write(fil[a-1+j], t1);
            read(fil[i], t1);
          end
          else
          if t1.money > t2.money then
          begin
            write(fil[a-1+j], t2);
            read(fil[i+1], t2);
          end
          else
          if t1.money = t2.money then
          begin
            write(fil[a-1+j], t1);
            read(fil[i], t1);
            write(fil[a-1+j], t2);
            read(fil[i+1], t2);
          end;
          end;
          end;
        end;
      end;
    while not EOF(fil[i]) do
      begin
        write(fil[a-1+j], t1);
        read(fil[i], t1);
      end;
    while not EOF(fil[i+1]) do
      begin
        write(fil[a-1+j], t2);
        read(fil[i+1], t2);
      end;
    i:= i + 2;
    Inc(j);
  end;


end;

{procedure Sliv;
var
  i, j: integer;
  t1, t2: TDoc;
begin

 for i:= 21 to 30 do begin
    AssignFile(fil[i], 'C:\Users\Кирилл\Desktop\ЛЕКЦИИ\LP\Программирование\Семестр 2\LAB 9\Files\f'+inttostr(i)+'.txt');
    rewrite(fil[i]);
  end;

 i:=1;
 j:=1;
  while i < 20 do begin

    if not EOF(fil[i]) then
    read(fil[i], t1);
    if not EOF(fil[i+1]) then
    read(fil[i+1], t2);

    While (not EOF(fil[i])) and (not EOF(fil[i+1])) do
      begin
        if t1.year < t2.year then
        begin
          write(fil[20+j], t1);
          read(fil[i], t1);
        end
        else
        if t1.year > t2.year then
        begin
          write(fil[20+j], t2);
          read(fil[i+1], t2);
        end
        else
        if t1.year = t2.year then
        begin
          if t1.month < t2.month then
          begin
            write(fil[20+j], t1);
            read(fil[i], t1);
          end
          else
          if t1.month > t2.month then
          begin
            write(fil[20+j], t2);
            read(fil[i+1], t2);
          end
          else
          if t1.month = t2.month then
          begin
          if t1.day < t2.day then
          begin
            write(fil[20+j], t1);
            read(fil[i], t1);
          end
          else
          if t1.day > t2.day then
          begin
            write(fil[20+j], t2);
            read(fil[i+1], t2);
          end
          else
          if t1.day = t2.day then
          begin
          if t1.money < t2.money then
          begin
            write(fil[20+j], t1);
            read(fil[i], t1);
          end
          else
          if t1.money > t2.money then
          begin
            write(fil[20+j], t2);
            read(fil[i+1], t2);
          end
          else
          if t1.money = t2.money then
          begin
           write(fil[20+j], t1);
            read(fil[i], t1);
             write(fil[20+j], t2);
            read(fil[i], t2);
          end;
          end;
          end;
        end;
      end;
    while not EOF(fil[i]) do
      begin
        write(fil[20+j], t1);
        read(fil[i], t1);
      end;
    while not EOF(fil[i+1]) do
      begin
        write(fil[20+j], t2);
        read(fil[i+1], t2)
      end;

     if t1.year < t2.year then
        begin
          write(fil[20+j], t1);

        end
        else
        if t1.year > t2.year then
        begin
          write(fil[20+j], t2);

        end
        else
        if t1.year = t2.year then
        begin
          if t1.month < t2.month then
          begin
            write(fil[20+j], t1);

          end
          else
          if t1.month > t2.month then
          begin
            write(fil[20+j], t2);

          end
          else
          if t1.month = t2.month then
          begin
          if t1.day < t2.day then
          begin
            write(fil[20+j], t1);

          end
          else
          if t1.day > t2.day then
          begin
            write(fil[20+j], t2);

          end
          else
          if t1.day = t2.day then
          begin
          if t1.money < t2.money then
          begin
            write(fil[20+j], t1);

          end
          else
          if t1.money > t2.money then
          begin
            write(fil[20+j], t2);

          end
          else
          if t1.money = t2.money then
          begin
           write(fil[20+j], t1);

             write(fil[20+j], t2);

          end;

          end;
          end;
        end;

    i:= i + 2;
    Inc(j);
  end;

  For i:= 1 to 30 do
  begin
    closefile(fil[i]);
  end;

   For i:= 21 to 30 do
   begin
    reset(fil[i]);
   end;

   for i:= 31 to 35 do begin
    AssignFile(fil[i], 'C:\Users\Кирилл\Desktop\ЛЕКЦИИ\LP\Программирование\Семестр 2\LAB 9\Files\f'+inttostr(i)+'.txt');
    rewrite(fil[i]);
  end;

  i:=21;
  j:=1;
  while i < 30 do begin

    if not EOF(fil[i]) then
    read(fil[i], t1);
    if not EOF(fil[i+1]) then
    read(fil[i+1], t2);

    While (not EOF(fil[i])) and (not EOF(fil[i+1])) do
      begin
        if t1.year < t2.year then
        begin
          write(fil[30+j], t1);
          read(fil[i], t1);
        end
        else
        if t1.year > t2.year then
        begin
          write(fil[30+j], t2);
          read(fil[i+1], t2);
        end
        else
        if t1.year = t2.year then
        begin
          if t1.month < t2.month then
          begin
            write(fil[30+j], t1);
            read(fil[i], t1);
          end
          else
          if t1.month > t2.month then
          begin
            write(fil[30+j], t2);
            read(fil[i+1], t2);
          end
          else
          if t1.month = t2.month then
          begin
          if t1.day < t2.day then
          begin
            write(fil[30+j], t1);
            read(fil[i], t1);
          end
          else
          if t1.day > t2.day then
          begin
            write(fil[30+j], t2);
            read(fil[i+1], t2);
          end
          else
          if t1.day = t2.day then
          begin
          if t1.money < t2.money then
          begin
            write(fil[30+j], t1);
            read(fil[i], t1);
          end
          else
          if t1.money > t2.money then
          begin
            write(fil[30+j], t2);
            read(fil[i+1], t2);
          end
          else
          if t1.money = t2.money then
          begin
            write(fil[30+j], t1);
            read(fil[i], t1);
            write(fil[30+j], t2);
            read(fil[i+1], t2);
          end;
          end;
          end;
        end;
      end;
    while not EOF(fil[i]) do
      begin
        write(fil[30+j], t1);
        read(fil[i], t1);
      end;
    while not EOF(fil[i+1]) do
      begin
        write(fil[30+j], t2);
        read(fil[i+1], t2);
      end;




     if t1.year < t2.year then
        begin
          write(fil[30+j], t1);
        end
        else
        if t1.year > t2.year then
        begin
          write(fil[30+j], t2);
        end
        else
        if t1.year = t2.year then
        begin
          if t1.month < t2.month then
          begin
            write(fil[30+j], t1);
          end
          else
          if t1.month > t2.month then
          begin
            write(fil[30+j], t2);
          end
          else
          if t1.month = t2.month then
          begin
          if t1.day < t2.day then
          begin
            write(fil[30+j], t1);
          end
          else
          if t1.day > t2.day then
          begin
            write(fil[30+j], t2);
          end
          else
          if t1.day = t2.day then
          begin
          if t1.money < t2.money then
          begin
            write(fil[30+j], t1);

          end
          else
          if t1.money > t2.money then
          begin
            write(fil[30+j], t2);

          end
          else
          if t1.money = t2.money then
          begin
            write(fil[30+j], t1);

            write(fil[30+j], t2);

          end;
          end;
          end;
        end;




    i:= i + 2;
    Inc(j);
  end;

  For i:= 21 to 35 do
  begin
    closefile(fil[i]);
  end;

  For i:= 31 to 35 do
   begin
    reset(fil[i]);
   end;

  for i:= 36 to 37 do begin
    AssignFile(fil[i], 'C:\Users\Кирилл\Desktop\ЛЕКЦИИ\LP\Программирование\Семестр 2\LAB 9\Files\f'+inttostr(i)+'.txt');
    rewrite(fil[i]);
  end;

   i:=31;
   j:=1;
  while i < 34 do begin

    if not EOF(fil[i]) then
    read(fil[i], t1);
    if not EOF(fil[i+1]) then
    read(fil[i+1], t2);

    While (not EOF(fil[i])) and (not EOF(fil[i+1])) do
      begin
        if t1.year < t2.year then
        begin
          write(fil[35+j], t1);
          read(fil[i], t1);
        end
        else
        if t1.year > t2.year then
        begin
          write(fil[35+j], t2);
          read(fil[i+1], t2);
        end
        else
        if t1.year = t2.year then
        begin
          if t1.month < t2.month then
          begin
            write(fil[35+j], t1);
            read(fil[i], t1);
          end
          else
          if t1.month > t2.month then
          begin
            write(fil[35+j], t2);
            read(fil[i+1], t2);
          end
          else
          if t1.month = t2.month then
          begin
          if t1.day < t2.day then
          begin
            write(fil[35+j], t1);
            read(fil[i], t1);
          end
          else
          if t1.day > t2.day then
          begin
            write(fil[35+j], t2);
            read(fil[i+1], t2);
          end
          else
          if t1.day = t2.day then
          begin
          if t1.money < t2.money then
          begin
            write(fil[35+j], t1);
            read(fil[i], t1);
          end
          else
          if t1.money > t2.money then
          begin
            write(fil[35+j], t2);
            read(fil[i+1], t2);
          end
           else
          if t1.money = t2.money then
          begin
           write(fil[35+j], t1);
            read(fil[i], t1);
            write(fil[35+j], t2);
            read(fil[i+1], t2);
          end;
          end;
          end;
        end;
      end;
    while not EOF(fil[i]) do
      begin
        write(fil[35+j], t1);
        read(fil[i], t1);
      end;
    while not EOF(fil[i+1]) do
      begin
        write(fil[35+j], t2);
        read(fil[i+1], t2);
      end;

     if t1.year < t2.year then
        begin
          write(fil[35+j], t1);

        end
        else
        if t1.year > t2.year then
        begin
          write(fil[35+j], t2);

        end
        else
        if t1.year = t2.year then
        begin
          if t1.month < t2.month then
          begin
            write(fil[35+j], t1);

          end
          else
          if t1.month > t2.month then
          begin
            write(fil[35+j], t2);

          end
          else
          if t1.month = t2.month then
          begin
          if t1.day < t2.day then
          begin
            write(fil[35+j], t1);

          end
          else
          if t1.day > t2.day then
          begin
            write(fil[35+j], t2);

          end
          else
          if t1.day = t2.day then
          begin
          if t1.money < t2.money then
          begin
            write(fil[35+j], t1);

          end
          else
          if t1.money > t2.money then
          begin
            write(fil[35+j], t2);

          end
          else
          if t1.money = t2.money then
          begin
           write(fil[35+j], t1);

            write(fil[35+j], t2);

          end;
          end;
          end;
        end;

    i:= i + 2;
    Inc(j);
  end;

   For i:= 31 to 36 do
  begin
    closefile(fil[i]);
  end;

  For i:= 35 to 36 do
   begin
    reset(fil[i]);
   end;

    AssignFile(fil[38], 'C:\Users\Кирилл\Desktop\ЛЕКЦИИ\LP\Программирование\Семестр 2\LAB 9\Files\f'+inttostr(38)+'.txt');
    rewrite(fil[38]);

    if not EOF(fil[35]) then
    read(fil[35], t1);
    if not EOF(fil[36]) then
    read(fil[36], t2);

    While (not EOF(fil[35])) and (not EOF(fil[36])) do
      begin
        if t1.year < t2.year then
        begin
          write(fil[38], t1);
          read(fil[35], t1);
        end
        else
        if t1.year > t2.year then
        begin
          write(fil[38], t2);
          read(fil[36], t2);
        end
        else
        if t1.year = t2.year then
        begin
          if t1.month < t2.month then
          begin
            write(fil[38], t1);
            read(fil[35], t1);
          end
          else
          if t1.month > t2.month then
          begin
            write(fil[38], t2);
            read(fil[36], t2);
          end
          else
          if t1.month = t2.month then
          begin
          if t1.day < t2.day then
          begin
            write(fil[38], t1);
            read(fil[35], t1);
          end
          else
          if t1.day > t2.day then
          begin
            write(fil[38], t2);
            read(fil[36], t2);
          end
          else
          if t1.day = t2.day then
          begin
          if t1.money < t2.money then
           begin
            write(fil[38], t1);
            read(fil[35], t1);
          end
          else
          if t1.money > t2.money then
          begin
            write(fil[38], t2);
            read(fil[36], t2);
          end
           else
          if t1.money = t2.money then
          begin
            write(fil[38], t1);
            read(fil[35], t1);
            write(fil[38], t2);
            read(fil[36], t2);
          end;
          end;
          end;
        end;
      end;
    while not EOF(fil[35]) do
      begin
        write(fil[38], t1);
        read(fil[35], t1);
      end;
    while not EOF(fil[36]) do
      begin
        write(fil[38], t2);
        read(fil[36], t2);
      end;

     if t1.year < t2.year then
        begin
          write(fil[38], t1);

        end
        else
        if t1.year > t2.year then
        begin
          write(fil[38], t2);

        end
        else
        if t1.year = t2.year then
        begin
          if t1.month < t2.month then
          begin
            write(fil[38], t1);

          end
          else
          if t1.month > t2.month then
          begin
            write(fil[38], t2);

          end
          else
          if t1.month = t2.month then
          begin
          if t1.day < t2.day then
          begin
            write(fil[38], t1);

          end
          else
          if t1.day > t2.day then
          begin
            write(fil[38], t2);

          end
          else
          if t1.day = t2.day then
          begin
          if t1.money < t2.money then
           begin
            write(fil[38], t1);

          end
          else
          if t1.money > t2.money then
          begin
            write(fil[38], t2);

          end
          else
          if t1.money = t2.money then
          begin
            write(fil[38], t1);

            write(fil[38], t2);

          end;
          end;
          end;
        end;


For i:= 35 to 38 do
 begin
   closefile(fil[i]);
 end;
For i:= 37 to 38 do
  begin
   reset(fil[i]);
  end;
 rewrite(FileLast);
if not EOF(fil[37]) then
  read(fil[37], t1);
  if not EOF(fil[38]) then
  read(fil[38], t2);
  While (not EOF(fil[37])) and (not EOF(fil[38])) do
    begin
      if t1.year < t2.year then
      begin
        write(FileLast, t1);
        read(fil[37], t1);
      end
      else
      if t1.year > t2.year then
      begin
        write(FileLast, t2);
        read(fil[38], t2);
      end
      else
      if t1.year = t2.year then
      begin
        if t1.month < t2.month then
        begin
          write(FileLast, t1);
          read(fil[37], t1);
        end
        else
        if t1.month > t2.month then
        begin
          write(FileLast, t2);
          read(fil[38], t2);
        end
        else
        if t1.month = t2.month then
        begin
        if t1.day < t2.day then
        begin
          write(FileLast, t1);
          read(fil[37], t1);
        end
        else
        if t1.day > t2.day then
        begin
          write(FileLast, t2);
          read(fil[38], t2);
        end
        else
        if t1.day = t2.day then
        begin
        if t1.money < t2.money then
        begin
          write(FileLast, t1);
          read(fil[37], t1);
        end
        else
        if t1.money > t2.money then
        begin
          write(FileLast, t2);
          read(fil[38], t2);
        end
        else
        if t1.money = t1.money then
        begin
          write(FileLast, t2);
          read(fil[38], t2);
          write(FileLast, t1);
          read(fil[37], t1);
        end;
        end;
        end;
      end;
    end;
  while not EOF(fil[37]) do
    begin
      write(FileLast, t1);
      read(fil[37], t1);
    end;
  while not EOF(fil[38]) do
    begin
      write(FileLast, t2);
      read(fil[38], t2);
    end;

   if t1.year < t2.year then
      begin
        write(FileLast, t1);

      end
      else
      if t1.year > t2.year then
      begin
        write(FileLast, t2);

      end
      else
      if t1.year = t2.year then
      begin
        if t1.month < t2.month then
        begin
          write(FileLast, t1);

        end
        else
        if t1.month > t2.month then
        begin
          write(FileLast, t2);

        end
        else
        if t1.month = t2.month then
        begin
        if t1.day < t2.day then
        begin
          write(FileLast, t1);

        end
        else
        if t1.day > t2.day then
        begin
          write(FileLast, t2);

        end
        else
        if t1.day = t2.day then
        begin
        if t1.money < t2.money then
        begin
          write(FileLast, t1);

        end
        else
        if t1.money > t2.money then
        begin
          write(FileLast, t2);

        end
        else
        if t1.money = t1.money then
        begin
          write(FileLast, t2);

          write(FileLast, t1);

        end;
        end;
        end;
      end;

   CloseFile(FileLast);
end;   }

{procedure CheckFile;


var
  f: file of TDoc;
  prov: string;
  i, j: integer;
  t1, t2: TDoc;

 begin
 Form1.OpenDialog1.Execute;
 prov:= Form1.OpenDialog1.FileName;
 assign(f,prov);
 reset(f);
 i:=0;
 j:=0;
 repeat
 seek(f,i);
 read(f,t1);
 i:=i+1;
 seek(f,i);
 read(f,t2);
 if (t1.year<=t2.year) then begin
 j:=j+1;
 end
 else
 if t1.year = t2.year then begin
 if t1.month<=t2.month then begin
 j:=j+1;
 end
 else
 if t1.month = t2.month then begin
 if t1.day<=t2.day then begin
 j:=j+1;
 end
 else
 if t1.day = t2.day then begin
 if t1.money<=t2.money then begin
 j:=j+1;
 end;
 end;
 end;
 end
 until(i=(filesize(f)-1));
 if j=(filesize(f)-1) then
 begin
 Form1.Label2.Caption:= 'Файл отсортирован правильно.';
 Form1.Label2.Visible:= True;
 end
 else
 begin
 Form1.Label2.Caption:= 'Файл не отсортирован.';
 Form1.Label2.Visible:= True;
 end;
 close(f);
 end;    }



 procedure CheckFile;
var
  f: file of TDoc;
  prov: string;
  i, j: integer;
  t1, t2: TDoc;

 begin
 Form1.OpenDialog1.Execute;
 prov:= Form1.OpenDialog1.FileName;
 assign(f,prov);
 reset(f);
 i:=0;
 j:=0;
 repeat
 seek(f,i);
 read(f,t1);
 i:=i+1;
 seek(f,i);
 read(f,t2);
 if (t1.year<=t2.year) then begin
 j:=j+1;
 end
 else
 if t1.month<=t2.month then begin
 j:=j+1;
 end
 else
 if t1.day<=t2.day then begin
 j:=j+1;
 end
 else
 if t1.money<=t2.money then begin
 j:=j+1;
 end
 until(i=(filesize(f)-1));
 if j=(filesize(f)-1) then
 begin
 Form1.Label2.Caption:= 'Файл отсортирован правильно.';
 Form1.Label2.Visible:= True;
 end
 else
 begin
 Form1.Label2.Caption:= 'Файл не отсортирован.';
 Form1.Label2.Visible:= True;
 end;
 close(f);
 end;

procedure QuickSort(left, right, c: integer);
var
  newLeft, newRight : integer;
  temp, pivot : TDoc;

begin
  if c = 1 then begin
  newLeft := left;
  newRight := right;

  pivot := zap[(left + right) div 2];

  repeat
    while zap[newLeft].year < pivot.year do begin
      newLeft := newLeft + 1;
    end;

    while zap[newRight].year > pivot.year do
      newRight := newRight - 1;

    if newLeft <= newRight then
    begin
      temp := zap[newLeft];
      zap[newLeft] := zap[newRight];
      zap[newRight] := temp;

      newLeft := newLeft + 1;
      newRight := newRight - 1;
    end;
  until newLeft > newRight;

  if left < newRight then
    QuickSort(left, newRight, 1);

  if newLeft < right then
    QuickSort(newLeft, right, 1);

end
else
if c = 2 then begin
  newLeft := left;
  newRight := right;

  pivot := zap[(left + right) div 2];

  repeat
    while zap[newLeft].month < pivot.month do begin
      newLeft := newLeft + 1;
    end;

    while zap[newRight].month > pivot.month do
      newRight := newRight - 1;

    if newLeft <= newRight then
    begin
      temp.month := zap[newLeft].month;
      zap[newLeft].month := zap[newRight].month;
      zap[newRight].month := temp.month;

      temp.day := zap[newLeft].day;
      zap[newLeft].day := zap[newRight].day;
      zap[newRight].day := temp.day;

      temp.money := zap[newLeft].money;
      zap[newLeft].money := zap[newRight].money;
      zap[newRight].money := temp.money;

      temp.Name := zap[newLeft].Name;
      zap[newLeft].Name := zap[newRight].Name;
      zap[newRight].Name := temp.Name;

      newLeft := newLeft + 1;
      newRight := newRight - 1;
    end;
  until newLeft > newRight;

  if left < newRight then
    QuickSort(left, newRight, 2);

  if newLeft < right then
    QuickSort(newLeft, right, 2);

end
else
if c = 3 then begin
  newLeft := left;
  newRight := right;

  pivot := zap[(left + right) div 2];

  repeat
    while zap[newLeft].day < pivot.day do begin
      newLeft := newLeft + 1;
    end;

    while zap[newRight].day > pivot.day do
      newRight := newRight - 1;

    if newLeft <= newRight then
    begin
      temp.day := zap[newLeft].day;
      zap[newLeft].day := zap[newRight].day;
      zap[newRight].day := temp.day;

      temp.money := zap[newLeft].money;
      zap[newLeft].money := zap[newRight].money;
      zap[newRight].money := temp.money;

      temp.Name := zap[newLeft].Name;
      zap[newLeft].Name := zap[newRight].Name;
      zap[newRight].Name := temp.Name;

      newLeft := newLeft + 1;
      newRight := newRight - 1;
    end;
  until newLeft > newRight;

  if left < newRight then
    QuickSort(left, newRight, 3);

  if newLeft < right then
    QuickSort(newLeft, right, 3);
end
else
if c = 4 then begin
  newLeft := left;
  newRight := right;

  pivot := zap[(left + right) div 2];

  repeat
    while zap[newLeft].money < pivot.money do begin
      newLeft := newLeft + 1;
    end;

    while zap[newRight].money > pivot.money do
      newRight := newRight - 1;

    if newLeft <= newRight then
    begin
      temp.money := zap[newLeft].money;
      zap[newLeft].money := zap[newRight].money;
      zap[newRight].money := temp.money;

      temp.Name := zap[newLeft].Name;
      zap[newLeft].Name := zap[newRight].Name;
      zap[newRight].Name := temp.Name;

      newLeft := newLeft + 1;
      newRight := newRight - 1;
    end;
  until newLeft > newRight;

  if left < newRight then
    QuickSort(left, newRight, 4);

  if newLeft < right then
    QuickSort(newLeft, right, 4);
end;

end;



Procedure Sort(first, last: integer);
var
  i, j:integer;

begin
 j:= first;
 i:= first;
 repeat
    while zap[i].year = zap[i+1].year do
      inc(i);
 QuickSort(j, i, 2);
 inc(i);
 j:=i;
 until i > last;

 j:= first;
 i:= first;
 repeat
    while zap[i].month = zap[i+1].month do
      inc(i);
 QuickSort(j, i, 3);
 inc(i);
 j:=i;
 until i > last;

 j:= first;
 i:= first;
 repeat
    while zap[i].day = zap[i+1].day do
      inc(i);
 QuickSort(j, i, 4);
 inc(i);
 j:=i;
 until i > last;

end;



procedure TForm1.SortButtonClick(Sender: TObject);
var
  i, j: integer;
  t: TDoc;
begin
  Form1.Label1.Visible:=False;
  AssignFile(FileStart, PathStart);
  reset(FileStart);
  AssignFile(FileLast, PathLast);

  for i:= 1 to 32 do begin
    AssignFile(fil[i], 'C:\Users\Кирилл\Desktop\ЛЕКЦИИ\LP\Программирование\Семестр 2\LAB 9\Files\f'+inttostr(i)+'.txt');
    rewrite(fil[i]);
  end;

  i:=1;
  while not EOF(FileStart) do begin
    while i <= 32 do begin
      if not EOF(FileStart) then
      read(FileStart, t)
      else
      break;
      write(fil[i], t);
      if i = 32 then
      i:= 0;
      Inc(i);
    end;
  end;

  CloseFile(FileStart);

  for i:=1 to 32 do begin
    CloseFile(fil[i]);
  end;

  for i:=1 to 32 do begin
    Reset(fil[i]);
    while not EOF(fil[i]) do begin
      for j:= 1 to 5 do begin
        read(fil[i], t);
        zap[j]:= t;
      end;
      QuickSort(1, 5, 1);
      Sort(1, 5);
    end;
      CloseFile(fil[i]);
      rewrite(fil[i]);
    for j:= 1 to 5 do
    begin
      write(fil[i], zap[j]);
    end;
     CloseFile(fil[i]);
     reset(fil[i]);
  end;

  Sliv(33, 48);

  Form1.Label1.Visible:=True;
end;



procedure TForm1.LastClick(Sender: TObject);
begin
  If OpenDialog1.Execute then
  PathLast:= OpenDialog1.FileName;
end;

procedure TForm1.CheckClick(Sender: TObject);
begin
  Form1.Label2.Visible:= false;
  CheckFile;
end;

procedure TForm1.StartClick(Sender: TObject);
begin
  If OpenDialog1.Execute then
  PathStart:= OpenDialog1.FileName;
end;

end.

