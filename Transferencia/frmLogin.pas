unit frmLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg, DB,  ShellApi,
  MemDS, DBAccess, Uni;

type
  TLogin = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label5: TLabel;
    ValorSenha: TEdit;
    ValorNome: TEdit;
    Label3: TLabel;
    Label2: TLabel;
    lfuncao: TLabel;
    Image2: TImage;
    Label4: TLabel;
    qryFilial: TUniQuery;
    qryEu: TUniQuery;
    qryAniversario: TUniQuery;
    my: TUniQuery;
    myCurrent_Time: TTimeField;
    myCurrent_date: TDateField;
    qryUpdate: TUniQuery;
    TimeField1: TTimeField;
    DateField1: TDateField;
    qryBloquear: TUniQuery;
    Label6: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ValorSenhaExit(Sender: TObject);
    procedure Label1MouseEnter(Sender: TObject);
    procedure Label1MouseLeave(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure ValorNomeEnter(Sender: TObject);
    procedure ValorNomeExit(Sender: TObject);
    procedure ValorSenhaEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    Function DesligarMeuWindows(RebootParam: Longword): Boolean;
    procedure AlteraDataHoraSistema; //Altera data do Computador
    procedure LiberarAcessoSuper;
    function SoNumeros(const Texto: String): String;
  end;

var
  Login: TLogin;
  {Colhe o código e nome do usuário}
  CODPERFIL,USUARIO,CODFILIAL,CODUSUARIO,MOSTRAFINANC,CODCAIXA,CODFUNC,ALTERA,
  ALTERAJUROS,AlteraPedidoPosFaturamento,ArqEmail,AssuntoEmail, NOMEFILIAL,ESTORNAPEDIDO,ALTERACONTRATO,LIBERASEPARACAO:STRING;
  QTFILIAIS: INTEGER;
  AlteraLimCred: String;
  RecebeComissao: boolean;
  


implementation

uses UPrincipal;

{$R *.dfm}

procedure TLogin.AlteraDataHoraSistema;
var
SystemTime : TSystemTime;

begin
With SystemTime do
begin
my.Close;
my.SQL.Clear;
my.SQL.Add('Select Current_Time,Current_date');
my.Open;

//Definindo o dia do sistema
wYear:= StrToInt(FormatDateTime('yyyy', myCurrent_date.Value));
wMonth:= StrToInt(FormatDateTime('mm', myCurrent_date.Value));
wDay:= StrToInt(FormatDateTime('dd', myCurrent_date.Value));
//Definindo a hora do sistema
wHour:=StrToInt(FormatDateTime('hh', myCurrent_Time.Value)); //hora
wMinute:=StrToInt(FormatDateTime('mm', myCurrent_Time.Value)); //minutos
wSecond:= StrToInt(FormatDateTime('ss', myCurrent_Time.Value)); //segundos
end;
//Colocar a hora e data do sistema
//SetLocalTime(SystemTime);

end;

procedure TLogin.BitBtn1Click(Sender: TObject);
var
strSqlLog: string;
mensagem, mensagem2, endereco_bkp:  string;
begin



  strSqlLog:='select * ';
  strSqlLog:=strSqlLog + ',(select cadfunc.recebecomissao from cadfunc where  cadusuario.codfunc = cadfunc.codfunc ) recebecomissao';
  strSqlLog:=strSqlLog + '  from cadusuario,cadperfil left join cadperfil2 on  cadperfil.codperfil = cadperfil2.codperfil2 ';
  strSqlLog:=strSqlLog + ' where cadusuario.perfil=cadperfil.codperfil';
  strSqlLog:=strSqlLog + ' and (login = ' + #39 + (ValorNome.Text) + #39;
  strSqlLog:=strSqlLog + ' or codusur = ' +SoNumeros(ValorNome.Text) +')';
  strSqlLog:=strSqlLog + ' and cadusuario.senha =  AES_ENCRYPT('+#39+ValorSenha.Text+#39+',1978) ';


  frmPincipal.QueryLogin.Close;
  frmPincipal.QueryLogin.SQL.Clear;
  frmPincipal.QueryLogin.SQL.Add(strSqlLog);
  frmPincipal.QueryLogin.Open;



  if frmPincipal.QueryLogin.RecordCount=0 then
  begin

  strSqlLog:='select * ';
  strSqlLog:=strSqlLog + ',(select cadfunc.recebecomissao from cadfunc where  cadusuario.codfunc = cadfunc.codfunc ) recebecomissao';
  strSqlLog:=strSqlLog + '  from cadusuario,cadperfil left join cadperfil2 on  cadperfil.codperfil = cadperfil2.codperfil2 ';
  strSqlLog:=strSqlLog + ' where cadusuario.perfil=cadperfil.codperfil';
  strSqlLog:=strSqlLog + ' and (login = ' + #39 + (ValorNome.Text) + #39;
  strSqlLog:=strSqlLog + ' or codusur = ' +SoNumeros(ValorNome.Text) +')';
  strSqlLog:=strSqlLog + ' and senha =  '+#39+Trim(ValorSenha.Text)+#39;


  frmPincipal.QueryLogin.Close;
  frmPincipal.QueryLogin.SQL.Clear;
  frmPincipal.QueryLogin.SQL.Add(strSqlLog);
  frmPincipal.QueryLogin.Open;

  end;


  qryEu.Close;
  qryEu.SQL.Clear;
  qryEu.SQL.Add('SELECT * FROM CADEMPRESA');
  qryEu.Open;

  QTFILIAIS:= qryEu.RecordCount;

  //bloquueia o sistema
  {if date=StrToDate('11/04/2011') then
  begin
    qryBloquear.Close;
    qryBloquear.SQL.Clear;
    qryBloquear.SQL.Add('update cadusuario set status='+QuotedStr('A')+' ');
    qryBloquear.ExecSQL;
  end;}
  {if date>=StrToDate('15/02/2016') then
  begin
    qryBloquear.Close;
    qryBloquear.SQL.Clear;
    qryBloquear.SQL.Add('update cadusuario set status='+QuotedStr('N')+' ');
    qryBloquear.ExecSQL;
    //DesligarMeuWindows(EWX_POWEROFF or EWX_FORCE);
  end;}

  if frmPincipal.QueryLogin.RecordCount = 0 then
  begin
    Application.MessageBox('Senha ou login errado. Solicite a chave de desbloqueio do sistema.', 'Informação', MB_OK + MB_ICONEXCLAMATION);
    ValorSenha.Text := '';
    ValorNome.SetFocus;
    ModalResult := mrNone;
    Abort;
  end;

  codperfil                     :=frmPincipal.QueryLogin.FieldByName('perfil').AsString;
  USUARIO                       :=frmPincipal.QueryLogin.FieldByName('login').AsString;
  CODUSUARIO                    :=frmPincipal.QueryLogin.FieldByName('codusur').AsString;
  CODCAIXA                      :=frmPincipal.QueryLogin.FieldByName('codcaixa').AsString;
  CODFUNC                       :=frmPincipal.QueryLogin.FieldByName('codfunc').AsString;
  MOSTRAFINANC                  :=frmPincipal.QueryLogin.FieldByName('mensagensfinanc').AsString;
  ALTERA                        :=frmPincipal.QueryLogin.FieldByName('AlteraCompra').AsString;
  ALTERAJUROS                   :=frmPincipal.QueryLogin.FieldByName('AlteraJuros').AsString;
  ESTORNAPEDIDO                 :=frmPincipal.QueryLogin.FieldByName('EstornaPedido').AsString;
  ALTERACONTRATO                :=frmPincipal.QueryLogin.FieldByName('AlteraContrato').AsString;
  LIBERASEPARACAO               :=frmPincipal.QueryLogin.FieldByName('liberaseparacao').AsString;
  AlteraPedidoPosFaturamento    :=frmPincipal.QueryLogin.FieldByName('AlteraPedidoPosFaturamento').AsString;
  AlteraLimCred                 :=frmPincipal.QueryLogin.FieldByName('AlterarLimCred').AsString;
  RecebeComissao                :=frmPincipal.QueryLogin.FieldByName('recebecomissao').AsString='S';


  qryEu.Close;
  qryEu.SQL.Clear;
  qryEu.SQL.Add('select  AlteraJuros from cadusuario ');
  qryEu.SQL.Add(' where cadusuario.codusur='+CODUSUARIO );
  qryEu.Open;

  ALTERAJUROS:=qryEu.FieldByName('AlteraJuros').AsString;



  frmPincipal.btnLogoff.Caption :='LogOff de '+USUARIO;




   qryEu.Close;
   qryEu.SQl.Clear;
   qryEu.SQl.Add('select codempresa, ifnull(Apelido, fantasia) nome from cadempresa');
   qryEu.Open;

   CODFILIAL :=qryEu.FieldByName('codempresa').AsString;
   NOMEFILIAL:=qryEu.FieldByName('nome').AsString;



   if qryEu.RecordCount>1 then
    begin
      qryFilial.Close;
      qryFilial.SQL.Clear;
      qryFilial.SQL.Add('select cadusurfilial.*, cadempresa.codempresa,'+
                      ' ifnull(cadempresa.apelido, cadempresa.fantasia) as nome,'+
                      ' cadempresa.cnpj'+
                      ' FROM cadusurfilial left join cadempresa on'+
                      ' cadempresa.codempresa = cadusurfilial.codfilial'+
                      ' where cadusurfilial.codusur='+CODUSUARIO+
                      ' group by cadempresa.codempresa');
      qryFilial.Open;
      if qryFilial.FieldByName('codfilial').AsString='0' then
        begin
          qryEu.Close;
          qryEu.SQL.Clear;
          qryEu.SQL.Add('insert into cadusurfilial' +
                        ' set codusur='+CODUSUARIO+
                        ' , codfilial=1');
          qryEu.ExecSQL;
          qryFilial.Refresh;
        end;

      
      //Se houver somente uma filial
      if qryFilial.RecordCount=1 then
      begin
        CODFILIAL:=qryFilial.FieldByName('codfilial').AsString;
        NOMEFILIAL:=qryFilial.FieldByName('nome').AsString;


        if qryFilial.FieldByName('codfilial').AsString='0' then
        begin
          Application.MessageBox('Seu usuário não tem acesso a nenhuma filial da empresa, solicite a liberação ao administrador!','Atenção!', mb_ok+MB_ICONINFORMATION);
          Application.Terminate;
        end;

        with frmPincipal do
        begin
          qryParametros.Close;
          qryParametros.SQL.Clear;
          qryParametros.SQL.Add('select * from cadparametos where CodParametos='+CODFILIAL);
          qryParametros.Open;

          qryParamGerais.Close;
          qryParamGerais.SQL.Clear;
          qryParamGerais.SQL.Add('select * from paramgerais where codfilial='+CODFILIAL);
          qryParamGerais.Open;

          qryEmpresa.Close;
          qryEmpresa.SQL.Clear;
          qryEmpresa.SQL.add('select * from cadempresa where codempresa='+CODFILIAL);
          qryEmpresa.Open;
        end;
      end;


   end;






  //Aniversário do funcionário
  if trim(CODFUNC)<>NullAsStringValue then
  begin
  qryAniversario.Close;
  qryAniversario.SQL.Clear;
  qryAniversario.SQL.Add('select * from cadfunc where codfunc='+CODFUNC);
  qryAniversario.Open;
  end;




  //Verifica a Licença
 // if not frmPincipal.LicencaAtiva(CODFILIAL) then
 //    frmPincipal.licenca;

  //Verifica backUp;
 // frmPincipal.backup;




  if not frmPincipal.QueryLogin.IsEmpty then
  begin
    if frmPincipal.QueryLogin.FieldByName('status').AsString='N' then
    begin
      mensagem:='Você está cadastrado no sistema, mas, não '+#13
      + 'possui autorização para usá-lo neste momento. '+#13+#13
      +'Consulte o administrador do sistema.';
      Application.MessageBox(Pchar(mensagem),'Login não autorizado',
      MB_OK+MB_ICONERROR);
      frmPincipal.Close;
    end
    else
    begin
    {frmPincipal.StatusBar.Panels[2].Text:=' '+'Usuário:'+ Login.ValorNome.Text+
    ' - '+frmPincipal.QueryLogin.FieldByName('depto').AsString;}
    frmPincipal.btnLogoff.Caption   :='Logoff de: '+
    frmPincipal.QueryLogin.FieldByName('login').AsString;
    frmPincipal.btnLogoff.Hint      :='Logoff de: '+
    frmPincipal.QueryLogin.FieldByName('login').AsString;

    end;
  end
  else
  begin
    mensagem:='Nome ou senha do usuário inválidos.'+ #13 + #13
    + 'Se você esqueceu sua senha, consulte ' + #13
    + 'o administrador do sistema.';
    Application.MessageBox(PChar(mensagem), 'Login não autorizado',
    MB_OK+MB_ICONERROR);
    ValorSenha.Text:='';
    ValorSenha.SetFocus;
    ModalResult:=mrNone;
  end;

  //Atualiza a data de instalação
  qryUpdate.close;
  qryUpdate.sql.Clear;
  qryUpdate.sql.Add('update cadparametos set dtinstalacao = current_date where dtinstalacao is null');
  qryUpdate.ExecSQL;

  //Atualiza a data de expiração
  qryUpdate.close;
  qryUpdate.sql.Clear;
  qryUpdate.sql.Add('update cadparametos set explicenca = adddate(current_date,15) where explicenca is null');
  qryUpdate.ExecSQL;

  //Atualiza o CNPJ
  qryUpdate.close;
  qryUpdate.sql.Clear;
  qryUpdate.sql.Add('update cadempresa set cnpj = '+#39+'00.000.000/0000-00'+#39+' where cnpj is null');
  qryUpdate.ExecSQL;

  //Atualiza qt de pc's
  if USUARIO = 'ADMIN' then
  begin
    qryUpdate.close;
    qryUpdate.sql.Clear;
    qryUpdate.sql.Add('update cadparametos set qtpc = qtpc+1');
    qryUpdate.ExecSQL;
  end;






 frmPincipal.Show;
 Self.Hide;
end;



procedure TLogin.BitBtn2Click(Sender: TObject);
begin
Application.Terminate;
end;

function TLogin.DesligarMeuWindows(RebootParam: Longword): Boolean;
var
    TTokenHd: THandle;
    TTokenPvg: TTokenPrivileges;
    cbtpPrevious: DWORD;
    rTTokenPvg: TTokenPrivileges;
    pcbtpPreviousRequired: DWORD;
    tpResult: Boolean;
const
    SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
begin
    if Win32Platform = VER_PLATFORM_WIN32_NT then
    begin
        tpResult := OpenProcessToken(GetCurrentProcess(),
            TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,
            TTokenHd);
        if tpResult then
        begin
            tpResult := LookupPrivilegeValue(nil, SE_SHUTDOWN_NAME, TTokenPvg.Privileges[0].Luid);
            TTokenPvg.PrivilegeCount := 1;
            TTokenPvg.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
            cbtpPrevious := SizeOf(rTTokenPvg);
            pcbtpPreviousRequired := 0;
            if tpResult then
                Windows.AdjustTokenPrivileges(TTokenHd, False, TTokenPvg, cbtpPrevious, rTTokenPvg, pcbtpPreviousRequired);
        end;
    end;
    Result := ExitWindowsEx(RebootParam, 0);

end;

procedure TLogin.FormActivate(Sender: TObject);
begin
ValorNome.SetFocus;
end;

procedure TLogin.FormCreate(Sender: TObject);
begin
  SetWindowPos(Login.handle, HWND_TOPMOST, Login.Left, Login.Top, Login.Width, Login.Height, 0);
end;

procedure TLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_f5 then
LiberarAcessoSuper;
end;

procedure TLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
begin
  SelectNext(ActiveControl,true,true);
  Key:=#0;
end;
end;

procedure TLogin.Label1Click(Sender: TObject);
begin
ShellExecute(Handle,'open','www.thewaysistemas.com',nil,nil,SW_SHOW);
end;

procedure TLogin.Label1MouseEnter(Sender: TObject);
begin
Label1.Font.Color := clBlue;
Label1.Font.Style := [fsUnderline]; 
end;

procedure TLogin.Label1MouseLeave(Sender: TObject);
begin
// Voltando ao normal.
Label1.Font.Color := clWhite;; // Cor original; 
Label1.Font.Style := []; // estilo original
end;

procedure TLogin.LiberarAcessoSuper;
var
comando: string;
begin
qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add('SELECT column_name AS campo FROM information_schema.columns'+
              ' AS campo WHERE table_name = '+#39+'cadperfil'+#39+
              ' AND  DATA_TYPE = '+#39+'char'+#39+
              ' and TABLE_SCHEMA='+#39+frmPincipal.uOrigem.Database+#39+
              ' GROUP BY column_name');
qryEu.Open;


comando:=NullAsStringValue;

while not qryEu.Eof do
begin

 if qryEu.RecordCount<>qryEu.RecNo then
 begin
 comando:=comando+qryEu.FieldByName('campo').AsString+'='+#39+'S'+#39+',';
 end
 else
 begin
 comando:=comando +qryEu.FieldByName('campo').AsString+'='+#39+'S'+#39;
 end;

  qryEu.Next;
end;


 qryUpdate.Close;
 qryUpdate.SQL.Clear;
 qryUpdate.SQL.Add('update cadperfil set '+
                  comando+
                  ' where codperfil=1');

 qryUpdate.ExecSQL;

qryEu.Close;
qryEu.SQL.Clear;
qryEu.SQL.Add('SELECT column_name AS campo FROM information_schema.columns'+
              ' AS campo WHERE table_name = '+#39+'cadperfil2'+#39+
              ' AND  DATA_TYPE = '+#39+'char'+#39+
              ' and TABLE_SCHEMA='+#39+frmPincipal.uOrigem.Database+#39+
              ' GROUP BY column_name');
qryEu.Open;

comando:=NullAsStringValue;

while not qryEu.Eof do
begin

 if qryEu.RecordCount<>qryEu.RecNo then
 begin
 comando:=comando+qryEu.FieldByName('campo').AsString+'='+#39+'S'+#39+',';
 end
 else
 begin
 comando:=comando +qryEu.FieldByName('campo').AsString+'='+#39+'S'+#39;
 end;

  qryEu.Next;
end;

 //Testa se existe cadperfil2
 qryEu.Close;
 qryEu.SQL.Clear;
 qryEu.SQL.Add('select * from cadperfil2');
 qryEu.Open;

 if qryEu.RecordCount=0 then
 begin
  qryEu.Close;
  qryEu.SQL.Clear;
  qryEu.SQL.Add('insert into cadperfil2 set codperfil2=1');
  qryEu.ExecSQL;
 end;

 qryUpdate.Close;
 qryUpdate.SQL.Clear;
 qryUpdate.SQL.Add('update cadperfil2 set '+
                  comando+
                  ' where codperfil2=1');
 qryUpdate.ExecSQL;


end;

function TLogin.SoNumeros(const Texto: String): String;
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

procedure TLogin.ValorNomeEnter(Sender: TObject);
begin
ValorNome.Color:=clYellow;
end;

procedure TLogin.ValorNomeExit(Sender: TObject);
begin
ValorNome.Color:=clWhite;
end;

procedure TLogin.ValorSenhaEnter(Sender: TObject);
begin
ValorSenha.Color:=clYellow;
end;

procedure TLogin.ValorSenhaExit(Sender: TObject);
begin
ValorSenha.Color:=clWhite;
BitBtn1.Click;
end;

end.
