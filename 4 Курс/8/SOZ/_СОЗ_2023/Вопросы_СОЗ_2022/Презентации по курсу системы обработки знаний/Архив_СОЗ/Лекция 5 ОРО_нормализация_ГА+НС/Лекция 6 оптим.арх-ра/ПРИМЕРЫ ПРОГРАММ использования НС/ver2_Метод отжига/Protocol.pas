unit Protocol;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons;

type
  TForm3 = class(TForm)
    StringGrid1: TStringGrid;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.FormShow(Sender: TObject);
begin
  Form3.StringGrid1.Cells[0,0] := '���';
  Form3.StringGrid1.Cells[1,0] := '�����������';
  Form3.StringGrid1.Cells[2,0] := '��������';
  Form3.StringGrid1.Cells[3,0] := '������� �������� �������';
  Form3.StringGrid1.Cells[4,0] := '������� � ������ �������';
  Form3.StringGrid1.Cells[5,0] := '������� ������ �������';
  Form3.StringGrid1.Cells[6,0] := '����������� �������� �������';
  Form3.StringGrid1.Cells[7,0] := '������� �� �������';
end;

procedure TForm3.BitBtn1Click(Sender: TObject);
begin
  Form3.Close();
end;

end.
