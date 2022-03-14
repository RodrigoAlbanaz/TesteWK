object FPedidos: TFPedidos
  Left = 0
  Top = 0
  ActiveControl = btConectar
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Pedido de Venda'
  ClientHeight = 333
  ClientWidth = 533
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbNumeroPedido: TLabel
    Left = 24
    Top = 16
    Width = 36
    Height = 13
    Caption = 'Pedido:'
  end
  object lbCliente: TLabel
    Left = 24
    Top = 56
    Width = 37
    Height = 13
    Caption = 'Cliente:'
  end
  object lbProduto: TLabel
    Left = 24
    Top = 96
    Width = 42
    Height = 13
    Caption = 'Produto:'
  end
  object lbCidade: TLabel
    Left = 280
    Top = 56
    Width = 37
    Height = 13
    Caption = 'Cidade:'
  end
  object lbUF: TLabel
    Left = 448
    Top = 56
    Width = 17
    Height = 13
    Caption = 'UF:'
  end
  object lbQtdProduto: TLabel
    Left = 280
    Top = 96
    Width = 22
    Height = 13
    Caption = 'Qtd:'
  end
  object lbPrecoProduto: TLabel
    Left = 361
    Top = 96
    Width = 27
    Height = 13
    Caption = 'Pre'#231'o'
  end
  object lbTotalPedido: TLabel
    Left = 24
    Top = 276
    Width = 78
    Height = 13
    Caption = 'Total do Pedido:'
  end
  object dbtTotalPedido: TDBText
    Left = 112
    Top = 276
    Width = 65
    Height = 17
    DataField = 'TOTAL_PEDIDO'
    DataSource = dsProdutos
  end
  object lbDataEmissao: TLabel
    Left = 155
    Top = 16
    Width = 42
    Height = 13
    Caption = 'Emiss'#227'o:'
  end
  object btConectar: TButton
    Left = 422
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Conectar'
    TabOrder = 0
    OnClick = btConectarClick
  end
  object edNumeroPedido: TEdit
    Left = 67
    Top = 13
    Width = 71
    Height = 21
    Enabled = False
    TabOrder = 1
  end
  object edCodigoCliente: TEdit
    Left = 67
    Top = 53
    Width = 46
    Height = 21
    NumbersOnly = True
    TabOrder = 2
    OnChange = edCodigoClienteChange
    OnExit = edCodigoClienteExit
  end
  object edNomeCliente: TEdit
    Left = 119
    Top = 53
    Width = 153
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 3
  end
  object edCodigoProduto: TEdit
    Left = 67
    Top = 93
    Width = 46
    Height = 21
    NumbersOnly = True
    TabOrder = 4
    OnExit = edCodigoProdutoExit
    OnKeyDown = edCodigoProdutoKeyDown
  end
  object edDescricaoProduto: TEdit
    Left = 119
    Top = 93
    Width = 153
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 5
  end
  object edCidade: TEdit
    Left = 323
    Top = 53
    Width = 118
    Height = 21
    Enabled = False
    TabOrder = 6
    OnExit = edCodigoClienteExit
  end
  object edUF: TEdit
    Left = 471
    Top = 53
    Width = 46
    Height = 21
    Enabled = False
    TabOrder = 7
    OnExit = edCodigoClienteExit
  end
  object edQtdProduto: TEdit
    Left = 307
    Top = 93
    Width = 46
    Height = 21
    NumbersOnly = True
    TabOrder = 8
  end
  object edPrecoProduto: TEdit
    Left = 395
    Top = 93
    Width = 46
    Height = 21
    Enabled = False
    NumbersOnly = True
    TabOrder = 9
    OnExit = edCodigoProdutoExit
  end
  object btIncluirProduto: TButton
    Left = 470
    Top = 91
    Width = 47
    Height = 25
    Caption = 'Incluir'
    TabOrder = 10
    OnClick = btIncluirProdutoClick
  end
  object grdProdutos: TDBGrid
    Left = 24
    Top = 122
    Width = 493
    Height = 145
    DataSource = dsProdutos
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 11
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyDown = grdProdutosKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'AUTOINCREM'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'NUMERO_PEDIDO'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'CODIGO_PRODUTO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO_PRODUTO'
        Width = 235
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QUANTIDADE'
        Width = 31
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VLR_UNITARIO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VLR_TOTAL'
        Visible = True
      end>
  end
  object btGravar: TButton
    Left = 323
    Top = 300
    Width = 85
    Height = 25
    Caption = '&Gravar Pedido'
    TabOrder = 12
    OnClick = btGravarClick
  end
  object edDataEmissao: TEdit
    Left = 199
    Top = 13
    Width = 73
    Height = 21
    Enabled = False
    TabOrder = 13
  end
  object btCarregarPedido: TButton
    Left = 227
    Top = 300
    Width = 90
    Height = 25
    Caption = 'Carregar Pedido'
    TabOrder = 14
    OnClick = btCarregarPedidoClick
  end
  object btCancelarAlteracoes: TButton
    Left = 414
    Top = 300
    Width = 103
    Height = 25
    Caption = 'Cancelar Altera'#231#245'es'
    TabOrder = 15
    OnClick = btCancelarAlteracoesClick
  end
  object btCancelarPedido: TButton
    Left = 128
    Top = 300
    Width = 93
    Height = 25
    Caption = 'Cancelar Pedido'
    TabOrder = 16
    OnClick = btCancelarPedidoClick
  end
  object dsProdutos: TDataSource
    DataSet = DM.mtProdutos
    Left = 264
    Top = 200
  end
end
