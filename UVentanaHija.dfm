object Form1: TForm1
  Left = 229
  Top = 290
  Width = 562
  Height = 381
  Caption = 'Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 554
    Height = 327
    ActivePage = TabSheet1
    Align = alClient
    TabIndex = 0
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Raster simple'
      object StatusBar1: TStatusBar
        Left = 0
        Top = 276
        Width = 546
        Height = 23
        Panels = <
          item
            Width = 120
          end
          item
            Width = 120
          end
          item
            Width = 100
          end>
        SimplePanel = False
      end
      object ToolBar2: TToolBar
        Left = 0
        Top = 28
        Width = 546
        Height = 28
        Caption = 'ToolBar2'
        Images = ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        object ToolButton32: TToolButton
          Left = 0
          Top = 2
          Action = ActionAumentar
        end
        object ToolButton33: TToolButton
          Left = 23
          Top = 2
          Action = ActionDisminuir
        end
        object ToolButton19: TToolButton
          Left = 46
          Top = 2
          Width = 8
          Caption = 'ToolButton19'
          Style = tbsSeparator
        end
        object ToolButton20: TToolButton
          Left = 54
          Top = 2
          Action = ActionMoverInicio
        end
        object ToolButton21: TToolButton
          Left = 77
          Top = 2
          Action = ActionMoverFinal
        end
        object ToolButton26: TToolButton
          Left = 100
          Top = 2
          Width = 8
          Caption = 'ToolButton26'
          ImageIndex = 26
          Style = tbsSeparator
        end
        object ToolButton22: TToolButton
          Left = 108
          Top = 2
          Action = ActionDesplazarIzquierda
        end
        object ToolButton23: TToolButton
          Left = 131
          Top = 2
          Action = ActionDesplazarDerecha
        end
        object ToolButton24: TToolButton
          Left = 154
          Top = 2
          Action = ActionDisminuirPeriodo
        end
        object ToolButton25: TToolButton
          Left = 177
          Top = 2
          Action = ActionAumentarPeriodo
        end
        object ToolButton27: TToolButton
          Left = 200
          Top = 2
          Width = 8
          Caption = 'ToolButton27'
          ImageIndex = 26
          Style = tbsSeparator
        end
        object ToolButton37: TToolButton
          Left = 208
          Top = 2
          Action = ActionCambiarColores
        end
        object ToolButton16: TToolButton
          Left = 231
          Top = 2
          Width = 8
          Caption = 'ToolButton16'
          ImageIndex = 21
          Style = tbsSeparator
        end
        object ToolButton3: TToolButton
          Left = 239
          Top = 2
          Action = ActionAyuda
        end
        object ToolButton28: TToolButton
          Left = 262
          Top = 2
          Action = ActionLeyenda
        end
      end
      object ToolBar1: TToolBar
        Left = 0
        Top = 0
        Width = 546
        Height = 28
        Caption = 'ToolBar1'
        Images = ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        object ToolButton1: TToolButton
          Left = 0
          Top = 2
          Action = ActionSalvarCambios
        end
        object ToolButton2: TToolButton
          Left = 23
          Top = 2
          Action = ActionGuardarImagen
        end
        object ToolButton5: TToolButton
          Left = 46
          Top = 2
          Action = ActionCerrar
        end
        object ToolButton7: TToolButton
          Left = 69
          Top = 2
          Width = 8
          Caption = 'ToolButton7'
          ImageIndex = 4
          Style = tbsSeparator
        end
        object ToolButton8: TToolButton
          Left = 77
          Top = 2
          Action = ActionDeshacer
        end
        object ToolButton9: TToolButton
          Left = 100
          Top = 2
          Action = ActionRehacer
        end
        object ToolButton10: TToolButton
          Left = 123
          Top = 2
          Action = ActionCopiar
        end
        object ToolButton11: TToolButton
          Left = 146
          Top = 2
          Action = ActionCortar
        end
        object ToolButton12: TToolButton
          Left = 169
          Top = 2
          Action = ActionPegar
        end
        object ToolButton13: TToolButton
          Left = 192
          Top = 2
          Action = ActionLlenar
        end
        object ToolButton14: TToolButton
          Left = 215
          Top = 2
          Action = ActionInsertar
        end
        object ToolButton15: TToolButton
          Left = 238
          Top = 2
          Action = ActionVerTexto
        end
        object ToolButton17: TToolButton
          Left = 261
          Top = 2
          Action = ActionBorrar
        end
        object ToolButton6: TToolButton
          Left = 284
          Top = 2
          Action = ActionFiltrar
        end
        object ToolButton29: TToolButton
          Left = 307
          Top = 2
          Action = ActionCantidadSimbolos
        end
        object ToolButton30: TToolButton
          Left = 330
          Top = 2
          Action = ActionRecalcularCantidadSimbolos
        end
        object ToolButton31: TToolButton
          Left = 353
          Top = 2
          Action = ActionConvertorEnBinario
        end
        object ToolButton4: TToolButton
          Left = 376
          Top = 2
          Width = 8
          Caption = 'ToolButton4'
          ImageIndex = 13
          Style = tbsSeparator
        end
        object ToolButton18: TToolButton
          Left = 384
          Top = 2
          Action = ActionDesseleccionar
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Raster de caracteres'
      ImageIndex = 1
      object ToolBar3: TToolBar
        Left = 0
        Top = 28
        Width = 546
        Height = 28
        Caption = 'ToolBar2'
        Images = ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object ToolButton38: TToolButton
          Left = 0
          Top = 2
          Action = ActionAumentar
        end
        object ToolButton39: TToolButton
          Left = 23
          Top = 2
          Action = ActionDisminuir
        end
        object ToolButton40: TToolButton
          Left = 46
          Top = 2
          Width = 8
          Caption = 'ToolButton19'
          Style = tbsSeparator
        end
        object ToolButton41: TToolButton
          Left = 54
          Top = 2
          Action = ActionMoverInicio
        end
        object ToolButton42: TToolButton
          Left = 77
          Top = 2
          Action = ActionMoverFinal
        end
        object ToolButton43: TToolButton
          Left = 100
          Top = 2
          Width = 8
          Caption = 'ToolButton26'
          ImageIndex = 26
          Style = tbsSeparator
        end
        object ToolButton44: TToolButton
          Left = 108
          Top = 2
          Action = ActionDesplazarIzquierda
        end
        object ToolButton45: TToolButton
          Left = 131
          Top = 2
          Action = ActionDesplazarDerecha
        end
        object ToolButton46: TToolButton
          Left = 154
          Top = 2
          Action = ActionDisminuirPeriodo
        end
        object ToolButton47: TToolButton
          Left = 177
          Top = 2
          Action = ActionAumentarPeriodo
        end
        object ToolButton48: TToolButton
          Left = 200
          Top = 2
          Width = 8
          Caption = 'ToolButton27'
          ImageIndex = 26
          Style = tbsSeparator
        end
        object ToolButton49: TToolButton
          Left = 208
          Top = 2
          Action = ActionCambiarColores
        end
        object ToolButton50: TToolButton
          Left = 231
          Top = 2
          Width = 8
          Caption = 'ToolButton28'
          ImageIndex = 21
          Style = tbsSeparator
        end
        object ToolButton51: TToolButton
          Left = 239
          Top = 2
          Action = ActionAyuda
        end
        object ToolButton52: TToolButton
          Left = 262
          Top = 2
          Action = ActionLeyenda
        end
      end
      object ToolBar4: TToolBar
        Left = 0
        Top = 0
        Width = 546
        Height = 28
        Caption = 'ToolBar1'
        Images = ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        object ToolButton53: TToolButton
          Left = 0
          Top = 2
          Action = ActionSalvarCambios
        end
        object ToolButton54: TToolButton
          Left = 23
          Top = 2
          Action = ActionGuardarImagen
        end
        object ToolButton55: TToolButton
          Left = 46
          Top = 2
          Action = ActionCerrar
        end
        object ToolButton56: TToolButton
          Left = 69
          Top = 2
          Width = 8
          Caption = 'ToolButton7'
          ImageIndex = 4
          Style = tbsSeparator
        end
        object ToolButton57: TToolButton
          Left = 77
          Top = 2
          Action = ActionDeshacer
        end
        object ToolButton58: TToolButton
          Left = 100
          Top = 2
          Action = ActionRehacer
        end
        object ToolButton59: TToolButton
          Left = 123
          Top = 2
          Action = ActionCopiar
        end
        object ToolButton60: TToolButton
          Left = 146
          Top = 2
          Action = ActionCortar
        end
        object ToolButton61: TToolButton
          Left = 169
          Top = 2
          Action = ActionPegar
        end
        object ToolButton62: TToolButton
          Left = 192
          Top = 2
          Action = ActionLlenar
        end
        object ToolButton63: TToolButton
          Left = 215
          Top = 2
          Action = ActionInsertar
        end
        object ToolButton64: TToolButton
          Left = 238
          Top = 2
          Action = ActionVerTexto
        end
        object ToolButton65: TToolButton
          Left = 261
          Top = 2
          Action = ActionBorrar
        end
        object ToolButton66: TToolButton
          Left = 284
          Top = 2
          Action = ActionFiltrar
        end
        object ToolButton67: TToolButton
          Left = 307
          Top = 2
          Action = ActionCantidadSimbolos
        end
        object ToolButton68: TToolButton
          Left = 330
          Top = 2
          Action = ActionRecalcularCantidadSimbolos
        end
        object ToolButton69: TToolButton
          Left = 353
          Top = 2
          Action = ActionConvertorEnBinario
        end
        object ToolButton70: TToolButton
          Left = 376
          Top = 2
          Width = 8
          Caption = 'ToolButton4'
          ImageIndex = 13
          Style = tbsSeparator
        end
        object ToolButton71: TToolButton
          Left = 384
          Top = 2
          Action = ActionBuscar
        end
        object ToolButton72: TToolButton
          Left = 407
          Top = 2
          Action = ActionBuscarSiguiente
        end
        object ToolButton73: TToolButton
          Left = 430
          Top = 2
          Width = 8
          Caption = 'ToolButton31'
          ImageIndex = 15
          Style = tbsSeparator
        end
        object ToolButton74: TToolButton
          Left = 438
          Top = 2
          Action = ActionDesseleccionar
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'TabSheet3'
      ImageIndex = 2
    end
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 16
    Top = 192
    object ActionMoverIzquierda: TAction
      Category = 'Visualizacion'
      Caption = 'Izquierda'
      Hint = 'Izquierda'
      ImageIndex = 27
      ShortCut = 37
    end
    object ActionMoverDerecha: TAction
      Category = 'Visualizacion'
      Caption = 'Derecha'
      Hint = 'Derecha'
      ImageIndex = 26
      ShortCut = 39
    end
    object ActionMoverArriba: TAction
      Category = 'Visualizacion'
      Caption = 'Arriba'
      Hint = 'Arriba'
      ImageIndex = 25
      ShortCut = 38
    end
    object ActionMoverAbajo: TAction
      Category = 'Visualizacion'
      Caption = 'Abajo'
      Hint = 'Abajo'
      ImageIndex = 24
      ShortCut = 40
    end
    object ActionMoverInicio: TAction
      Category = 'Visualizacion'
      Caption = 'Inicio'
      Hint = 'Inicio'
      ImageIndex = 15
      ShortCut = 36
    end
    object ActionMoverFinal: TAction
      Category = 'Visualizacion'
      Caption = 'Final'
      Hint = 'Final'
      ImageIndex = 16
      ShortCut = 35
    end
    object ActionPaginaArriba: TAction
      Category = 'Visualizacion'
      Caption = 'Pagina arriba'
      Hint = 'Pagina arriba'
      ImageIndex = 29
    end
    object ActionPaginaAbajo: TAction
      Category = 'Visualizacion'
      Caption = 'Pagina abajo'
      Hint = 'Pagina abajo'
      ImageIndex = 28
    end
    object ActionPaginaIzquierda: TAction
      Category = 'Visualizacion'
      Caption = 'Pagina izquierda'
      Hint = 'Pagina izquierda'
      ImageIndex = 31
    end
    object ActionPaginaDerecha: TAction
      Category = 'Visualizacion'
      Caption = 'Pagina derecha'
      Hint = 'Pagina derecha'
      ImageIndex = 30
    end
    object ActionAumentar: TAction
      Category = 'Visualizacion'
      Caption = 'Aumentar'
      Hint = 'Aumentar'
      ImageIndex = 17
      ShortCut = 120
    end
    object ActionDisminuir: TAction
      Category = 'Visualizacion'
      Caption = 'Disminuir'
      Hint = 'Disminuir'
      ImageIndex = 18
      ShortCut = 121
    end
    object ActionCambiarColores: TAction
      Category = 'Visualizacion'
      Caption = 'Cambiar colores'
      Hint = 'Cambiar colores'
      ImageIndex = 20
      ShortCut = 16457
    end
    object ActionDeshacer: TAction
      Category = 'Edicion'
      Caption = 'Deshacer'
      Hint = 'Deshacer'
      ImageIndex = 3
      ShortCut = 16474
    end
    object ActionRehacer: TAction
      Category = 'Edicion'
      Caption = 'Rehacer'
      Hint = 'Rehacer'
      ImageIndex = 4
      ShortCut = 16473
    end
    object ActionDesseleccionar: TAction
      Category = 'Edicion'
      Caption = 'Desseleccionar'
      Hint = 'Desseleccionar'
      ImageIndex = 14
      ShortCut = 27
    end
    object ActionBorrar: TAction
      Category = 'Edicion'
      Caption = 'Borrar selecci'#243'n'
      Hint = 'Borrar selecci'#243'n'
      ImageIndex = 23
      ShortCut = 16430
    end
    object ActionCopiar: TAction
      Category = 'Edicion'
      Caption = 'Copiar selecci'#243'n'
      Hint = 'Copiar selecci'#243'n'
      ImageIndex = 5
      ShortCut = 16451
    end
    object ActionCortar: TAction
      Category = 'Edicion'
      Caption = 'Cortar selecci'#243'n'
      Hint = 'Cortar selecci'#243'n'
      ImageIndex = 6
      ShortCut = 16472
    end
    object ActionPegar: TAction
      Category = 'Edicion'
      Caption = 'Pegar'
      Hint = 'Pegar'
      ImageIndex = 7
      ShortCut = 16470
    end
    object ActionFiltrar: TAction
      Category = 'Edicion'
      Caption = 'Filtrar datos'
      Hint = 'Filtrar datos'
      ImageIndex = 13
      ShortCut = 16454
    end
    object ActionLlenar: TAction
      Category = 'Edicion'
      Caption = 'Llenar selecci'#243'n'
      Hint = 'Llenar selecci'#243'n'
      ImageIndex = 8
      ShortCut = 16460
    end
    object ActionInsertar: TAction
      Category = 'Edicion'
      Caption = 'Insertar datos'
      Hint = 'Insertar datos'
      ImageIndex = 9
      ShortCut = 16429
    end
    object ActionCantidadSimbolos: TAction
      Category = 'Edicion'
      Caption = 'Cantidad de s'#237'mbolos'
      Hint = 'Cantidad de s'#237'mbolos'
      ImageIndex = 33
      ShortCut = 117
    end
    object ActionRecalcularCantidadSimbolos: TAction
      Category = 'Edicion'
      Caption = 'Recalcular cantidad de s'#237'mbolos'
      Hint = 'Recalcular cantidad de s'#237'mbolos'
      ImageIndex = 34
      ShortCut = 116
    end
    object ActionDesplazamiento: TAction
      Category = 'Edicion'
      Caption = 'Desplazamiento horizontal'
      Hint = 'Desplazamiento horizontal'
      ImageIndex = 32
      ShortCut = 118
    end
    object ActionPeriodo: TAction
      Category = 'Edicion'
      Caption = 'Periodo'
      Hint = 'Periodo'
      ImageIndex = 35
      ShortCut = 119
    end
    object ActionLeyenda: TAction
      Category = 'Ayuda'
      Caption = 'Leyenda del raster'
      Hint = 'Leyenda del raster'
      ImageIndex = 22
      ShortCut = 113
    end
    object ActionAyuda: TAction
      Category = 'Ayuda'
      Caption = 'Ayuda'
      Hint = 'Ayuda'
      ImageIndex = 21
      ShortCut = 112
    end
    object ActionCerrar: TAction
      Category = 'Fichero'
      Caption = 'Cerrar'
      Hint = 'Cerrar'
      ImageIndex = 2
      ShortCut = 32883
    end
    object ActionSalvarCambios: TAction
      Category = 'Fichero'
      Caption = 'Salvar cambios'
      Hint = 'Salvar cambios'
      ImageIndex = 0
      ShortCut = 16467
    end
    object ActionGuardarImagen: TAction
      Category = 'Fichero'
      Caption = 'Guardar imagen'
      Hint = 'Guardar imagen'
      ImageIndex = 1
      ShortCut = 16455
    end
    object ActionVerTexto: TAction
      Category = 'Edicion'
      Caption = 'Ver texto seleccionado'
      Hint = 'Ver texto seleccionado'
      ImageIndex = 10
      ShortCut = 16468
    end
    object ActionBuscar: TAction
      Category = 'Edicion'
      Caption = 'Buscar'
      Hint = 'Buscar'
      ImageIndex = 11
      ShortCut = 16450
    end
    object ActionBuscarSiguiente: TAction
      Category = 'Edicion'
      Caption = 'Buscar siguiente'
      Hint = 'Buscar siguiente'
      ImageIndex = 12
      ShortCut = 114
    end
    object ActionDesplazarIzquierda: TAction
      Category = 'Edicion'
      Caption = 'Desplazar izquierda'
      Hint = 'Desplazar izquierda'
      ImageIndex = 36
      ShortCut = 16421
    end
    object ActionDesplazarDerecha: TAction
      Category = 'Edicion'
      Caption = 'Desplazar derecha'
      Hint = 'Desplazar derecha'
      ImageIndex = 37
      ShortCut = 16423
    end
    object ActionDisminuirPeriodo: TAction
      Category = 'Edicion'
      Caption = 'Disminuir periodo'
      Hint = 'Disminuir periodo'
      ImageIndex = 38
      ShortCut = 16424
    end
    object ActionAumentarPeriodo: TAction
      Category = 'Edicion'
      Caption = 'Aumentar periodo'
      Hint = 'Aumentar periodo'
      ImageIndex = 39
      ShortCut = 16422
    end
    object ActionConvertorEnBinario: TAction
      Category = 'Edicion'
      Caption = 'Convertor en binario'
      ImageIndex = 40
    end
  end
  object MainMenu1: TMainMenu
    Images = ImageList1
    Left = 48
    Top = 192
    object Fichero1: TMenuItem
      Caption = 'Fichero'
      SubMenuImages = ImageList1
      object Salvarcambios1: TMenuItem
        Action = ActionSalvarCambios
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Guardarimagen1: TMenuItem
        Action = ActionGuardarImagen
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Cerrar1: TMenuItem
        Action = ActionCerrar
      end
    end
    object Edicin1: TMenuItem
      Caption = 'Edici'#243'n'
      object Deshacer1: TMenuItem
        Action = ActionDeshacer
      end
      object Rehacer1: TMenuItem
        Action = ActionRehacer
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object Copiarseleccin1: TMenuItem
        Action = ActionCopiar
      end
      object Cortarseleccin1: TMenuItem
        Action = ActionCortar
      end
      object Pegar1: TMenuItem
        Action = ActionPegar
      end
      object Llenarseleccin1: TMenuItem
        Action = ActionLlenar
      end
      object Insertardatos1: TMenuItem
        Action = ActionInsertar
      end
      object Vertextoseleccionado1: TMenuItem
        Action = ActionVerTexto
      end
      object Borrarseleccin1: TMenuItem
        Action = ActionBorrar
      end
      object Filtrardatos1: TMenuItem
        Action = ActionFiltrar
      end
      object Cantidaddesmbolos1: TMenuItem
        Action = ActionCantidadSimbolos
      end
      object Recalcularcantidaddesmbolos1: TMenuItem
        Action = ActionRecalcularCantidadSimbolos
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object Buscar1: TMenuItem
        Action = ActionBuscar
      end
      object Buscarsiguiente1: TMenuItem
        Action = ActionBuscarSiguiente
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object Desseleccionar1: TMenuItem
        Action = ActionDesseleccionar
      end
    end
    object Visualizacin1: TMenuItem
      Caption = 'Visualizaci'#243'n'
      object Aumentar1: TMenuItem
        Action = ActionAumentar
      end
      object Disminuir1: TMenuItem
        Action = ActionDisminuir
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Inicio1: TMenuItem
        Action = ActionMoverInicio
      end
      object Final1: TMenuItem
        Action = ActionMoverFinal
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Periodo1: TMenuItem
        Action = ActionPeriodo
      end
      object Desplazamientohorizontal1: TMenuItem
        Action = ActionDesplazamiento
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Cambiarcolores1: TMenuItem
        Action = ActionCambiarColores
      end
    end
    object Ayuda1: TMenuItem
      Caption = 'Ayuda'
      object Ayuda2: TMenuItem
        Action = ActionAyuda
      end
      object Leyendadelraster1: TMenuItem
        Action = ActionLeyenda
      end
    end
  end
  object ImageList1: TImageList
    Left = 80
    Top = 192
    Bitmap = {
      494C010129002C00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000040000000B000000001001800000000000084
      0000000000000000000000000000000000000000000000000000000000000000
      0080000080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0080000080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000080000080000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000800000800000800000
      0000000080000080000000000000000000000000000000008000008000008000
      0080000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000800000800000800000
      8000000080000080000000000000000000000000000000000000008000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000800000000000800000
      8000000000000080000080000000000000000000000000000000008000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000800000000000800000
      8000000000000080000080000000000000000000000000000000008000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000800000000000800000
      8000000000000080000080000000000000000000000000000000008000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000800000000000800000
      8000000000000000000080000080000000000000000000000000008000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000800000000000800000
      8000000000000000000080000080000000000000000000000000008000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000800000000000800000
      8000000000000000000000000080000080000000000000008000008000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000800000800000800000
      8000000000000000000000000080000080000000000000000000008000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000800000800000800000
      0000000000000000000000000080000080000000000000000000000000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080000080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080000080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000FF0000FF0000
      0000FF0000FF0000FF00000000FF0000FF0000FF00000000000000FF0000FF00
      00000000000000FF0000FF0000FF00000000FF0000FF0000FF00000000FF0000
      FF0000FF00000000000000FF0000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000FF0000FF0000
      0000FF0000FF0000FF00000000FF0000FF0000FF00000000000000FF0000FF00
      00000000000000FF0000FF0000FF00000000FF0000FF0000FF00000000FF0000
      FF0000FF00000000000000FF0000FF0000000000000000000000000000000000
      0000000000000000000000000000008000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000080
      0000800000000000000000000000000000000000000000FF0000FF0000FF0000
      0000FF0000FF0000FF00000000FF0000FF0000FF00000000000000FF0000FF00
      00000000000000FF0000FF0000FF00000000FF0000FF0000FF00000000FF0000
      FF0000FF00000000000000FF0000FF0000000000000000000000000000000000
      0000000000000000000000000000008000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000080
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000080
      00008000000000000000000000000000000000000000FF0000FF0000FF000000
      00FF0000FF0000FF000000000000FF0000FF0000FF0000000000FFFF00FFFF00
      000000000000FF0000FF0000FF00000000FF0000FF0000FF000000000000FF00
      00FF0000FF0000000000FFFF00FFFF0000000000000000000000000000000000
      0000000000000000000000000000008000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000080
      00008000000000000000000000000000000000000000FF0000FF0000FF000000
      00FF0000FF0000FF000000000000FF0000FF0000FF0000000000FFFF00FFFF00
      000000000000FF0000FF0000FF00000000FF0000FF0000FF000000000000FF00
      00FF0000FF0000000000FFFF00FFFF0000000000000000000000000000000000
      0000000000000000000000000000008000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000080
      00008000000000000000000000000000000000000000FF0000FF0000FF000000
      00FF0000FF0000FF000000000000FF0000FF0000FF0000000000FFFF00FFFF00
      000000000000FF0000FF0000FF00000000FF0000FF0000FF000000000000FF00
      00FF0000FF0000000000FFFF00FFFF0000000000000000000000000000000000
      0000000000000000000000000000008000008000008000008000008000000000
      0000000000000000000000000000000000000000000000000000000000000080
      00008000008000008000008000000000000000000000FF0000FF0000FF000000
      00FF0000FF0000FF000000000000FF0000FF0000FF0000000000FFFF00FFFF00
      000000000000FF0000FF0000FF00000000FF0000FF0000FF000000000000FF00
      00FF0000FF0000000000FFFF00FFFF0000000000000000000000000000000000
      0000000000000000000000000000008000008000008000008000008000008000
      0000000000000000000000000000000000000000000000000000000000000080
      0000800000800000800000800000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008000008000000000000000008000008000
      0080000000000000000000000000000000000000000000000000000000000080
      0000800000000000000000800000800000800000000000000000000000000000
      000000000000000000000000000000FF0000FF0000FF000000FF0000FF000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000FF0000FF000000FF0000FF00000000000000000000000000000000000000
      0000000000000000000000000000008000008000000000000000000000008000
      0080000000000000000000000000000000000000000000000000000000000080
      0000800000000000000000000000800000800000000000008080800000000000
      000000000000000000000000000000FF0000FF0000FF000000FF0000FF000000
      00000000000000000000000000008080800000000000000000000000000000FF
      0000FF0000FF000000FF0000FF00000000000000000000000000000000000000
      0000000000000000000000000000008000008000000000000000000000008000
      0080000000000000000000000000000000000000000000000000000000000080
      0000800000000000000000000000800000800000008080800000000000000000
      000000000000000000000000000000FF0000FF0000FF000000FF0000FF000000
      00000000000000000000000000000000008080800000000000000000000000FF
      0000FF0000FF000000FF0000FF00000000000000000000000000000000000000
      0000000000000000000000000000008000008000000000000000008000008000
      0080000000000000000000000000000000000000000000000000000000000080
      0000800000000000000000800000800000808080800000000000000000000000
      000000000000000000000000000000FF0000FF0000FF000000FF0000FF000000
      00000000000000000000000000000000000000008080800000000000000000FF
      0000FF0000FF000000FF0000FF00000000000000000000000000000000000000
      0000000000000000000000000000008000008000008000008000008000008000
      0000000000000000000000000000000000000000000000000000000000000080
      0000800000800000800000800000800000000000008080800000000000000000
      000000000000000000000000000000FF0000FF0000FF000000FF0000FF000000
      00000000000000000000000000000000008080800000000000000000000000FF
      0000FF0000FF000000FF0000FF00000000000000000000000000000000000000
      0000000000000000000000000000008000008000008000008000008000000000
      0000000000000000000000000000000000000000000000000000000000000080
      0000800000800000800000800000000000000000000000008080800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000FF0000FF0000
      0000FF0000FF0000FF00000000FF0000FF0000FF00000000000000FF0000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000FF0000FF0000
      0000FF0000FF0000FF00000000FF0000FF0000FF00000000000000FF0000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000800000000000000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000008000000000008000
      00000000000000000000FF0000FF00000000000000FFFF00FFFF000000000000
      FF0000FF000000000000000000FF000000000000000000FF0000FF0000FF0000
      0000FF0000FF0000FF00000000FF0000FF0000FF00000000000000FF0000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      00000000000000000000FF0000FF00000000000000FFFF00FFFF000000000000
      FF0000FF000000000000000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000800000000000008000008000000000000000000000
      0000000000000000000000000000000000000000000000000000008000000000
      00000000000000000000FF0000FF00000000000000FFFF00FFFF000000000000
      FF0000FF000000000000000000FF0000000000000000FF0000FF0000FF000000
      00FF0000FF0000FF000000000000FF0000FF0000FF0000000000FFFF00FFFF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000000000000000008080008000000000000000000000
      0000000000000000000000000000000000000000000000008000000000000000
      00000000000000000000FF0000FF00000000000000FFFF00FFFF000000000000
      FF0000FF000000000000000000FF0000000000000000FF0000FF0000FF000000
      00FF0000FF0000FF000000000000FF0000FF0000FF0000000000FFFF00FFFF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000800000000000000000000000000000008000008000000000000000
      0000000000000000000000000000000000000000000000008000000000008000
      00000000000000000000FF0000FF00000000000000FFFF00FFFF000000000000
      FF0000FF000000000000000000FF0000000000000000FF0000FF0000FF000000
      00FF0000FF0000FF000000000000FF0000FF0000FF0000000000FFFF00FFFF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000800000000000000000800000000000000000008000000000000000
      0000000000000000000000000000000000000000000000000000008000000000
      00000000000000000000FF0000FF00000000000000FFFF00FFFF000000000000
      FF0000FF000000000000000000FF0000000000000000FF0000FF0000FF000000
      00FF0000FF0000FF000000000000FF0000FF0000FF0000000000FFFF00FFFF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000800000000000000000008000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF0000FF00000000000000FFFF00FFFF000000000000
      FF0000FF000000000000000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000008000008080000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF0000FF00000000000000FFFF00FFFF000000000000
      FF0000FF000000000000000000FF000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF0000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000008000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF0000FF00000000000000FFFF00FFFF000000000000
      FF0000FF000000000000000000FF000000000000000000008080800000000000
      00000000000000000000808080000000000000000000000000FF0000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF0000FF00000000000000FFFF00FFFF000000000000
      FF0000FF000000000000000000FF000000000000008080800000000000000000
      00000000000000000000000000808080000000000000000000FF0000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000008000008000008000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF0000FF00000000000000FFFF00FFFF000000000000
      FF0000FF000000000000000000FF000000008080800000000000000000000000
      00000000000000000000000000000000808080000000000000FF0000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF0000FF00000000000000FFFF00FFFF000000000000
      FF0000FF000000000000000000FF000000000000008080800000000000000000
      00000000000000000000000000808080000000000000000000FF0000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000008000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008080800000000000
      0000000000000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080008000008000008000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000080000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF0000FF0000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008000FFFF000080000000
      00000000000000000000000000000000000000000000FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00000000000000000000000000000000000000000000
      0000000000000000000080000000000000000000000000000000000000000000
      000000000000000000000080000000000000000000FF0000FF0000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000080000080000000
      00000000000000000000000000000000000000000000FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00000000000000000000000000000000000000000000
      0000000000000080000080000080000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF0000FF0000FF00000000
      0000000000000000000000000080808000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080000080000080000080000000000000000000000000000000
      000000000000000080000000000000000000000000FF0000FF0000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000080000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000080000080000000000000000000000000000000
      0000000000800000000000000000000000000000000000000000000000000000
      0000000000000000000000000080808000000000000000000000000000000000
      000000000000000000000000000000000000000000008000FFFF000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000080000080000080000000000000000000000000
      00008000008000000000000000000000000000000000FF0000FF0000FF000000
      00000000000000000000000000000000000000000000C0C0C0C0C0C0C0C0C000
      000000000000000000000000000000000000000000008000FFFF000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080000080000080000000000000000080
      00008000000000000000000000000000000000000000FF0000FF0000FF000000
      00000000000000000000000000000000000000000000C0C0C0C0C0C0C0C0C000
      000000000000000000000000000000000000000000008000FFFF000080000080
      00000000000000000000000000000000000000000000FF0000FF0000FF0000FF
      0000FF0000FF0000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000080000080000080000080000080
      00000000000000000000000000000000000000000000FF0000FF0000FF000000
      00000000000000000000000000000000000000000000C0C0C0C0C0C0C0C0C000
      000000000000000000000000000000000000000000008000FFFF00FFFF00FFFF
      00008000000000000000000000000000000000000000FF0000FF0000FF0000FF
      0000FF0000FF0000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000080000080000000
      00000000000000000000000000000000000000000000FF0000FF0000FF000000
      00000000000000000000000000000000000000000000C0C0C0C0C0C0C0C0C000
      000000000000000000000000000000000000000000008000008000008000FFFF
      00FFFF0000800000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000080000080000080000080000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000080808000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000080
      00FFFF00FFFF0000800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080000080000080000000000000000080
      0000800000000000000000000000000000000000000000FF0000FF0000FF0000
      00000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFF00
      0000000000000000000000000000000080000080000000000000000000000000
      00008000FFFF0000800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000080000080000080000000000000000000000000
      0000800000800000000000000000000000000000000000FF0000FF0000FF0000
      00000000808080000000000000000000000000000000FFFFFFFFFFFFFFFFFF00
      000000000000000000000000008000FFFF00FFFF000080000000000000000080
      00FFFF00FFFF0000800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080000080000080000080000000000000000000000000000000
      0000000000800000800000000000000000000000000000FF0000FF0000FF0000
      00000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFF00
      000000000000000000000000008000FFFF00FFFF00FFFF00008000008000FFFF
      00FFFF0000800000800000000000000000000000000000FF0000FF0000FF0000
      FF0000FF0000FF0000FF00000000000000000000000000000000000000000000
      0000000000000080000080000080000000000000000000000000000000000000
      0000000000000000000000800000000000000000000000FF0000FF0000FF0000
      00000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFF00
      000000000000000000000000000000008000FFFF00FFFF00FFFF00FFFF00FFFF
      0000800000800000000000000000000000000000000000FF0000FF0000FF0000
      FF0000FF0000FF0000FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000080000080000080000080000080
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FFFFFF000000000000000000C0C0C0FFFFFFFFFFFFFFFFFFFFFFFF
      C0C0C0000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FFFFFF000000000000C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FFFFFF000000C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFF000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FFFFFFC0C0C0FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF
      000000FFFFFFFFFFFFC0C0C0FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFFFFFFFC0C0C0
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000
      00000000FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000
      00000000FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000
      00000000FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFFFFFFFC0C0C0
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000
      00000000FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FFFFFFC0C0C0FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF
      000000FFFFFFFFFFFFC0C0C0FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FFFFFF000000C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000C0C0C0000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FFFFFF000000000000C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFC0C0C0000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FFFFFF000000000000000000C0C0C0FFFFFFFFFFFFFFFFFFFFFFFF
      C0C0C0000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008000008000008000008000008000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFFFFC0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000000000000000000000000000000000000000008000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFFFFC0C0C0000000
      0000000000000000000000000000000000000000000000000000800000800000
      0000000000000000000000000000000080808000000000008000008000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFFFFC0C0C0000000
      0000000000000000000000000000000000000000000000000000800000800000
      0000000000000000000000000000000000000000000000000000008000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFFFFC0C0C0000000
      0000000000000000000000000000000000000000000000800000000000000000
      8000000000000000000000000000000080808000000000000000000000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFFFFC0C0C0000000
      0000000000000000000000000000000000000000800000000000000000000000
      0000008000000080808000000000000000000000000000000000000000000000
      0080000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FFFFFFFFFFFFC0C0C0808080
      0000000000000000000000000000000000000000800000000000000000000000
      0000000000008000000000000000000000000000000000000000000000000000
      0080000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080800000
      0000000000000080808000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFC0C0C0
      8080800000000000000000000000000000000000800000000000000000000000
      0000000000000000008000000000000000000000000000000000000000000000
      0080000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0
      C0C0C08080800000000000000000000000000000800000000000000000000000
      0000000000000000000000008000000000000000000000000000000000000000
      0080000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      C0C0C0C0C0C08080800000000000000000000000800000000000000000000000
      0000000000000000000000000000008000000000000000000000000000000000
      0080000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000000000000000000000
      0000000000000000000000000000000000008000000000000000000000000000
      0080000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000800000000000000000
      0000000000000000000000000000000000000000008000000000000000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000080000000000000000000000000
      0000800000000000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000008000008000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0080808000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080000080000080000000000000000080
      0000800000800000000000000000000000000000000000000000800000800000
      0000000000000000000000000000000000000000000000008000008000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000080000000000000000000000000
      0000800000000000000000000000000000000000000000000000000000000000
      8000000000000000000000000000000000000000008000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000080000000000000000000000000
      0000800000000000000000000000000000000000000000000000000000000000
      0000008000008000008000008000008000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000080
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000080
      000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000000000000000
      0000000000000000000000000000000080808000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      000080000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000000000FFFFFF000000000000000000000000000000000000000000000000
      000000FFFFFF0000000000000000000000000000000000FF0000000000000000
      00000000000000000000000000808080808080C0C0C000000000000000000000
      0000000000000000000000000000000000808080000000000000000000000000
      000000000080000000000000000000000000000000FFFFFF000080000080FFFF
      FFFFFFFF000080000080000080FFFFFF000080FFFFFFFFFFFFFFFFFFFFFFFF00
      0000000000FFFFFF000000000000000000000000000000000000000000000000
      000000FFFFFF0000000000000000000000000000000000FF0000FF0000000000
      00000000000000000000808080808080C0C0C0C0C0C0FFFFFF00000000000000
      0000000000000000000000000000C0C0C0808080808080000000000000000000
      000000000000000080000000000000000000000000FFFFFF000080FFFFFF0000
      80FFFFFF000080FFFFFFFFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFFFFFFFF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      00000000000000808080808080C0C0C0C0C0C0FFFFFFFFFFFFFFFFFF00000000
      0000000000000000000000FFFFFFC0C0C0C0C0C0000000808080000000000000
      000000000000000000000000000000000000000000FFFFFF000080FFFFFF0000
      80FFFFFF000080000080000080FFFFFF000080000080000080FFFFFFFFFFFF00
      0000000000000000FFFFFF000000000000000000000000000000000000FFFFFF
      0000000000000000000000000000000000000000000000FF0000FF0000000000
      00000000808080808080C0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFC0C0C000
      0000000000000000000000000000FFFFFF000000C0C0C0808080808080000000
      000000000000000000000000000000000000000000FFFFFF000080FFFFFF0000
      80FFFFFF000080FFFFFFFFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFFFFFFFF00
      0000000000000000FFFFFF000000000000000000000000000000000000FFFFFF
      0000000000000000000000000000000000000000000000000000000000FF0000
      00808080808080C0C0C0C0C0C0000000FFFFFFFFFFFFFFFFFFC0C0C000000000
      0000000000000000000000000000000000FFFFFFC0C0C0C0C0C0000000808080
      000000000000000000000000000000000000000000FFFFFF000080000080FFFF
      FFFFFFFF000080000080000080FFFFFF000080000080000080FFFFFFFFFFFF00
      0000000000000000FFFFFF000000000000000000000000000000000000FFFFFF
      0000000000000000000000000000000000000000000000000000FF0000008080
      80000000C0C0C0C0C0C0000000FFFFFF000000FFFFFFC0C0C000000000000000
      0000000080000080000080000000000000000000FFFFFF000000C0C0C0808080
      808080000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000C0C0C0FFFFFF000000000000FFFFFFC0C0C000000000000000000000
      0000000080000080000000000000000000000000000000FFFFFFC0C0C0C0C0C0
      000000000000000000000000000000000000000000FFFFFF000080FFFFFF0000
      80FFFFFF000080000080FFFFFFFFFFFF000080000080000080FFFFFFFFFFFF00
      0000000000000000000000FFFFFF000000000000000000000000000000FFFFFF
      0000000000000000000000000000000000000000000000000000000000FF0000
      00000000000000000000FFFFFFFFFFFFC0C0C000000000000000000000000000
      0000000080000000000080000000000000000000000000000000FFFFFF000000
      C0C0C0808080000000000000000000000000000000FFFFFF000080FFFFFF0000
      80FFFFFF000080FFFFFF000080FFFFFF000080FFFFFF000080FFFFFFFFFFFF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000FF000000FFFFFFC0C0C000000000000000000000000000000000
      0000000000000000000000000080000000000000000000000000000000000000
      FFFFFFC0C0C0808080000000000000000000000000FFFFFF0000800000800000
      80FFFFFF000080000080FFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFFFFFFFF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFFFFC0C0C0808080000000000000000000FFFFFF000080FFFFFF0000
      80FFFFFF000080FFFFFF000080FFFFFF000080FFFFFF000080FFFFFFFFFFFF00
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      FFFFFF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFFC0C0C0000000000000000000FFFFFF0000800000800000
      80FFFFFF000080000080FFFFFFFFFFFF000080000080000080FFFFFFFFFFFF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000800000800000800000
      8000008000008000008000008000008000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000
      0080000080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000000000000000000000000000000000
      0000000080808000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFFFF000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000008000
      0000000000000080000000000000000080000080000000000000000000000000
      0000000000000000000000000000000000000000800000FFFFFF808080FFFFFF
      808080FFFFFF808080FFFFFFFFFFFF8000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000008000
      0000000000000080000000000080000000000000000080000000000000000000
      0000000000000000000000000000000000000000800000FFFFFF000000000000
      000000000000000000000000FFFFFF8000000000000000000000000000000000
      0000000080808000000000000000000000000000000000000000000000000000
      0000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000008000
      0000000000000080000000000080000000000000000080000000000000000000
      0000000000808080008080808080008080808080800000FFFFFF808080FFFFFF
      808080FFFFFF808080FFFFFFFFFFFF8000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000C0C0C0000000000000000000000000000000FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000
      0080000080000080000000000080000000000000000080000000000000000000
      0000000000008080808080008080808080008080800000FFFFFF000000000000
      000000FFFFFFFFFFFFFFFFFFFFFFFF8000000000000000008080800000000000
      0000000000000000000080808080808080808080808080808080808080808000
      0000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000080000000000080000080000080000000000000000000000000
      0000000000808080008080808080008080808080800000FFFFFF808080FFFFFF
      808080FFFFFF8000008000008000008000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080808000
      0000000000C0C0C0000000000000000000000000000000FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000
      0000000000000080000000000080000000000000000000000000000000000000
      0000000000008080808080008080808080008080800000FFFFFF000000000000
      000000FFFFFF800000FFFFFF8000000000000000000000000000000000000000
      0000000000000000000080808000000000000000000000000000000080808000
      0000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000000000
      000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000808080008080808080008080808080800000FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF8000008000000000000000000000000000000000000000000000
      0000000000000000000000000080808000000000000000000000000080808000
      0000000000C0C0C0000000000000000000000000000000FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080808080008080808080008080800000800000800000800000
      8000008000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080808000
      0000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000000000
      000000FFFFFF000000FFFFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000808080008080808080008080808080008080808080008080808080
      0080808080800080800000000000000000000000000000000000000000000000
      0080808000000000000000000000000000000080808000000000000080808000
      0000000000C0C0C0000000000000000000C0C0C0000000FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080808080000000000000000000000000000000000000000000
      0000000080808080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000080808000000080808000000080808000
      0000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000808080008080000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      0000008080800080800000000000000000000000000000008080800000000000
      0000000000000000000000000080808000000000000000000000000000000000
      0000000000C0C0C0000000000000000000C0C0C0000000C0C0C0000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000808080808000808000000000FFFF00000000000000FFFF000000
      8080800080808080800000000000000000000000000000000000008080800000
      0000000000000080808000000000000000000000000000000000000000000000
      0000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FFFF00FFFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000C0C0C00000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080008080000000000000000000000000C0C0C0000000008080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000080800080800000
      00000000000000000000000000000000C0C0C0C0C0C000000000808000000000
      0000000000008080008080000000000000000000000000C0C0C0000000008080
      000000000000000000000000000000000000000000000000C0C0C00000800000
      80C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000080000080C0C0C000000000
      0000000000000000000000000000000000000000000000000000000000808080
      0000000000000000000000000000000000000000000000000080800080800000
      00000000000000000000000000000000C0C0C0C0C0C000000000808000000000
      0000000000008080008080000000000000000000000000000000000000008080
      000000000000000000000000000000000000000000000000C0C0C00000800000
      FF000080C0C0C0C0C0C0C0C0C0C0C0C00000800000FF000080C0C0C000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008080800000000000000000000000000000000000000080800080800000
      00000000000000000000000000000000C0C0C0C0C0C000000000808000000000
      0000000000008080008080008080008080008080008080008080008080008080
      000000FF0000FF000000FF0000FF00000000000000000000C0C0C0C0C0C00000
      800000FF000080C0C0C0C0C0C00000800000FF000080C0C0C0C0C0C000000000
      0000000000000000000000000000000000000000000000000000000000808080
      0000000000000000000000000000000000000000000000000080800080800000
      0000000000000000000000000000000000000000000000000000808000000000
      0000000000008080008080000000000000000000000000000000008080008080
      000000FF0000FF000000FF0000FF00000000000000000000C0C0C0C0C0C0C0C0
      C00000800000FF0000800000800000FF000080C0C0C0C0C0C0C0C0C000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000080800080800080
      8000808000808000808000808000808000808000808000808000808000000000
      0000000000008080000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000008080
      0000000000FF0000FF00FFFF00FFFF000000000000000000C0C0C0C0C0C0C0C0
      C0C0C0C00000800000FF0000FF000080C0C0C0C0C0C0C0C0C0C0C0C000000000
      0000000000808080808080808080808080808080808080808080000000000000
      0000000000000000008080800000000000000000000000000080800080800000
      0000000000000000000000000000000000000000000000808000808000000000
      0000000000008080000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000008080
      0000000000FF0000FF00FFFF00FFFF000000000000000000C0C0C0C0C0C0C0C0
      C0C0C0C0C0C0C00000FF0000FF000080C0C0C0C0C0C0C0C0C0C0C0C000000000
      0000000000808080000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000008080000000C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000808000000000
      0000000000008080000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000000000
      0000000000FF0000FF00FFFF00FFFF000000000000000000C0C0C0C0C0C0C0C0
      C0C0C0C00000FF000080C0C0C00000FF000080C0C0C0C0C0C0C0C0C000000000
      0000000000808080000000000000000000000000000000808080000000000000
      000000000000000000000000000000000000000000000000008080000000C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000808000000000
      0000000000008080000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C0C0C0
      00000000FF0000FF000000FF0000FF000000000000000000C0C0C0C0C0C0C0C0
      C00000FF000080C0C0C0C0C0C0C0C0C00000FF000080C0C0C0C0C0C000000000
      0000000000808080000000000000000000000000808080000000000000000000
      000000000000000000000000000000000000000000000000008080000000C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000808000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF0000FF000000FF0000FF000000000000000000C0C0C0C0C0C00000
      FF000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000FF000080C0C0C000000000
      0000000000808080000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000008080000000C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000808000000000
      000000000000000000000000000000FFFF00FFFF00FFFFFF0000FF0000FF0000
      00FF0000FF0000FF000000FF0000FF000000000000000000C0C0C0000080C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000080C0C0C000000000
      0000000000808080000000000000808080000000000000000000000000000000
      808080000000000000000000000000000000000000000000008080000000C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000000000000000
      00000000000000000000000000000000FF0000FF0000FF00FF0000FF0000FF00
      FF0000FF0000FF000000FFFF00FFFF0000000000008000008000008000008000
      0080000080000080000080000080000080000080000080000080000080000000
      0000000000808080000000808080000000808080000000000000000000000000
      000000000000000000000000000000000000000000000000008080000000C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C0C0C000000000
      00000000000000000000000000000000FF0000FF0000FF00FF0000FF0000FF00
      FF0000FF0000FF000000FFFF00FFFF000000000000800000FF0000FF0000FF00
      00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF000080000000
      0000000000000000000000000000000000000000808080000000000000000000
      0000000000000000008080800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF0000FF0000FF00FF0000FF0000FF00
      FF0000FF0000FF000000FFFF00FFFF0000000000008000008000008000008000
      0080000080000080000080000080000080000080000080000080000080000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000B00000000100010000000000800500000000000000000000
      000000000000000000000000FFFFFF00F9FF000000000000F9FF000000000000
      FCFF0000000000008CF000000000000004F90000000000002679000000000000
      2679000000000000267900000000000027390000000000002739000000000000
      279100000000000007990000000000008F9D000000000000FFCF000000000000
      FFCF000000000000FFFF00000000000000000000FFFFFFFF00000000FFFFFFFF
      00000000EF9FEF9F00000000C79FEF9F00000000839FEF9F00000000019FEF9F
      00000000EF9FEF9F00000000EF83EF8300000000EF81EF8100000000EF98EF98
      FF00FF00EF9CEF9CCF00E700EF9C019C8F00E300EF98839801000100EF81C781
      8F00E300EF83EF83CF00E700FFFFFFFF0000FFFFFFFFFFFF0000FFF3FFFBFFFF
      0000FFED7FF5CCCD0000FFFD7FFDCCCD0000803B3FFBCCCD0000C0373FF7CCCD
      0000E7AF9815CCCD0000F3EDDDDBCCCD0000F9F39EFFCCCD0000FCFF9F7FCCCD
      FFF0F9FF3EFFCCCDCE70F3FF7DDFCCCD8E30E7BF081FCCCD0010C03F7FFFCCCD
      8E30803F3FFFFFFFCE70FFFF07FFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFB7FFF6F
      FC7FFFFFF93FFE4FF83FFFFFF81FFC0FF01F8003F80FF80FE00FC007F807F00F
      C007E00FF803E00F80038003F801C00FE00FC007F803E00FC007E00FF807F00F
      8003F01FF80FF80FFFFFF83FF81FFC0FFFFFFC7FF93FFE4FFFFFFEFFFB7FFF6F
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFEF
      FFFFFFFFF9FFFFCFFFFFFFFFF8FFFF8FFEFF8003F87FFF0FFC7FC007F83FFE0F
      F83FE00FF81FFC0FF01FF01FF80FF80FE00FF83FF81FFC0FC007FC7FF83FFE0F
      8003FEFFF87FFF0FFFFFFFFFF8FFFF8FFFFFFFFFF9FFFFCFFFFFFFFFFBFFFFEF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF07E0FC7F0061FFFF07E0FC7F007BDFFB
      07E0FC7F006D8FFF0720FFFF006387F70420FC7FFFFFC7EF0720FC7FFFFFE3CF
      07E0FC7F0061F19F07E0FC3F0073F83F07E0FC1F0063FC7F07E0FC0F0073F83F
      04E0FF87FFFFF19F0420F3C7FFFFC3CF04E0E187006187E707E0E007006D8FFB
      07E0F00F006DFFFF07E0F81F0061FFFFFFFF00007FFEFFFFFFFF0000AFF5FFFF
      80030000CFF3BBFF800300008FF1B3FFFFF30000FFFFA000FFF30000F81FB3FF
      FC330000F81FBBFFFE330000F81FFFFFFE330000F81FFFDDFDB30000F81FFFCD
      FBF30000F81F0005F7F30000FFFFFFCDEFF300008FF1FFDDDFF30000CFF3FFFF
      BFF30000AFF5FFFFFFFF00007FFEFFFFFFFFFC3FF81FFFFFFCCCFC3FF7EFFFFF
      FCCCFC3FCFD39FFBFFFFFC3FCF9B9FF7FFFFFC3FB71D9FEF1F1FFC3F7A3E9FDF
      5F5FF81F787E9FBF0E1FF00F781E9B7F001FE007783E98FF001FC003783E98FF
      421F800178DE987F421FFFFFB9ED9FFF001FFBDFDBF39FFF001FF18FCFF38003
      CE7FFBDFF7EF8003CE7FFBDFF81FFFFFBFFF7F1F0000FFFFBFCFBF3F000007C1
      BF87DB5F000007C19F03E1EF000007C19E01E0F7000001019C00C07F00000001
      8800E03B00000201C001F01700000201C003180F00008003E0073C0F0000C107
      E00F5E070000C107C81FEF030000E38FDC3FFEC00000E38FBB7FFDE10000E38F
      B3FFFFF30000FFFF8FFFFFF70000FFFFFFFFFC00FFFFFC00FFFFFC00F9FFFC00
      FCFFFC00F6CFFC00F1FF0000F6B78000F1FF0000F6B70000E3FF0000F8B70000
      C7010000FE8F0000C7010000FE3F0001C7010000FF7F0003C7810000FE3F0003
      C7810001FEBF0003C3010003FC9F0003C0110007FDDF0003C03F007FFDDF0003
      E0FF00FFFDDF8007FFFF01FFFFFFF87FFFFF001FFFFFFFFF8001001F8001FFFF
      8001001F8001FF3F800100008001FF8F800100008001FF8F800100008001FFC7
      80010000800180E380010000800180E380010000800180E380010000800181E3
      80010000800181E38001E000800180C38001E000800188038001E0008001FC03
      8001E0008001FF07FFFFE000FFFFFFFF00000000000000000000000000000000
      000000000000}
  end
end
