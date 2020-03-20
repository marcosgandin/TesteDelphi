unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ComCtrls, IdComponent, IdException, SqlExpr, Vcl.Samples.Gauges,
  uThreadDonwnload;

type
  TfPrincipal = class(TForm)
    lbUrl: TLabel;
    btIniciarDownload: TButton;
    btPararDownload: TButton;
    btExibirMensagem: TButton;
    btExibirHistórico: TButton;
    btSair: TButton;
    dbUrl: TEdit;
    Gauge1: TGauge;
    lbStatus: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btSairClick(Sender: TObject);
    procedure btIniciarDownloadClick(Sender: TObject);
    procedure btExibirMensagemClick(Sender: TObject);
    procedure btExibirHistóricoClick(Sender: TObject);
    procedure btPararDownloadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    nCodigo : Integer;
    function VerificaCampoURLPreenchido: Boolean;
    function VerificaECriaPasta(sPath: string): Boolean;
    function GetNameFileFromLink(Url: String): String;
    function GeraCodigo: Integer;
    procedure InserirRegistros;
    procedure AtualizaDataFinal;
  end;

var
  fPrincipal: TfPrincipal;
  ThreadBaixar: TBaixar;
  parar: Boolean = False;
  sArquivo: string;

const
  sPasta : string = 'C:\Downloads\';

implementation

{$R *.dfm}

uses uDM, uDownload, uHistorico;

procedure TfPrincipal.AtualizaDataFinal;
begin
  dmDownload.qyUpdate.Close;
  dmDownload.qyUpdate.SQL.Clear;
  dmDownload.qyUpdate.SQL.Text := 'Update LogDownload Set DataFim = :DataFim '+
                                  'Where Codigo = :Codigo';
  dmDownload.qyUpdate.ParamByName('DataFim').AsDate := Now;
  dmDownload.qyUpdate.ParamByName('Codigo').AsInteger := nCodigo;

  try
    dmDownload.qyUpdate.ExecSQL;
  except
    on E:Exception do
      ShowMessage('Erro na inserção do registro: '+E.Message);
  end;
end;

procedure TfPrincipal.btExibirHistóricoClick(Sender: TObject);
begin
  fHistorico := TfHistorico.Create(Application);
  fHistorico.ShowModal;
  fHistorico.Free;
end;

procedure TfPrincipal.btExibirMensagemClick(Sender: TObject);
begin
  if btExibirMensagem.Caption = 'Exibir mensagem' then
  begin
    btExibirMensagem.Caption := 'Esconder mensagem';
    Gauge1.ShowText := True;
  end
  else
  begin
    btExibirMensagem.Caption := 'Exibir mensagem';
    Gauge1.ShowText := False;
  end;
end;

procedure TfPrincipal.btIniciarDownloadClick(Sender: TObject);
begin
  if not VerificaCampoURLPreenchido then
  begin
    ShowMessage('Campo URL não está preenchido!');
    dbUrl.SetFocus;
    Abort;
  end;

  if VerificaECriaPasta(sPasta) then
  begin
    dbUrl.Enabled := False;
    btIniciarDownload.Enabled := False;
    btPararDownload.Enabled := True;
    parar := False;
    sArquivo := sPasta + GetNameFileFromLink(dbUrl.Text);

    if Gauge1.Progress = 0 then
    begin
      if FileExists(sArquivo) then
        DeleteFile(sArquivo);

      InserirRegistros;
    end;

    ThreadBaixar := TBaixar.Create (True);
    ThreadBaixar.FreeOnTerminate := True;
    ThreadBaixar.Resume;

    Application.ProcessMessages;
  end
  else
    ShowMessage('Não foi possível criar a pasta: '+sPasta);
end;

procedure TfPrincipal.btPararDownloadClick(Sender: TObject);
begin
  btIniciarDownload.Enabled := True;
  btPararDownload.Enabled := False;
  parar := True;
end;

procedure TfPrincipal.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(dmDownload);
end;

procedure TfPrincipal.FormCreate(Sender: TObject);
begin
  dmDownload := TdmDownload.Create(Self);
end;

function TfPrincipal.GeraCodigo: Integer;
begin
  dmDownload.qyAux.Close;
  dmDownload.qyAux.SQL.Clear;
  dmDownload.qyAux.SQL.Text := 'Select Max(Codigo) as Codigo From LogDownload';
  dmDownload.qyAux.Open;

  if dmDownload.qyAux.FieldByName('Codigo').Value = null then
    nCodigo := 1
  else
    nCodigo := dmDownload.qyAux.FieldByName('Codigo').AsInteger + 1;

  Result := nCodigo;
end;

function TfPrincipal.GetNameFileFromLink(Url: String): String;
var
   pos: ShortInt;
begin
   pos := LastDelimiter('/', Url);
   Result := Copy(url, pos + 1, MaxInt);
end;

procedure TfPrincipal.InserirRegistros;
begin
  dmDownload.qyInsert.Close;
  dmDownload.qyInsert.SQL.Clear;
  dmDownload.qyInsert.SQL.Text := 'Insert Into LogDownload '+
                                  '  (Codigo, URL, DataInicio) '+
                                  'Values (:Codigo, :URL, :DataInicio)';
  dmDownload.qyInsert.ParamByName('Codigo').AsInteger := GeraCodigo;
  dmDownload.qyInsert.ParamByName('URL').AsString := dbUrl.Text;
  dmDownload.qyInsert.ParamByName('DataInicio').AsDate := Now;

  try
    dmDownload.qyInsert.ExecSQL;
  except
    on E:Exception do
      ShowMessage('Erro na inserção do registro: '+E.Message);
  end;
end;

function TfPrincipal.VerificaCampoURLPreenchido: Boolean;
begin
  Result := dbUrl.Text <> '';
end;

function TfPrincipal.VerificaECriaPasta(sPath: string): Boolean;
begin
  Result := False;

  if not DirectoryExists(sPath)then
  begin
    if not CreateDir(sPath) then
      Result := False
    else
      Result := True;
  end
  else
    Result := True;
end;

end.
