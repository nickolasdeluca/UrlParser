unit UrlParser;

interface

Uses
  { System }
  System.Generics.Collections, System.Classes,
  System.SysUtils, System.NetEncoding, System.Math;

type
  TProtocol = (stNone, stHttp, stHttps);

  TProtocolHelper = record Helper for TProtocol
    function Parse(const AValue: string): TProtocol;
    function ToString: string;
  end;

  IUrlParser = interface
    ['{992CD585-6821-433A-B1A5-B6E305A50844}']
    function Parse(AURI: String): IUrlParser;

    function Protocol(AProtocol: TProtocol): IUrlParser; overload;
    function Protocol: TProtocol; overload;

    function Username(AUsername: String): IUrlParser; overload;
    function Username: string; overload;

    function Password(APassword: String): IUrlParser; overload;
    function Password: string; overload;

    function BaseUrl(AUrl: String): IUrlParser; overload;
    function BaseUrl: String; overload;

    function Port(APort: Integer): IUrlParser; overload;
    function Port: Integer; overload;

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
    FUsername: string;
    FPassword: string;
    FPort: Integer;
  public
    function Parse(AURI: String): IUrlParser;

    function Protocol(AProtocol: TProtocol): IUrlParser; overload;
    function Protocol: TProtocol; overload;

    function Username(AUsername: String): IUrlParser; overload;
    function Username: string; overload;

    function Password(APassword: String): IUrlParser; overload;
    function Password: string; overload;

    function BaseUrl(AUrl: String): IUrlParser; overload;
    function BaseUrl: String; overload;

    function Port(APort: Integer): IUrlParser; overload;
    function Port: Integer; overload;

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

{ TProtocolHelper }

function TProtocolHelper.Parse(const AValue: string): TProtocol;
var
  I: Integer;
begin
  Result := TProtocol.stNone;

  for I := Ord(Low(TProtocol)) to Ord(High(TProtocol)) do
  begin
    if AValue = TProtocol(I).ToString then
    begin
      Result := TProtocol(I);
      Break
    end;
  end;

  Self := Result;
end;

function TProtocolHelper.ToString: string;
begin
  case Self of
    stNone:
      Result := '';
    stHttp:
      Result := 'http://';
    stHttps:
      Result := 'https://';
  else
    Result := '';
  end;
end;

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
  LHasProtocol, LHasPaths, LHasParameters, LHasHashes, LHasUserPass, LHasPort: Boolean;
begin
  Result := Self;

  LURI := AURI.Trim(['/']);

  if Length(LURI) <= 0 then
    Exit;

  LHasProtocol := ContainsStr(LURI, '://');
  LHasPaths := ContainsStr(LURI, '/');
  LHasParameters := ContainsStr(LURI, '?');
  LHasHashes := ContainsStr(LURI, '#');
  LHasUserPass := ((ContainsStr(LURI, '@') and ContainsStr(LURI, ':')));

  if LHasProtocol then
  begin
    LFragment := Copy(LURI, 0, Pos('://', LURI) + 2);

    FProtocol.Parse(LFragment);

    Delete(LURI, 1, Length(LFragment));
  end;

  if Length(LURI) <= 0 then
    Exit;

  if (LHasUserPass) then
  begin
    while (Pos('@', LURI) > 0) do
    begin
      LFragment := Copy(LURI, 0, Pos('@', LURI) - 1);

      if (ContainsStr(LFragment, ':')) then
      begin
        Result.Username(Copy(LFragment, 0, Pos(':', LFragment) - 1));
        Result.Password(Copy(LFragment, Pos(':', LFragment) + 1, LFragment.Length));

        Delete(LURI, 1, Length(LFragment) + 1);
      end;
    end;
  end;

  if Length(LURI) <= 0 then
    Exit;

  LHasPort := ContainsStr(LURI, ':');

  LFragment := Copy(LURI, 0, Pos(IfThen(LHasPort, ':', '/'), LURI) - 1);

  FBaseUrl := LFragment;

  Delete(LURI, 1, Length(LFragment) + 1);

  if Length(LURI) <= 0 then
    Exit;

  if (LHasPort) then
  begin
    LFragment := Copy(LURI, 0, Pos('/', LURI) - 1);

    Result.Port(StrToIntDef(LFragment, 0));

    Delete(LURI, 1, Length(LFragment) + 1);
  end;

  if Length(LURI) <= 0 then
    Exit;

  if LHasPaths then
  begin
    while (Pos('/', LURI) > 0) do
    begin
      LFragment := Copy(LURI, 0, Pos('/', LURI) - 1);

      Result.Resources.Add(LFragment);

      Delete(LURI, 1, Length(LFragment) + 1);
    end;

    LFragment := Copy(LURI, 0, IfThen(LHasParameters,
                                      Pos('?', LURI) - 1,
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
      LFragment := Copy(LURI, 0, Pos('&', LURI) - 1);

      AddParameter(LFragment);

      Delete(LURI, 1, Length(LFragment) + 1);
    end;

    LFragment := Copy(LURI, 0, IfThen(LHasHashes,
                                      Pos('#', LURI) - 1,
                                      Length(LURI)));

    AddParameter(LFragment);

    Delete(LURI, 1, Length(LFragment));
  end;
end;

function TUrlParser.Username(AUsername: String): IUrlParser;
begin
  Result := Self;
  FUsername := AUsername;
end;

function TUrlParser.Username: string;
begin
  Result := FUsername;
end;

function TUrlParser.Password(APassword: String): IUrlParser;
begin
  Result := Self;
  FPassword := APassword;
end;

function TUrlParser.Password: string;
begin
  Result := FPassword;
end;

function TUrlParser.Port(APort: Integer): IUrlParser;
begin
  Result := Self;
  FPort := APort;
end;

function TUrlParser.Port: Integer;
begin
  Result := FPort;
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
  Result := Protocol.ToString;

  if (not(Username.IsEmpty)) or (not(Password.IsEmpty)) then
    Result := Result + Username + ':' + Password + '@';

  Result := Result + BaseUrl;

  if (Port > 0) then
    Result := Result + ':' + IntToStr(Port);

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
