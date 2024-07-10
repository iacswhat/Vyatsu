object FEditMark: TFEditMark
  Left = 92
  Top = 127
  BorderStyle = bsDialog
  Caption = #1054#1094#1077#1085#1082#1072
  ClientHeight = 194
  ClientWidth = 382
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 62
    Height = 16
    Caption = #1043#1080#1087#1086#1090#1077#1079#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 101
    Height = 16
    Caption = #1057#1074#1080#1076#1077#1090#1077#1083#1100#1089#1090#1074#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 128
    Top = 16
    Width = 41
    Height = 16
    Caption = 'Label3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 128
    Top = 40
    Width = 41
    Height = 16
    Caption = 'Label4'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 16
    Top = 112
    Width = 41
    Height = 16
    Caption = 'Label5'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 328
    Top = 112
    Width = 41
    Height = 16
    Alignment = taRightJustify
    Caption = 'Label6'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 13
    Top = 96
    Width = 354
    Height = 13
    Caption = 
      '-5         -4        -3         -2        -1          0         ' +
      ' 1         2          3         4         5'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 13
    Top = 96
    Width = 357
    Height = 13
    Caption = 
      '-20        -15          -10          -5             0           ' +
      ' 5           10           15          20'
    Visible = False
  end
  object Label9: TLabel
    Left = 13
    Top = 96
    Width = 357
    Height = 13
    Caption = 
      '-50      -40      -30       -20      -10         0        10    ' +
      '   20        30       40        50'
    Visible = False
  end
  object TrackBar1: TTrackBar
    Left = 8
    Top = 64
    Width = 369
    Height = 33
    Max = 5
    Min = -5
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    TabStop = False
  end
  object Button1: TButton
    Left = 112
    Top = 152
    Width = 75
    Height = 25
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 208
    Top = 152
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
end
