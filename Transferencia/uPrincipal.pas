unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, MemDS, DBAccess, Uni, UniProvider, SQLiteUniProvider,
  AdvGlowButton, ExtCtrls, MySQLUniProvider;

type
  TfrmPincipal = class(TForm)
    ConectSQLite: TUniConnection;
    SQLiteUniProvider1: TSQLiteUniProvider;
    qryVPN: TUniQuery;
    dscVPN: TDataSource;
    uOrigem: TUniConnection;
    UniQuery1: TUniQuery;
    uDestino: TUniConnection;
    UniQuery2: TUniQuery;
    Button1: TButton;
    QueryLogin: TUniQuery;
    Panel1: TPanel;
    btnVPN: TAdvGlowButton;
    btnSair: TAdvGlowButton;
    btnLogoff: TAdvGlowButton;
    qryParametros: TUniQuery;
    qryParametrosmetavolume: TFloatField;
    qryParametrosexplicenca: TDateField;
    qryParametroslicenca: TStringField;
    qryParametrosGeraEstoque: TStringField;
    qryParametrosMostraSite: TStringField;
    qryParametrosUsaMontagemNova: TStringField;
    qryParametrosultbackup: TDateTimeField;
    qryParametroschave: TMemoField;
    qryParametrosemailexpiracao: TStringField;
    qryParametrosPedFabril: TStringField;
    qryParametrosusaprogramadepontos: TStringField;
    qryParametroscontacomissao: TIntegerField;
    qryParametroscontavale: TIntegerField;
    qryParametroscontaadmcartao: TIntegerField;
    qryParametroscontajurospagos: TIntegerField;
    qryParametroscontajurosrecebidos: TIntegerField;
    qryParametroscontadescontosconcedidos: TIntegerField;
    qryParametroscontaadiantfornec: TIntegerField;
    qryParametroscontainadimplencia: TIntegerField;
    qryParametroscontcompramercadoria: TIntegerField;
    qryParametrosOpGerCarne: TStringField;
    qryParametrospermitevenderqqpreco: TStringField;
    qryParametrosfotos: TStringField;
    qryParametroscodcli_empresa: TIntegerField;
    qryParametrosCFOPNFConsolidada: TIntegerField;
    qryParamGerais: TUniQuery;
    qryEmpresa: TUniQuery;
    qryEmpresacodempresa: TIntegerField;
    qryEmpresacnpj: TStringField;
    qryEmpresaie: TStringField;
    qryEmpresadtconstituicao: TDateField;
    qryEmpresarazaosocial: TStringField;
    qryEmpresafantasia: TStringField;
    qryEmpresaendereco: TStringField;
    qryEmpresabairro: TStringField;
    qryEmpresacidade: TStringField;
    qryEmpresauf: TStringField;
    qryEmpresacep: TStringField;
    qryEmpresatelefone: TStringField;
    qryEmpresatelefone2: TStringField;
    qryEmpresafax: TStringField;
    qryEmpresaemail: TStringField;
    qryEmpresasocio1: TStringField;
    qryEmpresaenderecosocio1: TStringField;
    qryEmpresabairrosocio1: TStringField;
    qryEmpresacidadesocio1: TStringField;
    qryEmpresacpfsocio1: TStringField;
    qryEmpresaidentidadesocio1: TStringField;
    qryEmpresatelsocio1: TStringField;
    qryEmpresacelsocio1: TStringField;
    qryEmpresaufsocio1: TStringField;
    qryEmpresasocio2: TStringField;
    qryEmpresaenderecosocio2: TStringField;
    qryEmpresacidadesocio2: TStringField;
    qryEmpresabairrosocio2: TStringField;
    qryEmpresacpfsocio2: TStringField;
    qryEmpresaidentidadesocio2: TStringField;
    qryEmpresatelsocio2: TStringField;
    qryEmpresacelsocio2: TStringField;
    qryEmpresaufsocio2: TStringField;
    qryEmpresaempresacont: TStringField;
    qryEmpresaenderecocont: TStringField;
    qryEmpresaempcont: TStringField;
    qryEmpresacepcont: TStringField;
    qryEmpresabairrocont: TStringField;
    qryEmpresacidadecont: TStringField;
    qryEmpresacpfcont: TStringField;
    qryEmpresaidentidadecont: TStringField;
    qryEmpresatelcont: TStringField;
    qryEmpresacelcont: TStringField;
    qryEmpresaufcont: TStringField;
    qryEmpresacontador: TStringField;
    qryEmpresacnpjcont: TStringField;
    qryEmpresacrccont: TStringField;
    qryEmpresaemailcont: TStringField;
    qryEmpresafaxcont: TStringField;
    qryEmpresamensagem: TStringField;
    qryEmpresalogotipo: TStringField;
    qryEmpresaregrecolhimento: TStringField;
    qryEmpresanumerador_dae: TLargeintField;
    qryEmpresacontribuinteipi: TStringField;
    qryEmpresasubstituto: TStringField;
    qryEmpresaPROVIN_FDI: TStringField;
    qryEmpresaPERC_FDI: TFloatField;
    qryEmpresaDT_VENC_FDI: TDateField;
    qryEmpresaCodTransmissorSefaz: TStringField;
    qryEmpresacodmuni_ibge_cont: TIntegerField;
    qryEmpresanumerocont: TIntegerField;
    qryEmpresacomplementocont: TStringField;
    qryEmpresasuframa: TStringField;
    qryEmpresaie_municipal: TStringField;
    qryEmpresaie_subst_tributaria: TStringField;
    qryEmpresaCNAE: TStringField;
    qryEmpresanumero: TStringField;
    qryEmpresacomplemento: TStringField;
    qryEmpresacodpais: TIntegerField;
    qryEmpresaCRT: TIntegerField;
    qryEmpresaCodMunCont: TIntegerField;
    qryEmpresaAliqEspecifica: TStringField;
    qryEmpresaApelido: TStringField;
    qryEmpresaExterior: TStringField;
    MySQLUniProvider1: TMySQLUniProvider;
    AdvGlowButton1: TAdvGlowButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLogoffClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnVPNClick(Sender: TObject);
    procedure AdvGlowButton1Click(Sender: TObject);
  private
    function SoNumeros(const Texto: string): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPincipal: TfrmPincipal;
  FormatoMoeda:String;

