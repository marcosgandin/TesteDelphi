object dmDownload: TdmDownload
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 305
  Width = 379
  object dsDownload: TDataSource
    Left = 32
    Top = 32
  end
  object cnDownload: TFDConnection
    Params.Strings = (
      'Database=C:\Projetos\TesteDelphi\Banco\TesteDelphiSoftplan.db'
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 112
    Top = 32
  end
  object qyInsert: TFDQuery
    Connection = cnDownload
    Left = 32
    Top = 104
  end
  object csInsert: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dpInsert'
    Left = 200
    Top = 104
  end
  object dsInsert: TDataSource
    DataSet = csInsert
    Left = 144
    Top = 104
  end
  object dpInsert: TDataSetProvider
    DataSet = qyInsert
    Left = 88
    Top = 104
  end
  object qyAux: TFDQuery
    Connection = cnDownload
    Left = 288
    Top = 72
  end
  object qyUpdate: TFDQuery
    Connection = cnDownload
    Left = 32
    Top = 160
  end
  object csUpdate: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dpUpdate'
    Left = 200
    Top = 160
  end
  object dsUpdate: TDataSource
    DataSet = csUpdate
    Left = 144
    Top = 160
  end
  object dpUpdate: TDataSetProvider
    DataSet = qyUpdate
    Left = 88
    Top = 160
  end
  object dsSelect: TDataSource
    DataSet = csSelect
    Left = 144
    Top = 220
  end
  object dpSelect: TDataSetProvider
    DataSet = qySelect
    Left = 88
    Top = 216
  end
  object qySelect: TFDQuery
    Connection = cnDownload
    SQL.Strings = (
      
        'Select Codigo, URL, DataInicio, DataFim From LogDownload Order B' +
        'y Codigo Desc')
    Left = 32
    Top = 216
  end
  object csSelect: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dpSelect'
    Left = 208
    Top = 224
    object csSelectCodigo: TFMTBCDField
      FieldName = 'Codigo'
      Required = True
      Precision = 22
      Size = 0
    end
    object csSelectURL: TStringField
      FieldName = 'URL'
      Required = True
      Size = 600
    end
    object csSelectDataInicio: TDateField
      FieldName = 'DataInicio'
      Required = True
    end
    object csSelectDataFim: TDateField
      FieldName = 'DataFim'
    end
  end
end
