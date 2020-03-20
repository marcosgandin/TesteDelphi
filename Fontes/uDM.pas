unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, Vcl.StdCtrls, Winapi.Windows,
  Vcl.Controls, Vcl.Forms, Datasnap.DBClient, Datasnap.Provider;

type
  TdmDownload = class(TDataModule)
    dsDownload: TDataSource;
    cnDownload: TFDConnection;
    qyInsert: TFDQuery;
    csInsert: TClientDataSet;
    dsInsert: TDataSource;
    dpInsert: TDataSetProvider;
    qyAux: TFDQuery;
    qyUpdate: TFDQuery;
    csUpdate: TClientDataSet;
    dsUpdate: TDataSource;
    dpUpdate: TDataSetProvider;
    dsSelect: TDataSource;
    dpSelect: TDataSetProvider;
    qySelect: TFDQuery;
    csSelect: TClientDataSet;
    csSelectCodigo: TFMTBCDField;
    csSelectURL: TStringField;
    csSelectDataInicio: TDateField;
    csSelectDataFim: TDateField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDownload: TdmDownload;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmDownload.DataModuleCreate(Sender: TObject);
begin
  try
    cnDownload.Connected := True;
  except
    Application.MessageBox('Houve Problemas ao conectar a base de dados!','CONEXÃO FALHOU');
  end;
end;

procedure TdmDownload.DataModuleDestroy(Sender: TObject);
begin
  cnDownload.Connected := False;
end;

end.
