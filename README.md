# UrlParser for Delphi

 Node.js like URL constructor for Delphi.

## How to use it

Add it to your uses

```pascal
uses UrlParser;
```

Then you can simply call it.

```pascal
var
  url: String;
begin
  url := TUrlParser.Create
  .Protocol(stHttps)
  .Username('myuser')
  .Password('mypass')
  .BaseUrl('thisisatest.com')
  .Port(3574)
  .AddResource('tests')
  .AddResource('subTests')
  .AddParameter('thisisa', 'test')
  .AddParameter('useiton', 'delphi')
  .ToString);
end;
```

The sample above would return the url below as a string

`
https://myuser:mypass@thisisatest.com:3574/tests/subTests?thisisa=test&useiton=delphi
`

New parsing method is now availabe.

```pascal
var
  LUrlObject: IUrlParser;
begin
  LUrlObject := TUrlParser.Create.Parse('https://www.thisisatest.com/tests/subTests?thisisa=test&useiton=delphi');
end;
```

The sample above would return a `IUrlParser` interface that would contain following attributes: `Protocol`, `BaseUrl`, `Resources` and `Parameters` of the parsed url.

### How to install it

#### Install it manually

Simply drop the UrlParser.pas in your project's folder and add it to the project.

#### Installation using [**Boss**](https://github.com/HashLoad/boss)

```shell
boss install github.com/nickolasdeluca/UrlParser
```
