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
  url := TUrlParser.New
           .SetProtocol(stHttps)
	   .BaseUrl('www.thisisatest.com')
	   .AddResource('tests')
	   .AddResource('subTests')
	   .AddParameter('thisisa', 'test')
	   .AddParameter('useiton', 'delphi')
	   .ToString;
end;
```

The sample above would return the url below as a string

`
https://www.thisisatest.com/tests/subTests?thisisa=test&useiton=delphi
`

### How to install it

##### Install it manually:

Simply drop the UrlParser.pas in your project's folder and add it to the project.

##### Installation using [**Boss**](https://github.com/HashLoad/boss):

```
boss install github.com/nickolasdeluca/UrlParser
```
