object FExpEv: TFExpEv
  Left = 92
  Top = 127
  BorderStyle = bsDialog
  Caption = #1042#1099#1103#1074#1083#1077#1085#1080#1077' '#1089#1074#1080#1076#1077#1090#1077#1083#1100#1089#1090#1074
  ClientHeight = 451
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    632
    451)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 96
    Width = 160
    Height = 13
    Caption = #1059#1078#1077' '#1089#1086#1079#1076#1072#1085#1085#1099#1077' '#1089#1074#1080#1076#1077#1090#1077#1083#1100#1089#1090#1074#1072
  end
  object RadioGroup1: TRadioGroup
    Left = 16
    Top = 8
    Width = 217
    Height = 81
    Caption = #1052#1077#1090#1086#1076
    ItemIndex = 0
    Items.Strings = (
      #1090#1088#1080#1072#1076
      #1076#1080#1072#1076
      #1087#1086#1083#1085#1086#1075#1086' '#1082#1086#1085#1090#1077#1082#1089#1090#1072)
    TabOrder = 0
    OnClick = RadioGroup1Click
  end
  object ListBox1: TListBox
    Left = 16
    Top = 120
    Width = 217
    Height = 320
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    TabOrder = 1
  end
  object Button1: TButton
    Left = 544
    Top = 415
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1044#1072#1083#1100#1096#1077
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 456
    Top = 415
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
