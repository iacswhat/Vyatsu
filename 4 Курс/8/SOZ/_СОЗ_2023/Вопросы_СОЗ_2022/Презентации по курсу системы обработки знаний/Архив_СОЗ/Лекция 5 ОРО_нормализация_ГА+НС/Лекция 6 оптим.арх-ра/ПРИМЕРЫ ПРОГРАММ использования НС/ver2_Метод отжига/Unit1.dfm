object Form1: TForm1
  Left = 294
  Top = 122
  Width = 210
  Height = 318
  Caption = #1056#1072#1089#1089#1090#1072#1085#1086#1074#1082#1072' '#1092#1077#1088#1079#1077#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 15
    Top = 16
    Width = 87
    Height = 32
    Alignment = taRightJustify
    Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1090#1077#1084#1087#1077#1088#1072#1090#1091#1088#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label2: TLabel
    Left = 12
    Top = 64
    Width = 101
    Height = 32
    Alignment = taRightJustify
    Caption = #1050#1086#1083'-'#1074#1086' '#1092#1077#1088#1079#1077#1081' ('#1088#1072#1079#1084#1077#1088' '#1076#1086#1089#1082#1080')'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label3: TLabel
    Left = 15
    Top = 112
    Width = 106
    Height = 32
    Alignment = taRightJustify
    Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1087#1086#1085#1080#1078#1077#1085#1080#1103' ('#1074' %)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label4: TLabel
    Left = 10
    Top = 160
    Width = 111
    Height = 48
    Alignment = taRightJustify
    Caption = #1063#1080#1089#1083#1086' '#1080#1090#1077#1088#1072#1094#1080#1081' '#1087#1088#1080' '#1085#1077#1080#1079#1084#1077#1085#1085#1086#1081' '#1090#1077#1084#1087#1077#1088#1072#1090#1091#1088#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object EdTmp: TEdit
    Left = 128
    Top = 24
    Width = 33
    Height = 21
    MaxLength = 2
    TabOrder = 0
    Text = '0'
  end
  object UpDown1: TUpDown
    Left = 161
    Top = 24
    Width = 15
    Height = 21
    Associate = EdTmp
    Min = 0
    Position = 0
    TabOrder = 1
    Wrap = False
  end
  object UpDown2: TUpDown
    Left = 161
    Top = 72
    Width = 15
    Height = 21
    Associate = EdN
    Min = 0
    Max = 40
    Position = 0
    TabOrder = 2
    Wrap = False
  end
  object EdN: TEdit
    Left = 128
    Top = 72
    Width = 33
    Height = 21
    MaxLength = 2
    TabOrder = 3
    Text = '0'
  end
  object UpDown3: TUpDown
    Left = 161
    Top = 120
    Width = 15
    Height = 21
    Associate = EdAlpha
    Min = 0
    Max = 99
    Position = 0
    TabOrder = 4
    Wrap = False
  end
  object EdAlpha: TEdit
    Left = 128
    Top = 120
    Width = 33
    Height = 21
    MaxLength = 2
    TabOrder = 5
    Text = '0'
  end
  object UpDown4: TUpDown
    Left = 161
    Top = 176
    Width = 15
    Height = 21
    Associate = EdIter
    Min = 0
    Max = 32767
    Position = 0
    TabOrder = 6
    Wrap = False
  end
  object EdIter: TEdit
    Left = 128
    Top = 176
    Width = 33
    Height = 21
    MaxLength = 4
    TabOrder = 7
    Text = '0'
  end
  object Button1: TButton
    Left = 8
    Top = 218
    Width = 185
    Height = 25
    Caption = #1056#1077#1096#1080#1090#1100' '#1079#1072#1076#1072#1095#1091
    TabOrder = 8
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 258
    Width = 185
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 9
    OnClick = Button2Click
  end
end
