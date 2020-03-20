object fHistorico: TfHistorico
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Hist'#243'rico'
  ClientHeight = 211
  ClientWidth = 918
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 170
    Width = 918
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 176
    ExplicitWidth = 776
    object btSair: TButton
      Left = 362
      Top = 6
      Width = 113
      Height = 25
      Caption = 'Sair'
      TabOrder = 0
      OnClick = btSairClick
    end
  end
  object gdHistorico: TDBGrid
    Left = 0
    Top = 0
    Width = 918
    Height = 170
    Align = alClient
    DataSource = dmDownload.dsSelect
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Codigo'
        Title.Caption = 'C'#243'digo'
        Width = 41
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'URL'
        Width = 642
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DataInicio'
        Title.Caption = 'Data In'#237'cio'
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DataFim'
        Title.Caption = 'Data Fim'
        Width = 74
        Visible = True
      end>
  end
end
