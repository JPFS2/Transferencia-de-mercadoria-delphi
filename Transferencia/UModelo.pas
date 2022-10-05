unit UModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,printers,Registry,ShellAPI, DB, WinInet,
  ShlObj, ActiveX, ComObj, OleCtrls, SHDocVw, RDprint,UrlMon, StdCtrls, Mask,
  DBCtrls, AdvOfficeStatusBar,
  cxLookAndFeels, ImgList, cxGraphics, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdFTP, MemDS,
  DBAccess, Uni ,StrUtils, DASQLMonitor, UniSQLMonitor,IdHTTP, ACBrBase,
  ACBrMail,ACBrDownload, ACBrBoletoConversao,ACBrBoleto,ACBrUtil,
  mimemess, ACBrBoletoFCFortesFr
  //,System.Notification
  ;

type
  TFormato = (CNPJ, CPF, InscricaoEstadual, CNPJorCPF, TelefoneFixo, Celular, Personalizado,
                Valor, Money, CEP, Dt, Peso);
  TfrmModelo = class(TForm)

    Panel1: TPanel;
    Panel2: TPanel;
    pstatus: TAdvOfficeStatusBar;
    ImagensHot: TcxImageList;
    Imagens: TcxImageList;
    IdFTP: TIdFTP;
    qryEu: TUniQuery;
    qryRotina: TUniQuery;
    UniSQLMonitor1: TUniSQLMonitor;
    EnviarMail: TACBrMail;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    function TraduzirEspanhol(Texto: String): String;
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    procedure WMMove(var Msg: TWMMove); message WM_MOVE;
    function Notificacao(NOME, TITULO, MENSAGEM: string): boolean;



  public
    { Public declarations }
//    function GravaNossoNumero(Codbanco, Numped, str: String): String;
    function TrocaVirgula ( str: String ): String;
    function RetiraPonto( v:string):STRING;
    function LimpaCPF_CNPJ( str: String ): String;
    function ExtractWindowsDir : String;//Acha o Diret�rio do Windows
    procedure EscondeTaskBar(Visible: Boolean);
    procedure PontoDecimal(var Key: char; cValor: string);//Venda Fracionada
    procedure PontoInteiro(var Key: char; cValor: string);//Venda Inteiro
    Function ArredondarVendaMeia(value: string): string;
    procedure TrimAppMemorySize; //Melhora a memoria
    function CorrentPrinter :String; {Retona a impessora padr�o do Windows}
    function NumeroSerie(Unidade:PChar):String;
    procedure bloquearUSB;
    Procedure desbloquearUSB;
    Procedure MapearUnidadeRede;
    function SysWinDir: string;
    function SysTempDir: string;
    function SysUserName: string;
    function RetiraAcentuacao ( str: String ): String;
    FUNCTION RemoveZeros(S: string): string;//Romove zeros a esquerda e espa�os em branco
    function SoNumeros(Const Texto:String):String;
    procedure ConsertaCustos;
    procedure Pinta(Sender: TObject);
    PROCEDURE InsereReplica;
    function ENumero( cCampo: variant): boolean;
    procedure BaixarAquivo(Arquivo, Dest: string);

    //function Dias_Uteis(DataI, DataF:TDateTime):Integer;
    function RetiraMarcas(const StrTxt: String): String;
    Function DifDateUtil(dataini,datafin:string):integer;
    function UltimoDiaMes(Mdt: TDateTime) : TDateTime;
    function DetectarInternet: Boolean;
    procedure CriarAtalho(ANomeArquivo, AParametros, ADiretorioInicial,
    ANomedoAtalho, APastaDoAtalho: string);
    procedure ExecutePrograma(Nome, Parametros: String);
    procedure ShowFolder(strFolder: string); //Abre pasta do windows
    procedure CorrigeUnidadeMedida;
    Function Func_getComputerName(): String;  //Pega o nome do computador
    procedure ListarArquivos(Diretorio: string; Sub:Boolean);
    function DownloadFile(Source, Dest: string): Boolean;
    function moeda(moeda: String): String;
    function lpad(str: String;tamano: integer;caracter: String): String;
    procedure FreeMemAndNil(var ptr; size: Integer = -1);
    procedure BaixaUnico;
    procedure DeletaArqTemporarios;
    procedure FechaQuery;
    procedure FechaTables;
    Function ImpressoraPadrao : string;
    procedure FormataNumeroQuery;
    procedure FormataNumeroTable;
    function AdicionaMinuto (const DT: TDateTime; const Mnts: Extended): TDateTime;
    function AdicionaHora (const DT: TDateTime; const Hrs: Extended): TDateTime;
    function AdicionaDia (const DT: TDateTime; const Ds: Extended): TDateTime;
    procedure ImprimirMemo(Memo: TMemo);
    Function Arredondar(value: double;casas : integer): double;
    Function DifHora(Inicio,Fim : String):String;
    function ValidarChaveNFe(const ChaveNFe: string):boolean;
    function MySqlDate(data1 : string):string;
    procedure ConfiguraEmail;
    procedure BuscaCNPJReceitaWS(CNPJ: String; var RazaoSocial,
      NomeFantasia, Endereco, Numero, Bairro, Complemento, CEP: string);
    Function DatafinalDiasUteis(dataini:tdatetime; dias_uteis:integer):tdatetime;
    //Function UltimoDiaDoMes( MesAno: string ): string;
    procedure ImprimirBoletos(NumCareg,NumPedido,CodRecebimento: integer);
    Function CriticarCadastroCliente(codcliente: integer):boolean;
    procedure ModeloImpressora;
    function GetDefaultPrinterName : string;
    procedure Formatar(Obj: TObject; Formato : TFormato; Extra : string = '');
    function FormataValor(str : string) : string;
    function FormataPeso(str : string) : string;
    function Mask(Mascara, Str : string) : string;
    function FormataIE(Num, UF: string): string;
    function FormataData(str : string): string;

    procedure IncluirLinha(qt: integer; Relatorio: TRDPrint);
  end;

var
  frmModelo: TfrmModelo;
  linha:integer;
  traco,traco2,TracoMaior:string;
  MemoryStatus: TMemoryStatus;
  MBTotal : Integer;
  PCUso : Integer;
  PCLivre : Integer;
  MBUso : Integer;
  MBLivre : Integer;
  FreeAvailable,TotalSpace,TotalFree : Int64;
  Diretorio,NomeDoArquivo: string;
  xNomeImpressora: String;

  iBal_time: integer; // configuracao de time out da balanca
  sBal_Resposta: string; // resposta da balanca
  rBal_peso: real; // peso lido na balanca


implementation

uses  UPrincipal, frmLogin;

{$R *.dfm}
{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}

procedure TfrmModelo.IncluirLinha(qt:integer;Relatorio: TRDPrint);
begin
    Inc(linha,qt);
    if linha>88 then
    begin
      Relatorio.Novapagina;
      linha:=6;
    end;
end;

function TfrmModelo.AdicionaDia(const DT: TDateTime;
  const Ds: Extended): TDateTime;
begin
  Result := DT + Ds;
end;

function TfrmModelo.AdicionaHora(const DT: TDateTime;
  const Hrs: Extended): TDateTime;
begin
  Result := (DT + Hrs / 24);
end;

function TfrmModelo.AdicionaMinuto(const DT: TDateTime;
  const Mnts: Extended): TDateTime;
begin
   Result := (DT + Mnts / 1440.0);
end;


function TfrmModelo.FormataData(str: string): string;
begin
    str := Copy(str, 1, 8);

    if Length(str) < 8 then
        Result := Mask('##/##/####', str)
    else
    begin
        try
            str := Mask('##/##/####', str);
            strtodate(str);
            Result := str;
        except
            Result := '';
        end;
    end;
end;

function TfrmModelo.FormataIE(Num, UF: string): string;
var
    Mascara : string;
begin
    Mascara := '';
    IF UF = 'AC' Then Mascara := '##.###.###/###-##';
    IF UF = 'AL' Then Mascara := '#########';
    IF UF = 'AP' Then Mascara := '#########';
    IF UF = 'AM' Then Mascara := '##.###.###-#';
    IF UF = 'BA' Then Mascara := '######-##';
    IF UF = 'CE' Then Mascara := '########-#';
    IF UF = 'DF' Then Mascara := '###########-##';
    IF UF = 'ES' Then Mascara := '#########';
    IF UF = 'GO' Then Mascara := '##.###.###-#';
    IF UF = 'MA' Then Mascara := '#########';
    IF UF = 'MT' Then Mascara := '##########-#';
    IF UF = 'MS' Then Mascara := '#########';
    IF UF = 'MG' Then Mascara := '###.###.###/####';
    IF UF = 'PA' Then Mascara := '##-######-#';
    IF UF = 'PB' Then Mascara := '########-#';
    IF UF = 'PR' Then Mascara := '########-##';
    IF UF = 'PE' Then Mascara := '##.#.###.#######-#';
    IF UF = 'PI' Then Mascara := '#########';
    IF UF = 'RJ' Then Mascara := '##.###.##-#';
    IF UF = 'RN' Then Mascara := '##.###.###-#';
    IF UF = 'RS' Then Mascara := '###/#######';
    IF UF = 'RO' Then Mascara := '###.#####-#';
    IF UF = 'RR' Then Mascara := '########-#';
    IF UF = 'SC' Then Mascara := '###.###.###';
    IF UF = 'SP' Then Mascara := '###.###.###.###';
    IF UF = 'SE' Then Mascara := '#########-#';
    IF UF = 'TO' Then Mascara := '###########';

    Result := Mask(mascara, Num);

end;

procedure TfrmModelo.FormataNumeroQuery;
var
I,J : integer;
begin

for I := 0 to ComponentCount - 1 do begin
   if Components[I] is TDataSet then begin
     with TDataSet(Components[I]) do begin
       for J := 0 to Fields.Count - 1 do begin
        if (Fields[J] is TFloatField) or (Fields[J] is TBCDField) then
        if FormatoMoeda='##,##0.00' then
          TNumericField(Fields[J]).DisplayFormat := ',0.00;-,0.00'
          ELSE
          TNumericField(Fields[J]).DisplayFormat := ',0;-,0';
       end;
     end;
   end;
  end;

end;

procedure TfrmModelo.FormataNumeroTable;
var
I,J : integer;
begin

for I := 0 to ComponentCount - 1 do begin
   if Components[I] is TDataSet then begin
     with TDataSet(Components[I]) do begin
       for J := 0 to Fields.Count - 1 do begin
        if (Fields[J] is TFloatField) or (Fields[J] is TBCDField) then
        if FormatoMoeda='##,##0.00' then
          TNumericField(Fields[J]).DisplayFormat := '0.00'
          ELSE
          TNumericField(Fields[J]).DisplayFormat := '0';
       end;
     end;
   end;
  end;

