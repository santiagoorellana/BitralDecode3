object FormComparadorDIFF: TFormComparadorDIFF
  Left = 335
  Top = 137
  Width = 340
  Height = 401
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Comparador DIFF'
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
    1111111111111AAA2AAAAAAAAAA11AA292AAAA292AA11A29992AA29992A11299
    9992299999211AA999AAAA999AA1111999111199911100099900009990000009
    99000099900011199911119991111AA999AAAA999AA11AA999AAAA999AA11AA9
    99AAAA999AA11AA999AAAA999AA11AAAAAAAAAAAAAA111111111111111110000
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
    Top = 345
    Width = 332
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
    Width = 332
    Height = 93
    Hint = 'Panel de an'#225'lisis de resultados.'
    Align = alTop
    Ctl3D = True
    ParentCtl3D = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnResize = Panel1Resize
    DesignSize = (
      332
      93)
    object PaintBox1: TPaintBox
      Left = 4
      Top = 5
      Width = 321
      Height = 48
      Hint = 'Muestra los caracteres a partir del cursor.'
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = OEM_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Terminal'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnPaint = PaintBox1Paint
    end
    object Panel3: TPanel
      Left = 4
      Top = 57
      Width = 281
      Height = 31
      Hint = 'Controles de desplazamiento.'
      Anchors = [akLeft, akBottom]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      object Button4: TButton
        Left = 136
        Top = 5
        Width = 45
        Height = 22
        Hint = 'Un paso adelante.'
        Caption = '<<<'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 183
        Top = 5
        Width = 45
        Height = 22
        Hint = 'Un paso hacia atras.'
        Caption = '>>>'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = Button5Click
      end
      object Button7: TButton
        Left = 89
        Top = 5
        Width = 45
        Height = 22
        Hint = 'Ir al inicio.'
        Caption = 'Inicio'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = Button7Click
      end
      object Button8: TButton
        Left = 231
        Top = 5
        Width = 45
        Height = 22
        Hint = 'Ir al final.'
        Caption = 'Final'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = Button8Click
      end
      object Edit3: TEdit
        Left = 3
        Top = 4
        Width = 81
        Height = 23
        Hint = 'Inicio de la muestra.'
        BevelInner = bvSpace
        BevelKind = bkFlat
        BevelOuter = bvSpace
        ReadOnly = True
        TabOrder = 4
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 332
    Height = 86
    Hint = 'Panel de comparaci'#243'n.'
    Align = alTop
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    DesignSize = (
      332
      86)
    object PaintBox2: TPaintBox
      Left = 6
      Top = 58
      Width = 260
      Height = 22
      Hint = 'Permite desplazarse por la comparaci'#243'n.'
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnMouseDown = PaintBox2MouseDown
      OnPaint = PaintBox2Paint
    end
    object PaintBox3: TPaintBox
      Left = 20
      Top = 58
      Width = 246
      Height = 22
      Anchors = [akLeft, akTop, akRight]
      OnPaint = PaintBox3Paint
    end
    object Label2: TLabel
      Left = 7
      Top = 10
      Width = 10
      Height = 15
      Caption = 'A:'
    end
    object Label3: TLabel
      Left = 6
      Top = 35
      Width = 11
      Height = 15
      Caption = 'B:'
    end
    object Edit1: TEdit
      Left = 19
      Top = 6
      Width = 249
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
      Left = 19
      Top = 31
      Width = 248
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
      Left = 270
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
      Left = 270
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
      Left = 19
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
      Left = 270
      Top = 58
      Width = 57
      Height = 21
      Hint = 'Permite seleccionar el segundo fichero a comparar.'
      Anchors = [akTop, akRight]
      Caption = 'Ayuda'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = Button6Click
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 179
    Width = 332
    Height = 166
    Hint = 'Panel de resultados.'
    Align = alClient
    Ctl3D = True
    ParentCtl3D = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnResize = Panel1Resize
    object Label1: TLabel
      Left = 4
      Top = 9
      Width = 139
      Height = 15
      Caption = 'Total de comparaciones: '
    end
    object Label4: TLabel
      Left = 56
      Top = 35
      Width = 85
      Height = 15
      Caption = 'Coincidencias: '
    end
    object Label5: TLabel
      Left = 84
      Top = 61
      Width = 57
      Height = 15
      Caption = 'Borrados: '
    end
    object Label6: TLabel
      Left = 70
      Top = 87
      Width = 71
      Height = 15
      Caption = 'Inserciones: '
    end
    object Label7: TLabel
      Left = 65
      Top = 113
      Width = 76
      Height = 15
      Caption = 'Reemplazos: '
    end
    object Label8: TLabel
      Left = 27
      Top = 139
      Width = 114
      Height = 15
      Caption = 'Total de diferencias: '
    end
    object EditValor1: TEdit
      Left = 146
      Top = 5
      Width = 81
      Height = 23
      Hint = 'Cantidad de caracteres procesados.'
      BevelInner = bvSpace
      BevelKind = bkFlat
      BevelOuter = bvSpace
      ReadOnly = True
      TabOrder = 0
    end
    object EditPorciento1: TEdit
      Left = 235
      Top = 5
      Width = 81
      Height = 23
      Hint = 'Porciento de caracteres procesados.'
      BevelInner = bvSpace
      BevelKind = bkFlat
      BevelOuter = bvSpace
      ReadOnly = True
      TabOrder = 1
    end
    object EditValor2: TEdit
      Left = 146
      Top = 31
      Width = 81
      Height = 23
      Hint = 'Cantidad de igualdades encontradas.'
      BevelInner = bvSpace
      BevelKind = bkFlat
      BevelOuter = bvSpace
      ReadOnly = True
      TabOrder = 2
    end
    object EditPorciento2: TEdit
      Left = 235
      Top = 31
      Width = 81
      Height = 23
      Hint = 'Porciento de igualdades encontradas.'
      BevelInner = bvSpace
      BevelKind = bkFlat
      BevelOuter = bvSpace
      ReadOnly = True
      TabOrder = 3
    end
    object EditValor3: TEdit
      Left = 146
      Top = 57
      Width = 81
      Height = 23
      Hint = 'Diferencia por cantidad de caracteres borrados.'
      BevelInner = bvSpace
      BevelKind = bkFlat
      BevelOuter = bvSpace
      ReadOnly = True
      TabOrder = 4
    end
    object EditPorciento3: TEdit
      Left = 235
      Top = 57
      Width = 81
      Height = 23
      Hint = 'Porciento de caracteres borrados.'
      BevelInner = bvSpace
      BevelKind = bkFlat
      BevelOuter = bvSpace
      ReadOnly = True
      TabOrder = 5
    end
    object EditPorciento4: TEdit
      Left = 235
      Top = 83
      Width = 81
      Height = 23
      Hint = 'Porciento de caracteres insertados.'
      BevelInner = bvSpace
      BevelKind = bkFlat
      BevelOuter = bvSpace
      ReadOnly = True
      TabOrder = 6
    end
    object EditValor4: TEdit
      Left = 146
      Top = 83
      Width = 81
      Height = 23
      Hint = 'Diferencia por cantidad de caracteres insertados.'
      BevelInner = bvSpace
      BevelKind = bkFlat
      BevelOuter = bvSpace
      ReadOnly = True
      TabOrder = 7
    end
    object EditValor5: TEdit
      Left = 146
      Top = 109
      Width = 81
      Height = 23
      Hint = 'Diferencia por cantidad de caracteres cambiados.'
      BevelInner = bvSpace
      BevelKind = bkFlat
      BevelOuter = bvSpace
      ReadOnly = True
      TabOrder = 8
    end
    object EditPorciento5: TEdit
      Left = 235
      Top = 109
      Width = 81
      Height = 23
      Hint = 'Porciento de caracteres cambiados.'
      BevelInner = bvSpace
      BevelKind = bkFlat
      BevelOuter = bvSpace
      ReadOnly = True
      TabOrder = 9
    end
    object EditPorciento6: TEdit
      Left = 235
      Top = 135
      Width = 81
      Height = 23
      Hint = 'Porciento de diferencias encontradas.'
      BevelInner = bvSpace
      BevelKind = bkFlat
      BevelOuter = bvSpace
      ReadOnly = True
      TabOrder = 10
    end
    object EditValor6: TEdit
      Left = 146
      Top = 135
      Width = 81
      Height = 23
      Hint = 'Total de diferencias encontradas.'
      BevelInner = bvSpace
      BevelKind = bkFlat
      BevelOuter = bvSpace
      ReadOnly = True
      TabOrder = 11
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = ActualizarTiempoTranscurrido
    Left = 240
    Top = 352
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer2Timer
    Left = 192
    Top = 64
  end
end
