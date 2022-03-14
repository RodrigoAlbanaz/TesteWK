unit uSelecionaBanco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFSelecionaBanco = class(TForm)
    lbServidor: TLabel;
    lbPorta: TLabel;
    edServidor: TEdit;
    edPorta: TEdit;
    Label2: TLabel;
    edDatabase: TEdit;
    lbSenha: TLabel;
    edSenha: TEdit;
    btConectar: TButton;
    procedure btConectarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSelecionaBanco: TFSelecionaBanco;

implementation

{$R *.dfm}

uses uDM;

procedure TFSelecionaBanco.btConectarClick(Sender: TObject);
begin
  DM.Conexao.Params.Values['Server']   := edServidor.Text;
  DM.Conexao.Params.Values['Port']     := edPorta.Text;
  DM.Conexao.Params.Values['Database'] := edDatabase.Text;
  DM.Conexao.Params.Values['Password'] := edSenha.Text;
  DM.Conexao.Open;
  if DM.Conexao.Connected then
    Close;
end;

procedure TFSelecionaBanco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