end;

function TfrmModelo.FormataPeso(str: string): string;
begin
    if Str=NullAsStringValue then
        Str := '0';

    try
        Result := FormatFloat('#,##0.000', strtofloat(str) / 1000);
    except
        Result := FormatFloat('#,##0.000', 0);
    end;


end;

procedure TfrmModelo.Formatar(Obj: TObject; Formato: TFormato; Extra: string);
var
    texto : string;
begin
  //  TThread.Queue(Nil, procedure
  //  begin
        if obj is TEdit then
            texto := TEdit(obj).Text;

        // Telefone Fixo...
        if formato = TelefoneFixo then
            texto := Mask('(##) ####-####', SoNumeros(texto));

        // Celular...
        if formato = Celular then
            texto := Mask('(##) #####-####', SoNumeros(texto));

        // CNPJ...
        if formato = CNPJ then
            texto := Mask('##.###.###/####-##', SoNumeros(texto));

        // CPF...
        if formato = CPF then
            texto := Mask('###.###.###-##', SoNumeros(texto));

        // Inscricao Estadual (IE)...
        if formato = InscricaoEstadual then
            texto := FormataIE(SoNumeros(texto), Extra);

        // CNPJ ou CPF...
        if formato = CNPJorCPF then
            if Length(SoNumeros(texto)) <= 11 then
                texto := Mask('###.###.###-##', SoNumeros(texto))
            else
                texto := Mask('##.###.###/####-##', SoNumeros(texto));

        // Personalizado...
        if formato = Personalizado then
            texto := Mask(Extra, SoNumeros(texto));

        // Valor...
        if Formato = Valor then
            texto := FormataValor(SoNumeros(texto));

        // Money (com simbolo da moeda)...
        if Formato = Money then
        begin
//            if Extra = '' then
//                Extra := 'R$';

            texto := Extra + ' ' + FormataValor(SoNumeros(texto));
        end;

        // CEP...
        if Formato = CEP then
            texto := Mask('##.###-###', SoNumeros(texto));

        // Data...
        if formato = Dt then
            texto := FormataData(SoNumeros(texto));

        // Peso...
        if Formato = Peso then
            texto := FormataPeso(SoNumeros(texto));


        if obj is TEdit then
        begin
            TEdit(obj).Text := texto;
            TEdit(obj).SelStart := Length(TEdit(obj).Text);
        end;

//    end);


end;

function TfrmModelo.FormataValor(str: string): string;
begin
    if Str = '' then
        Str := '0';

    try
        Result := FormatFloat('#,##0.00', strtofloat(str) / 100);
    except
        Result := FormatFloat('#,##0.00', 0);
    end;

end;

function TfrmModelo.ImpressoraPadrao: string;
begin //Uses Printers
if(Printer.PrinterIndex > 0)then
  begin
  Result := Printer.Printers[Printer.PrinterIndex];
  end
else
  begin
  Result := 'Nenhuma impressora Padr�o foi detectada';
  end;
end;

Function TfrmModelo.Notificacao(NOME,TITULO,MENSAGEM:string):boolean;
var
qrNotificacao : TUniQuery;
//MyNotification: TNotification;
//NC            : TNotificationCenter;
begin
 { try

  qrNotificacao := frmPincipal.UniConnection1;
  NC := TNotificationCenter.Create(nil);

      IF (NOME <> '') AND (TITULO <> '') AND (MENSAGEM <> '') THEN
      BEGIN

        qrNotificacao.close;
        qrNotificacao.SQL.Clear;
        qrNotificacao.SQL.Add('INSERT INTO NOTIFICACAO (NOME, TITULO, MENSAGEM) VALUES (:NOME, :TITULO, :MENSAGEM)');
        qrNotificacao.ParamByName('NOME').AsString     := NOME;
        qrNotificacao.ParamByName('TITULO').AsString   := TITULO;
        qrNotificacao.ParamByName('MENSAGEM').AsString := MENSAGEM;
        qrNotificacao.ExecSQL;
      END
      ELSE
      BEGIN
        qrNotificacao.close;
        qrNotificacao.SQL.Clear;
        qrNotificacao.SQL.Add('SELECT FIRST 1  * FROM NOTIFICACAO WHERE STATUS = 0');
        qrNotificacao.Open;

        IF NOT qrNotificacao.IsEmpty THEN
        BEGIN
          MyNotification := NC.CreateNotification;
          try
            MyNotification.Name      := qrNotificacao.FieldByNAme('NOME').AsString;
            MyNotification.Title     := qrNotificacao.FieldByNAme('TITULO').AsString;
            MyNotification.AlertBody := qrNotificacao.FieldByNAme('MENSAGEM').AsString;;

            NC.PresentNotification(MyNotification);
          finally
            MyNotification.Free;
            var id:Integer;
            id := qrNotificacao.FieldByNAme('ID').AsInteger;
            qrNotificacao.close;
            qrNotificacao.SQL.Clear;
            qrNotificacao.SQL.Add('UPDATE NOTIFICACAO SET STATUS = 1 WHERE ID = :ID');
            qrNotificacao.ParamByName('ID').AsInteger   := id;
            qrNotificacao.ExecSQL;
          end;
        END;

      END;
     result := true;
    finally
   FreeAndNil(qrNotificacao);
   FreeAndNil(NC);
   FreeAndNil(vConLocal);
  end; }
end;


procedure TfrmModelo.ImprimirBoletos(NumCareg, NumPedido,
  CodRecebimento: integer);
var
  Titulo: TACBrTitulo;
  cedente:TACBrCedente;
  MinhaMensagem: string;
  qryBoleto,QryBanco,qryEmpresa,qryParametos: TUniQuery;
  Boleto: TACBrBoleto;
  FCFortes:TACBrBoletoFCFortes;
  i: integer;
  LogoMarca: string;
begin
i:=0;
{$Region 'Cria os objetos'}
Boleto:=TACBrBoleto.Create(nil);
FCFortes:=TACBrBoletoFCFortes.Create(nil);

QryBanco:=TUniQuery.Create(nil);
qryEmpresa:=TUniQuery.Create(nil);
qryParametos:=TUniQuery.Create(nil);


qryParametos.SQL.Text :='select * from cadparametos where codfilial='+CODFILIAL;
qryEmpresa.SQL.Text   :='select * from cadempresa where codempresa='+CODFILIAL;
QryBanco.SQL.Text     :='select * from cadbanco WHERE numbancoCob<>''0''';
{$EndRegion}
  {$Region 'Queries'}
if QryBanco.Active=true then
     QryBanco.Refresh
     else
     QryBanco.Open;

  if qryEmpresa.Active=true then
     qryEmpresa.Refresh
     else
     qryEmpresa.Open;

  if not qryParametos.Active then
     qryParametos.Open
     else
     qryParametos.Refresh;

      qryBoleto.Close;
      qryBoleto.SQL.Clear;
      qryBoleto.SQL.Add('select cadcliente.endereco,cadcliente.cep,');
      qryBoleto.SQL.Add('contasreceber.ValorAbatimento, contasreceber.vlliq,');
      qryBoleto.SQL.Add('cadcliente.cliente, contasreceber.NossoNumero,cadcliente.endereco,cadcliente.numero,');
      qryBoleto.SQL.Add('cadcliente.bairro,cadcliente.cidade,cadcliente.cep, cadcliente.uf, if(LENGTH(ifnull(cadcliente.cpf,0))<15,  cadcliente.cpf, cadcliente.cnpj) cnpj,');
      qryBoleto.SQL.Add('contasreceber.TxJuros,contasreceber.numped,contasreceber.dtprocessamento,contasreceber.carteira,');
      qryBoleto.SQL.Add('contasreceber.parcela,contasreceber.especie,contasreceber.dtfaturamento,');
      qryBoleto.SQL.Add('contasreceber.dtvencimento, contasreceber.localpgto,contasreceber.aceite,contasreceber.multa,');
      qryBoleto.SQL.Add('contasreceber.mensagem01,contasreceber.mensagem02,contasreceber.mensagem03,contasreceber.mensagem04');
      qryBoleto.SQL.Add('from contasreceber,cadcliente');
      qryBoleto.SQL.Add('where contasreceber.codcli=cadcliente.codcli');

      if NumPedido>0 then
         qryBoleto.SQL.Add('and contasreceber.numped='+IntToStr(NumPedido));
      if NumCareg<>0 then
         qryBoleto.SQL.Add('and contasreceber.codlote='+IntToStr(NumCareg));
      if CodRecebimento>0 then
         qryBoleto.SQL.Add('and contasreceber.codrec='+IntToStr(CodRecebimento));

      qryBoleto.SQL.Add('and contasreceber.moeda in (');
      qryBoleto.SQL.Add(' select codmoeda from cadmoeda where tipo=''DS'''+')');
      qryBoleto.SQL.Add('order by contasreceber.codrec');
      qryBoleto.Open;
    {$EndRegion}

     {$Region 'SelecionarBanco'};
     if (QryBanco.FieldByName('numbancoCob').Value=Null) or
   (QryBanco.FieldByName('numbancoCob').Value=0   ) then
begin
Application.MessageBox('Banco Emiss�o DUPLICATA n�o informado no sistema','Aten��o',MB_ICONWARNING);
Exit;
end;


case QryBanco.FieldByName('numbancoCob').Value of

00 :Boleto.Banco.TipoCobranca:=    cobNenhum;
01 :Boleto.Banco.TipoCobranca:=    cobBancoDoBrasil;
02 :Boleto.Banco.TipoCobranca:=    cobSantander;
03 :Boleto.Banco.TipoCobranca:=    cobCaixaEconomica;
04 :Boleto.Banco.TipoCobranca:=    cobCaixaSicob;
05 :Boleto.Banco.TipoCobranca:=    cobBradesco;
06 :Boleto.Banco.TipoCobranca:=    cobItau;
07 :Boleto.Banco.TipoCobranca:=    cobBancoMercantil;
08 :Boleto.Banco.TipoCobranca:=    cobSicred;
09 :Boleto.Banco.TipoCobranca:=    cobBancoob;
10 :Boleto.Banco.TipoCobranca:=    cobBanrisul;
11 :Boleto.Banco.TipoCobranca:=    cobBanestes;
12 :Boleto.Banco.TipoCobranca:=    cobHSBC;
13 :Boleto.Banco.TipoCobranca:=    cobBancoDoNordeste;
14 :Boleto.Banco.TipoCobranca:=    cobBRB;
15 :Boleto.Banco.TipoCobranca:=    cobBicBanco;
16 :Boleto.Banco.TipoCobranca:=    cobBradescoSICOOB;
17 :Boleto.Banco.TipoCobranca:=    cobBancoSafra;
18 :Boleto.Banco.TipoCobranca:=    cobSafraBradesco;
19 :Boleto.Banco.TipoCobranca:=    cobBancoCECRED;
20 :Boleto.Banco.TipoCobranca:=    cobBancoDaAmazonia;
21 :Boleto.Banco.TipoCobranca:=    cobBancoDoBrasilSICOOB;
end;
LogoMarca:=ExtractFileDir(Application.ExeName)+'\LogoBancos\'+FormatFloat('000',QryBanco.FieldByName('numbanco').Value)+'.bmp';

