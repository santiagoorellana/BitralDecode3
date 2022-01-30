unit UConvertirEnBinario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids, ImgList, ActnList, ToolWin, Buttons, HistoryDataManager,
  ExtCtrls;

type
  TFormConvertirEnBinario = class(TForm)
    StringGrid1: TStringGrid;
    ImageList1: TImageList;
    ActionList1: TActionList;
    ActionCargarLista: TAction;
    ActionGuardarLista: TAction;
    ActionRotarArriba: TAction;
    ActionRotarAbajo: TAction;
    ActionMoverArriba: TAction;
    ActionMoverAbajo: TAction;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    ActionRecrearLista: TAction;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    ActionCancelar: TAction;
    ActionConvertir: TAction;
    Panel1: TPanel;
    ComboBox1: TComboBox;
    BitBtn7: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure ActionCargarListaExecute(Sender: TObject);
    procedure ActionGuardarListaExecute(Sender: TObject);
    procedure ActionRotarArribaExecute(Sender: TObject);
    procedure ActionRotarAbajoExecute(Sender: TObject);
    procedure ActionMoverArribaExecute(Sender: TObject);
    procedure ActionMoverAbajoExecute(Sender: TObject);
    procedure ActionRecrearListaExecute(Sender: TObject);
    procedure ActionCancelarExecute(Sender: TObject);
    procedure ActionConvertirExecute(Sender: TObject);
  private
    CantidadDeSimbolos: Integer;
    ListaDeCombinaciones: TStringList;
    FuenteDeDatos: THistoryDataManager;
    procedure MostrarLista;
    procedure GuardarListaDeCombinaciones;
    procedure CargarListaDeCombinaciones;
    function CrearCombinacionesEnBinario(CodigoGray: Boolean): TStringList;
    procedure CrearYMostrarLista;
  public
    procedure Mostrar(Fuente: THistoryDataManager);
  end;

var
  FormConvertirEnBinario: TFormConvertirEnBinario;

implementation

uses Child, Frame;
{$R *.dfm}

//-----------------------------------------------------------------------------
// Inicia el formulario.
//-----------------------------------------------------------------------------
procedure TFormConvertirEnBinario.Mostrar(Fuente: THistoryDataManager);
begin
FuenteDeDatos := Fuente;
CantidadDeSimbolos := FuenteDeDatos.OptenerCantidadDeSimbolos;
CrearYMostrarLista;
ShowModal;
end;

//-----------------------------------------------------------------------------
// Crea la lista yla muestra.
//-----------------------------------------------------------------------------
procedure TFormConvertirEnBinario.CrearYMostrarLista;
begin
ListaDeCombinaciones := CrearCombinacionesEnBinario(ComboBox1.ItemIndex = 0);
MostrarLista;
end;


//-----------------------------------------------------------------------------
// Muestra la lista de combinaciones binarias.
//-----------------------------------------------------------------------------
procedure TFormConvertirEnBinario.MostrarLista;
var n: Integer;
begin
StringGrid1.Cells[0, 0] := 'Símbolo';
StringGrid1.Cells[1, 0] := 'Sustituto';
StringGrid1.RowCount := CantidadDeSimbolos + 1;
for n := 1 to ListaDeCombinaciones.Count do
    begin
    StringGrid1.Cells[0, n] := IntToStr(n - 1);
    StringGrid1.Cells[1, n] := ListaDeCombinaciones[n - 1];
    end;
end;

//-----------------------------------------------------------------------------
// Guarda la lista de combinaciones binarias en un fichero.
//-----------------------------------------------------------------------------
procedure TFormConvertirEnBinario.GuardarListaDeCombinaciones;
var dlg: TSaveDialog;
begin
dlg := TSaveDialog.Create(Self);                                               //Crea un diálogo.
dlg.InitialDir := MainForm.RutaParaGuardarCombinacionesBinarias;
dlg.Title := 'Guardar lista binaria...';                                       //Título del diálogo.
dlg.Filter := 'Ficheros de texto (*.txt)|*.TXT|Todos los ficheros (*.*)|*.*';  //Ficheros que se muestran.
dlg.DefaultExt := 'TXT';
if dlg.Execute then                                                            //Permite seleccionar un fichero.
   begin
   MainForm.RutaParaGuardarCombinacionesBinarias := dlg.FileName;
   ListaDeCombinaciones.SaveToFile(dlg.FileName);
   end;
dlg.Free;
end;

