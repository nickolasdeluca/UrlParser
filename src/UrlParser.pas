unit UrlParser;

interface

Uses
  { System }
  System.StrUtils, System.Generics.Collections, System.Classes,
  System.SysUtils, System.NetEncoding;

type
  TUrlParser = class

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
  Result.FParams := TStringlist.Create;
end;

function TUrlParser.AddParameter(AName: String; AValue: String): TUrlParser;
begin
  Result := Self;
  Result.FParams.AddPair(AName, AValue);
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

  if FParams.Count > 0 then
  begin
    for AParam in FParams do
    begin
      Result := Result + IfThen(Result.Contains('?'), '&', '?') + TNetEncoding.URL.Encode(AParam, [], []);
    end;
  end;
  
  Self.Destroy;
end;

end.
