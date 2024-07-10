object FEditHyp: TFEditHyp
  Left = 142
  Top = 99
  BorderStyle = bsDialog
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1075#1080#1087#1086#1090#1077#1079
  ClientHeight = 451
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    632
    451)
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 8
    Top = 8
    Width = 538
    Height = 438
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 0
    OnDblClick = acEditExecute
  end
  object Button1: TButton
    Left = 553
    Top = 8
    Width = 75
    Height = 25
    Action = acAdd
    Anchors = [akTop, akRight]
    TabOrder = 1
  end
  object Button2: TButton
    Left = 553
    Top = 40
    Width = 75
    Height = 25
    Action = acDel
    Anchors = [akTop, akRight]
    TabOrder = 2
  end
  object Button3: TButton
    Left = 553
    Top = 72
    Width = 75
    Height = 25
    Action = acEdit
    Anchors = [akTop, akRight]
    TabOrder = 3
  end
  object Button4: TButton
    Left = 553
    Top = 104
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 4
  end
  object Button5: TButton
    Left = 553
    Top = 136
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1044#1072#1083#1100#1096#1077
    ModalResult = 1
    TabOrder = 5
  end
  object ActionManager1: TActionManager
    Left = 16
    Top = 16
    StyleName = 'XP Style'
    object acAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      OnExecute = acAddExecute
    end
    object acDel: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnExecute = acDelExecute
    end
    object acEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      OnExecute = acEditExecute
    end
  end
end
