program CEP_API;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  Horse.BasicAuthentication,
  Horse.Commons,
  Web.HTTPD24Impl,
  System.SysUtils,
  System.Classes,
  System.JSON,
  System.NetEncoding,
  IdCoderMIME,
  idHashMessageDigest,
  rest.client,
  REST.Types,
  CEP_API.Controller.PesquisaCEP in 'Controller\CEP_API.Controller.PesquisaCEP.pas',
  CEP_API.Helpers.Auxiliar in 'Helpers\CEP_API.Helpers.Auxiliar.pas',
  CEP_API.Model.Resposta in 'Model\CEP_API.Model.Resposta.pas';

var
  App : THorse;

const
  HTTP_PORT = 9000;

begin

  App := THorse.Create;

  App.Use(Jhonson('UTF-8'));

  CEP_API.Controller.PesquisaCEP.Registry(App);

  Writeln(Format('Yay! Horse API listening at %s port', [HTTP_PORT.ToString]));
  Writeln('Try it on postman http://localhost:9000/pesquisacep/numerocep');
  App.Listen(9000);
end.
