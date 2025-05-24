object ModelConexaoDM: TModelConexaoDM
  OldCreateOrder = False
  Height = 648
  Width = 1045
  object FDconnection1: TFDConnection
    Params.Strings = (
      'Database=127.0.0.1/3051:D:\_DelphiEstudos\Vendas\Dados\Dados.fdb'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 400
    Top = 104
  end
  object fdgxwtcrsr1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 400
    Top = 200
  end
  object fdphysfbdrvrlnk1: TFDPhysFBDriverLink
    Left = 400
    Top = 280
  end
end
