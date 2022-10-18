unit uVPN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UModelo, AdvGlowButton, ACBrBase, ACBrMail, DASQLMonitor,
  UniSQLMonitor, DB, MemDS, DBAccess, Uni, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdFTP, ImgList,
  cxGraphics, AdvOfficeStatusBar, ExtCtrls, Grids, DBGrids;

type
  TfrmVPN = class(TfrmModelo)
    btnSair: TAdvGlowButton;
    DBGrid1: TDBGrid;
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVPN: TfrmVPN;

implementation

uses UPrincipal, frmLogin, uTrasf;

{$R *.dfm}

procedure TfrmVPN.btnSairClick(Sender: TObject);
begin
  inherited;
close;
end;

procedure TfrmVPN.DBGrid1DblClick(Sender: TObject);
var
EndrecoAtual,EnderecoDoBanco: String;
begin
  inherited;

TRY
if frmPincipal.uDestino.Connected then
   EndrecoAtual:=frmPincipal.uDestino.Server;

EnderecoDoBanco:=frmPincipal.qryVPN.FieldByName('IP').AsString;
frmPincipal.uDestino.Disconnect;
frmPincipal.uDestino.Server:=frmPincipal.qryVPN.FieldByName('IP').AsString;
frmPincipal.uDestino.Connect;
EXCEPT
  Application.MessageBox('Não foi possível conectar à filial desejada','Atenção',MB_ICONEXCLAMATION);
  EnderecoDoBanco:='';
  frmPincipal.uDestino.Server:=EndrecoAtual;
  Exit;

END;
frmPincipal.qryEmpresa.Close;
frmPincipal.qryEmpresa.OPEN;

CLOSE;
end;

procedure TfrmVPN.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
if key=vk_return then
   DBGrid1DblClick(sender);
end;

procedure TfrmVPN.FormCreate(Sender: TObject);
begin
  inherited;
frmPincipal.qryVPN.Close;  
frmPincipal.qryVPN.Open;
end;

procedure TfrmVPN.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
if Key=vk_escape then
if btnSair.Enabled then
   btnSair.Click;
   
end;

end.
