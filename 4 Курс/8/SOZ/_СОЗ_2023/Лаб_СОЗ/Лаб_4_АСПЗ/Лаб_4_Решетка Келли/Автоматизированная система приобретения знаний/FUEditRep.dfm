object FEditRep: TFEditRep
  Left = 94
  Top = 129
  BorderStyle = bsDialog
  Caption = #1056#1077#1087#1077#1088#1090#1091#1072#1088#1085#1072#1103' '#1088#1077#1096#1077#1090#1082#1072' '#1050#1077#1083#1083#1080
  ClientHeight = 266
  ClientWidth = 558
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    558
    266)
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 561
    Height = 217
    Anchors = [akLeft, akTop, akRight, akBottom]
    DefaultColWidth = 80
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    TabOrder = 0
    OnDblClick = StringGrid1DblClick
  end
  object Button1: TButton
    Left = 384
    Top = 232
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1050
    ModalResult = 2
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 472
    Top = 232
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1044#1072#1083#1100#1096#1077
    ModalResult = 1
    TabOrder = 2
    OnClick = Button2Click
  end
end
