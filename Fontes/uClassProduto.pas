unit uClassProduto;

interface

type
  TProduto = class
    private
      FCodigo: integer;
      FDescricao: string;
      FPreco: double;
    public
      function Carrega(codigo: integer): boolean;
      property Codigo: integer read FCodigo;
      property Descricao: string read FDescricao;
      property Preco: double read FPreco;
  end;

implementation

{ TProduto }

uses uDM;

function TProduto.Carrega(codigo: integer): boolean;
begin
  DM.sqlProduto.Close;
  DM.sqlProduto.ParamByName('codigo').AsInteger := codigo;
  DM.sqlProduto.Open;

  if DM.sqlProduto.IsEmpty then
  begin
    FCodigo    := 0;
    FDescricao := '';
    FPreco     := 0;
    Result     := False;
  end
  else
  begin
    FCodigo    := DM.sqlProduto.FieldByName('codigo').AsInteger;
    FDescricao := DM.sqlProduto.FieldByName('descricao').AsString;
    FPreco     := DM.sqlProduto.FieldByName('preco').AsFloat;

    Result := True;
  end;
end;

end.
