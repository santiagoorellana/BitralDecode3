object FormBuscaPeriodos: TFormBuscaPeriodos
  Left = 518
  Top = 112
  Width = 371
  Height = 495
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Buscador de per'#237'odos'
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
    1111111100471CCAA99AABB104F41CCAA99444B14F40199BB44EEE44F400199B
    4EEEEEEE40001AAE4EEEEEEE40001AA4EEEEEEEEE4001224EEEEEEEEE4001224
    EEEEEEEEE4001CC94EEEEEEE40001CC94EEEEEEE40001AABB44EEE4400001AAB
    B22444210000199CCEEBB9910000199CCEEBB99100001111111111110000000C
    0000000800000001000000030000000700000007000000030000000300000003
    00000007000000070000000F0000000F0000000F0000000F0000000F0000}
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
    Top = 439
    Width = 363
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
    Top = 226
    Width = 363
    Height = 213
    Hint = 'Panel de resultados.'
    Align = alClient
    Ctl3D = True
    ParentCtl3D = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    DesignSize = (
      363
      213)
    object GroupBox1: TGroupBox
      Left = 4
      Top = 0
      Width = 111
      Height = 208
      Hint = 'Per'#237'odos encontrados ordenados por prioridad.'
      Anchors = [akLeft, akTop, akBottom]
      Caption = 'Per'#237'odos'
      TabOrder = 0
      object ListBox1: TListBox
        Left = 2
        Top = 17
        Width = 107
        Height = 189
        Align = alClient
        ItemHeight = 15
        PopupMenu = PopupMenu2
        TabOrder = 0
        OnClick = ListBox1Click
      end
    end
    object GroupBox8: TGroupBox
      Left = 119
      Top = 0
      Width = 239
      Height = 208
      Hint = 'Muestra el raster en el per'#237'odo seleccionado.'
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = 'Raster de la demodulaci'#243'n'
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 363
    Height = 226
    Hint = 'Panel de b'#250'squeda.'
    Align = alTop
    Ctl3D = True
    ParentCtl3D = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    DesignSize = (
      363
      226)
    object PaintBox2: TPaintBox
      Left = 5
      Top = 197
      Width = 288
      Height = 22
      Hint = 'Indica el funcionamiento del algoritmo.'
      OnPaint = PaintBox2Paint
    end
    object Button1: TButton
      Left = 5
      Top = 197
      Width = 109
      Height = 22
      Hint = 'Inicia la b'#250'squeda de per'#237'odos.'
      Caption = 'Buscar Per'#237'odos'
      Default = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = Button1Click
    end
    object Button6: TButton
      Left = 300
      Top = 198
      Width = 57
      Height = 20
      Hint = 'Ayuda local de la herramienta.'
      Caption = 'Ayuda'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = Button6Click
    end
    object GroupBox2: TGroupBox
      Left = 5
      Top = 48
      Width = 353
      Height = 46
      Hint = 'Rango de b'#250'squeda de los per'#237'odos.'
      Caption = 'Rango de b'#250'squeda'
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 1
      object Label1: TLabel
        Left = 5
        Top = 20
        Width = 95
        Height = 15
        Caption = 'Desde el per'#237'odo'
      end
      object Label2: TLabel
        Left = 180
        Top = 20
        Width = 89
        Height = 15
        Caption = 'hasta el per'#237'odo'
      end
      object SpinEdit1: TSpinEdit
        Left = 103
        Top = 16
        Width = 74
        Height = 24
        Hint = 'Per'#237'odo a partir del cual se busca.'
        MaxValue = 1024
        MinValue = 2
        TabOrder = 0
        Value = 8
      end
      object SpinEdit2: TSpinEdit
        Left = 274
        Top = 16
        Width = 74
        Height = 24
        Hint = 'Per'#237'odo '#250'ltimo que se busca.'
        MaxValue = 1024
        MinValue = 2
        TabOrder = 1
        Value = 1024
      end
    end
    object GroupBox3: TGroupBox
      Left = 5
      Top = 96
      Width = 254
      Height = 46
      Hint = 'Algoritmo de b'#250'squeda de per'#237'odo que se emplea.'
      Caption = 'Algoritmo de b'#250'squeda'
      TabOrder = 2
      DesignSize = (
        254
        46)
      object ComboBox1: TComboBox
        Left = 5
        Top = 17
        Width = 244
        Height = 23
        Hint = 'Permite seleccionar el algoritmo a emplear.'
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 15
        TabOrder = 0
        Text = 'Sumatoria de repeticiones'
        Items.Strings = (
          'Detecci'#243'n de patrones de areas'
          'Sumatoria de repeticiones'
          'Modelo de dispersi'#243'n')
      end
    end
    object GroupBox4: TGroupBox
      Left = 5
      Top = 145
      Width = 212
      Height = 46
      Hint = 'Prioridad de ejecuci'#243'n del subproceso de b'#250'squeda.'
      Caption = 'Prioridad del subproceso'
      TabOrder = 4
      DesignSize = (
        212
        46)
      object ComboBox2: TComboBox
        Left = 5
        Top = 17
        Width = 202
        Height = 23
        Hint = 'Permite seleccionar la prioridad.'
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 15
        ItemIndex = 0
        TabOrder = 0
        Text = 'Ejecuci'#243'n normal '
        Items.Strings = (
          'Ejecuci'#243'n normal '
          'Ejecutar r'#225'pidamente'
          'Velocidad m'#225'xima de ejecuci'#243'n')
      end
    end
    object GroupBox5: TGroupBox
      Left = 267
      Top = 96
      Width = 91
      Height = 46
      Hint = 'Tama'#241'o m'#237'nimo de las repeticiones.'
      Caption = 'Resoluci'#243'n'
      TabOrder = 3
      DesignSize = (
        91
        46)
      object SpinEdit3: TSpinEdit
        Left = 5
        Top = 16
        Width = 81
        Height = 24
        Hint = 'Permite seleccionar el tama'#241'o m'#237'nimo de las repeticiones.'
        Anchors = [akLeft, akTop, akRight]
        MaxValue = 1024
        MinValue = 2
        TabOrder = 0
        Value = 16
      end
    end
    object GroupBox6: TGroupBox
      Left = 5
      Top = 1
      Width = 353
      Height = 46
      Hint = 'Fichero que se analiza.'
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Fichero de demodulaci'#243'n en el que se busca'
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
      DesignSize = (
        353
        46)
      object Edit1: TEdit
        Left = 5
        Top = 17
        Width = 283
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        BevelInner = bvNone
        BevelKind = bkFlat
        BevelOuter = bvSpace
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 0
      end
      object Button2: TButton
        Left = 291
        Top = 18
        Width = 55
        Height = 21
        Hint = 'Permite seleccionar el fichero a analizar.'
        Anchors = [akTop, akRight]
        Caption = 'Cargar'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = Button2Click
      end
    end
    object GroupBox7: TGroupBox
      Left = 225
      Top = 145
      Width = 133
      Height = 46
      Hint = 'Para eliminar los m'#250'ltiplos redundantes.'
      TabOrder = 5
      object CheckBox1: TCheckBox
        Left = 7
        Top = 14
        Width = 122
        Height = 26
        Hint = 'Activa la eliminaci'#243'n de m'#250'ltiplos.'
        Caption = 'Eliminar m'#250'ltiplos'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = ActualizarTiempoTranscurrido
    Left = 200
    Top = 432
  end
  object Timer2: TTimer
    Interval = 50
    OnTimer = Timer2Timer
    Left = 216
    Top = 200
  end
  object PopupMenu1: TPopupMenu
    Left = 224
    Top = 328
    object Procesarfichero1: TMenuItem
      Caption = 'Procesar fichero'
      OnClick = Procesarfichero1Click
    end
    object Guardarimagen1: TMenuItem
      Caption = 'Guardar imagen'
      OnClick = Guardarimagen1Click
    end
    object Monocromtico1: TMenuItem
      Caption = 'Monocrom'#225'tico'
      OnClick = Monocromtico1Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 48
    Top = 328
    object Guardarlista1: TMenuItem
      Caption = 'Guardar lista'
      OnClick = Guardarlista1Click
    end
  end
end
