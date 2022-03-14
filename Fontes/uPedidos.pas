unit uPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, uClassCliente, uClassProduto,
  Data.DB, Vcl.DBGrids, Vcl.DBCtrls;

type
  TFPedidos = class(TForm)
    btConectar: TButton;
    lbNumeroPedido: TLabel;
    edNumeroPedido: TEdit;
    lbCliente: TLabel;
    edCodigoCliente: TEdit;
    edNomeCliente: TEdit;
    lbProduto: TLabel;
    edCodigoProduto: TEdit;
    edDescricaoProduto: TEdit;
    lbCidade: TLabel;
    edCidade: TEdit;
    lbUF: TLabel;
    edUF: TEdit;
    edQtdProduto: TEdit;
    lbQtdProduto: TLabel;
    edPrecoProduto: TEdit;
    lbPrecoProduto: TLabel;
    btIncluirProduto: TButton;
    dsProdutos: TDataSource;
    grdProdutos: TDBGrid;
    btGravar: TButton;
    lbTotalPedido: TLabel;
    dbtTotalPedido: TDBText;
    lbDataEmissao: TLabel;
    edDataEmissao: TEdit;
    btCarregarPedido: TButton;
    btCancelarAlteracoes: TButton;
    btCancelarPedido: TButton;
    procedure btConectarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edCodigoClienteExit(Sender: TObject);
    procedure edCodigoProdutoExit(Sender: TObject);
    procedure btIncluirProdutoClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure grdProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btCarregarPedidoClick(Sender: TObject);
    procedure btCancelarAlteracoesClick(Sender: TObject);
    procedure edCodigoClienteChange(Sender: TObject);
    procedure btCancelarPedidoClick(Sender: TObject);
  private
    { Private declarations }
    Cliente: TCliente;
    Produto: TProduto;
    procedure pLimpaProduto;
    procedure pLimpaCliente;
    procedure pLimpaTela;
    function fValida: boolean;
  public
    { Public declarations }
  end;

var
  FPedidos: TFPedidos;

implementation

{$R *.dfm}

uses uDM, uSelecionaBanco;

procedure TFPedidos.btIncluirProdutoClick(Sender: TObject);
begin
  if Produto.Codigo > 0 then
  begin
    if btIncluirProduto.Tag = 0 then //incluir produto
    begin
      DM.mtProdutos.Append;
      DM.mtProdutosAUTOINCREM.AsInteger       := 0;
      DM.mtProdutosNUMERO_PEDIDO.AsInteger    := 0;
      DM.mtProdutosCODIGO_PRODUTO.AsInteger   := Produto.Codigo;
      DM.mtProdutosDESCRICAO_PRODUTO.AsString := Produto.Descricao;
      DM.mtProdutosVLR_UNITARIO.AsFloat       := Produto.Preco;
    end
    else //alterar produto
      DM.mtProdutos.Edit;

    DM.mtProdutosQUANTIDADE.AsFloat := StrToFloat(edQtdProduto.Text);
    DM.mtProdutosVLR_TOTAL.AsFloat  := Produto.Preco * DM.mtProdutosQUANTIDADE.AsFloat;
    DM.mtProdutos.Post;

    pLimpaProduto;
    edCodigoProduto.SetFocus;
  end;
end;

procedure TFPedidos.btConectarClick(Sender: TObject);
begin
  FSelecionaBanco := TFSelecionaBanco.Create(Self);
  FSelecionaBanco.ShowModal;
end;

procedure TFPedidos.btCancelarAlteracoesClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja cancelar as alterações?', 'Pedido', MB_YESNO + MB_ICONQUESTION) = idYes then
    pLimpaTela;
end;

