unit UEstadisticas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart, HistoryDataManager, DataManager,
  ActnList, ComCtrls, TabNotBk, Grids, ImgList, StdCtrls, Buttons, Menus;

type
  TFormEstadisticas = class(TForm)
    ActionList1: TActionList;
    ActionCerrar: TAction;
    TabbedNotebook1: TTabbedNotebook;
    Chart1: TChart;
    Series1: TBarSeries;
    StringGrid1: TStringGrid;
    ActionGuardarDatos: TAction;
    ActionGuardarGrafico: TAction;
    ImageList1: TImageList;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    PopupMenu1: TPopupMenu;
    Guardardatos1: TMenuItem;
    Guardargrfico1: TMenuItem;
    Cerrarventana1: TMenuItem;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure ActionCerrarExecute(Sender: TObject);
    procedure ActionGuardarDatosExecute(Sender: TObject);
    procedure ActionGuardarGraficoExecute(Sender: TObject);
  private
  public
    procedure Mostrar(Fuente: THistoryDataManager);
  end;

var
  FormEstadisticas: TFormEstadisticas;

implementation

uses Frame;


{$R *.dfm}

procedure TFormEstadisticas.FormCreate(Sender: TObject);
begin
Chart1.BottomAxis.TickOnLabelsOnly:=True;
Chart1.LeftAxis.TickOnLabelsOnly:=True;
Series1.XValues.DateTime:=False;
end;

procedure TFormEstadisticas.Mostrar(Fuente: THistoryDataManager);
var n, m, Total: Integer;
    Lista: TStringList;
begin
Series1.Clear;
m := 0;
with Fuente.History[Fuente.HistoryMoment] do
     begin
     for n := 0 to 31 do
         if EstadisticasDeSimbolos[n].Caracter <> Chr(0) then
            begin
            Series1.AddXY( n, EstadisticasDeSimbolos[n].Cantidad, EstadisticasDeSimbolos[n].Caracter, clRed );
            Inc(m);
            end;
     StringGrid1.RowCount := m + 1;
     StringGrid1.Cells[0, 0] := 'Símbolo';
     StringGrid1.Cells[1, 0] := 'Cantidad';
     StringGrid1.Cells[2, 0] := 'Porciento';
     Edit1.Text := IntToStr(Fuente.Longitud);
     for n := 1 to StringGrid1.RowCount do
         begin
         StringGrid1.Cells[0, n] := EstadisticasDeSimbolos[n - 1].Caracter;
         StringGrid1.Cells[1, n] := IntToStr(EstadisticasDeSimbolos[n - 1].Cantidad);
         StringGrid1.Cells[2, n] := FloatToStrF(EstadisticasDeSimbolos[n - 1].Cantidad / Fuente.Longitud * 100, ffNumber, 3, 2) + ' %';
         end;
     end;
Show;
end;

procedure TFormEstadisticas.ActionCerrarExecute(Sender: TObject);
begin
Close;
end;

procedure TFormEstadisticas.ActionGuardarDatosExecute(Sender: TObject);
var dlg: TSaveDialog;
    Lista: TStringList;
    n: Integer;
begin
dlg := TSaveDialog.Create(Self);                                               //Crea un diálogo.
dlg.InitialDir := MainForm.RutaParaGuardarEstadisticas;
dlg.Title := 'Guardar datos de estadísticas...';                               //Título del diálogo.
dlg.Filter := 'Ficheros de texto (*.txt)|*.TXT|Todos los ficheros (*.*)|*.*';  //Ficheros que se muestran.
dlg.DefaultExt := 'TXT';
if dlg.Execute then                                                            //Permite seleccionar un fichero.
   begin
   MainForm.RutaParaGuardarEstadisticas := dlg.FileName;
   Lista := TStringList.Create;
   Lista.Clear;
   Lista.Add(StringGrid1.Cells[0, 0]+#9#9+StringGrid1.Cells[1, 0]+#9+StringGrid1.Cells[2, 0]);
   for n := 1 to StringGrid1.RowCount - 1 do
       begin
       Lista.Add(StringGrid1.Cells[0, n]+#9#9+StringGrid1.Cells[1, n]+#9#9+StringGrid1.Cells[2, n]);
       end;
   Lista.SaveToFile(dlg.FileName);
   end;
dlg.Free;
end;

procedure TFormEstadisticas.ActionGuardarGraficoExecute(Sender: TObject);
var dlg: TSaveDialog;
begin
dlg := TSaveDialog.Create(Self);                                               //Crea un diálogo.
dlg.InitialDir := MainForm.RutaParaGuardarEstadisticas;
dlg.Title := 'Guardar gráfico de estadísticas...';                              //Título del diálogo.
dlg.Filter := 'Mapa de bits (*.bmp)|*.BMP|Todos los ficheros (*.*)|*.*';  //Ficheros que se muestran.
dlg.DefaultExt := 'BMP';
if dlg.Execute then                                                            //Permite seleccionar un fichero.
   begin
   MainForm.RutaParaGuardarEstadisticas := dlg.FileName;
   Chart1.SaveToBitmapFile(dlg.FileName);
   end;
dlg.Free;
end;

end.
