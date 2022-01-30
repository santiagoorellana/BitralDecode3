object FormAmpliador: TFormAmpliador
  Left = 714
  Top = 110
  Width = 200
  Height = 200
  BorderStyle = bsSizeToolWin
  Caption = 'Ampliador'
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 200
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
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000110000000000000131000000000000131000000000000131000001
    41141013100000111EE111110000014EEEEEE410000011EEE44EEE11000041EE
    E44EEE1400001EE444444EE100001EE444444EE1000041EEE44EEE14000011EE
    E44EEE110000014EEEEEE410000000111EE1110000000001411410000000FFFC
    0000FFF80000FFF10000FFE30000E0470000C00F0000801F0000000F0000000F
    0000000F0000000F0000000F0000000F0000801F0000C03F0000E07F0000}
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnCanResize = FormCanResize
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 30
    Width = 192
    Height = 136
    Align = alClient
    Constraints.MinWidth = 150
  end
  object TrackBar1: TTrackBar
    Left = 0
    Top = 0
    Width = 192
    Height = 30
    Align = alTop
    Max = 20
    Min = 2
    Position = 2
    TabOrder = 0
    OnChange = TrackBar1Change
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 150
    OnTimer = Timer1Timer
    Left = 8
    Top = 40
  end
end
