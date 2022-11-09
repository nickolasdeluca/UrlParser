unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.Variants, System.Classes, System.StrUtils,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  UrlParser, Vcl.ExtCtrls, Vcl.WinXPanels, Vcl.Buttons;

type
  TFMain = class(TForm)
    cpSamples: TCardPanel;
    cdTestToString: TCard;
    btSampler: TButton;
    mmUrl: TMemo;
    pnControlCards: TPanel;
    btNext: TSpeedButton;
    btPrevious: TSpeedButton;
    cdTestObjectCreation: TCard;
    mmParsedInfo: TMemo;
    btParse: TButton;
    edUrl: TEdit;
    procedure btSamplerClick(Sender: TObject);
    procedure btNextClick(Sender: TObject);
    procedure btPreviousClick(Sender: TObject);
    procedure cpSamplesCardChange(Sender: TObject; PrevCard, NextCard: TCard);
    procedure btParseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

uses System.SysUtils;

{$R *.dfm}

procedure TFMain.btNextClick(Sender: TObject);
begin
  cpSamples.NextCard;
end;

procedure TFMain.btParseClick(Sender: TObject);
var
  LUrlObject: IUrlParser;
  LResource, LResources: String;
  LParam, LParams: String;
begin
  if String(edUrl.Text).IsEmpty then
    Exit;

  LUrlObject := TUrlParser.Create.Parse(edUrl.Text);

  mmParsedInfo.Lines.Clear;

  mmParsedInfo.Lines.Add('Unparsed URL: ' + edUrl.Text);

  mmParsedInfo.Lines.Add('');

  mmParsedInfo.Lines.Add('Protocol: ' + IntToStr(Integer(LUrlObject.Protocol)));

  mmParsedInfo.Lines.Add('Username: ' + LUrlObject.Username);
  mmParsedInfo.Lines.Add('Password: ' + LUrlObject.Password);

  mmParsedInfo.Lines.Add('BaseUrl: ' + LUrlObject.BaseUrl);

  mmParsedInfo.Lines.Add('Port: ' + IntToStr(LUrlObject.Port));

  for LResource in LUrlObject.Resources do
    LResources := LResources + IfThen(LResources.IsEmpty, '', ', ') + LResource;
  mmParsedInfo.Lines.Add('Resources: ' + LResources);

  for LParam in LUrlObject.Parameters do
    LParams := LParams + IfThen(LParams.IsEmpty, '', ', ') + LParam;
  mmParsedInfo.Lines.Add('Params: ' + LParams);

  mmParsedInfo.Lines.Add('');

  mmParsedInfo.Lines.Add('Reconstructed URL: ' + LUrlObject.ToString);
end;

procedure TFMain.btPreviousClick(Sender: TObject);
begin
  cpSamples.PreviousCard;
end;

procedure TFMain.btSamplerClick(Sender: TObject);
begin
  mmUrl.Clear;

  mmUrl.Lines.Add(TUrlParser.Create
        .Protocol(stHttps)
        .BaseUrl('www.thisisatest.com')
        .AddResource('tests')
        .AddResource('subTests')
        .AddParameter('thisisa', 'test')
        .AddParameter('useiton', 'delphi')
        .ToString);
end;

procedure TFMain.cpSamplesCardChange(Sender: TObject; PrevCard,
  NextCard: TCard);
begin
  pnControlCards.Caption := NextCard.Hint;
end;

end.
