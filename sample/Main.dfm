object FMain: TFMain
  Left = 0
  Top = 0
  Caption = 'UrlParser sample'
  ClientHeight = 269
  ClientWidth = 494
  Color = 4802889
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object cpSamples: TCardPanel
    Left = 0
    Top = 0
    Width = 494
    Height = 236
    Align = alClient
    ActiveCard = cdTestToString
    BevelOuter = bvNone
    Caption = 'cpSamples'
    TabOrder = 0
    OnCardChange = cpSamplesCardChange
    object cdTestToString: TCard
      Left = 0
      Top = 0
      Width = 494
      Height = 236
      Hint = 'Simple creation'
      Caption = 'cdTestToString'
      CardIndex = 0
      TabOrder = 0
      object btSampler: TButton
        AlignWithMargins = True
        Left = 5
        Top = 211
        Width = 484
        Height = 25
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 0
        Align = alBottom
        Caption = 'Test it!'
        TabOrder = 0
        OnClick = btSamplerClick
      end
      object mmUrl: TMemo
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 484
        Height = 201
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 0
        Align = alClient
        ReadOnly = True
        TabOrder = 1
      end
    end
    object cdTestObjectCreation: TCard
      Left = 0
      Top = 0
      Width = 494
      Height = 236
      Hint = 'Object creation and usage'
      Caption = 'cdTestObjectCreation'
      CardIndex = 1
      TabOrder = 1
      ExplicitWidth = 185
      ExplicitHeight = 41
      object mmParsedInfo: TMemo
        AlignWithMargins = True
        Left = 5
        Top = 31
        Width = 484
        Height = 175
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 0
        Align = alClient
        ReadOnly = True
        TabOrder = 0
        ExplicitTop = 56
        ExplicitHeight = 150
      end
      object btParse: TButton
        AlignWithMargins = True
        Left = 5
        Top = 211
        Width = 484
        Height = 25
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 0
        Align = alBottom
        Caption = 'Parse it!'
        TabOrder = 1
        OnClick = btParseClick
        ExplicitLeft = 10
      end
      object edUrl: TEdit
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 484
        Height = 21
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 0
        Align = alTop
        TabOrder = 2
        TextHint = 'Type your URL here'
        ExplicitLeft = 184
        ExplicitTop = 112
        ExplicitWidth = 121
      end
    end
  end
  object pnControlCards: TPanel
    AlignWithMargins = True
    Left = 0
    Top = 236
    Width = 494
    Height = 33
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Simple creation'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object btNext: TSpeedButton
      AlignWithMargins = True
      Left = 466
      Top = 5
      Width = 23
      Height = 23
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alRight
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C30E0000C30E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFB57A4EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB57A4EC07A5DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFB57A4EEAB085BE7B5CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB57A4EF0B78BEBB286C07B5FFF00
        FFFF00FFFF00FFFF00FFFF00FFB57A4EB57A4EB57A4EB57A4EB57A4EB57A4EB5
        7A4EB57A4EF0B78BF0B78BEBB286C07D5EFF00FFFF00FFFF00FFFF00FFB57A4E
        F0B78BF0B78BF0B78BF0B78BF0B78BF0B78BF0B78BF0B78BF0B78BF0B78BEAB0
        85BE7B5CFF00FFFF00FFFF00FFB57A4EF0B78BF0B78BF0B78BF0B78BF0B78BF0
        B78BF0B78BF0B78BF0B78BF0B78BF0B78BEBB287C17E5EFF00FFFF00FFB57A4E
        F0B78BF0B78BF0B78BF0B78BF0B78BF0B78BF0B78BF0B78BF0B78BF0B78BF0B7
        8BEBB286C07D5EFF00FFFF00FFB57A4EF0B78BF0B78BF0B78BF0B78BF0B78BF0
        B78BF0B78BF0B78BF0B78BF0B78BEAB185BE7C5BFF00FFFF00FFFF00FFB57A4E
        B57A4EB57A4EB57A4EB57A4EB57A4EB57A4EB57A4EF0B78BF0B78BEAB185BF7C
        5DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFB57A4EF0B78BEBB286C07D5EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB57A4EEBB286C07D5EFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFB57A4EC07D5CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB57A4EFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = btNextClick
      ExplicitLeft = 216
      ExplicitTop = 8
      ExplicitHeight = 22
    end
    object btPrevious: TSpeedButton
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 23
      Height = 23
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alLeft
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C30E0000C30E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB5
        7A4EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFBF7B5DB57A4EFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBE7B5CEAB184B5
        7A4EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFC07B5FEBB286F0B78BB57A4EFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC07D5EEBB286F0B78BF0B78BB5
        7A4EB57A4EB57A4EB57A4EB57A4EB57A4EB57A4EB57A4EFF00FFFF00FFFF00FF
        BE7B5CEAB085F0B78BF0B78BF0B78BF0B78BF0B78BF0B78BF0B78BF0B78BF0B7
        8BF0B78BB57A4EFF00FFFF00FFC07E5FEBB287F0B78BF0B78BF0B78BF0B78BF0
        B78BF0B78BF0B78BF0B78BF0B78BF0B78BF0B78BB57A4EFF00FFFF00FFC07D5E
        EBB286F0B78BF0B78BF0B78BF0B78BF0B78BF0B78BF0B78BF0B78BF0B78BF0B7
        8BF0B78BB57A4EFF00FFFF00FFFF00FFBF7D5CEAB185F0B78BF0B78BF0B78BF0
        B78BF0B78BF0B78BF0B78BF0B78BF0B78BF0B78BB57A4EFF00FFFF00FFFF00FF
        FF00FFBF7C5DEAB185F0B78BF0B78BB57A4EB57A4EB57A4EB57A4EB57A4EB57A
        4EB57A4EB57A4EFF00FFFF00FFFF00FFFF00FFFF00FFBF7D5DEBB286F0B78BB5
        7A4EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFC07D5EEBB386B57A4EFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBF7D5BB5
        7A4EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFB57A4EFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = btPreviousClick
      ExplicitLeft = 216
      ExplicitTop = 8
      ExplicitHeight = 22
    end
  end
end
