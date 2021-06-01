unit UrlParser;

interface

Uses
  { System }
  System.StrUtils, System.Generics.Collections, System.Classes,
  System.SysUtils, System.NetEncoding;

type
  TProtocol = (stNone, stHttp, stHttps);

  TUrlParser = class

  protected
    {$IF CompilerVersion <= 23.0}
    FNameValueSeparator: Char;
    property NameValueSeparator: Char read FNameValueSeparator write FNameValueSeparator;
    {$ENDIF}
  private
    FBaseUrl: String;
    FParams: TStringlist;
    FResources: TList<String>;
    FProtocol: TProtocol;
  public
    class function New: TUrlParser;
    function SetProtocol(AProtocol: TProtocol): TUrlParser;
    function BaseUrl(AUrl: String): TUrlParser;
    function AddParameter(AName: String; AValue: String): TUrlParser;
    function AddResource(AResource: String): TUrlParser;
    function ToString: String; override;
  end;

implementation

{ TSchemeType }

const
  cProtocol : array[TProtocol] of string = ('', 'http://', 'https://');

{ TUrlParser }

class function TUrlParser.New: TUrlParser;
begin
  Result := TUrlParser.Create;
  Result.FBaseUrl := '';
  {$IF CompilerVersion <= 23.0}
  Result.FNameValueSeparator := '=';
  {$ENDIF}
  Result.FParams := TStringlist.Create;
  Result.FResources := TList<String>.Create;
end;

function TUrlParser.SetProtocol(AProtocol: TProtocol): TUrlParser;
begin
  Result := Self;
  Result.FProtocol := AProtocol;
end;

function TUrlParser.AddParameter(AName: String; AValue: String): TUrlParser;
begin
  Result := Self;
  {$IF CompilerVersion > 23.0}
  Result.FParams.AddPair(AName, AValue);
  {$ELSE}
  Result.FParams.Add(AName + NameValueSeparator + AValue);
  {$ENDIF}
end;

function TUrlParser.AddResource(AResource: String): TUrlParser;
begin
  Result := Self;
  Result.FResources.Add(AResource);
end;

function TUrlParser.BaseUrl(AUrl: String): TUrlParser;
begin
  Result := Self;
  FBaseUrl := AUrl;
end;

function TUrlParser.ToString: String;
var
  AParam: String;
  AResource: String;
begin
  Result := cProtocol[FProtocol];

  Result := Result + FBaseUrl;

  for AResource in FResources do
    Result := Result + '/' + AResource;

  for AParam in FParams do
    Result := Result + IfThen(Result.Contains('?'), '&', '?') + AParam;

  Result :=
  {$IF CompilerVersion > 23.0}
  TNetEncoding.URL.Encode(Result, [], []);
  {$ELSE}
  TNetEncoding.URL.Encode(Result);
  {$ENDIF}

  FResources.Free;
  FParams.Free;
  Self.Destroy;
end;

end.
