object fPrincipal: TfPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Download'
  ClientHeight = 171
  ClientWidth = 742
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbUrl: TLabel
    Left = 16
    Top = 24
    Width = 27
    Height = 16
    Caption = 'URL:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Gauge1: TGauge
    Left = 9
    Top = 61
    Width = 720
    Height = 30
    ForeColor = clSkyBlue
    Progress = 0
    ShowText = False
  end
  object lbStatus: TLabel
    Left = 16
    Top = 98
    Width = 4
    Height = 16
    Caption = ' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object btIniciarDownload: TButton
    Left = 8
    Top = 134
    Width = 113
    Height = 25
    Caption = 'Iniciar download'
    TabOrder = 1
    OnClick = btIniciarDownloadClick
  end
  object btExibirMensagem: TButton
    Left = 246
    Top = 134
    Width = 113
    Height = 25
    Caption = 'Exibir mensagem'
    TabOrder = 3
    OnClick = btExibirMensagemClick
  end
  object btPararDownload: TButton
    Left = 127
    Top = 134
    Width = 113
    Height = 25
    Caption = 'Parar download'
    TabOrder = 2
    OnClick = btPararDownloadClick
  end
  object btSair: TButton
    Left = 616
    Top = 134
    Width = 113
    Height = 25
    Caption = 'Sair'
    TabOrder = 5
    OnClick = btSairClick
  end
  object btExibirHistórico: TButton
    Left = 365
    Top = 134
    Width = 164
    Height = 25
    Caption = 'Exibir hist'#243'rico de downloads'
    TabOrder = 4
    OnClick = btExibirHistóricoClick
  end
  object dbUrl: TEdit
    Left = 49
    Top = 23
    Width = 680
    Height = 21
    TabOrder = 0
  end
end
