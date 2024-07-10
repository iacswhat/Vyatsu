unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, Forms, Controls, Graphics, Dialogs, UTF8Process;

type

  { TForm1 }

  TForm1 = class(TForm)
    AProcess: TProcessUTF8;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
   AProcess := TProcessUTF8.Create(nil);

   AProcess.Executable:= 'C:\day\program1\program1.exe';

   AProcess.Parameters.Add('-h');

   AProcess.Options := AProcess.Options + [poWaitOnExit];

   AProcess.Execute;

   AProcess.Free;
end;

end.