//if FilesExists(LogoMarca) then
   try
   FCFortes.DirLogo:=ExtractFileDir(Application.ExeName)+'\LogoBancos\';
   except
   FCFortes.DirLogo:='';
   end;

case QryBanco.FieldByName('numbancoCob').Value of

00 :Boleto.Banco.TipoCobranca:=    cobNenhum;
01 :Boleto.Banco.TipoCobranca:=    cobBancoDoBrasil;
02 :Boleto.Banco.TipoCobranca:=    cobSantander;
03 :Boleto.Banco.TipoCobranca:=    cobCaixaEconomica;
04 :Boleto.Banco.TipoCobranca:=    cobCaixaSicob;
05 :Boleto.Banco.TipoCobranca:=    cobBradesco;
06 :Boleto.Banco.TipoCobranca:=    cobItau;
07 :Boleto.Banco.TipoCobranca:=    cobBancoMercantil;
08 :Boleto.Banco.TipoCobranca:=    cobSicred;
09 :Boleto.Banco.TipoCobranca:=    cobBancoob;
10 :Boleto.Banco.TipoCobranca:=    cobBanrisul;
11 :Boleto.Banco.TipoCobranca:=    cobBanestes;
12 :Boleto.Banco.TipoCobranca:=    cobHSBC;
13 :Boleto.Banco.TipoCobranca:=    cobBancoDoNordeste;
14 :Boleto.Banco.TipoCobranca:=    cobBRB;
15 :Boleto.Banco.TipoCobranca:=    cobBicBanco;
16 :Boleto.Banco.TipoCobranca:=    cobBradescoSICOOB;
17 :Boleto.Banco.TipoCobranca:=    cobBancoSafra;
18 :Boleto.Banco.TipoCobranca:=    cobSafraBradesco;
19 :Boleto.Banco.TipoCobranca:=    cobBancoCECRED;
20 :Boleto.Banco.TipoCobranca:=    cobBancoDaAmazonia;
21 :Boleto.Banco.TipoCobranca:=    cobBancoDoBrasilSICOOB;
end;



//Dados do Cedente
Boleto.Cedente.Convenio        :=QryBanco.FieldByName('Convennio').AsString;
Boleto.Cedente.Agencia         :=QryBanco.FieldByName('agencia').AsString;
Boleto.Cedente.AgenciaDigito   :=QryBanco.FieldByName('DigitoAgencia').AsString;
Boleto.Cedente.Conta           :=QryBanco.FieldByName('contacorrente').AsString;
Boleto.Cedente.ContaDigito     :=QryBanco.FieldByName('DigConta').AsString;
//Dados da Empresa
Boleto.Cedente.Nome            :=qryEmpresa.FieldByName('razaosocial').AsString;
Boleto.Cedente.FantasiaCedente :=qryEmpresa.FieldByName('fantasia').AsString;
Boleto.Cedente.CNPJCPF         :=qryEmpresa.FieldByName('cnpj').AsString;
Boleto.Cedente.Logradouro      :=qryEmpresa.FieldByName('endereco').AsString;
Boleto.Cedente.NumeroRes       :=qryEmpresa.FieldByName('numero').AsString;
Boleto.Cedente.Complemento     :=qryEmpresa.FieldByName('complemento').AsString;
Boleto.Cedente.Bairro          :=qryEmpresa.FieldByName('bairro').AsString;
Boleto.Cedente.Cidade          :=qryEmpresa.FieldByName('cidade').AsString;
Boleto.Cedente.UF              :=qryEmpresa.FieldByName('uf').AsString;
Boleto.Cedente.CEP             :=qryEmpresa.FieldByName('cep').AsString;
Boleto.Cedente.Telefone        :=qryEmpresa.FieldByName('telefone').AsString;
{$EndRegion}

//Acha os boletos

  qryBoleto:=TUniQuery.Create(nil);
  qryBoleto.Connection:=frmPincipal.uOrigem;
  qryBoleto.Close;
  qryBoleto.SQL.Clear;
  qryBoleto.SQL.Add('select cadcliente.endereco,cadcliente.cep,');
  qryBoleto.SQL.Add('contasreceber.ValorAbatimento, contasreceber.vlliq,');
  qryBoleto.SQL.Add('cadcliente.cliente, contasreceber.NossoNumero,cadcliente.endereco,cadcliente.numero,');
  qryBoleto.SQL.Add('cadcliente.bairro,cadcliente.cidade,cadcliente.cep, cadcliente.uf, if(LENGTH(ifnull(cadcliente.cpf,0))<15,  cadcliente.cpf, cadcliente.cnpj) cnpj,');
  qryBoleto.SQL.Add('contasreceber.TxJuros,contasreceber.numped,contasreceber.dtprocessamento,contasreceber.carteira,');
  qryBoleto.SQL.Add('contasreceber.parcela,contasreceber.especie,contasreceber.dtfaturamento,');
  qryBoleto.SQL.Add('contasreceber.dtvencimento, contasreceber.localpgto,contasreceber.aceite,contasreceber.multa,');
  qryBoleto.SQL.Add('contasreceber.mensagem01,contasreceber.mensagem02,contasreceber.mensagem03,contasreceber.mensagem04');
  qryBoleto.SQL.Add('from contasreceber,cadcliente');
  qryBoleto.SQL.Add('where contasreceber.codcli=cadcliente.codcli');

  if NumPedido>0 then
    qryBoleto.SQL.Add('and contasreceber.numped='+IntToStr(NumPedido));
  if NumCareg<>0 then
    qryBoleto.SQL.Add('and contasreceber.codlote='+IntToStr(NumCareg));

    qryBoleto.SQL.Add('and contasreceber.moeda in (');
    qryBoleto.SQL.Add(' select codmoeda from cadmoeda where tipo=''DS'''+')');
    qryBoleto.SQL.Add('order by contasreceber.codrec');
    qryBoleto.Open;

  qryBoleto.Open;
  if qryBoleto.RecordCount=0 then
  begin
    Application.MessageBox('N�o BOLETO a ser impresso','Aten��o',MB_ICONEXCLAMATION);
    FreeAndNil(qryBoleto);
    Exit;
  end;

Boleto.ListadeBoletos.Clear;
cedente:=Boleto.Cedente;

Titulo := Boleto.CriarTituloNaLista;
  while not qryBoleto.Eof do
  begin
  {$Region 'Dados do Cliente e Cedente'}
  with Titulo do
    begin
     if qryBoleto.FieldByName('aceite').AsString='S' then
         Aceite            := atSim
         else
         Aceite            := atNao;

      LocalPagamento    := RetiraAcentuacao(qryBoleto.FieldByName('localpgto').AsString);// 'Pagar prefer�ncialmente nas ag�ncias do Bradesco'; // MEnsagem exigida pelo bradesco
      Vencimento        := qryBoleto.FieldByName('dtvencimento').Value;/// IncMonth(EncodeDate(2010, 05, 10), I);
      DataDocumento     := StrToDate(FormatDateTime('dd/mm/yyyy', qryBoleto.FieldByName('dtfaturamento').AsDateTime));
      NumeroDocumento   := qryBoleto.FieldByName('numped').AsString+' | '+ qryBoleto.FieldByName('parcela').AsString;/// PadRight(IntToStr(I), 6, '0');
      EspecieDoc        := qryBoleto.FieldByName('especie').AsString;/// 'DM';

      DataProcessamento := qryBoleto.FieldByName('dtprocessamento').AsDateTime;// Now;
      Carteira          := qryBoleto.FieldByName('carteira').AsString; //'09';
      NossoNumero       := qryBoleto.FieldByName('NossoNumero').AsString;//IntToStrZero(qryBoleto.FieldByName('NossoNumero').AsInteger, ACBrBoleto1.Banco.TamanhoMaximoNossoNum);
      ValorDocumento    := qryBoleto.FieldByName('vlliq').AsFloat;  // 100.35 * (I + 0.5);
      Sacado.NomeSacado := RetiraAcentuacao(qryBoleto.FieldByName('cliente').AsString); //'Jose Luiz Pedroso';
      Sacado.CNPJCPF    := qryBoleto.FieldByName('cnpj').AsString;// '12345678901';
      Sacado.Logradouro := RetiraAcentuacao(qryBoleto.FieldByName('endereco').AsString);// Rua da Consolacao';
      Sacado.Numero     := RetiraAcentuacao(qryBoleto.FieldByName('numero').AsString);//'100';
      Sacado.Bairro     := RetiraAcentuacao(qryBoleto.FieldByName('bairro').AsString);//'Vila Esperanca';
      Sacado.Cidade     := RetiraAcentuacao(qryBoleto.FieldByName('cidade').AsString);//'Tatui';
      Sacado.UF         := RetiraAcentuacao(qryBoleto.FieldByName('uf').AsString);//'SP';
      Sacado.CEP        := qryBoleto.FieldByName('cep').AsString;//'18270000';
      cedente.Modalidade:='19';
      ValorAbatimento   := qryBoleto.FieldByName('ValorAbatimento').Value;
      ValorMoraJuros    := StrToCurrDef(qryBoleto.FieldByName('TxJuros').AsString, 0);
      CodigoMora        := '2';
      MultaValorFixo    := False;
      //DataMoraJuros