//-----------------------------------------------------------------------------
// Cargar la lista de combinaciones binarias desde un fichero.
//-----------------------------------------------------------------------------
procedure TFormConvertirEnBinario.CargarListaDeCombinaciones;
var dlg: TOpenDialog;
begin
dlg := TOpenDialog.Create(Self);                                               //Crea un diálogo.
dlg.InitialDir := MainForm.RutaParaGuardarCombinacionesBinarias;
dlg.Title := 'Cargar lista binaria...';                                        //Título del diálogo.
dlg.Filter := 'Ficheros de texto (*.txt)|*.TXT|Todos los ficheros (*.*)|*.*';  //Ficheros que se muestran.
dlg.DefaultExt := 'TXT';
if dlg.Execute then                                                            //Permite seleccionar un fichero.
   if FileExists(dlg.FileName) then                                            //Si el fichero seleccionado existe:
      begin
      MainForm.RutaParaGuardarCombinacionesBinarias := dlg.FileName;
      ListaDeCombinaciones.LoadFromFile(dlg.FileName);
      MostrarLista;
      end;
dlg.Free;
end;

//-----------------------------------------------------------------------------
// Crea una lista de combinaciones binarias.
//-----------------------------------------------------------------------------
function TFormConvertirEnBinario.CrearCombinacionesEnBinario(CodigoGray: Boolean): TStringList;
const Lugares: Array[1..32]of Byte = (0,1,2,2,3,3,3,3,4,4,4,4,4,4,4,4,      //Lugares binarios por
                                      5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5);     //cantidad de síbolos.
const Natural: Array[0..31]of String = (
      '00000','00001','00010','00011','00100','00101','00110','00111',      //Código binario natural.
      '01000','01001','01010','01011','01100','01101','01110','01111',
      '10000','10001','10010','10011','10100','10101','10110','10111',
      '11000','11001','11010','11011','11100','11101','11110','11111');
const Gray: Array[0..31]of String = (
      '00000','00001','00011','00010','00110','00111','00101','00100',      //Código binario Gray o reflejado.
      '01100','01101','01111','01110','01010','01011','01001','01000',
      '11000','11001','11011','11010','11110','11111','11101','11100',
      '10100','10101','10111','10110','10010','10011','10001','10000');
var n, m: Integer;
begin
Result := TStringList.Create;
Result.Clear;
m := Lugares[CantidadDeSimbolos] - 1;
for n := 0 to CantidadDeSimbolos - 1 do
    if CodigoGray then
       Result.Add(Copy(Gray[n], Length(Gray[n]) - m, Length(Gray[n])))
    else   
       Result.Add(Copy(Natural[n], Length(Natural[n]) - m, Length(Natural[n])));
end;

//-----------------------------------------------------------------------------
procedure TFormConvertirEnBinario.FormCreate(Sender: TObject);
begin
//
end;

//-----------------------------------------------------------------------------
procedure TFormConvertirEnBinario.ActionCargarListaExecute(Sender: TObject);
begin
CargarListaDeCombinaciones;
end;

//-----------------------------------------------------------------------------
procedure TFormConvertirEnBinario.ActionGuardarListaExecute(Sender: TObject);
begin
GuardarListaDeCombinaciones;
end;

//-----------------------------------------------------------------------------
procedure TFormConvertirEnBinario.ActionRotarArribaExecute(Sender: TObject);
var SalvaTemporal: String;
begin
SalvaTemporal := ListaDeCombinaciones[0];
ListaDeCombinaciones.Delete(0);
ListaDeCombinaciones.Add(SalvaTemporal);
MostrarLista;
end;

//-----------------------------------------------------------------------------
procedure TFormConvertirEnBinario.ActionRotarAbajoExecute(Sender: TObject);
var SalvaTemporal: String;
begin
SalvaTemporal := ListaDeCombinaciones[ListaDeCombinaciones.Count - 1];
ListaDeCombinaciones.Delete(ListaDeCombinaciones.Count - 1);
ListaDeCombinaciones.Insert(0, SalvaTemporal);
MostrarLista;
end;

//-----------------------------------------------------------------------------
procedure TFormConvertirEnBinario.ActionMoverArribaExecute(Sender: TObject);
var Row: Longint;
begin
Row := StringGrid1.Row - 1;
if Row > 0 then
   begin
   ListaDeCombinaciones.Exchange(Row, Row - 1);
   MostrarLista;
   StringGrid1.Row := Row;
   end;
end;

//-----------------------------------------------------------------------------
procedure TFormConvertirEnBinario.ActionMoverAbajoExecute(Sender: TObject);
var Row: Longint;
begin
Row := StringGrid1.Row - 1;
if Row < ListaDeCombinaciones.Count - 1 then
   begin
   ListaDeCombinaciones.Exchange(Row, Row + 1);
   MostrarLista;
   StringGrid1.Row := Row + 2;
   end;
end;

//-----------------------------------------------------------------------------
procedure TFormConvertirEnBinario.ActionRecrearListaExecute(Sender: TObject);
begin
CrearYMostrarLista;
end;

//-----------------------------------------------------------------------------
procedure TFormConvertirEnBinario.ActionCancelarExecute(Sender: TObject);
begin
Close;
end;

//-----------------------------------------------------------------------------
procedure TFormConvertirEnBinario.ActionConvertirExecute(Sender: TObject);
begin
FuenteDeDatos.ConvertirEnBinario(ListaDeCombinaciones);
Close;
end;

end.
