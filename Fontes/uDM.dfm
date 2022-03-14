object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 338
  Width = 324
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=bancoteste'
      'User_Name=root'
      'Password=root'
      'Server=localhoste'
      'DriverID=MySQL')
    Left = 24
    Top = 16
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'libmysql.dll'
    Left = 128
    Top = 16
  end
  object sqlCliente: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select codigo, nome, cidade, uf'
      'from clientes'
      'where codigo = :codigo')
    Left = 24
    Top = 80
    ParamData = <
      item
        Name = 'CODIGO'
        ParamType = ptInput
      end>
  end
  object mtProdutos: TFDMemTable
    AggregatesActive = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 208
    Top = 80
    object mtProdutosAUTOINCREM: TIntegerField
      FieldName = 'AUTOINCREM'
    end
    object mtProdutosNUMERO_PEDIDO: TIntegerField
      FieldName = 'NUMERO_PEDIDO'
    end
    object mtProdutosCODIGO_PRODUTO: TIntegerField
      DisplayLabel = 'C'#243'd. Produto'
      FieldName = 'CODIGO_PRODUTO'
    end
    object mtProdutosDESCRICAO_PRODUTO: TStringField
      DisplayLabel = 'Descricao'
      FieldName = 'DESCRICAO_PRODUTO'
      Size = 120
    end
    object mtProdutosQUANTIDADE: TFloatField
      DisplayLabel = 'Qtd.'
      FieldName = 'QUANTIDADE'
    end
    object mtProdutosVLR_UNITARIO: TFloatField
      DisplayLabel = 'Vlr. Unit'#225'rio'
      FieldName = 'VLR_UNITARIO'
      DisplayFormat = '0.00'
    end
    object mtProdutosVLR_TOTAL: TFloatField
      DisplayLabel = 'Vlr. Total'
      FieldName = 'VLR_TOTAL'
      DisplayFormat = '0.00'
    end
    object mtProdutosTOTAL_PEDIDO: TAggregateField
      FieldName = 'TOTAL_PEDIDO'
      Active = True
      DisplayName = ''
      DisplayFormat = '0.00'
      Expression = 'SUM(VLR_TOTAL)'
    end
  end
  object sqlProduto: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select codigo, descricao, preco'
      'from produtos'
      'where codigo = :codigo')
    Left = 120
    Top = 80
    ParamData = <
      item
        Name = 'CODIGO'
        ParamType = ptInput
      end>
  end
  object sqlInserePedido: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      
        'insert into pedidos (numero_pedido, data_emissao, codigo_cliente' +
        ', valor_total)'
      'values (null, current_date(), :cliente, :total)')
    Left = 24
    Top = 136
    ParamData = <
      item
        Name = 'CLIENTE'
        ParamType = ptInput
      end
      item
        Name = 'TOTAL'
        ParamType = ptInput
      end>
  end
  object sqlAlteraPedido: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'update pedidos'
      'set codigo_cliente = :cliente,'
      '    valor_total = :total'
      'where numero_pedido = :pedido')
    Left = 120
    Top = 136
    ParamData = <
      item
        Name = 'CLIENTE'
        ParamType = ptInput
      end
      item
        Name = 'TOTAL'
        ParamType = ptInput
      end
      item
        Name = 'PEDIDO'
        ParamType = ptInput
      end>
  end
  object sqlExcluiPedido: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'delete from pedidos'
      'where numero_pedido = :pedido')
    Left = 208
    Top = 136
    ParamData = <
      item
        Name = 'PEDIDO'
        ParamType = ptInput
      end>
  end
  object sqlExcluiProdutos: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'delete from pedidos_produtos'
      'where numero_pedido = :pedido')
    Left = 24
    Top = 192
    ParamData = <
      item
        Name = 'PEDIDO'
        ParamType = ptInput
      end>
  end
  object sqlInsereProdutos: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      
        'insert into pedidos_produtos (autoincrem, numero_pedido, codigo_' +
        'produto, quantidade, vlr_unitario, vlr_total)'
      
        'values (null, :pedido, :produto, :quantidade, :vlr_unitario, :vl' +
        'r_total)')
    Left = 120
    Top = 192
    ParamData = <
      item
        Name = 'PEDIDO'
        ParamType = ptInput
      end
      item
        Name = 'PRODUTO'
        ParamType = ptInput
      end
      item
        Name = 'QUANTIDADE'
        ParamType = ptInput
      end
      item
        Name = 'VLR_UNITARIO'
        ParamType = ptInput
      end
      item
        Name = 'VLR_TOTAL'
        ParamType = ptInput
      end>
  end
  object sqlUltimoPedido: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select max(numero_pedido) as numero_pedido'
      'from pedidos;')
    Left = 208
    Top = 192
  end
  object sqlCarregaPedido: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select numero_pedido, data_emissao, codigo_cliente, valor_total'
      'from pedidos'
      'where numero_pedido = :pedido')
    Left = 24
    Top = 264
    ParamData = <
      item
        Name = 'PEDIDO'
        ParamType = ptInput
      end>
  end
  object sqlCarregaProdutos: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select pp.autoincrem, pp.numero_pedido, pp.codigo_produto, '
      
        '       pp.quantidade, pp.vlr_unitario, pp.vlr_total, p.descricao' +
        ' descricao_produto'
      'from pedidos_produtos pp'
      'left join produtos p on p.codigo = pp.codigo_produto'
      'where pp.numero_pedido = :pedido')
    Left = 120
    Top = 264
    ParamData = <
      item
        Name = 'PEDIDO'
        ParamType = ptInput
      end>
  end
end
