unit CEP_API.Helpers.Auxiliar;

interface

uses SysUtils, idHashMessageDigest, System.Classes, IdHTTP;

function ExecutarMetodoHTTP(URL, ContentString, Method : String; var Status : Integer) : String;

implementation

function ExecutarMetodoHTTP(URL, ContentString, Method: String; var Status: Integer): String;
var
  jsonToSend: TStringStream;
  idHTTP1: TIdHTTP;
  resposta: String;
begin
  IdHTTP1 := TIdHTTP.Create(nil);
  jsonToSend := TStringStream.Create(ContentString, TEncoding.UTF8);
  try
    idHTTP1.Request.ContentType := 'application/json';
    idHTTP1.Request.Accept := '*/*';
    try
      if Method = 'POST' then
      begin
        resposta := idHTTP1.Post(URL, jsonToSend);
        Status := idHTTP1.ResponseCode;
      end
      else if Method = 'GET' then
      begin
        resposta := idHTTP1.Get(URL);
        Status := idHTTP1.ResponseCode;
      end;
    except
      on E: EIdHTTPProtocolException do
      begin
        Status := IdHTTP1.ResponseCode;
        case Status of
          400:
            begin
              resposta := 'Bad Request';
              Status := idHTTP1.ResponseCode;
            end;
          404:
            begin
              resposta := 'Not Found';
              Status := idHTTP1.ResponseCode;
            end
        else
          resposta := E.Message;
        end;
      end;
      on E: Exception do
      begin
        resposta := E.Message;
        Status := -1;
      end;
    end;
  finally
    JsonToSend.Free;
    IdHTTP1.Free;
  end;
  Result := resposta;
end;

end.

