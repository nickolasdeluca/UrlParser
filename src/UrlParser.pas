unit UrlParser;

interface

Uses
  { System }
  System.Generics.Collections, System.Classes,
  System.SysUtils, System.NetEncoding, System.Math;

type
  TProtocol = (stInvalid = -1, stNone = 0, stHttp = 1, stHttps = 2);

  IUrlParser = interface
    ['{992CD585-6821-433A-B1A5-B6E305A50844}']
    function Parse(AURI: String): IUrlParser;

    function Protocol(AProtocol: TProtocol): IUrlParser; overload;
    function Protocol: TProtocol; overload;

    function BaseUrl(AUrl: String): IUrlParser; overload;
    function BaseUrl: String; overload;

    function AddResource(AResource: String): IUrlParser;
    function Resources: TList<String>;

    function AddParameter(AName: String; AValue: String): IUrlParser; overload;
    function AddParameter(APair: String): IUrlParser; overload;
    function Parameters: TStringlist;

    function ToString: String;
  end;

  TUrlParser = class(TInterfacedObject, IUrlParser)
  protected
    {$IF CompilerVersion <= 23.0}
    FNameValueSeparator: Char;
    property NameValueSeparator: Char read FNameValueSeparator write FNameValueSeparator;
    {$ENDIF}
  private
    FProtocol: TProtocol;
    FBaseURL: string;
    FResources: TList<String>;
    FParameters: TStringlist;
  public
    function Parse(AURI: String): IUrlParser;

    function Protocol(AProtocol: TProtocol): IUrlParser; overload;
    function Protocol: TProtocol; overload;

    function BaseUrl(AUrl: String): IUrlParser; overload;
    function BaseUrl: String; overload;

    function AddResource(AResource: String): IUrlParser;
    function Resources: TList<String>;

    function AddParameter(AName: String; AValue: String): IUrlParser; overload;
    function AddParameter(APair: String): IUrlParser; overload;
    function Parameters: TStringlist;

    function ToString: String; override;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  System.StrUtils;

const
  cProtocol : array[TProtocol] of string = ('', '', 'http://', 'https://');

{ TUrlParser }

constructor TUrlParser.Create;
begin
  FBaseUrl := '';
  {$IF CompilerVersion <= 23.0}
  FNameValueSeparator := '=';
  {$ENDIF}
  FParameters := TStringlist.Create;
  FResources := TList<String>.Create;
end;

destructor TUrlParser.Destroy;
begin
  FResources.Free;
  FParameters.Free;

  inherited;
end;

function TUrlParser.Parameters: TStringlist;
begin
  Result := FParameters;
end;

function TUrlParser.Parse(AURI: String): IUrlParser;
var
  LFragment: String;
  LURI: String;
  LHasPaths, LHasParameters, LHasHashes: Boolean;
begin
  Result := Self;

  LURI := AURI.Trim(['/']);

  if Length(LURI) <= 0 then
    Exit;

  LHasPaths := ContainsStr(LURI, '/');
  LHasParameters := ContainsStr(LURI, '?');
  LHasHashes := ContainsStr(LURI, '#');

  LFragment := Copy(LURI, 0, Pos('://', LURI)+2);

  FProtocol := TProtocol(IndexStr(LFragment, cProtocol)-1);

  Delete(LURI, 1, Length(LFragment));

  if Length(LURI) <= 0 then
    Exit;

  LFragment := Copy(LURI, 0, Pos('/', LURI)-1);

  FBaseUrl := LFragment;

  Delete(LURI, 1, Length(LFragment)+1);

  if Length(LURI) <= 0 then
    Exit;

  if LHasPaths then
  begin
    while (Pos('/', LURI) > 0) do
    begin
      LFragment := Copy(LURI, 0, Pos('/', LURI)-1);

      Result.Resources.Add(LFragment);

      Delete(LURI, 1, Length(LFragment)+1);
    end;

    LFragment := Copy(LURI, 0, IfThen(LHasParameters,
                                      Pos('?', LURI)-1,
                                      Length(LURI)));

    FResources.Add(LFragment);

    Delete(LURI, 1, Length(LFragment));
  end;

  if Length(LURI) <= 0 then
    Exit;

  if LHasParameters then
  begin
    Delete(LURI, 1, 1);

    while (Pos('&', LURI) > 0) do
    begin
      LFragment := Copy(LURI, 0, Pos('&', LURI)-1);

      AddParameter(LFragment);

      Delete(LURI, 1, Length(LFragment)+1);
    end;

    LFragment := Copy(LURI, 0, IfThen(LHasHashes,
                                      Pos('#', LURI)-1,
                                      Length(LURI)));

    AddParameter(LFragment);

    Delete(LURI, 1, Length(LFragment));
  end;
end;

function TUrlParser.Protocol: TProtocol;
begin
  Result := FProtocol;
end;

function TUrlParser.Protocol(AProtocol: TProtocol): IUrlParser;
begin
  Result := Self;
  FProtocol := AProtocol;
end;

function TUrlParser.AddParameter(AName: String; AValue: String): IUrlParser;
begin
  Result := Self;

  {$IF CompilerVersion > 23.0}
  FParameters.AddPair(AName, AValue);
  {$ELSE}
  AddParameter(AName + NameValueSeparator + AValue);
  {$ENDIF}
end;

function TUrlParser.AddParameter(APair: String): IUrlParser;
begin
  FParameters.Add(APair);
end;

function TUrlParser.AddResource(AResource: String): IUrlParser;
begin
  Result := Self;
  Result.Resources.Add(AResource);
end;

function TUrlParser.BaseUrl: String;
begin
  Result := FBaseURL;
end;

function TUrlParser.BaseUrl(AUrl: String): IUrlParser;
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

  Result := Result + BaseUrl;

  for AResource in Resources do
    Result := Result + '/' + AResource;

  for AParam in FParameters do
    Result := Result + IfThen(Result.Contains('?'), '&', '?') + AParam;

  Result :=
  {$IF CompilerVersion > 23.0}
  TNetEncoding.URL.Encode(Result, [], []);
  {$ELSE}
  TNetEncoding.URL.Encode(Result);
  {$ENDIF}
end;

function TUrlParser.Resources: TList<String>;
begin
  Result := FResources;
end;

end.
