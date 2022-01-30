unit UProcedencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList, jpeg, ExtCtrls, ImgList;

type
  TFormProcedencia = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    ActionList1: TActionList;
    ActionSalir: TAction;
    Label6: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    procedure ActionSalirExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormProcedencia: TFormProcedencia;

implementation

uses Frame;

{$R *.dfm}

procedure TFormProcedencia.ActionSalirExecute(Sender: TObject);
begin
Close;
end;

end.
