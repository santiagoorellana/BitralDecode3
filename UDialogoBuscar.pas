unit UDialogoBuscar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, EditableText;

type
  TFormBuscaCoincidencia = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Fuente: TEditableText;
  end;

var
  FormBuscaCoincidencia: TFormBuscaCoincidencia;

implementation


{$R *.dfm}


procedure TFormBuscaCoincidencia.Button2Click(Sender: TObject);
begin
Close;
end;

procedure TFormBuscaCoincidencia.Button1Click(Sender: TObject);
begin
if Assigned(Fuente) then
   if TButton(Sender).Caption = 'Buscar' then
      begin
      Fuente.BuscarPrimeraCoincidencia(Edit1.Text);
      TButton(Sender).Caption := 'Siguiente';
      end
   else
      Fuente.BuscarSiguienteCoincidencia;
end;

procedure TFormBuscaCoincidencia.Edit1Change(Sender: TObject);
begin
Button1.Caption := 'Buscar';
end;

procedure TFormBuscaCoincidencia.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Fuente.DesseleccionarCoincidencia;
end;

procedure TFormBuscaCoincidencia.FormCreate(Sender: TObject);
begin
ClientHeight := Button1.Top + Button1.Height + 5;
end;

end.
