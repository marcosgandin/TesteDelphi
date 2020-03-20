unit uHistorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfHistorico = class(TForm)
    Panel1: TPanel;
    gdHistorico: TDBGrid;
    btSair: TButton;
    procedure FormShow(Sender: TObject);
    procedure btSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fHistorico: TfHistorico;

implementation

{$R *.dfm}

uses uDM;

procedure TfHistorico.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfHistorico.FormShow(Sender: TObject);
begin
  dmDownload.csSelect.Close;

  dmDownload.qySelect.Close;
  dmDownload.qySelect.SQL.Clear;
  dmDownload.qySelect.SQL.Add('Select Codigo, URL, DataInicio, DataFim From LogDownload Order By Codigo Desc ');

  dmDownload.csSelect.Open;
end;

end.
