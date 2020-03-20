program Download;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {fPrincipal},
  uDM in 'uDM.pas' {dmDownload: TDataModule},
  uHistorico in 'uHistorico.pas' {fHistorico},
  uThreadDonwnload in 'uThreadDonwnload.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfPrincipal, fPrincipal);
  Application.Run;
end.
