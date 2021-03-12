object FMain: TFMain
  Left = 0
  Top = 0
  Caption = 'UrlParser sample'
  ClientHeight = 201
  ClientWidth = 447
  Color = 4802889
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btSampler: TButton
    Left = 184
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Test it!'
    TabOrder = 0
    OnClick = btSamplerClick
  end
  object mmUrl: TMemo
    Left = 8
    Top = 8
    Width = 431
    Height = 154
    ReadOnly = True
    TabOrder = 1
  end
end