procedure TFPedidos.grdProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if DM.mtProdutos.IsEmpty then
    Exit;

  if Key = 13 then //apertou <ENTER>, altera produto
  begin
    edCodigoProduto.Text := DM.mtProdutosCODIGO_PRODUTO.AsString;
    edCodigoProdutoExit(grdProdutos);

    edQtdProduto.Text        := DM.mtProdutosQUANTIDADE.AsString;
    btIncluirProduto.Caption := 'Alterar';
    btIncluirProduto.Tag     := 1;
    edQtdProduto.SetFocus;
  end
  else if Key = 46 then //apertou <DEL>, exclui o produto
  begin
    if Application.MessageBox('Tem certeza que deseja excluir o produto?', 'Produtos', MB_YESNO + MB_ICONQUESTION) = IDYES then
      DM.mtProdutos.Delete;
  end;
end;

procedure TFPedidos.btCancelarPedidoClick(Sender: TObject);
var strCodPedido: string;
    intCodPedido: integer;
begin
  if not DM.Conexao.Connected then
    btConectarClick(Self);

  strCodPedido := '';
  strCodPedido := InputBox('Buscar Pedido', 'Digite o número do pedido a ser Excluído:', '');
  if TryStrToInt(strCodPedido, intCodPedido) then
  begin
    DM.sqlCarregaPedido.Close;
    DM.sqlCarregaPedido.ParamByName('pedido').AsInteger := intCodPedido;
    DM.sqlCarregaPedido.Open;

    if DM.sqlCarregaPedido.Eof then // não encontrou o pedido
      Application.MessageBox('Pedido não encontrado!', 'Pedido', MB_OK+MB_ICONEXCLAMATION)
    else
    begin
      try
        DM.Conexao.StartTransaction;
        //apaga os produtos
        DM.sqlExcluiProdutos.ParamByName('pedido').AsInteger := intCodPedido;
        DM.sqlExcluiProdutos.ExecSQL;
        //apaga o pedido
        DM.sqlExcluiPedido.ParamByName('pedido').AsInteger := intCodPedido;
        DM.sqlExcluiPedido.ExecSQL;

        DM.Conexao.Commit;

        Application.MessageBox('Pedido excluído com sucesso!', 'Pedido', MB_OK+MB_ICONINFORMATION);
      except
        on e:exception do
        begin
          DM.Conexao.Rollback;
          raise Exception.Create('Ocorreu um erro ao cancelar o Pedido:'#13 + e.Message);
        end;
      end;
    end;
  end;
end;

procedure TFPedidos.btCarregarPedidoClick(Sender: TObject);
var strCodPedido: string;
    intCodPedido: integer;
begin
  if not DM.Conexao.Connected then
    btConectarClick(Self);

  strCodPedido := '';
  strCodPedido := InputBox('Buscar Pedido', 'Digite o número do pedido:', '');
  if TryStrToInt(strCodPedido, intCodPedido) then
  begin
    DM.sqlCarregaPedido.Close;
    DM.sqlCarregaPedido.ParamByName('pedido').AsInteger := intCodPedido;
    DM.sqlCarregaPedido.Open;

    if DM.sqlCarregaPedido.Eof then // não encontrou o pedido
      Application.MessageBox('Pedido não encontrado!', 'Pedido', MB_OK+MB_ICONEXCLAMATION)
    else
    begin
      edNumeroPedido.Text  := DM.sqlCarregaPedido.FieldByName('numero_pedido').AsString;
      edDataEmissao.Text   := FormatDateTime('dd/MM/yyyy', DM.sqlCarregaPedido.FieldByName('data_emissao').AsDateTime);
      edCodigoCliente.Text := DM.sqlCarregaPedido.FieldByName('codigo_cliente').AsString;
      edCodigoClienteExit(Sender);

      // carrega produtos do pedido na memorytable
      DM.sqlCarregaProdutos.Close;
      DM.sqlCarregaProdutos.ParamByName('pedido').AsInteger := intCodPedido;
      DM.sqlCarregaProdutos.Open;

      while not DM.sqlCarregaProdutos.Eof do
      begin
        DM.mtProdutos.Append;
        DM.mtProdutosAUTOINCREM.AsInteger       := DM.sqlCarregaProdutos.FieldByName('AUTOINCREM').AsInteger;
        DM.mtProdutosNUMERO_PEDIDO.AsInteger    := DM.sqlCarregaProdutos.FieldByName('NUMERO_PEDIDO').AsInteger;
        DM.mtProdutosCODIGO_PRODUTO.AsInteger   := DM.sqlCarregaProdutos.FieldByName('CODIGO_PRODUTO').AsInteger;
        DM.mtProdutosQUANTIDADE.AsFloat         := DM.sqlCarregaProdutos.FieldByName('QUANTIDADE').AsFloat;
        DM.mtProdutosVLR_UNITARIO.AsFloat       := DM.sqlCarregaProdutos.FieldByName('VLR_UNITARIO').AsFloat;
        DM.mtProdutosVLR_TOTAL.AsFloat          := DM.sqlCarregaProdutos.FieldByName('VLR_TOTAL').AsFloat;
        DM.mtProdutosDESCRICAO_PRODUTO.AsString := DM.sqlCarregaProdutos.FieldByName('DESCRICAO_PRODUTO').AsString;
        DM.mtProdutos.Post;
        DM.sqlCarregaProdutos.Next;
      end;
    end;
  end
  else
    Application.MessageBox('Digite um número de pedido válido', 'Pedido', MB_OK+MB_ICONWARNING);
end;

procedure TFPedidos.btGravarClick(Sender: TObject);
var codPedido: integer;
begin
  if fValida then
  begin
    try
      DM.Conexao.StartTransaction;

      codPedido := StrToIntDef(edNumeroPedido.Text, 0);
      if codPedido = 0 then //novo pedido
      begin
        //insere o pedido
        DM.sqlInserePedido.ParamByName('cliente').AsInteger := Cliente.Codigo;
        DM.sqlInserePedido.ParamByName('total').AsFloat     := DM.mtProdutosTOTAL_PEDIDO.Value;
        DM.sqlInserePedido.ExecSQL;

        //pega o código do pedido
        dm.sqlUltimoPedido.Close;
        dm.sqlUltimoPedido.Open;
        codPedido := dm.sqlUltimoPedido.FieldByName('numero_pedido').AsInteger;
      end
      else //alteração
      begin
        //altera o pedido
        DM.sqlAlteraPedido.ParamByName('pedido').AsInteger  := codPedido;
        DM.sqlAlteraPedido.ParamByName('cliente').AsInteger := Cliente.Codigo;
        DM.sqlAlteraPedido.ParamByName('total').AsFloat     := DM.mtProdutosTOTAL_PEDIDO.Value;
        DM.sqlAlteraPedido.ExecSQL;
      end;

      //exclui produtos já gravados anteriormente
      DM.sqlExcluiProdutos.ParamByName('pedido').AsInteger := codPedido;
      DM.sqlExcluiProdutos.ExecSQL;

      try
        DM.mtProdutos.DisableControls;
        DM.mtProdutos.First;
        while not DM.mtProdutos.Eof do
        begin
          //inclui produtos do pedido
          DM.sqlInsereProdutos.ParamByName('pedido').AsInteger     := codPedido;
          DM.sqlInsereProdutos.ParamByName('produto').AsInteger    := DM.mtProdutosCODIGO_PRODUTO.AsInteger;
          DM.sqlInsereProdutos.ParamByName('quantidade').AsFloat   := DM.mtProdutosQUANTIDADE.AsFloat;
          DM.sqlInsereProdutos.ParamByName('vlr_unitario').AsFloat := DM.mtProdutosVLR_UNITARIO.AsFloat;
          DM.sqlInsereProdutos.ParamByName('vlr_total').AsFloat    := DM.mtProdutosVLR_TOTAL.AsFloat;
          DM.sqlInsereProdutos.ExecSQL;

          DM.mtProdutos.Next;
        end;
        DM.mtProdutos.First;
      finally
        DM.mtProdutos.EnableControls;
      end;

      DM.Conexao.Commit;

      Application.MessageBox('Pedido gravado com sucesso!', 'Pedido', MB_OK+MB_ICONINFORMATION);

      pLimpaTela;
    except
      on e:exception do
      begin
        DM.Conexao.Rollback;
        raise Exception.Create('Ocorreu um erro ao gravar os dados:'#13 + e.Message);
      end;
    end;
  end;
end;

procedure TFPedidos.edCodigoClienteChange(Sender: TObject);
begin
  if Trim(edCodigoCliente.Text) = '' then
  begin
    btCarregarPedido.Show;
    btCancelarPedido.Show;
  end
  else
  begin
    btCarregarPedido.Hide;
    btCancelarPedido.Hide;
  end;
end;

procedure TFPedidos.edCodigoClienteExit(Sender: TObject);
begin
  if Trim(edCodigoCliente.Text) = '' then
    Exit;

  if not DM.Conexao.Connected then
    btConectarClick(Self);

  if Cliente.Carrega(StrToIntDef(edCodigoCliente.Text,0)) then
  begin
    edNomeCliente.Text := Cliente.Nome;
    edCidade.Text      := Cliente.Cidade;
    edUF.Text          := Cliente.UF;
  end
  else
  begin
    pLimpaCliente;
    Application.MessageBox('Cliente não encontrado','Cliente',MB_OK+MB_ICONWARNING);
    edCodigoCliente.SetFocus;
  end;
end;

procedure TFPedidos.edCodigoProdutoExit(Sender: TObject);
begin
  if Trim(edCodigoProduto.Text) = '' then
    Exit;

  if not DM.Conexao.Connected then
    btConectarClick(Self);

  if Produto.Carrega(StrToIntDef(edCodigoProduto.Text,0)) then
  begin
    edDescricaoProduto.Text := Produto.Descricao;
    edQtdProduto.Text       := '1';
    edPrecoProduto.Text     := FormatFloat('0.00', Produto.Preco);
  end
  else
  begin
    Application.MessageBox('Produto não encontrado','Cliente',MB_OK+MB_ICONWARNING);
    pLimpaProduto;
    edCodigoProduto.SetFocus;
  end;
end;

procedure TFPedidos.edCodigoProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = VK_DOWN) or (key = VK_UP) then
    grdProdutos.SetFocus;
end;

procedure TFPedidos.FormCreate(Sender: TObject);
begin
  Cliente := TCliente.Create;
  Produto := TProduto.Create;
end;

function TFPedidos.fValida: boolean;
begin
  Result := False;

  if Trim(edCodigoCliente.Text) = '' then
  begin
    Application.MessageBox('Informe o Cliente!', 'Gravar', MB_OK+MB_ICONEXCLAMATION);
    edCodigoCliente.SetFocus;
    Exit;
  end;

  if DM.mtProdutos.IsEmpty then
  begin
    Application.MessageBox('Informe pelo menos um Produto!', 'Gravar', MB_OK+MB_ICONEXCLAMATION);
    edCodigoProduto.SetFocus;
    Exit;
  end;

  Result := True;
end;

procedure TFPedidos.pLimpaCliente;
begin
  edNomeCliente.Clear;
  edCidade.Clear;
  edUF.Clear;
end;

procedure TFPedidos.pLimpaProduto;
begin
  btIncluirProduto.Tag     := 0;
  btIncluirProduto.Caption := 'Incluir';
  edCodigoProduto.Clear;
  edDescricaoProduto.Clear;
  edQtdProduto.Clear;
  edPrecoProduto.Clear;
end;

procedure TFPedidos.pLimpaTela;
begin
  edNumeroPedido.Clear;
  edDataEmissao.Clear;
  pLimpaCliente;
  pLimpaProduto;
  DM.mtProdutos.Close;
  DM.mtProdutos.Open;
  edCodigoCliente.Clear;
  edCodigoCliente.SetFocus;
end;

end.
