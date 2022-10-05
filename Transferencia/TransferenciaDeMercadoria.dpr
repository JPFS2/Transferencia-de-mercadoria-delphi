program TransferenciaDeMercadoria;

uses
  Forms,
  uPrincipal in 'uPrincipal.pas' {frmPincipal},
  UModelo in 'UModelo.pas' {frmModelo},
  frmLogin in 'frmLogin.pas' {Login},
  uVPN in 'uVPN.pas' {frmVPN},
  uTrasf in 'uTrasf.pas' {frmTrasf};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPincipal, frmPincipal);
  Application.CreateForm(Tlogin, login);
  //Cria a tela de login
    Login.ShowModal;                     //Exibe a tela de login
    Login.Destroy;                       //Depois de logar fecha a tela de login
  Application.Run;
end.
