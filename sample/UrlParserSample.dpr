program UrlParserSample;

uses
  {$IFDEF DEBUG}
  FastMM4 in 'FastMM4\FastMM4.pas',
  {$ENDIF}
  Vcl.Forms,
  Main in 'Main.pas' {FMain},
  UrlParser in '..\src\UrlParser.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
