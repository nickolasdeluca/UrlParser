program UrlParserSample;

uses
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
