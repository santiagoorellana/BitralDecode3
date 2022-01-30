object FormComparadorMost: TFormComparadorMost
  Left = 632
  Top = 117
  Width = 360
  Height = 444
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Comparador MOST WOLE COINCIDENCE'
  Color = clBtnShadow
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
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
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object StatusBar1: TStatusBar
    Left = 0
    Top = 388
    Width = 352
    Height = 22
    Panels = <
      item
        Width = 150
      end
      item
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Width = 200
      end>
    OnResize = StatusBar1Resize
  end
  object Panel1: TPanel
    Left = 0
    Top = 86
    Width = 352
    Height = 113
    Hint = 'Panel de an'#225'lisis de gr'#225'fica.'
    Align = alTop
    Ctl3D = True
    ParentCtl3D = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnResize = Panel1Resize
    DesignSize = (
      352
      113)
    object PaintBox1: TPaintBox
      Left = 4
      Top = 5
      Width = 341
      Height = 101
      Hint = 'Muestra las coincidencias entre A y B.'
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = OEM_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Terminal'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnMouseDown = PaintBox1MouseDown
      OnPaint = PaintBox1Paint
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 352
    Height = 86
    Hint = 'Panel de comparaci'#243'n.'
    Align = alTop
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    DesignSize = (
      352
      86)
    object Label2: TLabel
      Left = 25
      Top = 63
      Width = 57
      Height = 15
      Caption = 'Diferentes'
      ParentShowHint = False
      ShowHint = False
    end
    object Label3: TLabel
      Left = 117
      Top = 63
      Width = 41
      Height = 15
      Caption = 'Iguales'
      ParentShowHint = False
      ShowHint = False
    end
    object Label9: TLabel
      Left = 207
      Top = 63
      Width = 75
      Height = 15
      Caption = 'Seleccionado'
      ParentShowHint = False
      ShowHint = False
    end
    object Label1: TLabel
      Left = 7
      Top = 10
      Width = 10
      Height = 15
      Caption = 'A:'
    end
    object Label12: TLabel
      Left = 7
      Top = 34
      Width = 11
      Height = 15
      Caption = 'B:'
    end
    object PaintBox2: TPaintBox
      Left = 21
      Top = 58
      Width = 265
      Height = 22
      Anchors = [akLeft, akTop, akRight]
      OnPaint = PaintBox2Paint
    end
    object Edit1: TEdit
      Left = 20
      Top = 6
      Width = 268
      Height = 23
      Hint = 'Primer fichero a comparar.'
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvSpace
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 20
      Top = 31
      Width = 267
      Height = 23
      Hint = 'Segundo fichero a comparar.'
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvSpace
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 1
    end
    object Button2: TButton
      Left = 290
      Top = 7
      Width = 57
      Height = 21
      Hint = 'Permite seleccionar el primer fichero a comparar.'
      Anchors = [akTop, akRight]
      Caption = 'Buscar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 290
      Top = 32
      Width = 57
      Height = 21
      Hint = 'Permite seleccionar el segundo fichero a comparar.'
      Anchors = [akTop, akRight]
      Caption = 'Buscar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = Button3Click
    end
    object Button1: TButton
      Left = 21
      Top = 58
      Width = 82
      Height = 22
      Hint = 'Compara los ficheros seleccionados.'
      Caption = 'Comparar'
      Default = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = Button1Click
    end
    object Button6: TButton
      Left = 290
      Top = 58
      Width = 57
      Height = 21
      Hint = 'Muestra la ayuda local de la herramienta.'
      Anchors = [akTop, akRight]
      Caption = 'Ayuda'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = Button6Click
    end
    object Panel3: TPanel
      Left = 6
      Top = 63
      Width = 15
      Height = 15
      Hint = 'Color que indica las diferencias entre ficheros.'
      TabOrder = 6
    end
    object Panel5: TPanel
      Left = 98
      Top = 63
      Width = 15
      Height = 15
      Hint = 'Color que indica las igualdades entre ficheros.'
      TabOrder = 7
    end
    object Panel6: TPanel
      Left = 188
      Top = 63
      Width = 15
      Height = 15
      Hint = 'Color que toma un fragmento al ser seleccionado.'
      TabOrder = 8
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 199
    Width = 352
    Height = 189
    Hint = 'Panel de resultados.'
    Align = alClient
    Ctl3D = True
    ParentCtl3D = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnResize = Panel1Resize
    DesignSize = (
      352
      189)
    object GroupBox1: TGroupBox
      Left = 5
      Top = 5
      Width = 193
      Height = 178
      Hint = 'Longitud de las coincidencias.'
      Anchors = [akLeft, akTop, akBottom]
      Caption = 'Coincidencias :'
      TabOrder = 0
      DesignSize = (
        193
        178)
      object ListBox1: TListBox
        Left = 4
        Top = 16
        Width = 183
        Height = 156
        Hint = 'Longitud de las coincidencias.'
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 15
        TabOrder = 0
        OnKeyDown = ListBox1KeyDown
        OnKeyUp = ListBox1KeyUp
        OnMouseDown = ListBox1MouseDown
      end
    end
    object GroupBox2: TGroupBox
      Left = 202
      Top = 5
      Width = 145
      Height = 71
      Hint = 'Datos de la coincidencia en A.'
      Caption = 'Fichero A'
      TabOrder = 1
      DesignSize = (
        145
        71)
      object Label4: TLabel
        Left = 5
        Top = 20
        Width = 32
        Height = 15
        Caption = 'Inicio:'
      end
      object Label5: TLabel
        Left = 7
        Top = 46
        Width = 30
        Height = 15
        Caption = 'Final:'
      end
      object EditValor2: TEdit
        Left = 40
        Top = 16
        Width = 100
        Height = 23
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
        Width = 100
        Height = 23
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
      Left = 202
      Top = 78
      Width = 145
      Height = 71
      Hint = 'Datos de la coincidencia en B.'
      Caption = 'Fichero B'
      TabOrder = 2
      DesignSize = (
        145
        71)
      object Label10: TLabel
        Left = 5
        Top = 20
        Width = 32
        Height = 15
        Caption = 'Inicio:'
      end
      object Label11: TLabel
        Left = 7
        Top = 46
        Width = 30
        Height = 15
        Caption = 'Final:'
      end
      object EditValor4: TEdit
        Left = 40
        Top = 16
        Width = 100
        Height = 23
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
        Width = 100
        Height = 23
        Hint = 'Posici'#243'n del final de la coincidencia.'
        Anchors = [akLeft, akTop, akRight]
        BevelInner = bvSpace
        BevelKind = bkFlat
        BevelOuter = bvSpace
        ReadOnly = True
        TabOrder = 1
      end
    end
    object Button4: TButton
      Left = 202
      Top = 156
      Width = 145
      Height = 25
      Hint = 'Muestra los caracteres de la coincidencia seleccionada.'
      Caption = 'Ver Coincidencia'
      Enabled = False
      TabOrder = 3
      OnClick = Button4Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = ActualizarTiempoTranscurrido
    Left = 96
    Top = 392
  end
  object Timer2: TTimer
    Interval = 50
    OnTimer = Timer2Timer
    Left = 248
    Top = 64
  end
end
