unit uThreadDonwnload;

interface

uses Classes, IdBaseComponent, IdComponent, IdTCPConnection, Dialogs,
  IdTCPClient, IdHTTP, SysUtils, Math, IdException;

type
  TBaixar = class(TThread)
  Http: TIdHTTP;
  fFileStream: TFileStream;
  Tam_Tot_arq: Integer;
  quant_baixada_arq: Integer;
  ja_baixado: integer;

  protected
  procedure Execute; override;
  procedure HTTPWork(ASender: TObject; AWorkMode: TWorkMode;
            AWorkCount: Int64);
  procedure HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
            AWorkCountMax: Int64);
  procedure HTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);

end;

implementation

uses
  uPrincipal;

{ TBaixar }

procedure TBaixar.Execute;
var
  terminado:Boolean;
begin
  Http := TIdHTTP.Create(nil);
  fFileStream := nil;
  try
    Http.OnWorkBegin := HTTPWorkBegin;
    Http.OnWork := HTTPWork;
    Http.OnWorkEnd := HTTPWorkEnd;
    HTTP.Request.UserAgent :='Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0';
    Http.Request.CacheControl := 'no-cache';

    Http.Head(fPrincipal.dbUrl.Text);
    Tam_Tot_arq := Http.Response.ContentLength;
    terminado := False;
    repeat
      if uPrincipal.parar then
        Http.Free;

      if not FileExists(uPrincipal.sArquivo) then
      begin
        fFileStream := TFileStream.Create(uPrincipal.sArquivo, fmCreate);
      end
      else
      begin
        fFileStream := TFileStream.Create(uPrincipal.sArquivo, fmOpenReadWrite);
        terminado:= fFileStream.Size >= Tam_Tot_arq;
        ja_baixado:=fFileStream.Size;
        if not terminado then
          fFileStream.Seek(Max(0, fFileStream.Size-4096), soFromBeginning);
      end;

      try
        quant_baixada_arq := fFileStream.Size + 50000;
        if quant_baixada_arq < Tam_Tot_arq then
        begin
          Http.Request.Range := IntToStr(fFileStream.Position) + '-'+  IntToStr(quant_baixada_arq);
        end
        else
        begin
          Http.Request.Range := IntToStr(fFileStream.Position) + '-';
          terminado:=true;
        end;
        Http.Get(fPrincipal.dbUrl.Text, fFileStream);
      finally
        fFileStream.Free;
      end;
    until terminado;

    Http.Disconnect;
  finally
    Http.Free;
  end;
end;

procedure TBaixar.HTTPWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  fPrincipal.Gauge1.Progress :=  Trunc((ja_baixado/Tam_Tot_arq)*101);
  fPrincipal.lbStatus.Caption := IntToStr(Trunc(ja_baixado/1024))+' de '+IntToStr(Trunc(Tam_Tot_arq/1024))+' kb';
  fPrincipal.lbStatus.Refresh;
end;

procedure TBaixar.HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin

end;

procedure TBaixar.HTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  if fPrincipal.Gauge1.Progress = 100 then
  begin
    fPrincipal.AtualizaDataFinal;
    fPrincipal.dbUrl.Enabled := True;
    fPrincipal.dbUrl.Clear;
    fPrincipal.dbUrl.SetFocus;
    fPrincipal.btIniciarDownload.Enabled := True;
  end;
end;

end.
