unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TDM = class(TDataModule)
    Conexao: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    sqlCliente: TFDQuery;
    mtProdutos: TFDMemTable;
    mtProdutosAUTOINCREM: TIntegerField;
    mtProdutosNUMERO_PEDIDO: TIntegerField;
    mtProdutosCODIGO_PRODUTO: TIntegerField;
    mtProdutosQUANTIDADE: TFloatField;
    mtProdutosVLR_UNITARIO: TFloatField;
    mtProdutosVLR_TOTAL: TFloatField;
    mtProdutosDESCRICAO_PRODUTO: TStringField;
    sqlProduto: TFDQuery;
    sqlInserePedido: TFDQuery;
    sqlAlteraPedido: TFDQuery;
    sqlExcluiPedido: TFDQuery;
    sqlExcluiProdutos: TFDQuery;
    sqlInsereProdutos: TFDQuery;
    sqlUltimoPedido: TFDQuery;
    mtProdutosTOTAL_PEDIDO: TAggregateField;
    sqlCarregaPedido: TFDQuery;
    sqlCarregaProdutos: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  mtProdutos.Open;
end;

end.
