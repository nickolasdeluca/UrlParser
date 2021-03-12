unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFMain = class(TForm)
    btSampler: TButton;
    mmUrl: TMemo;
    procedure btSamplerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

uses UrlParser;

{$R *.dfm}

procedure TFMain.btSamplerClick(Sender: TObject);
begin
  mmUrl.Clear;

  mmUrl.Lines.Add(
    TUrlParser.New
      .BaseUrl('www.test.com/t.html?a=1&b=3&c=m2-m3-m4-m5')
      .AddParameter('a', '1')
      .AddParameter('b', '3')
      .AddParameter('c', 'm2-m3-m4-m5')
      .ToString
  );
end;

end.
