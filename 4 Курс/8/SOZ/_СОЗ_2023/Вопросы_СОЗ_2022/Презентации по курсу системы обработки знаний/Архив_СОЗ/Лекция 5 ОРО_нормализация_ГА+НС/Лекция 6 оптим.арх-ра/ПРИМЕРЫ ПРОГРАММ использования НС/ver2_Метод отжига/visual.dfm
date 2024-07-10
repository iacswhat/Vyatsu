object Form2: TForm2
  Left = 157
  Top = 14
  Width = 542
  Height = 547
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1056#1077#1096#1077#1085#1080#1077' '#1079#1072#1076#1072#1095#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 448
    Width = 45
    Height = 13
    Caption = #1056#1077#1096#1077#1085#1080#1077
  end
  object Label2: TLabel
    Left = 104
    Top = 448
    Width = 3
    Height = 13
  end
  object SolveBtn: TBitBtn
    Left = 16
    Top = 408
    Width = 75
    Height = 25
    Caption = #1056#1077#1096#1080#1090#1100
    TabOrder = 0
    OnClick = SolveBtnClick
    Kind = bkOK
  end
  object StepBtn: TBitBtn
    Left = 101
    Top = 408
    Width = 81
    Height = 25
    Caption = #1055#1086#1096#1072#1075#1086#1074#1086
    TabOrder = 1
    OnClick = StepBtnClick
    Kind = bkIgnore
  end
  object StopBtn: TBitBtn
    Left = 191
    Top = 408
    Width = 75
    Height = 25
    Caption = #1057#1073#1088#1086#1089
    TabOrder = 2
    OnClick = StopBtnClick
    Kind = bkCancel
  end
  object GroupBox1: TGroupBox
    Left = 280
    Top = 408
    Width = 225
    Height = 73
    Caption = #1059#1088#1086#1074#1077#1085#1100' '#1074#1080#1079#1091#1072#1083#1080#1079#1072#1094#1080#1080
    TabOrder = 3
    object AllRdBtn: TRadioButton
      Left = 16
      Top = 24
      Width = 193
      Height = 17
      Caption = #1042#1089#1077' '#1101#1090#1072#1087#1099' '#1088#1077#1096#1077#1085#1080#1103
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object SimpleRdBtn: TRadioButton
      Left = 16
      Top = 48
      Width = 201
      Height = 17
      Caption = #1058#1086#1083#1100#1082#1086' '#1086#1082#1086#1085#1095#1072#1090#1077#1083#1100#1085#1086#1077' '#1088#1077#1096#1077#1085#1080#1077
      TabOrder = 1
    end
  end
  object ProgressBar1: TProgressBar
    Left = 16
    Top = 496
    Width = 249
    Height = 16
    Min = 0
    Max = 100
    TabOrder = 4
  end
  object ProgressBar2: TProgressBar
    Left = 16
    Top = 472
    Width = 249
    Height = 16
    Min = 0
    Max = 100
    TabOrder = 5
    Visible = False
  end
  object BitBtn1: TBitBtn
    Left = 280
    Top = 488
    Width = 145
    Height = 25
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1091#1089#1090#1072#1085#1086#1074#1082#1080
    TabOrder = 6
    OnClick = BitBtn1Click
    Kind = bkRetry
  end
  object BitBtn2: TBitBtn
    Left = 432
    Top = 488
    Width = 75
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 7
    OnClick = BitBtn2Click
    Kind = bkNo
  end
end
