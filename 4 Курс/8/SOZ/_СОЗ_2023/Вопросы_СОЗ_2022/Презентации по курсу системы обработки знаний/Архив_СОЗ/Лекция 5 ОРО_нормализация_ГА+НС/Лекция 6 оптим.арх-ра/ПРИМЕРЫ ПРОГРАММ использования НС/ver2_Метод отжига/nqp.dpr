program nqp;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  visual in 'visual.pas' {Form2},
  Protocol in 'Protocol.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
