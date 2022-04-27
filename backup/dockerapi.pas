unit DockerAPI;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,fpjson, jsonparser, fphttpclient;

function available():boolean;
function VolumeCount():integer;
function nameOf(namedVolume:integer):string;
function usageCount(namedVolume:integer):integer;

implementation
function read(url:string):TJSONData;
var Http:TFPHTTPClient;
    Stream : TRawByteStringStream;

begin
  Result := nil;
  Stream:=TRawByteStringStream.Create;
  try
    Http :=TFPHTTPClient.Create(Nil);
    Http.HTTPMethod('GET','http://localhost:2375/' + url, Stream, [404,200]);
    Result := GetJSON(Stream.DataString);
  finally
    Http.Free;
  end;
  Stream.Free;
end;
function nameOf(namedVolume:integer):string;
begin
  Result := '';
  with read('volumes') do try
    Result := GetPath('Volumes['+inttostr(namedVolume - 1)+'].Name').asString;
  finally
    Free;
  end;
end;
function usageCount(namedVolume:integer):integer;
begin
  Result := '';
  with read('volumes') do try
    Result := GetPath('Volumes['+inttostr(namedVolume - 1)+'].Name').asString;
  finally
    Free;
  end;
end;

function available():boolean;
begin
  with (read('').GetPath('message')) do
  begin
    result := AsString = 'page not found';  // everything ok.
    Free();
  end;
end;
function VolumeCount():integer;
begin
  Result := 0;
  with read('volumes') do try
    Result := GetPath('Volumes').Count;
  finally
    Free;
  end;
end;

end.

