object FInputEv: TFInputEv
  Left = 116
  Top = 133
  BorderStyle = bsDialog
  Caption = 'FInputEv'
  ClientHeight = 197
  ClientWidth = 502
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    502
    197)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 77
    Height = 13
    Caption = #1057#1074#1080#1076#1077#1090#1077#1083#1100#1089#1090#1074#1086
  end
  object Label2: TLabel
    Left = 16
    Top = 64
    Width = 118
    Height = 13
    Caption = #1055#1086#1083#1086#1078#1080#1090#1077#1083#1100#1085#1099#1081' '#1087#1086#1083#1102#1089
  end
  object Label3: TLabel
    Left = 16
    Top = 112
    Width = 115
    Height = 13
    Caption = #1054#1090#1088#1080#1094#1072#1090#1077#1083#1100#1085#1099#1081' '#1087#1086#1083#1102#1089
  end
  object Edit1: TEdit
    Left = 16
    Top = 32
    Width = 468
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 16
    Top = 80
    Width = 468
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 16
    Top = 128
    Width = 468
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    Text = 'Edit3'
  end
  object Button1: TButton
    Left = 152
    Top = 160
    Width = 75
    Height = 25
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object Button2: TButton
    Left = 248
    Top = 160
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 4
  end
end
