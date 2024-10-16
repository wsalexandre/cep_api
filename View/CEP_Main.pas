unit CEP_Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Effects, FMX.Filter.Effects,
  FMX.Edit, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  THeaderFooterForm = class(TForm)
    Header: TToolBar;
    Footer: TToolBar;
    HeaderLabel: TLabel;
    RadialBlurEffect1: TRadialBlurEffect;
    btnSair: TCornerButton;
    Panel1: TPanel;
    lblPesquisa: TLabel;
    Edit1: TEdit;
    btnPesquisar: TCornerButton;
    MemoResultado: TMemo;
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
    procedure LimparPesquisa;
    procedure NovaPesquisa(const CEPNumero : String);
  public
    { Public declarations }
  end;

var
  HeaderFooterForm: THeaderFooterForm;

implementation

uses
  CEP_API.Model.Resposta, CEP_API.Helpers.Auxiliar;

{$R *.fmx}

{ THeaderFooterForm }

procedure THeaderFooterForm.btnPesquisarClick(Sender: TObject);
begin
  NovaPesquisa(Edit1.Text);
end;

procedure THeaderFooterForm.btnSairClick(Sender: TObject);
begin
  Application.terminate;
end;

procedure THeaderFooterForm.LimparPesquisa;
begin
  MemoResultado.Lines.Clear;
end;

procedure THeaderFooterForm.NovaPesquisa(const CEPNumero: String);
var
  resposta : string;
  status : Integer;
  CEP : TCEP_Resposta;
begin
  LimparPesquisa;
  CEP := TCEP_Resposta.Create;
  try
    resposta := ExecutarMetodoHTTP(Format('https://cep.awesomeapi.com.br/json/%s', [CEPNumero]), '', 'GET', status);
    case status of
      200 :
        begin
          CEP.GetFromJSON(resposta);
          MemoResultado.Lines.Add('Resultado da pesquisa: ');
          MemoResultado.Lines.Add('CEP: ' + CEP.CEP);
          MemoResultado.Lines.Add('Tipo: ' + CEP.AddressType);
          MemoResultado.Lines.Add('Logradouro: ' + CEP.AddressName);
          MemoResultado.Lines.Add('Bairro: ' + CEP.District);
          MemoResultado.Lines.Add('Estado: ' + CEP.State);
          MemoResultado.Lines.Add('Cidade: ' + CEP.City);
          MemoResultado.Lines.Add('Latitude: ' + CEP.Lat);
          MemoResultado.Lines.Add('Longitude: ' + CEP.Lng);
          MemoResultado.Lines.Add('DDD: ' + CEP.DDD);
          MemoResultado.Lines.Add('C�d. Mun. IBGE: ' + CEP.CityIBGE);
        end;
      400 : MemoResultado.Lines.Add('CEP invalido.');
      404 : MemoResultado.Lines.Add('CEP n�o encontrado');
    end;
  finally
   CEP.Free;
  end;
end;

end.
