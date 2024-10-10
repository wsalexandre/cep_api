program CEP_UserInterface;

uses
  System.StartUpCopy,
  FMX.Forms,
  CEP_Main in 'CEP_Main.pas' {HeaderFooterForm},
  CEP_API.Model.Resposta in '..\Model\CEP_API.Model.Resposta.pas',
  CEP_API.Helpers.Auxiliar in '..\Helpers\CEP_API.Helpers.Auxiliar.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(THeaderFooterForm, HeaderFooterForm);
  Application.Run;
end.
