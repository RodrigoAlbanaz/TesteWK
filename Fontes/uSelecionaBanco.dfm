object FSelecionaBanco: TFSelecionaBanco
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Selecionar Banco de Dados'
  ClientHeight = 97
  ClientWidth = 322
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbServidor: TLabel
    Left = 16
    Top = 8
    Width = 44
    Height = 13
    Caption = 'Servidor:'
  end
  object lbPorta: TLabel
    Left = 206
    Top = 8
    Width = 30
    Height = 13
    Caption = 'Porta:'
  end
  object Label2: TLabel
    Left = 16
    Top = 35
    Width = 50
    Height = 13
    Caption = 'Database:'
  end
  object lbSenha: TLabel
    Left = 206
    Top = 35
    Width = 34
    Height = 13
    Caption = 'Senha:'
  end
  object edServidor: TEdit
    Left = 66
    Top = 5
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'localhost'
  end
  object edPorta: TEdit
    Left = 242
    Top = 5
    Width = 71
    Height = 21
    TabOrder = 1
    Text = '3306'
  end
  object edDatabase: TEdit
    Left = 66
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'bancoteste'
  end
  object edSenha: TEdit
    Left = 242
    Top = 32
    Width = 71
    Height = 21
    PasswordChar = '#'
    TabOrder = 3
  end
  object btConectar: TButton
    Left = 112
    Top = 61
    Width = 75
    Height = 25
    Caption = 'Conectar'
    TabOrder = 4
    OnClick = btConectarClick
  end
end