//      CodigoMoraJuros   := cjTaxaMensal;
      CodigoMoraJuros   := cjTaxaMensal;
      DataMulta         := (qryBoleto.FieldByName('dtvencimento').AsDateTime);
      CodigoMulta       := cmPercentual;

      PercentualMulta   := StrToCurrDef(qryBoleto.FieldByName('Multa').AsString, 0);
      Instrucao1        := PadRight(trim(qryBoleto.FieldByName('mensagem01').AsString), 2, '0');
      Instrucao2        := PadRight(trim(qryBoleto.FieldByName('mensagem01').AsString), 2, '0');
      Instrucao3        := PadRight(trim(qryBoleto.FieldByName('mensagem03').AsString), 2, '0');

      Mensagem.Clear;
      Mensagem.Add(qryBoleto.FieldByName('mensagem01').AsString);
      Mensagem.Add(qryBoleto.FieldByName('mensagem02').AsString);
      Mensagem.Add(qryBoleto.FieldByName('mensagem03').AsString);
      Mensagem.Add(qryBoleto.FieldByName('mensagem04').AsString);

    end;
    {$EndRegion}

  {$Region 'Layout do Boleto'}
      case QryBanco.FieldByName('LayoutImpBoleto').Value of
        0 : Boleto.ACBrBoletoFC.LayOut := lPadrao;
        1 : Boleto.ACBrBoletoFC.LayOut := lCarne;
        2 : Boleto.ACBrBoletoFC.LayOut := lFatura;
        3 : Boleto.ACBrBoletoFC.LayOut := lPadraoEntrega;
        4 : Boleto.ACBrBoletoFC.LayOut := lReciboTopo;
        5 : Boleto.ACBrBoletoFC.LayOut := lPadraoEntrega2;
        6 : Boleto.ACBrBoletoFC.LayOut := lFaturaDetal;
      end;
  {$EndRegion}


      Boleto.Imprimir;

      qryBoleto.Next;
      Application.ProcessMessages;
    end;

  FreeAndNil(qryBoleto);
  FreeAndNil(QryBanco);
  FreeAndNil(qryEmpresa);
  FreeAndNil(Boleto);
  FreeAndNil(FCFortes);
end;

procedure TfrmModelo.ImprimirMemo(Memo: TMemo);
var
  I: integer;
  F: TextFile;

begin

  { Usa na impressora a mesma fonte do memo }
  {informar Printers em uses}



  Printer.PrinterIndex := Printer.Printers.IndexOf(xNomeImpressora);
  Printer.Canvas.Font.Assign(Memo.Font);

  AssignPrn(F);
  Rewrite(F);
  try
    for I := 0 to Memo.Lines.Count -1 do
      WriteLn(F, Memo.Lines[I]);
  finally
    CloseFile(F);
  end;

  {if frmPincipal.qryEmpresa.FieldByName('cnpj').AsString='21.800.900/0001-93' then
  begin
  xNomeImpressora:='EPSON L355 Series';
  Printer.PrinterIndex := Printer.Printers.IndexOf(xNomeImpressora);
  end;}

end;

function TfrmModelo.Arredondar(value: double; casas: integer): double;
Var
fracao, Total:currency;
decimal:string;
begin
  try
    fracao := Frac(value); //Retorna a parte fracion�ria de um n�mero
    decimal := (RightStr(floattostr(fracao), length(floattostr(fracao)) - 2)); //decimal recebe a parte decimal
    if decimal = '' then
      decimal:='0';
//Enquanto o tamanho da variavel decimal for maior que o n�mero de casas fa�a
    while length(decimal) > casas do
    begin
      //Verifica se o �ltimo digito da vari�vel decimal � maior que 5
      if strtoint(RightStr(decimal, 1)) >= 5 then
      begin
      //Descarta o �ltimo digito da vari�vel Decimal
        decimal := leftstr(decimal, length(decimal) - 1);
      //Soma o valor n�mero da variavel decimal + 1
        decimal := floattostr(strtofloat(decimal) + 1);
      end
      else
        decimal := leftstr(decimal, length(decimal) - 1); //Descarta o �ltimo digito da vari�vel Decimal
    end;
    result := (int(value) + (strtofloat(decimal) / 100)); //devolve o resultado para a fun��o
  except
    raise Exception.Create('Erro no arredondamento');
  end;

end;

function TfrmModelo.ArredondarVendaMeia(value: string): string;
var
ValorOrig,Fracao,Inteiro,ValorFinal: double;

begin

//Colhe os valores
ValorOrig:=StrToFloat(value);
Fracao:=Frac(ValorOrig);
Inteiro:=ValorOrig-Fracao;

//Testa as Fra��es
if fracao>0.5 then
begin
  ValorFinal:=Inteiro+1;
end;

if fracao<0.5 then
begin
  ValorFinal:=(Inteiro);
end;

if Fracao=0.5 then
begin
  ValorFinal:=ValorOrig;
end;
 Result:=FloatToStr(ValorFinal);

end;

procedure TfrmModelo.BaixaUnico;
var
  I: Integer;
  Lista: TStringList;
  EditArquivoServidor,EditPastaServer,EditPasta,EditCaminho,EditPorta,EditUsuario,EditSenha: string;
begin
  DeletaArqTemporarios;

  EditCaminho:='thewaysistemas.com.br';
  EditUsuario:='thewa536';
  EditSenha:='ma2709ss';
  EditArquivoServidor:=NomeDoArquivo;
  EditPastaServer:='/public_html/sistema';
  EditPasta:=ExtractFileDir(Application.ExeName);

  if Not DirectoryExists(EditPasta) then
     ForceDirectories(EditPasta);

  Lista := TStringList.Create;

  IdFTP.Host     := EditCaminho;
  IdFTP.Port     := StrToIntDef(EditPorta, 21);
  IdFTP.Username := EditUsuario;
  IdFTP.Password := EditSenha;
  IdFTP.Disconnect();
  try
  IdFTP.Connect();
  except

  end;
  IdFTP.ChangeDir(EditPastaServer);

  IdFTP.List(Lista, NomeDoArquivo, False);



//   bytesToTransfer := IdFTP.Size(ListBox1.Items.Strings[ListBox1.ItemIndex]);

     i:=0;
  //Efetuando o download de todos os arquivos

    //Comando para efetuar o download de um arquivo (informado na tela)
    try
    IdFTP.Get(EditArquivoServidor, EditPasta + '\' + EditArquivoServidor, True);
    except
      Application.MessageBox('N�o foi poss�vel atualizar, por favor, tente mais tarde','Aten��o',MB_OK+MB_ICONEXCLAMATION);
    end;

  IdFTP.Disconnect();
end;

procedure TfrmModelo.bloquearUSB;
var
  reg : TRegistry;
begin
  //Inclua na cl�usula uses a unit Registry.
  reg := TRegistry.create;
  with reg do
  begin
     RootKey := HKEY_LOCAL_MACHINE;
     if OpenKey('\SYSTEM\CurrentControlSet\Services\UsbStor', false) then 
     begin
        //quatro bloqueia
        reg.WriteInteger('Start', 4);
        //caminho do arquivo que o windows usa para montar a unidade usb
        reg.WriteString('ImagePath', '_system32\DRIVERS\USBSTOR.SYS');
     end;
     CloseKey;
  end;
end;
procedure TfrmModelo.BuscaCNPJReceitaWS(CNPJ: String; var RazaoSocial,
  NomeFantasia, Endereco, Numero, Bairro, Complemento, CEP: string);
//var
//  HTTP: TIdHTTP;
//  IDSSLHandler: TIdSSLIOHandlerSocketOpenSSL;
//  Response: TStringStream;
//  JSON: TJSONObject;
begin
{  try
    HTTP           := TIdHTTP.Create;
    IDSSLHandler   := TIdSSLIOHandlerSocketOpenSSL.Create;
    HTTP.IOHandler := IDSSLHandler;

    Response := TStringStream.Create('');
    HTTP.Get('https://www.receitaws.com.br/v1/cnpj/' + SomenteNumero(CNPJ), Response);

    if (HTTP.ResponseCode = 200) and not (Pos('"status": "ERROR"', UTF8ToString(Response.DataString)) > 0) then
    begin
      JSON := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(UTF8ToString(Response.DataString)), 0) as TJSONObject;

      RazaoSocial  := JSON.Get('nome').JsonValue.Value;
      NomeFantasia := JSON.Get('fantasia').JsonValue.Value;
      Endereco     := JSON.Get('logradouro').JsonValue.Value;
      Numero       := JSON.Get('numero').JsonValue.Value;
      Bairro       := JSON.Get('bairro').JsonValue.Value;
      complemento  := JSON.Get('complemento').JsonValue.Value;
      CEP          := StringReplace(JSON.Get('cep').JsonValue.Value, '.', '', []);
    end
    else
      Abort;
  finally
    FreeAndNil(HTTP);
    FreeAndNil(IDSSLHandler);
    Response.Destroy;
  end;}

end;

procedure TfrmModelo.ConfiguraEmail;
begin
with EnviarMail do //Composi��o da mensagem:
  begin
  Clear;
  Attachments.Clear;

  Body.Clear; //limpa o corpo da mensagem

  //Configura��o do compoente
  //Dados da Emitente

    From    :='naoresponder@thewaysistemas.com';
    FromName:=USUARIO + ' - ' +frmPincipal.qryEmpresa.FieldByName('fantasia').AsString;

    Host    :='mail.thewaysistemas.com';
    Username:='naoresponder@thewaysistemas.com';
    Password:='MJRquGt&p_cK';

    Port    :='587';
    SetTLS  :=False;
    SetSSL  :=False;

    Priority            := MP_high;
    ReadingConfirmation := True; // solicita confirma��o de leitura
    IsHTML              := False;
    AddReplyTo('suporte@thewaysistemas.com'); // opcional
  end;
end;

procedure TfrmModelo.ConsertaCustos;
begin
qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add('update cadprod set vlmenorpreco=0 where vlmenorpreco is null');
qryEu.ExecSQL;

qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add('update cadprod set pcusto=0 where pcusto is null');
qryEu.ExecSQL;

qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add('update cadprod set menorprvarejo=0 where menorprvarejo is null');
qryEu.ExecSQL;

qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add('update cadprod set prvarejo=0 where prvarejo is null');
qryEu.ExecSQL;

qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add('update cadprod set percomissvarejo=0 where percomissvarejo is null');
qryEu.ExecSQL;

end;

function TfrmModelo.CorrentPrinter: String;
// Retorna a impressora padr�o do windows
// Requer a unit printers declarada na clausula uses da unit
var
Device : array[0..255] of char;
Driver : array[0..255] of char;
Port : array[0..255] of char;
hDMode : THandle;
begin
Printer.GetPrinter(Device, Driver, Port, hDMode);
Result := Device+' na porta '+Port;


end;

