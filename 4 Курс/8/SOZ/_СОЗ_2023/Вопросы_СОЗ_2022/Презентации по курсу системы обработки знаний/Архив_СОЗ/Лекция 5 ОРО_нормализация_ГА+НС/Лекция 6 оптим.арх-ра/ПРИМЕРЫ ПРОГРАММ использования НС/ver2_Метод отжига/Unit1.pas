unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    EdTmp: TEdit;
    UpDown1: TUpDown;
    Label1: TLabel;
    Label2: TLabel;
    UpDown2: TUpDown;
    EdN: TEdit;
    Label3: TLabel;
    UpDown3: TUpDown;
    EdAlpha: TEdit;
    Label4: TLabel;
    UpDown4: TUpDown;
    EdIter: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses visual;

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if(Form1.EdTmp.Text='0')
  then begin
         MessageBox(0,PChar('Начальная температура должна быть больше нуля'), PChar('Ошибка'), MB_OK);
         exit;
       end;
  if(Form1.EdN.Text='0')OR(StrToInt(Form1.EdN.Text) > 40)
  then begin
         MessageBox(0,PChar('Количество ферзей должно быть больше нуля'), PChar('Ошибка'), MB_OK);
         exit;
       end;
  if(Form1.EdAlpha.Text='0')
  then begin
         MessageBox(0,PChar('Коэффициент понижения должен быть больше нуля, но меньше 100'), PChar('Ошибка'), MB_OK);
         exit;
       end;
  if(Form1.EdIter.Text='0')                             
  then begin
         MessageBox(0,PChar('Число итераций должно быть больше нуля'), PChar('Ошибка'), MB_OK);
         exit;
       end;
  Form1.Hide;
  Form2.show;
end;

end.
