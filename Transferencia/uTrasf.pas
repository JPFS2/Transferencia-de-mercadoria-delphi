unit uTrasf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UModelo, ACBrBase, ACBrMail, DASQLMonitor, UniSQLMonitor, DB, MemDS,
  DBAccess, Uni, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP, ImgList, cxGraphics, AdvOfficeStatusBar,
  ExtCtrls, AdvGlowButton, UniProvider, MySQLUniProvider, Grids, DBGrids, Menus,
  StdCtrls, Mask, DBCtrls, Buttons;

type
  TfrmTrasf = class(TfrmModelo)
    Sair: TAdvGlowButton;
    btNovo: TAdvGlowButton;
    btSalvar: TAdvGlowButton;
    btCancelar: TAdvGlowButton;
    MySQLUniProvider1: TMySQLUniProvider;
    Label1: TLabel;
    qryEucodtransferencia: TIntegerField;
    qryEucodfilialorigem: TIntegerField;
    qryEucodfilialdestino: TIntegerField;
    qryEudttransferencia: TDateField;
    qryEuhrtransferencia: TTimeField;
    qryEucodusur: TIntegerField;
    qryEuusurario: TStringField;
    qryEucodfunc: TIntegerField;
    qryEuhistorico: TStringField;
    qryEudtbaixa: TDateField;
    qryEuhrbaixa: TTimeField;
    qryEucodusurbaixa: TIntegerField;
    qryEuusurbaixa: TStringField;
    qryEupktemp: TStringField;
    qryRotinacoditem: TIntegerField;
    qryRotinacodtransferencia: TIntegerField;
    qryRotinacodfilialorigem: TIntegerField;
    qryRotinacodfilialdestino: TIntegerField;
    qryRotinacodprod: TIntegerField;
    qryRotinaqt: TFloatField;
    qryRotinahistorico: TStringField;
    qryRotinaobs: TStringField;
    qryRotinadttransferencia: TDateField;
    qryRotinahrtransferencia: TTimeField;
    qryRotinacodusur: TIntegerField;
    qryRotinausuario: TStringField;
    qryRotinadtbaixa: TDateField;
    qryRotinahrbaixa: TTimeField;
    qryRotinabaixado: TStringField;
    qryRotinacodusurbaixa: TIntegerField;
    qryRotinapktemp: TStringField;
    qryRotinanumtransent: TIntegerField;
    qryRotinacodent: TIntegerField;
    txtBusca: TEdit;
    dscTransferencias: TDataSource;
    dscTransfintens: TDataSource;
    qryTransfitens: TUniQuery;
    qryTabtransferencia: TUniQuery;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    txtBuscar2: TEdit;
    BitBtn2: TBitBtn;
    gridTransfitens: TDBGrid;
    gridtabtransferencia: TDBGrid;
    procedure btnSairClick(Sender: TObject);
    procedure AdvGlowButton1Click(Sender: TObject);
    procedure AdvGlowButton1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tratabotoes();
    procedure btNovoClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTrasf: TfrmTrasf;

implementation

uses frmLogin, uPrincipal, uVPN;

{$R *.dfm}



procedure TfrmTrasf.AdvGlowButton1Click(Sender: TObject);
begin
  inherited;
    close
end;

procedure TfrmTrasf.AdvGlowButton1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  close;
end;

procedure TfrmTrasf.BitBtn1Click(Sender: TObject);
begin
    inherited;
    qryTransfitens.filtered := false;
    qryTransfitens.filter   := 'codtransferencia like' +QuotedStr('%'+txtBusca.Text+'%');
    qryTransfitens.filtered :=  true;
end;

procedure TfrmTrasf.BitBtn2Click(Sender: TObject);
begin
    inherited;
    qryTransfitens.filtered := false;
    qryTransfitens.filter   := 'codtransferencia like' +QuotedStr('%'+txtBusca.Text+'%');
    qryTransfitens.filtered :=  true;
end;

procedure TfrmTrasf.btCancelarClick(Sender: TObject);
begin
  inherited;
    tratabotoes;
end;

procedure TfrmTrasf.btNovoClick(Sender: TObject);
begin
  inherited;
    tratabotoes;

end;

procedure TfrmTrasf.btnSairClick(Sender: TObject);
begin
  inherited;
      close;
end;

procedure TfrmTrasf.btSalvarClick(Sender: TObject);
begin
  inherited;
    tratabotoes;
end;

procedure TfrmTrasf.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_escape then
   Sair.Click;
end;

procedure TfrmTrasf.tratabotoes;
begin
    btNovo.Enabled:=not btNovo.Enabled;
    btSalvar.Enabled:= not btSalvar.Enabled;
    btCancelar.enabled:= not btCancelar.Enabled;
end;

end.