procedure TfrmModelo.CorrigeUnidadeMedida;
begin
qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add(' update cadprod set und='+#39+'UN'+#39+
              ' where und='+#39+'UND'+#39);
qryEu.ExecSQL;

qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add(' update cadprod set und='+#39+'UN'+#39+
              ' where und='+#39+'PT'+#39);
qryEu.ExecSQL;

qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add(' update cadprod set und='+#39+'PC'+#39+
              ' where und='+#39+'PCA'+#39);
qryEu.ExecSQL;

qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add(' update cadprod set und='+#39+'UN'+#39+
              ' where und='+#39+'FR'+#39);
qryEu.ExecSQL;



qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add(' update nfsaidasitens set und='+#39+'UN'+#39+
              ' where und='+#39+'UND'+#39);
qryEu.ExecSQL;

qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add(' update nfsaidasitens set und='+#39+'UN'+#39+
              ' where und='+#39+'PT'+#39);
qryEu.ExecSQL;

qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add(' update nfsaidasitens set und='+#39+'PC'+#39+
              ' where und='+#39+'PCA'+#39);
qryEu.ExecSQL;

qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add(' update nfsaidasitens set und='+#39+'UN'+#39+
              ' where und='+#39+'FR'+#39);
qryEu.ExecSQL;




qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add(' update nfentradasitens set und='+#39+'UN'+#39+
              ' where und='+#39+'UND'+#39);
qryEu.ExecSQL;

qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add(' update nfentradasitens set und='+#39+'UN'+#39+
              ' where und='+#39+'PT'+#39);
qryEu.ExecSQL;

qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add(' update nfentradasitens set und='+#39+'PC'+#39+
              ' where und='+#39+'PCA'+#39);
qryEu.ExecSQL;

qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add(' update nfentradasitens set und='+#39+'UN'+#39+
              ' where und='+#39+'FR'+#39);
qryEu.ExecSQL;
end;

procedure TfrmModelo.CriarAtalho(ANomeArquivo, AParametros, ADiretorioInicial,
  ANomedoAtalho, APastaDoAtalho: string);
var
  MeuObjeto: IUnknown;
  MeuSLink: IShellLink;
  MeuPFile: IPersistFile;
  Diretorio: string;
  wNomeArquivo: WideString;
  MeuRegistro: TRegIniFile;
begin
  //Cria e instancia os objetos usados para criar o atalho

  MeuObjeto := CreateComObject(CLSID_ShellLink);
  MeuSLink := MeuObjeto as IShellLink;
  MeuPFile := MeuObjeto as IPersistFile;

  with MeuSLink do
  begin
    SetArguments(PChar(AParametros));
    SetPath(PChar(ANomeArquivo));
    SetWorkingDirectory(PChar(ADiretorioInicial));
  end;

  //Pega endere�o da pasta Desktop do Windows
  MeuRegistro :=
    TRegIniFile.Create('Software\MicroSoft\Windows\CurrentVersion\Explorer');
  Diretorio := MeuRegistro.ReadString('Shell Folders', 'Desktop', '');
  wNomeArquivo := Diretorio + '\' + ANomedoAtalho + '.lnk';

  //Cria de fato o atalho na tela

  MeuPFile.Save(PWChar(wNomeArquivo), False);
  MeuRegistro.Free;
end;

function TfrmModelo.CriticarCadastroCliente(codcliente: integer):Boolean;
var
qryCri: Tuniquery;
begin
 Result:=True;
 qryCri:=TUniQuery.Create(nil);
 qryCri.Connection:=frmPincipal.uOrigem;

 qryCri.Close;
 qryCri.SQL.Clear;
 qryCri.SQL.Add('select * from cadcliente where codcli=:cod');
 qryCri.ParamByName('cod').AsInteger:=codcliente;
 qryCri.Open;


{Campo de endere�o}
  if Length(Trim(qryCri.FieldByName('Endereco').AsString))<5 then
  begin
    Application.MessageBox(Pchar('Campo de Endere�o n�o est� preenchido.'+#13+'Cliente: '+qryCri.FieldByName('codcli').AsString),'Aten��o',MB_OK+MB_ICONINFORMATION);
    FreeAndNil(qryCri);
    Result:=False;
    Exit;
  end;

  {Campo de numero}
  if Length(Trim(qryCri.FieldByName('Numero').AsString))<1 then
  begin
    Application.MessageBox(Pchar('Campo de N�mero do Endere�o n�o est� preenchido.'+#13+'Cliente: '+qryCri.FieldByName('codcli').AsString),'Aten��o',MB_OK+MB_ICONINFORMATION);
    FreeAndNil(qryCri);
    Result:=False;
    Exit;
  end;

  {Campo de cidade}
  if Length(Trim(qryCri.FieldByName('CodMunicipio').AsString))<5 then
  begin
    Application.MessageBox(Pchar('Campo de Cidade n�o est� preenchido.'+#13+'Cliente: '+qryCri.FieldByName('codcli').AsString),'Aten��o',MB_OK+MB_ICONINFORMATION);
    FreeAndNil(qryCri);
    Result:=False;
    Exit;
  end;

  {Campo de cep}
  if Length(Trim(qryCri.FieldByName('Cep').AsString))<6 then
  begin
    Application.MessageBox(Pchar('Campo de Cep n�o est� preenchido.'+#13+'Cliente: '+qryCri.FieldByName('codcli').AsString),'Aten��o',MB_OK+MB_ICONINFORMATION);
    FreeAndNil(qryCri);
    Result:=False;
    Exit;
  end;

  {Campo de nome}
  if Length(Trim(qryCri.FieldByName('cliente').AsString))<1 then
  begin
    Application.MessageBox(Pchar('Campo de Nome n�o est� preenchido.'+#13+'Cliente: '+qryCri.FieldByName('codcli').AsString),'Aten��o',MB_OK+MB_ICONINFORMATION);
    FreeAndNil(qryCri);
    Result:=False;
    Exit;
  end;

    {Campo de bairro}
  if Length(Trim(qryCri.FieldByName('bairro').AsString))<1 then
  begin
    Application.MessageBox(Pchar('Campo de Bairro n�o est� preenchido.'+#13+'Cliente: '+qryCri.FieldByName('codcli').AsString),'Aten��o',MB_OK+MB_ICONINFORMATION);
    FreeAndNil(qryCri);
    Result:=False;
    Exit;
  end;

    {Campo de telefone}
  {if Length(Trim(qryCri.FieldByName('Tel1').AsString))<5 then
  begin
    Application.MessageBox(Pchar('Campo de Telefone n�o est� preenchido.'+#13+'Cliente: '+qryCri.FieldByName('codcli').AsString),'Aten��o',MB_OK+MB_ICONINFORMATION);
    FreeAndNil(qryCri);
    Result:=False;
    Exit;
 end;}

 if  (StrToFloat(SoNumeros( qryCri.FieldByName('CNPJ').AsString))=0)
 and (StrToFloat(SoNumeros( qryCri.FieldByName('CPF').AsString))=0) THEN
 BEGIN
    Application.MessageBox(Pchar('Campo de CPF n�o est� preenchido.'+#13+'Cliente: '+qryCri.FieldByName('codcli').AsString),'Aten��o!',MB_OK+MB_ICONINFORMATION);
    FreeAndNil(qryCri);
    Result:=False;
    Exit;
 END;

    {Campo de IE}
  if  (StrToFloat(SoNumeros( qryCri.FieldByName('CNPJ').AsString))>6)
  and (Length(Trim(qryCri.FieldByName('Ie').AsString))<5)
  and (Length(Trim(qryCri.FieldByName('CPF').AsString))<=0) then
  begin
    Application.MessageBox(Pchar('Campo de Inscri��o Estadual n�o est� preenchido.'+#13+'Cliente: '+qryCri.FieldByName('codcli').AsString),'Aten��o!',MB_OK+MB_ICONINFORMATION);
    FreeAndNil(qryCri);
    Result:=False;
    Exit;
  end;


  FreeAndNil(qryCri);


end;

function TfrmModelo.DatafinalDiasUteis(dataini: tdatetime;
  dias_uteis: integer): tdatetime;
// Retorna uma data acres�ida de mais um certo n�mero de dias
// uteis descontando os fins de semana
var dw:integer;
DataFinal,Data2: tdatetime;
begin
  dw := DayOfWeek(dataini)-1;
  //result := dataini+dias_uteis+((dias_uteis-1+dw) div 5)*2;

  DataFinal:=dataini+dias_uteis+((dias_uteis-1+dw) div 5)*2;
      qryEu.Close;
      qryEu.SQL.Clear;
      qryEu.SQL.Add('select count(*) qt from calendario');
      qryEu.SQL.Add('where data between :d1 and :d2');
      qryEu.SQL.Add('and feriado='+#39+'S'+#39);
      qryEu.ParamByName('d1').AsDate:=dataini;
      qryEu.ParamByName('d2').AsDate:=DataFinal;
      qryEu.Open;
         Data2:=DataFinal;
      if qryEu.FieldByName('qt').AsInteger>0 then
         Data2:=DataFinal+qryEu.FieldByName('qt').AsInteger;

      qryEu.Close;
      qryEu.SQL.Clear;
      qryEu.SQL.Add('select count(*) qt from calendario');
      qryEu.SQL.Add('where data between :d1 and :d2');
      qryEu.SQL.Add('and feriado='+#39+'S'+#39);
      qryEu.ParamByName('d1').AsDate:=DataFinal;
      qryEu.ParamByName('d2').AsDate:=Data2;
      qryEu.Open;
      DataFinal:=Data2;
      if qryEu.FieldByName('qt').AsInteger>0 then
         Data2:=DataFinal+qryEu.FieldByName('qt').AsInteger;
        Caption:=qryEu.FieldByName('qt').AsString;

       if DayOfWeek(DataFinal)=7 then
       begin
          Data2:= DataFinal+2;
          DataFinal:=Data2;
       end;

       if DayOfWeek(DataFinal)=1 then
       begin
          Data2:= DataFinal+1;
          DataFinal:=Data2;
       end;

      qryEu.Close;
      qryEu.SQL.Clear;
      qryEu.SQL.Add('select count(*) qt from calendario');
      qryEu.SQL.Add('where data between :d1 and :d2');
      qryEu.SQL.Add('and feriado='+#39+'S'+#39);
      qryEu.ParamByName('d1').AsDate:=DataFinal;
      qryEu.ParamByName('d2').AsDate:=DataFinal;
      qryEu.Open;

      Data2:= DataFinal+ qryEu.FieldByName('qt').AsInteger;
      DataFinal:=Data2;

      result := DataFinal;




end;



procedure TfrmModelo.DeletaArqTemporarios;
var
   info: PInternetCacheEntryInfo;
   diretorio: LongWord;
   tamanho: LongWord;
begin
//   Uses WinInet;
//Apaga arquivos tempor�rios da Internet
   tamanho := 0;
   FindFirstUrlCacheEntry(nil, TInternetCacheEntryInfo(nil^), tamanho) ;
   GetMem(info, tamanho) ;
   if tamanho > 0 then info^.dwStructSize := tamanho;
   diretorio := FindFirstUrlCacheEntry(nil, info^, tamanho) ;
   if diretorio <> 0 then
   begin
     repeat
       DeleteUrlCacheEntry(info^.lpszSourceUrlName) ;
       FreeMem(info, tamanho) ;
       tamanho := 0;
       FindNextUrlCacheEntry(diretorio, TInternetCacheEntryInfo(nil^), tamanho) ;
       GetMem(info, tamanho) ;
       if tamanho > 0 then info^.dwStructSize := tamanho;
     until not FindNextUrlCacheEntry(diretorio, info^, tamanho);
   end;
   FreeMem(info, tamanho) ;
   FindCloseUrlCache(diretorio) ;

end;

procedure TfrmModelo.desbloquearUSB;
var
 reg : Tregistry;
begin
  ///Inclua na cl�usula uses a unit Registry.
  reg := TRegistry.Create;
  with reg do 
  begin
     RootKey := HKEY_LOCAL_MACHINE;
     if OpenKey('\SYSTEM\CurrentControlSet\Services\UsbStor', false) then
     begin
        //tres desbloqueia
        reg.WriteInteger('Start', 3);
        //caminho do arquivo que o windows usa para montar a unidade usb
        reg.WriteString('ImagePath', 'system32\DRIVERS\USBSTOR.SYS');
     end;

  end;

end;

function TfrmModelo.DetectarInternet: Boolean;
var
Flags : dword;
begin
 //Uses WinInet
 Result := InternetGetConnectedState(@Flags, 0);
end;

function TfrmModelo.DifDateUtil(dataini, datafin: string): integer;
var a,b,c:tdatetime; 
  ct,s:integer;
begin 
if StrToDate(DataFin) < StrtoDate(DataIni) then 
  begin
  Result := 0; 
  exit;
  end; 
ct := 0; 
s := 1; 
a := strtodate(dataFin); 
b := strtodate(dataIni); 
if a > b then 
  begin 
  c := a; 
  a := b; 
  b := c; 
  s := 1; 
  end; 
a := a + 1; 
while (dayofweek(a)<>2) and (a <= b) do 
  begin 
  if dayofweek(a) in [2..6] then 
  begin 
  inc(ct); 
  end;
  a := a + 1; 
  end;
ct := ct + round((5*int((b-a)/7))); 
a := a + (7*int((b-a)/7)); 
while a <= b do 
  begin 
  if dayofweek(a) in [2..6] then
  begin 
  inc(ct); 
  end; 
  a := a + 1; 
  end; 
if ct < 0 then
  begin 
  ct := 0; 
  end; 
result := s*ct;
end;  


function TfrmModelo.DifHora(Inicio, Fim: String): String;
var 
  FIni,FFim : TDateTime; 
begin 
Fini := StrTotime(Inicio); 
FFim := StrToTime(Fim); 
If (Inicio > Fim) then 
  begin 
  Result := TimeToStr((StrTotime('23:59:59')-Fini)+FFim)
  end
else
  begin
  Result := TimeToStr(FFim-Fini);
  end;
end;

procedure TfrmModelo.BaixarAquivo(Arquivo, Dest: string);
var
ACBrDownload:TACBrDownload;
begin
  try
   ACBrDownload:=TACBrDownload.Create(nil);

   ACBrDownload.FTP.FtpHost     := '162.241.135.156';
   ACBrDownload.FTP.FtpPort     := '21';
   ACBrDownload.FTP.FtpUser     := 'thewa536';
   ACBrDownload.FTP.FtpPass     := 'ma20021978123';
   ACBrDownload.Protocolo       := protFTP;

   ACBrDownload.DownloadNomeArq:=Arquivo;
   ACBrDownload.DownloadUrl:='ftp://thewa536@162.241.135.156/public_html/sistema/'+Arquivo;

//   ACBrDownload.DownloadUrl:='ftp://thewa536@srv30.prodns.com.br/public_ftp/incoming/'+Arquivo;
   ACBrDownload.DownloadDest:=Dest;
   ACBrDownload.StartDownload;

   finally
     FreeAndNil(ACBrDownload);
   end;
end;

function TfrmModelo.DownloadFile(Source, Dest: string): Boolean;

begin


try

    Result:= UrlDownloadToFile(nil, PChar(source),PChar(Dest), 0, nil) = 0;

  except

    Result:= False;

  end;
end;

function TfrmModelo.ENumero(cCampo: variant): boolean;
var
TestaNo : CURRENCY;
begin
try
TestaNo := StrToFloat(cCampo);
Result := true;
except
Result := false;
end;
end;

procedure TfrmModelo.EscondeTaskBar(Visible: Boolean);
var wndHandle : THandle; 
wndClass : array[0..50] of Char; 
begin 
StrPCopy(@wndClass[0],'Shell_TrayWnd');
wndHandle := FindWindow(@wndClass[0], nil); 
If Visible=True Then Begin 
ShowWindow(wndHandle, SW_RESTORE); {Mostra a barra de tarefas} 
End Else Begin 
ShowWindow(wndHandle, SW_HIDE); {Esconde a barra de tarefas} 
End; 
end;

procedure TfrmModelo.ExecutePrograma(Nome, Parametros: String);
Var
 Comando: Array[0..1024] of Char;
 Parms: Array[0..1024] of Char;
begin
  StrPCopy (Comando, Nome);
  StrPCopy (Parms, Parametros);
  ShellExecute (0, Nil, Comando, Parms, Nil, SW_ShowMaximized);
end;

function TfrmModelo.ExtractWindowsDir: String;
Var
Buffer : Array[0..144] of Char;
begin
GetWindowsDirectory(Buffer,144);
Result :=copy(Buffer,1,3);
end;

procedure TfrmModelo.FechaQuery;
var
x: integer;
begin

for x := 0 to ComponentCount - 1 do //Desativo todas query do forma dinamicamente
if Components[x].Classname = 'TUniQuery' then
if TUniQuery(Components[x]).Active then
TUniQuery(Components[x]).close;

end;

procedure TfrmModelo.FechaTables;
var
x: integer;
begin
  for x := 0 to ComponentCount - 1 do //Desativo todas query do forma dinamicamente
    if Components[x].Classname = 'TUniTable' then
      if TUniTable(Components[x]).Active then
        TUniTable(Components[x]).close;
end;

procedure TfrmModelo.ModeloImpressora;
var
x: integer;
begin
  for x := 0 to ComponentCount - 1 do
    if Components[x].Classname = 'TRDPrint' then
        TRDPrint(Components[x]).Impressora:=Grafico;
end;


procedure TfrmModelo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FechaQuery;
FechaTables;
Action := caFree;
Release;
end;

procedure TfrmModelo.FormCreate(Sender: TObject);
var
nI: Integer;
SR: TSearchRec;
J: integer;
caminho: String;
arq : textfile;
linhaDIR: string;
DIR:String;
IPtemp:String;
begin
//Desabilitar beep
EscondeTaskBar(True);
SystemParametersInfo(SPI_SETBEEP, 0, nil, SPIF_SENDWININICHANGE);
ShortDateFormat:='dd/mm/yyyy';
ConfiguraEmail;
TracoMaior :='-------------------------------------------------------------------------------------------------------------------------------------';
if NOMEFILIAL<>NullAsStringValue then
begin
  Caption:=Caption+' - '+NOMEFILIAL;
end;

if not FileExists('c:\bkp\rotinas.txt') then
begin

qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add('CREATE TABLE cadusosis (' +
                  '    codID INT AUTO_INCREMENT,' +
                  '    rotina VARCHAR(50),' +
                  '    data DATE,' +
                  '    hora TIME,' +
                  '   cnpj VARCHAR(20),' +
                  '   PRIMARY KEY (codID)' +
                  ' ) ENGINE = MyISAM ROW_FORMAT = DEFAULT');
try
//  qryRotina.ExecSQL;
except

end;

qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add('alter table cadusosis add nome vachar(20)');

try
 // qryRotina.ExecSQL;
except

end;

qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add('CREATE TABLE cadusosis (' +
                  '    codID INT AUTO_INCREMENT,' +
                  '    rotina VARCHAR(50),' +
                  '    data DATE,' +
                  '    hora TIME,' +
                  '   cnpj VARCHAR(20),' +
                  '   PRIMARY KEY (codID)' +
                  ' ) ENGINE = MyISAM ROW_FORMAT = DEFAULT');

try
//  qryEu.ExecSQL;
except

end;

qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add('alter table cadusosis add nome varchar(20)');

try
 // qryEu.ExecSQL;
except

end;


qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add('INSERT INTO cadusosis(' +
                  'rotina' +
                  '  ,data' +
                  '  ,hora' +
                  '  ,cnpj' +
                  '  ,nome' +
                  ') VALUES ('+
                  #39+UpperCase(RetiraAcentuacao(Caption))+#39+','+
                  'current_date,'+
                  'current_time,' +
                  #39+SoNumeros(frmPincipal.qryEmpresa.Fieldbyname('cnpj').AsString)+#39+','+
                  #39+Name+#39+
                  ')');

try
 // qryEu.ExecSQL;
except

end;


qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add('INSERT INTO cadusosis(' +
                  'rotina' +
                  '  ,data' +
                  '  ,hora' +
                  '  ,cnpj' +
                  '  ,nome' +
                  ') VALUES ('+
                  #39+UpperCase(RetiraAcentuacao(Caption))+#39+','+
                  'current_date,'+
                  'current_time,' +
                  #39+SoNumeros(frmPincipal.qryEmpresa.Fieldbyname('cnpj').AsString)+#39+','+
                  #39+Name+#39+
                  ')');

try
  //qryEu.ExecSQL;
except

end;
end;


ClientHeight:=ClientHeight+25;

//LIMPA PASTA TEMP
DIR:=ExtractFileDir(Application.ExeName)+'\sys.txt';

if not FileExists(DIR) then
begin
  DIR:=ExtractWindowsDir+'\bkp\sys.txt';
end;

if FileExists(DIR) then
begin
AssignFile(arq,DIR);
Reset(arq);
Readln(arq,linhaDIR);
IPtemp:=linhaDIR;
end;
if  IPtemp='localhost' then
begin
  if DirectoryExists('c:\temp\') then
begin
  try
caminho:='c:\temp\*.*';
j := FindFirst(caminho, faAnyFile, SR);
  while j = 0 do
    begin
      if (SR.Attr and faDirectory) <> faDirectory then
        begin
          caminho:= 'c:\temp\'  + SR.Name;
          try
            DeleteFile(caminho);
          except

          end;

        end;
      j := FindNext(SR);
    end;
except

end;
end;

try
caminho:='c:\windows\temp\*.*';
j := FindFirst(caminho, faAnyFile, SR);
  while j = 0 do
    begin
      if (SR.Attr and faDirectory) <> faDirectory then
        begin
          caminho:= 'c:\windows\temp\'  + SR.Name;
          try
            DeleteFile(caminho);
          except

          end;

        end;
      j := FindNext(SR);
    end;
except

end;
end;


For nI := 0 to ComponentCount-1 do
    if (Components[nI] is TUniQuery) then
      (Components[nI] as TUniQuery).Prepared := false;


For nI := 0 to ComponentCount-1 do
    if (Components[nI] is TEdit) then
      (Components[nI] as TEdit).OnEnter := Pinta;

For nI := 0 to ComponentCount-1 do
    if (Components[nI] is TDBEdit) then
      (Components[nI] as TDBEdit).OnEnter := Pinta;

// altera cor
Application.HintColor := clYellow;
// tempo antes de apresentar
Application.HintPause := 100;
// Tempo de apresenta��o
Application.HintHidePause := 7000;

ShortDateFormat:='dd/mm/yyyy';
traco :='------------------------------------------------------------------------------------------------';
TracoMaior :='----------------------------------------------------------------------------------------------------------------------------------------';
traco2:='================================================================================================';



end;

procedure TfrmModelo.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if KEY=#13 then Perform(WM_NEXTDLGCTL,0,0);//Ativa o enter no formulario
end;



procedure TfrmModelo.FormShow(Sender: TObject);
begin
ModeloImpressora;
end;

procedure TfrmModelo.FreeMemAndNil(var ptr; size: Integer);
var
  p: Pointer;
begin
  p := Pointer(ptr);
  if p <> nil then
  begin
    if size > -1 then
      FreeMem(p, size)
    else
      FreeMem(p);
    Pointer(ptr) := nil;
  end;

end;

function TfrmModelo.Func_getComputerName: String;
var
Buffer: array [0 .. 255] of Char;
Size: DWORD;
ComputerName: String;
begin
Size := MAX_COMPUTERNAME_LENGTH + 1;
GetComputerName(Buffer, Size);
ComputerName := Buffer;
Result := ComputerName;
end;

function TfrmModelo.GetDefaultPrinterName: string;
// Retorna a impressora padr�o do windows
var
   Device : array[0..255] of char;
   Driver : array[0..255] of char;
   Port   : array[0..255] of char;
   hDMode : THandle;
begin
   Printer.GetPrinter(Device, Driver, Port, hDMode);
   Result := Device;
end;

procedure TfrmModelo.InsereReplica;
begin

end;

function TfrmModelo.LimpaCPF_CNPJ(str: String): String;
var
j: Integer;
pronto: string;
begin
pronto:='';
  for j := 1 to Length ( str ) do
  case str[j] of
  '.': str[j] := '.';
  '-': str[j] := '.';
  '/': str[j] := '.';
  ' ': str[j] := '.';
  '(': str[j] := '.';
  ')': str[j] := '.';
  #39: str[j] := '.';
end;

Result   :='';
For j      := 1 to length(str) do
    If str[j] <> '.' Then
    BEGIN
      Result   := Result + str[j] ;
    END;


end;

procedure TfrmModelo.ListarArquivos(Diretorio: string; Sub: Boolean);
var
  F: TSearchRec;
  Ret: Integer;
  TempNome: string;
begin

end;

function TfrmModelo.lpad(str: String; tamano: integer;
  caracter: String): String;
var
i: integer;
begin
if Length(str)>tamano then
begin
  result:=Copy(str,1,tamano);
end;
if Length(str)=tamano then
begin
  result:=str;
end;
if Length(str)<tamano then
begin
  for I := 0 to tamano-Length(str)-1 do
  begin
    str:=str+caracter;
  end;
  result:=str;
end;
end;

procedure TfrmModelo.MapearUnidadeRede;
var
NRW: TNetResource;
begin
 with NRW do

  begin

    dwType := RESOURCETYPE_ANY;

    lpLocalName := 'T:';    // onde H � a letra do drive a ser adicionado.

    lpRemoteName := Pchar(frmPincipal.uOrigem.Server+'\TheWay') ;     // computador � o nome do computador da rede a ser mapeado.

    lpProvider := '';

  end;

//  WNetAddConnection2(NRW, 'senha', 'usuario', CONNECT_UPDATE_PROFILE);
    WNetAddConnection2(NRW, '', '', CONNECT_UPDATE_PROFILE);
end;
function TfrmModelo.Mask(Mascara, Str: string): string;
var
    x, p : integer;
begin
    p := 0;
    Result := '';

{    if Str=NullAsStringValue then
        exit;

    for x := 0 to Length(Mascara) - 1 do
    begin
        if Mascara=Chars[x] = '#' then
        begin
            Result := Result + Str.Chars[p];
            inc(p);
        end
        else
            Result := Result + Mascara.Chars[x];

        if p = Length(Str) then
            break;
    end;}

end;

//#############################################################################
function strZero(num1: String; num2: integer): string; overload;
var i : integer;
    aux : string;
begin
     aux := num1;
     for i := 1 to (num2-Length(num1)) do
         insert('0',aux,1);
     result := aux;
end;

//#############################################################################
function strZero(const num1: Int64; const num2: integer): string; overload;
var i : integer;
    aux : string;
begin
     aux := IntToStr(num1);
     for i := 1 to (num2-Length(IntToStr(num1))) do
         insert('0',aux,1);
     result := aux;
end;

//#############################################################################

//function Mod11(iNumero: Integer): Integer;
//var   sCadeia  : String;
//iX       : Integer;      iY       : Integer;      iValor   : Integer;      iDigito  : Integer;
//sPosicao : String;      iPosicao : Integer;
//Begin   iValor := 0;
// sCadeia := StrZero( iNumero, 16 );   For iY := 2 DownTo 1 do   Begin
//       For iX := 8 DownTo 1 do      Begin
//        sPosicao    := Copy( sCadeia, ( 17 - ( iX + ( 8 * ( iY - 1 ) ) ) ), 1 );
//        iPosicao    := StrToInt( sPosicao );
//          iValor      := iValor + ( iPosicao * ( iX + 1 ) )      End;
//           End;   iDigito := ( ( iValor * 10 ) mod 11 );
//            If iDigito >= 10 Then      iDigito := 0;
//             Result := StrToInt(StrZero( iDigito, 1 ));
//
//end;

function TfrmModelo.moeda(moeda: String): String;
begin
qryEu.close;
qryEu.Sql.clear;
qryEu.SQl.Add('select * from cadmoeda where tipo='+#39+moeda+#39);
qryEu.Open;

result:= qryEu.FieldByName('codmoeda').AsString;
end;
function TfrmModelo.MySqlDate(data1: string): string;
// formata a data no formato do mysql
var dia,mes, ano: word;
    mesC,diaC: string;
begin
     decodeDate(strTodate(Data1),ano,mes,dia);
     mesC := IntToStr(mes);
     diaC:= intToStr(dia);
     if mes <10 then
        mesc := '0'+ IntToStr(mes);
     if dia < 10 then
        diaC := '0'+ IntToStr(dia);
     result := IntToStr(ano)+mesc+diac;
end;

//#############################################################################
//function strZero(const num1: Int64; const num2: integer): string; overload;
//var i : integer;
//    aux : string;
//begin
//     aux := IntToStr(num1);
//     for i := 1 to (num2-Length(IntToStr(num1))) do
//         insert('0',aux,1);
//     result := aux;
//end;

//Function Mod11( iNumero: Integer ) : Integer;
//var   sCadeia  : String;
//  iX       : Integer;      iY       : Integer;      iValor   : Integer;      iDigito  : Integer;
//  sPosicao : String;      iPosicao : Integer;Begin   iValor := 0;
//  sCadeia := StrZero( iNumero, 16 );   For iY := 2 DownTo 1 do Begin
//  For iX := 8 DownTo 1 do Begin
//    sPosicao    := Copy( sCadeia, ( 17 - ( iX + ( 8 * ( iY - 1 ) ) ) ), 1 );
//    iPosicao    := StrToInt( sPosicao );
//    iValor      := iValor + ( iPosicao * ( iX + 1 ) )
//  End;
//  End;   iDigito := ( ( iValor * 10 ) mod 11 );
//  If iDigito >= 10 Then
//     iDigito := 0;
//     Result := StrToInt(StrZero( iDigito, 1 ));
//End;

//function TfrmModelo.GravaNossoNumero(Codbanco, Numped, str: String): String;
//Var
//  NossoNumeroAtual : Integer;
//begin
//  //descobre no cadbanco o nossumero atual
//  with qryEu do begin
//    Close;
//    sql.Clear;
//    Sql.add('SELECT nossonumatual FROM cadbanco WHERE codbanco ='+ codbanco +'');
//  end;
//  qryEu.Open;
//  NossoNumeroAtual  := 0;
//  NossoNumeroAtual  := qryEu.FieldByName('nossonumatual').AsInteger + 1;
//
//  //insere no contas receber
//  With qryRotina do begin
//    Close;
//    SQL.Clear;
//    SQL.Add(' UPDATE contasreceber SET ');
//    SQL.Add(' Nossonumero  = ' + #39 + StrZero(NossoNumeroAtual,7)+IntToStr(Mod11(NossoNumeroAtual)) + #39 + '');
//    SQL.Add(' Boleto       = ' + #39 + 'S' + #39 + ',');
//    SQL.Add(' BoletoQt     = ' + 'BoletoQt + 1' + '');
//    SQL.Add(' WHERE codrec = ' +  Numped + '');
//  end;
//  qryRotina.ExecSQL;
//
//  //atualiza o nosso numero no cadastro do banco
//  With qryRotina do begin
//    Close;
//    SQL.Clear;
//    SQL.Add(' UPDATE cadbanco SET ');
//    SQL.Add(' nossonumatual  = ' + IntToStr(NossoNumeroAtual) + '');
//    SQL.Add(' WHERE codbanco = ' + codbanco + '');
//  end;
//  qryRotina.ExecSQL;
//
//  result := inttostr(NossoNumeroAtual);
//end;

function TfrmModelo.NumeroSerie(Unidade: PChar): String;
{Retorna o N�mero serial da unidade especificada}
var
VolName,SysName : AnsiString;
SerialNo,MaxCLength,FileFlags : DWord;
begin
try
  SetLength(VolName,255);
  SetLength(SysName,255);
  GetVolumeInformation(Unidade,PChar(VolName),255,@SerialNo,
  MaxCLength,FileFlags,PChar(SysName),255);
  result := IntToHex(SerialNo,8);
except
  result := ' ';
end;



end;

procedure TfrmModelo.Pinta;
var nI: Integer;
begin
For nI := 0 to ComponentCount-1 do
  begin
if (Components[nI] is TEdit) then
    begin
    if TEdit(Components[nI]).Focused then
      TEdit(Components[nI]).Color := clYellow
      else
      TEdit(Components[nI]).Color := clWhite;
    end;
  end;

For nI := 0 to ComponentCount-1 do
  begin
if (Components[nI] is TDBEdit) then
    begin
    if TDBEdit(Components[nI]).Focused then
      TDBEdit(Components[nI]).Color := clYellow
      else
      TDBEdit(Components[nI]).Color := clWhite;
    end;
  end;
end;

procedure TfrmModelo.PontoDecimal(var Key: char; cValor: string);
begin
if ( Key in ['.',','] ) then
Begin
Key := #44;
if Pos(Key,cValor) <> 0 then
Begin
Beep;
Key := #0;
End;
End;
//
if not ( Key in ['0','1','2','3','4','5','6','7','8','9',',',#8,#7] ) then
Begin
Beep;
Key := #0;
End;
end;

procedure TfrmModelo.PontoInteiro(var Key: char; cValor: string);
begin
if Not (key in ['0'..'9',#8]) then
begin
key := #0;
end;

end;

function TfrmModelo.RemoveZeros(S: string): string;
var
I, J : Integer;
begin
I := Length(S);
while (I > 0) and (S[I] <= ' ') do
      begin
      Dec(I);
      end;
J := 1;
while (J < I) and ((S[J] <= ' ') or (S[J] = '0')) do
      begin
      Inc(J);
      end;
Result := Copy(S, J, (I-J)+1);
end;

//#############################################################################
function TfrmModelo.RetiraMarcas(const StrTxt: String): String;
// Retira os caracteres "&" que sinaliza um atalho para
// ativar o controle.
// Ultima altera��o em : 21/07/1999
// By : Williams
var aux : string;
    i, j: integer;
begin
     j:= 0;
     aux := strTxt;
     for i := 1 to length(strTxt)-j do begin
         if strTxt[i] = '&' then begin
            delete(aux,i,1);
            inc(j);
         end // if... by williams
     end;//for ... by williams
     result := aux;
end;

function TfrmModelo.RetiraAcentuacao(str: String): String;
var
j: Integer;
begin
  for j := 1 to Length ( str ) do
  case str[j] of
  '�': str[j] := 'a';
  '�': str[j] := 'e';
  '�': str[j] := 'i';
  '�': str[j] := 'o';
  '�': str[j] := 'u';
  '�': str[j] := 'a';
  '�': str[j] := 'e';
  '�': str[j] := 'i';
  '�': str[j] := 'o';
  '�': str[j] := 'u';
  '�': str[j] := 'a';
  '�': str[j] := 'e';
  '�': str[j] := 'i';
  '�': str[j] := 'o';
  '�': str[j] := 'u';
  '�': str[j] := 'a';
  '�': str[j] := 'e';
  '�': str[j] := 'i';
  '�': str[j] := 'o';
  '�': str[j] := 'u';
  '�': str[j] := 'a';
  '�': str[j] := 'o';
  '�': str[j] := 'n';
  '�': str[j] := 'c';
  '�': str[j] := 'A';
  '�': str[j] := 'E';
  '�': str[j] := 'I';
  '�': str[j] := 'O';
  '�': str[j] := 'U';
  '�': str[j] := 'A';
  '�': str[j] := 'E';
  '�': str[j] := 'I';
  '�': str[j] := 'O';
  '�': str[j] := 'U';
  '�': str[j] := 'A';
  '�': str[j] := 'E';
  '�': str[j] := 'I';
  '�': str[j] := 'O';
  '�': str[j] := 'U';
  '�': str[j] := 'A';
  '�': str[j] := 'E';
  '�': str[j] := 'I';
  '�': str[j] := 'O';
  '�': str[j] := 'U';
  '�': str[j] := 'A';
  '�': str[j] := 'O';
  '�': str[j] := 'N';
  '�': str[j] := 'C';
  #39: str[j] := ' ';
  '#': str[j] := ' ';
  '|': str[j] := ' ';
  '<': str[j] := ' ';
  '>': str[j] := ' ';
  '&': str[j] := ' ';
  '�': str[j] := ' ';
  '�': str[j] := ' ';
  '�': str[j] := ' ';
  '�': str[j] := ' ';
  '�': str[j] := ' ';
  '�': str[j] := ' ';
  '�': str[j] := ' ';
end;
Result := str;


end;

function TfrmModelo.RetiraPonto(v: string): STRING;
Var
X :Integer;
Begin
Result   :='';
For x      := 1 to length(V) do
    If V[x] <> '.' Then
    BEGIN
      Result   := Result + V[x] ;
    END;

End;



procedure TfrmModelo.ShowFolder(strFolder: string);
begin
  ShellExecute(Application.Handle,
    PChar('explore'),
    PChar(strFolder),
    nil,
    nil,
    SW_SHOWNORMAL);
end;



function TfrmModelo.SoNumeros(const Texto: String): String;
var
  vContString: integer;
  vString: string;
begin
  vString:='';
  for vContString:= 1 To Length(Texto) Do
    begin
      if (Texto[vContString] in ['0'..'9']) then
        begin
          vString:= vString + Copy(Texto, vContString, 1);
        end;
    end;

  if vString<>'' then
    result:=vString
  else
    result:='00000000000';
end;

function TfrmModelo.SysTempDir: string;
begin
SetLength(Result, MAX_PATH);
if GetTempPath(MAX_PATH, PChar(Result)) > 0 then
Result := string(PChar(Result))
else
Result := '';
end;

function TfrmModelo.SysUserName: string;
var
I: DWord;
begin
I := 255;
SetLength(Result, I);
Windows.GetUserName(PChar(Result), I);
Result := string(PChar(Result));
end;

function TfrmModelo.SysWinDir: string;
begin
SetLength(Result, MAX_PATH);
Windows.GetWindowsDirectory(PChar(Result), MAX_PATH);
Result := string(PChar(Result));

end;

function TfrmModelo.TraduzirEspanhol(Texto: String): String;
var
  lNovoConteudo: String;
  pLista: TStringList;
begin

pLista:=TStringList.Create;
pLista.Text:=Texto;

lNovoConteudo := StringReplace(pLista.Text, 'Milhoes', 'Millones',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'Milh�es', 'Millones',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'Milhao', 'Millon',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' Hum ', ' Uno ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' Um ', ' Uno ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' Dois ', ' Dos ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' tres ', ' Tres ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' quatro ', ' Cuatro ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' cinco ', ' Cinco ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' seis ', ' Seis ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' oito ', ' Ocho ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' sete ', ' Siete ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' nove ', ' Nueve ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' dez ', ' Diez ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' cem ', ' Ciento ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' dez ', ' diez ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' onze ', ' once ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' vinte ', ' veinte ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' trinta ', ' treinta ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' quarenta ', ' cuarenta ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' cinquenta ', ' cincuenta ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' sessenta ', ' sesenta ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' setenta ', ' setenta ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' oitenta ', ' ochenta ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' noventa ', ' noventa ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' e ', ' y ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;

lNovoConteudo := StringReplace(pLista.Text, ' duzentos ', ' doscientos ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' trezentos ', ' trescientos ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' quatrocentos ', ' cuatrocientos ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' quinhentos ', ' quinientos ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' seiscentos ', ' seiscientos ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' setecentos ', ' setecientos ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' oitocentos ', ' ochocientos ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' novecentos ', ' novecientos ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' Cento ', ' Ciento ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'Um ', ' Un ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'dois ', ' Dos ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'sete ', ' Siete ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, ' tres ', ' Tres ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'quatro ', ' Cuatro ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'cinco ', ' Cinco ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'seis ', ' Seis ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'oito ', ' Ocho ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'sete ', ' Siete ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'nove ', ' Nueve ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'dez ', ' Diez ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'duzentos ', ' doscientos ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'trezentos ', ' trescientos ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'quatrocentos ', ' cuatrocientos ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'quinhentos ', ' quinientos ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'seiscentos ', ' seiscientos ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'setecentos ', ' setecientos ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'oitocentos ', ' ochocientos ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'novecentos ', ' novecientos ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;
lNovoConteudo := StringReplace(pLista.Text, 'Cento ', ' Ciento ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;

lNovoConteudo := StringReplace(pLista.Text, 'Onze ', ' Once ',[rfReplaceAll, rfIgnoreCase]);
pLista.Text:=lNovoConteudo;





Result:=trim(lNovoConteudo);
pLista.free;

end;

procedure TfrmModelo.TrimAppMemorySize;
var   MainHandle : THandle;
begin
try
MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID) ;
SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF) ;
CloseHandle(MainHandle) ;
except
end;
Application.ProcessMessages;


end;

function TfrmModelo.TrocaVirgula(str: String): String;
var
j: Integer;
begin
  for j := 1 to Length ( str ) do
  case str[j] of
  ',': str[j] := '.';

end;
Result := str;
end;



function TfrmModelo.UltimoDiaMes(Mdt: TDateTime): TDateTime;
var
  ano, mes, dia : word;
  mDtTemp : TDateTime;
begin
  Decodedate(mDt, ano, mes, dia);
  mDtTemp := (mDt - dia) + 33;
  Decodedate(mDtTemp, ano, mes, dia);
  Result := mDtTemp - dia;
end;

function TfrmModelo.ValidarChaveNFe(const ChaveNFe: string): boolean;
const
  PESO : Array[0..43] of Integer = (4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2, 0);
var
  Retorno : boolean;
  aChave  : Array[0..43] of Char;
  Soma    : Integer;
  Verif   : Integer;
  I       : Integer;
begin
  Retorno := false;
  try
    try
      if not Length(ChaveNFe) = 44 then
        raise Exception.Create('');

      StrPCopy(aChave,StringReplace(ChaveNFe,' ', '',[rfReplaceAll]));
      Soma := 0;
      for I := Low(aChave) to High(aChave) do
        Soma := Soma + (StrToInt(aChave[i]) * PESO[i]);

      if Soma = 0 then
        raise Exception.Create('');

      Soma := Soma - (11 * (Trunc(Soma / 11)));
      if (Soma = 0) or (Soma = 1) then
        Verif := 0
      else
        Verif := 11 - Soma;

      Retorno := Verif = StrToInt(aChave[43]);
    except
      Retorno := false;
    end;
  finally
    Result := Retorno;
  end;
end;

procedure TfrmModelo.WMMove(var Msg: TWMMove);
begin
{if Left < 0 then
    Left := 0;
  if Top < 0 then
    Top := 0;
  if Screen.Width - (Left + Width) < 0 then
    Left := Screen.Width - Width;
  if Screen.Height - (Top + Height) < 0 then
    Top := Screen.Height - Height;}

end;

end.
