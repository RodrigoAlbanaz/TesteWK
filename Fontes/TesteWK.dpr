program TesteWK;

uses
  Vcl.Forms,
  uPedidos in 'uPedidos.pas' {FPedidos},
  uDM in 'uDM.pas' {DM: TDataModule},
  uClassCliente in 'uClassCliente.pas',
  uClassProduto in 'uClassProduto.pas',
  uSelecionaBanco in 'uSelecionaBanco.pas' {FSelecionaBanco};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPedidos, FPedidos);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFSelecionaBanco, FSelecionaBanco);
  Application.Run;
end.
