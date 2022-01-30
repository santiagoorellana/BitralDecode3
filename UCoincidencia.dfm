object FormCoincidencia: TFormCoincidencia
  Left = 702
  Top = 168
  Width = 260
  Height = 180
  Caption = 'Coincidencia'
  Color = clBtnFace
  Constraints.MinHeight = 180
  Constraints.MinWidth = 260
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  Icon.Data = {
    0000010001001010100000000000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF001111
    1111111111111BBB3BBBBBBBBBB11BB393BBBB393BB11B39993BB39993B11399
    9993399999311BB999BBBB999BB1111999111199911100099900009990000009
    99000099900011199911119991111BB999BBBB999BB11BB999BBBB999BB11BB9
    99BBBB999BB11BB999BBBB999BB11BBBBBBBBBBBBBB111111111111111110000
    0000000000000000000000000000000000000000000000000000E3C70000E3C7
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 121
    Height = 146
    Align = alLeft
    TabOrder = 0
    object GroupBox2: TGroupBox
      Left = 3
      Top = 3
      Width = 114
      Height = 71
      Hint = 'Datos de la coincidencia en A.'
      Caption = 'Fichero A'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      DesignSize = (
        114
        71)
      object Label4: TLabel
        Left = 5
        Top = 20
        Width = 28
        Height = 13
        Caption = 'Inicio:'
      end
      object Label5: TLabel
        Left = 7
        Top = 46
        Width = 25
        Height = 13
        Caption = 'Final:'
      end
      object EditValor2: TEdit
        Left = 40
        Top = 16
        Width = 69
        Height = 21
        Hint = 'Posici'#243'n de inicio de la coincidencia.'
        Anchors = [akLeft, akTop, akRight]
        BevelInner = bvSpace
        BevelKind = bkFlat
        BevelOuter = bvSpace
        ReadOnly = True
        TabOrder = 0
      end
      object EditValor3: TEdit
        Left = 40
        Top = 42
        Width = 69
        Height = 21
        Hint = 'Posici'#243'n del final de la coincidencia.'
        Anchors = [akLeft, akTop, akRight]
        BevelInner = bvSpace
        BevelKind = bkFlat
        BevelOuter = bvSpace
        ReadOnly = True
        TabOrder = 1
      end
    end
    object GroupBox3: TGroupBox
      Left = 3
      Top = 76
      Width = 114
      Height = 71
      Hint = 'Datos de la coincidencia en B.'
      Caption = 'Fichero B'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      DesignSize = (
        114
        71)
      object Label10: TLabel
        Left = 5
        Top = 20
        Width = 28
        Height = 13
        Caption = 'Inicio:'
      end
      object Label11: TLabel
        Left = 7
        Top = 46
        Width = 25
        Height = 13
        Caption = 'Final:'
      end
      object EditValor4: TEdit
        Left = 40
        Top = 16
        Width = 69
        Height = 21
        Hint = 'Posici'#243'n de inicio de la coincidencia.'
        Anchors = [akLeft, akTop, akRight]
        BevelInner = bvSpace
        BevelKind = bkFlat
        BevelOuter = bvSpace
        ReadOnly = True
        TabOrder = 0
      end
      object EditValor5: TEdit
        Left = 40
        Top = 42
        Width = 69
        Height = 21
        Hint = 'Posici'#243'n del final de la coincidencia.'
        Anchors = [akLeft, akTop, akRight]
        BevelInner = bvSpace
        BevelKind = bkFlat
        BevelOuter = bvSpace
        ReadOnly = True
        TabOrder = 1
      end
    end
  end
  object Memo1: TMemo
    Left = 121
    Top = 0
    Width = 131
    Height = 146
    Hint = 'Coincidencia encontrada.'
    Align = alClient
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
end
