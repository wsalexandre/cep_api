unit CEP_API.Controller.PesquisaCEP;

interface

uses
  Horse,
  System.JSON,
  Sysutils,
  System.Classes,
  IdCoderMIME,
  Soap.EncdDecd,
  CEP_API.Helpers.Auxiliar;

procedure Registry(App : THorse);
procedure ListarCEP(Req : THorseRequest; Res : THorseResponse; Next : TProc);

implementation

uses CEP_API.Model.Resposta;

procedure Registry(App : THorse);
begin
  App.Get('/pesquisacep/:cep', ListarCEP);
end;

procedure ListarCEP(Req : THorseRequest; Res : THorseResponse; Next : TProc);
var
  resposta1 : string;
  status : Integer;
begin
  if not Req.Params.Items['cep'].IsEmpty then
  begin
    resposta1 := ExecutarMetodoHTTP(Format('https://cep.awesomeapi.com.br/json/%s', [Req.Params.Items['cep']]), '', 'GET', status);
  end;

  case status of
    200 : res.Send(resposta1).Status(status);
    400 : res.Send('CEP invalido.');
    404 : res.Send('CEP n�o encontrado');
  end;


end;

end.
