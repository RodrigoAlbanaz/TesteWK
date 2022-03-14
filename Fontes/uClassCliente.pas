unit uClassCliente;

interface

type
  TCliente = class
    private
      FCodigo: integer;
      FNome: string;
      FCidade: string;
      FUF: string;
    public
      function Carrega(codigo: integer): boolean;
      property Codigo: integer read FCodigo;
      property Nome: string read FNome;
      property Cidade: string read FCidade;
      property UF: string read FUF;
  end;

implementation

{ TCliente }

uses uDM;

function TCliente.Carrega(codigo: integer): boolean;
begin
  DM.sqlCliente.Close;
  DM.sqlCliente.ParamByName('codigo').AsInteger := codigo;
  DM.sqlCliente.Open;

  if DM.sqlCliente.IsEmpty then
  begin
    FCodigo := 0;
    FNome   := '';
    FCidade := '';
    FUF     := '';
    Result  := False;
  end
  else
  begin
    FCodigo := DM.sqlCliente.FieldByName('codigo').AsInteger;
    FNome   := DM.sqlCliente.FieldByName('nome').AsString;
    FCidade := DM.sqlCliente.FieldByName('cidade').AsString;
    FUF     := DM.sqlCliente.FieldByName('uf').AsString;

    Result := True;
  end;
end;

end.
