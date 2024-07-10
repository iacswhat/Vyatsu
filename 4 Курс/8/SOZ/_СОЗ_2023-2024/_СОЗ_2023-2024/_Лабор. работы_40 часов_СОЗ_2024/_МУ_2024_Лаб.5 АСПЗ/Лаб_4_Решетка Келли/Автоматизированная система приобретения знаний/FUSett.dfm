object MSett: TMSett
  Left = 233
  Top = 109
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 173
  ClientWidth = 227
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RadioGroup1: TRadioGroup
    Left = 16
    Top = 16
    Width = 193
    Height = 105
    Caption = #1064#1082#1072#1083#1072
    ItemIndex = 0
    Items.Strings = (
      '5 '#1076#1077#1083#1077#1085#1080#1081
      '20 '#1076#1077#1083#1077#1085#1080#1081
      '50 '#1076#1077#1083#1077#1085#1080#1081)
    TabOrder = 0
  end
  object Button1: TButton
    Left = 32
    Top = 136
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 120
    Top = 136
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
end
