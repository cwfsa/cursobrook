unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  BrookAction, BrookHttpUtils, classes, sysutils;

type
  TMyAction = class(TBrookAction)
  public
    procedure Get; override;
  end;

implementation

procedure TMyAction.Get;
const
  f = '/home/carlos/Imagens/0.png';
begin
  TheResponse.ContentStream := TFileStream.Create(f,
    fmOpenRead or fmShareDenyWrite);
  try
    TheResponse.ContentType := BrookMimeTypeFromFileName(f);
    TheResponse.SetCustomHeader('Content-Disposition',
      'inline; filename="'+ ExtractFileName(f) +'"');
    TheResponse.SendContent;
  finally
    TheResponse.ContentStream.Free;
    TheResponse.ContentStream := nil;
  end;
end;

initialization
  TMyAction.Register('*');

end.
