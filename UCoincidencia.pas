unit UCoincidencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFormCoincidencia = class(TForm)
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    EditValor2: TEdit;
    EditValor3: TEdit;
    GroupBox3: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    EditValor4: TEdit;
    EditValor5: TEdit;
    Memo1: TMemo;
  private
    { Private declarations }
  public
    procedure Insertar(caracter: Char);
    procedure MostrarDatos(Datos: TRect);
  end;

var
  FormCoincidencia: TFormCoincidencia;

implementation

{$R *.dfm}

procedure TFormCoincidencia.Insertar(caracter: Char);
begin
Memo1.Text := Memo1.Text + caracter;
end;

procedure TFormCoincidencia.MostrarDatos(Datos: TRect);
begin
EditValor2.Text := IntToStr(Datos.Left);
EditValor3.Text := IntToStr(Datos.Right);
EditValor4.Text := IntToStr(Datos.Top);
EditValor5.Text := IntToStr(Datos.Bottom);
end;

end.
