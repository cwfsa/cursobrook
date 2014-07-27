unit uform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Image1: TImage;
    procedure BitBtn1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  BrookUtils, BrookHttpClient, BrookFCLHttpClientBroker;

{$R *.lfm}

{ TForm1 }

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  vDados: TStream;
  vHttp: TBrookHttpClient;
begin
  vDados := TMemoryStream.Create;
  vHttp := TBrookHttpClient.Create('FCLWeb');
  try
    if not vHttp.Get('http://localhost/cgi-bin/imagem',vDados) then
      raise exception.Create('Não foi possível obter os dados do Servidor');
    vDados.Seek(0,0);
    Image1.Picture.LoadFromStream(vDados);
  finally
    vDados.Free;
    vHttp.Free;
  end;
end;

end.

