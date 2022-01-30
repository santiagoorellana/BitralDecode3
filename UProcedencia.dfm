object FormProcedencia: TFormProcedencia
  Left = 519
  Top = 144
  BorderStyle = bsDialog
  Caption = 'Procedencia'
  ClientHeight = 167
  ClientWidth = 335
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    00000000000000000000000000000BBBBBB0EEEEEEE0AAAAAAAA099999900BBB
    BBB0EEEEEEE0AAAAAAAA099999900BBBBBB0EEEEEEE0AAAAAAAA099999900BBB
    BBB0EEEEEEE0AAAAAAAA099999900BBBBBB0EEEEEEE0AAAAAAAA099999900BBB
    BBB0EEEEEEE0AAAAAAAA09999990000000000000000000000000000000000EEE
    EEE0CCCCCCC0999999990BBBBBB00EEEEEE0CCCCCCC0999999990BBBBBB00EEE
    EEE0CCCCCCC0999999990BBBBBB00EEEEEE0CCCCCCC0999999990BBBBBB00EEE
    EEE0CCCCCCC0999999990BBBBBB00EEEEEE0CCCCCCC0999999990BBBBBB00EEE
    EEE0CCCCCCC0999999990BBBBBB0000000000000000000000000000000000999
    9990BBBBBBB0EEEEEEEE0CCCCCC009999990BBBBBBB0EEEEEEEE0CCCCCC00999
    9990BBBBBBB0EEEEEEEE0CCCCCC009999990BBBBBBB0EEEEEEEE0CCCCCC00999
    9990BBBBBBB0EEEEEEEE0CCCCCC009999990BBBBBBB0EEEEEEEE0CCCCCC00999
    9990BBBBBBB0EEEEEEEE0CCCCCC0000000000000000000000000000000000AAA
    AAA0CCCCCCC0999999990AAAAAA00AAAAAA0CCCCCCC0999999990AAAAAA00AAA
    AAA0CCCCCCC0999999990AAAAAA00AAAAAA0CCCCCCC0999999990AAAAAA00AAA
    AAA0CCCCCCC0999999990AAAAAA00AAAAAA0CCCCCCC0999999990AAAAAA00AAA
    AAA0CCCCCCC0999999990AAAAAA0000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    335
    167)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 19
    Width = 240
    Height = 44
    Caption = 'Bitral Decode'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -37
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 77
    Width = 291
    Height = 20
    Anchors = [akLeft, akBottom]
    Caption = 'Programador: Santiago A. Orellana P'#233'rez'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 145
    Width = 200
    Height = 20
    Anchors = [akLeft, akBottom]
    Caption = 'SetV+, Habana, Cuba, 2012'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 234
    Top = -1
    Width = 90
    Height = 16
    Caption = 'Versi'#243'n 3.0.0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 7
    Top = 100
    Width = 218
    Height = 20
    Anchors = [akLeft, akBottom]
    Caption = 'Email: tecnochago@gmail.com'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 7
    Top = 123
    Width = 146
    Height = 20
    Anchors = [akLeft, akBottom]
    Caption = 'Movil: +53 54635944'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object ActionList1: TActionList
    Left = 296
    Top = 24
    object ActionSalir: TAction
      Caption = 'ActionSalir'
      ShortCut = 27
      OnExecute = ActionSalirExecute
    end
  end
end