implementation

uses frmLogin, uVPN, uTrasf, UModelo;

{$R *.dfm}

procedure TfrmPincipal.AdvGlowButton1Click(Sender: TObject);
begin
try
    frmTrasf:=TfrmTrasf.Create(self);
    frmTrasf.ShowModal;
finally
    FreeAndNil(frmTrasf);
end;
end;

procedure TfrmPincipal.btnLogoffClick(Sender: TObject);
begin
QueryLogin.Close;
  QueryLogin.SQL.Clear;
  Application.CreateForm(TLogin, login);
  Login.ShowModal;
  Login.Destroy;
end;

procedure TfrmPincipal.btnSairClick(Sender: TObject);
begin
close;
end;

procedure TfrmPincipal.btnVPNClick(Sender: TObject);
begin
try
  frmVPN:=tfrmVPN.create(self);
  frmVPN.showmodal;
finally
  FreeAndNil(frmVPN);
end;
end;

procedure TfrmPincipal.Button1Click(Sender: TObject);
begin
if not qryVPN.Active then
       qryVPN.Open;
uDestino.Disconnect;
uDestino.Server:=qryVPN.FieldByName('ip').AsString;

if qryVPN.FieldByName('ip').AsString=uOrigem.Server then
begin
  Application.MessageBox('Os bancos de dados est�o no mesmo endere�o','Aten��o',MB_ICONERROR);
  Exit;
end;

   try
     uDestino.Connect;
   except
     Application.MessageBox(pchar( 'N�o foi poss�vel conectar no banco de dadeos DESTINO: '+#13+#13+qryVPN.FieldByName('ip').AsString)

     ,'Aten��o',MB_ICONEXCLAMATION);
   end;

end;

function TfrmPincipal.SoNumeros(const Texto: string): string;
var
  vContString: integer;
  vString: string;
begin
  vString := '';
  for vContString := 1 to Length(Texto) do
  begin
    if (Texto[vContString] in ['0'..'9']) then
    begin
      vString := vString + Copy(Texto, vContString, 1);
    end;
  end;

  if vString <> '' then
    result := vString
  else
    result := '00000000000';

end;

procedure TfrmPincipal.FormCreate(Sender: TObject);
var
 diretorio,linha  : string;
 arq: textFile;
begin
{$Region 'Porta do banco de Dados'}
diretorio := ExtractFileDir(Application.ExeName) + '\porta.txt';
if not FileExists(diretorio) then
begin
    diretorio := 'c:\bkp\porta.txt';
end;

if FileExists(diretorio) then
  begin
 AssignFile(arq, diretorio);
 Reset(arq);
 Readln(arq, linha);


  uOrigem.Port :=StrToInt(SoNumeros(linha));
  CloseFile(arq);
  end;
{$EndRegion}

//Endere�o do banco
diretorio := ExtractFileDir(Application.ExeName) + '\sys.txt';
if not FileExists(diretorio) then
begin
    diretorio := 'c:\bkp\sys.txt';
end;

if FileExists(diretorio) then
  begin
 AssignFile(arq, diretorio);
 Reset(arq);
 Readln(arq, linha);

 {Ler linha e colocar o valor do host para onde est� o banco de dados}
  uOrigem.Server := linha;

  CloseFile(arq);
  end;

if not FileExists(diretorio) then
begin
  Application.MessageBox('Arquivo SYS.TXT n�o encontrado','Aten��o',MB_ICONEXCLAMATION);
  Application.Terminate;
end;


if FileExists('c:\bkp\vpn.db') then
begin
  try
  ConectSQLite.Connect;
  qryVPN.open;
  except
    on E: Exception do
    Application.MessageBox(PChar('N�o foi poss�vel acessar o banco de dados da VPN: '+E.Message),'Aten��o',MB_ICONEXCLAMATION);
  end;
end;
 qryEmpresa.Open;
end;

procedure TfrmPincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_escape then
   btnSair.Click;
end;

end.
