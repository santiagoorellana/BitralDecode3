object FormBuscaCoincidencia: TFormBuscaCoincidencia
  Left = 659
  Top = 132
  BorderStyle = bsDialog
  Caption = 'Buscar coincidencia de cadena'
  ClientHeight = 51
  ClientWidth = 299
  Color = clBtnFace
  Constraints.MaxHeight = 85
  Constraints.MaxWidth = 307
  Constraints.MinHeight = 78
  Constraints.MinWidth = 307
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
    1111111111111DDDCCCC2222BBB11DDDCCCC22220BB11DDDCCCC22000BB11AAA
    99900070CCC11AAA90077FF0CCC11AAA0330FF0BCCC11AA033B30F0BCCC11903
    3B3BB0AA99911033B3BB30AA9991133B3BB30AAA999113B3BB30AAAA99911B3B
    B30CDDDDBBB113BB30CCDDDDBBB11BB30CCCDDDDBBB111111111111111110000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    299
    51)
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 3
    Top = 3
    Width = 294
    Height = 21
    Hint = 'Inserte aqu'#237' la cadena a buscar.'
    Anchors = [akLeft, akTop, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = Edit1Change
  end
  object Button1: TButton
    Left = 64
    Top = 29
    Width = 77
    Height = 21
    Hint = 'Clic aqu'#237' para realizar una b'#250'squeda.'
    Anchors = [akTop, akRight]
    Caption = 'Buscar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 152
    Top = 29
    Width = 77
    Height = 21
    Hint = 'Clic aqu'#237' para cerrar la ventana.'
    Anchors = [akTop, akRight]
    Caption = 'Cerrar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = Button2Click
  end
end
