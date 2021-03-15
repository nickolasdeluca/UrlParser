unit UrlParser;

interface

Uses
  { System }
  System.StrUtils, System.Generics.Collections, System.Classes,
  System.SysUtils, System.NetEncoding;

type
  TUrlParser = class

  protected
    {$IF CompilerVersion <= 23.0}
    FNameValueSeparator: Char;
    property NameValueSeparator: Char read FNameValueSeparator write FNameValueSeparator;
    {$ENDIF}
  private
    FBaseUrl: String;
    FParams: TStringlist;
  public
    class function New: TUrlParser;
    function BaseUrl(AUrl: String): TUrlParser;
    function AddParameter(AName: String; AValue: String): TUrlParser;
    function ToString: String; override;
  end;

implementation

{ TUrlParser }

class function TUrlParser.New: TUrlParser;
begin
  Result := TUrlParser.Create;
  Result.FBaseUrl := '';
  {$IF CompilerVersion <= 23.0}
  Result.FNameValueSeparator := '=';
  {$ENDIF}
  Result.FParams := TStringlist.Create;
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

function TUrlParser.BaseUrl(AUrl: String): TUrlParser;
begin
  Result := Self;
  FBaseUrl := AUrl;
end;

function TUrlParser.ToString: String;
var
  AParam: String;
begin
  Result := FBaseUrl;

  for AParam in FParams do
    Result := Result + IfThen(Result.Contains('?'), '&', '?') + AParam;

  Result :=
  {$IF CompilerVersion > 23.0}
  TNetEncoding.URL.Encode(Result, [], []);
  {$ELSE}
  TNetEncoding.URL.Encode(Result);
  {$ENDIF}
  
  Self.Destroy;
end;

end.
