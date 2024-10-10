unit CEP_API.Model.Resposta;

interface

uses  System.SysUtils,
      System.Classes,
      System.JSON;


type TCEP_Resposta = class
  private
    fCEP: String;
    fAddressType: String;
    fAddressName: String;
    fAddress: String;
    fDistrict: String;
    fState: String;
    fCity: String;
    fLat: String;
    fLng: String;
    fDDD: String;
    fCityIBGE: String;
  public
    property CEP: String read fCEP write fCEP;
    property AddressType: String read fAddressType write fAddressType;
    property AddressName: String read fAddressName write fAddressName;
    property Address: String read fAddress write fAddress;
    property District: String read fDistrict write fDistrict;
    property State: String read fState write fState;
    property City: String read fCity write fCity;
    property Lat: String read fLat write fLat;
    property Lng: String read fLng write fLng;
    property DDD: String read fDDD write fDDD;
    property CityIBGE: String read fCityIBGE write fCityIBGE;
    constructor Create;
    destructor Destroy; override;
    procedure GetFromJSON(const AJSONString: String);
  end;

implementation

{ TResposta }

constructor TCEP_Resposta.Create;
begin
  fCEP := EmptyStr;
  fAddressType := EmptyStr;
  fAddressName := EmptyStr;
  fAddress := EmptyStr;
  fDistrict := EmptyStr;
  fState := EmptyStr;
  fCity := EmptyStr;
  fLat := EmptyStr;
  fLng := EmptyStr;
  fDDD := EmptyStr;
  fCityIBGE := EmptyStr;
end;

destructor TCEP_Resposta.Destroy;
begin
  inherited;
end;

procedure TCEP_Resposta.GetFromJSON(const AJSONString: String);
var
  JSONObject: TJSONObject;
begin
  JSONObject := TJSONObject.ParseJSONValue(AJSONString) as TJSONObject;
  try
    if Assigned(JSONObject) then
    begin
      Self.fCEP := JSONObject.GetValue<string>('cep', '');
      Self.fAddressType := JSONObject.GetValue<string>('address_type', '');
      Self.fAddressName := JSONObject.GetValue<string>('address_name', '');
      Self.fAddress := JSONObject.GetValue<string>('address', '');
      Self.fDistrict := JSONObject.GetValue<string>('district', '');
      Self.fState := JSONObject.GetValue<string>('state', '');
      Self.fCity := JSONObject.GetValue<string>('city', '');
      Self.fLat := JSONObject.GetValue<string>('lat', '');
      Self.fLng := JSONObject.GetValue<string>('lng', '');
      Self.fDDD := JSONObject.GetValue<string>('ddd', '');
      Self.fCityIBGE := JSONObject.GetValue<string>('city_ibge', '');
    end;
  finally
    JSONObject.Free;
  end;
end;

end.
