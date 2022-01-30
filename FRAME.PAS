unit Frame;

interface

uses
  Windows, Classes, Graphics, Forms, Controls,
  Child, Menus, SysUtils, Dialogs, ImgList,
  StdCtrls, ULista, Messages, StdActns, ActnList, ToolWin, ComCtrls,
  ExtCtrls;

const C_FICHERO_GRANDE = 100000;      //Tamaño a partir del cual se considera grande un fichero.

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    Window1: TMenuItem;
    File1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Cascade1: TMenuItem;
    Tile1: TMenuItem;
    ArrangeIcons1: TMenuItem;
    ActionList1: TActionList;
    ActionArrange: TWindowArrange;
    ActionCascade: TWindowCascade;
    ActionCerrarDemodulacion: TWindowClose;
    ActionMinimizeAll: TWindowMinimizeAll;
    ActionTileHorizontal: TWindowTileHorizontal;
    ActionTileVertical: TWindowTileVertical;
    Tile2: TMenuItem;
    Close1: TMenuItem;
    MinimizeAll1: TMenuItem;
    ActionAbrir: TAction;
    ActionSalvarComo: TAction;
    Open1: TMenuItem;
    Save1: TMenuItem;
    ActionSalvar: TAction;
    Save2: TMenuItem;
    Ayuda1: TMenuItem;
    GuardarImagen1: TMenuItem;
    ActionGuardarImagen: TAction;
    StatusBar1: TStatusBar;
    ActionBuscarPeriodo: TAction;
    ActionPropiedades: TAction;
    Utilidades1: TMenuItem;
    ImageList1: TImageList;
    ActionUtilizacion: TAction;
    ActionProcedencia: TAction;
    ActionAmpliador: TAction;
    ActionComparadorDIFF: TAction;
    ActionComparadorMOSTWOLE: TAction;
    ActionBuscadorPeriodos: TAction;
    ActionBuscarCadena: TAction;
    Ampliador1: TMenuItem;
    ComparadorDIFF1: TMenuItem;
    ComparadorMOSTWOLE1: TMenuItem;
    Buscadordeperiodos1: TMenuItem;
    Buscarcadena1: TMenuItem;
    Comoutilizaresteprograma1: TMenuItem;
    Procedencia1: TMenuItem;
    ControlBar1: TControlBar;
    ToolBar2: TToolBar;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    ToolButton27: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    N2: TMenuItem;
    N3: TMenuItem;
    ActionEstructurarDemodulacion: TAction;
    ToolButton16: TToolButton;
    Estructurardemodulacin1: TMenuItem;
    ActionBuscarBloques: TAction;
    ToolButton17: TToolButton;
    Buscarbloque1: TMenuItem;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ActionComparadorLevenshtein: TAction;
    procedure Exit1Click(Sender: TObject);
    procedure ActionNewExecute(Sender: TObject);
    procedure ActionAbrirExecute(Sender: TObject);
    procedure ActionSalvarComoExecute(Sender: TObject);
    procedure ActionSalvarComoUpdate(Sender: TObject);
    procedure ActionSalvarUpdate(Sender: TObject);
    procedure ActionSalvarExecute(Sender: TObject);
    procedure ActionGuardarImagenExecute(Sender: TObject);
    procedure ActionGuardarImagenUpdate(Sender: TObject);
    procedure ActionBuscarPeriodoExecute(Sender: TObject);
    procedure ActionBuscarPeriodoUpdate(Sender: TObject);
    procedure ActionPropiedadesUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActionUtilizacionExecute(Sender: TObject);
    procedure ActionProcedenciaExecute(Sender: TObject);
    procedure ActionAmpliadorExecute(Sender: TObject);
    procedure ActionComparadorDIFFExecute(Sender: TObject);
    procedure ActionComparadorMOSTWOLEExecute(Sender: TObject);
    procedure ActionBuscadorPeriodosExecute(Sender: TObject);
    procedure ActionBuscarCadenaExecute(Sender: TObject);
    procedure ActionEstructurarDemodulacionExecute(Sender: TObject);
    procedure ActionBuscarBloquesExecute(Sender: TObject);
    procedure ActionComparadorLevenshteinExecute(Sender: TObject);
  private
    procedure ReadIni;
    procedure WriteIni;
  public
    Counter: Integer;
    RutaParaBuscarDemodulaciones: String;
    RutaParaGuardarDemodulaciones: String;
    RutaParaGuardarImagenes: String;
    RutaParaGuardarCombinacionesBinarias: String;
    RutaParaGuardarEstadisticas: String;
    function ExtraerNombreDeFichero(Ruta: String): String;
    procedure ProcesarFichero(FileName: String);
  end;



var
  MainForm: TMainForm;

implementation

uses UAmpliador, UBuscaCadenaEnFichero, UComparadorDIFF,
     UComparadorMOST, UInterfaceBuscaPeriodo,
  UGuardaEnRegistro, UProcedencia, UEstructurarDemodulacion,
  UBuscaBloqueDeCadenaEnFichero, UComparadorLevenshtein;

{$R *.dfm}

//-------------------------------------------------------------------
// Se le pasa un a ruta completa y devuelve solo el nombre del fichero.  
//-------------------------------------------------------------------
function TMainForm.ExtraerNombreDeFichero(Ruta: String): String;
var n: Integer;
begin
for n := Length(Ruta) downto 1 do if Ruta[n] = '\' then Break;
Result := Copy(Ruta, n + 1, Length(Ruta) - n + 1);
end;


//-------------------------------------------------------------------
// Cierra la aplicación.
//-------------------------------------------------------------------
procedure TMainForm.Exit1Click(Sender: TObject);
begin
Close;
end;

//-------------------------------------------------------------------
// Crea una nueva ventana hija.
//-------------------------------------------------------------------
procedure TMainForm.ActionNewExecute(Sender: TObject);
var ChildForm: TChildForm;
begin
Inc (Counter);
ChildForm := TChildForm.Create(self);
ChildForm.Caption := LowerCase(ExtractFilePath (Application.Exename)) + 'Sin_Nombre_' + IntToStr (Counter) + '.txt';
ChildForm.Show;
end;


//-------------------------------------------------------------------
// Permite cargar los datos de la demodulación desde un fichero.
//-------------------------------------------------------------------
procedure TMainForm.ActionAbrirExecute(Sender: TObject);
var dlg: TOpenDialog;
begin
dlg := TOpenDialog.Create(Self);                                               //Crea un diálogo.
dlg.InitialDir := RutaParaBuscarDemodulaciones;
dlg.Title := 'Cargar demodulación...';                                         //Título del diálogo.
dlg.Filter := 'Ficheros de texto (*.txt)|*.TXT|Todos los ficheros (*.*)|*.*';  //Ficheros que se muestran.
if dlg.Execute then                                                            //Permite seleccionar un raster.
   if FileExists(dlg.FileName) then                                            //Si el raster seleccionado existe:
      ProcesarFichero(dlg.FileName);
dlg.Free;                                                                      //Libera el diálogo creado.
end;


//-------------------------------------------------------------------
// Permite cargar los datos de la demodulación desde el fichero indicado.
//-------------------------------------------------------------------
procedure TMainForm.ProcesarFichero(FileName: String);
begin
RutaParaBuscarDemodulaciones := FileName;
ActionNewExecute(self);                                                  //Crea una ventana hija.
StatusBar1.Panels[0].Text := 'Cargando demodulación '+ FileName;         //Crea en la barra de estado un mensaje.
Refresh;                                                                 //Muestra el mensaje de la barra de estado.
(ActiveMDIChild as TChildForm).Cargar(FileName);                         //Carga el raster seleccionado.
StatusBar1.Panels[0].Text := '';
Refresh;
(ActiveMDIChild as TChildForm).BuscarPeriodos;                           //Busca los períodos de la demodulación cargada.
end;


//-------------------------------------------------------------------
// Permite guardar los datos de la demodulación en un fichero.
//-------------------------------------------------------------------
procedure TMainForm.ActionSalvarComoExecute(Sender: TObject);
begin
if Assigned(ActiveMDIChild) then
   (ActiveMDIChild as TChildForm).ActionSalvarComoExecute(Sender);
end;


//-------------------------------------------------------------------
procedure TMainForm.ActionSalvarExecute(Sender: TObject);
begin
if Assigned(ActiveMDIChild) then
   (ActiveMDIChild as TChildForm).ActionSalvarCambiosExecute(Sender);
end;

//-------------------------------------------------------------------
// Guarda la imagen del raster en un fichero.
//-------------------------------------------------------------------
procedure TMainForm.ActionGuardarImagenExecute(Sender: TObject);
begin
if Assigned(ActiveMDIChild) then
   (ActiveMDIChild as TChildForm).ActionGuardarImagenExecute(Sender);
end;


//-------------------------------------------------------------------
// Busca los períodos de la demodulación.
//-------------------------------------------------------------------
procedure TMainForm.ActionBuscarPeriodoExecute(Sender: TObject);
begin
if Assigned(ActiveMDIChild) then
   (ActiveMDIChild as TChildForm).BuscarPeriodos;
end;

//-------------------------------------------------------------------
// Activa estos submenús si existen ventanas hijas.
//-------------------------------------------------------------------
procedure TMainForm.ActionGuardarImagenUpdate(Sender: TObject);
begin
ActionGuardarImagen.Enabled := MDIChildCount > 0;
end;

//-------------------------------------------------------------------
procedure TMainForm.ActionBuscarPeriodoUpdate(Sender: TObject);
begin
ActionBuscarPeriodo.Enabled := MDIChildCount > 0;
end;

//-------------------------------------------------------------------
procedure TMainForm.ActionPropiedadesUpdate(Sender: TObject);
begin
ActionPropiedades.Enabled := MDIChildCount > 0;
end;

//-------------------------------------------------------------------
procedure TMainForm.ActionSalvarComoUpdate(Sender: TObject);
begin
ActionSalvarComo.Enabled := MDIChildCount > 0;
end;

//-------------------------------------------------------------------
procedure TMainForm.ActionSalvarUpdate(Sender: TObject);
begin
ActionSalvar.Enabled := (MDIChildCount > 0) and (ActiveMDIChild as TChildForm).HistoryDataManager1.Modificado;
end;

//-------------------------------------------------------------------
procedure TMainForm.FormCreate(Sender: TObject);
begin
ReadIni;
end;

//-----------------------------------------------------------------------------
// Lee del registro los valores de configuración.
//-----------------------------------------------------------------------------
procedure TMainForm.ReadIni;
begin
with SrchIniFile do
     begin
     RutaParaBuscarDemodulaciones := ReadString('Aplicacion', 'RutaParaBuscarDemodulaciones', 'D:\');
     RutaParaGuardarDemodulaciones := ReadString('Aplicacion', 'RutaParaGuardarDemodulaciones', 'D:\');
     RutaParaGuardarImagenes := ReadString('Aplicacion', 'RutaParaGuardarImagenes', 'D:\');
     RutaParaGuardarCombinacionesBinarias := ReadString('Aplicacion', 'RutaParaGuardarCombinacionesBinarias', 'D:\');
     RutaParaGuardarEstadisticas := ReadString('Aplicacion', 'RutaParaGuardarEstadisticas', 'D:\');
     end;
end;

//-----------------------------------------------------------------------------
// Escribe en el registro los valores de configuración.
//-----------------------------------------------------------------------------
procedure TMainForm.WriteIni;
begin
with SrchIniFile do
     begin
     WriteString('Aplicacion', 'RutaParaBuscarDemodulaciones', RutaParaBuscarDemodulaciones);
     WriteString('Aplicacion', 'RutaParaGuardarDemodulaciones', RutaParaGuardarDemodulaciones);
     WriteString('Aplicacion', 'RutaParaGuardarImagenes', RutaParaGuardarImagenes);
     WriteString('Aplicacion', 'RutaParaGuardarCombinacionesBinarias', RutaParaGuardarCombinacionesBinarias);
     WriteString('Aplicacion', 'RutaParaGuardarEstadisticas', RutaParaGuardarEstadisticas);
     end;
end;

//-----------------------------------------------------------------------------
// Guarda la configuración.
//-----------------------------------------------------------------------------
procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
WriteIni;
end;

procedure TMainForm.ActionUtilizacionExecute(Sender: TObject);
begin
//Muestra la ayuda sobre la utilización del programa.
end;

procedure TMainForm.ActionProcedenciaExecute(Sender: TObject);
var Form: TFormProcedencia;
begin
Inc (Counter);
Form := TFormProcedencia.Create(self);
Form.Show;
end;

procedure TMainForm.ActionAmpliadorExecute(Sender: TObject);
var Form: TFormAmpliador;
begin
Inc (Counter);
Form := TFormAmpliador.Create(self);
Form.Show;
end;

procedure TMainForm.ActionComparadorDIFFExecute(Sender: TObject);
var Form: TFormComparadorDIFF;
begin
Inc (Counter);
Form := TFormComparadorDIFF.Create(self);
Form.Show;
end;

procedure TMainForm.ActionComparadorMOSTWOLEExecute(Sender: TObject);
var Form: TFormComparadorMost;
begin
Inc (Counter);
Form := TFormComparadorMost.Create(self);
Form.Show;
end;

procedure TMainForm.ActionComparadorLevenshteinExecute(Sender: TObject);
begin
Inc (Counter);
with TFormComparadorLevenshtein.Create(self) do Show;
end;

procedure TMainForm.ActionBuscadorPeriodosExecute(Sender: TObject);
var Form: TFormBuscaPeriodos;
begin
Inc (Counter);
Form := TFormBuscaPeriodos.Create(self);
Form.Show;
end;

procedure TMainForm.ActionBuscarCadenaExecute(Sender: TObject);
var Form: TFormCadenaEnFichero;
begin
Inc (Counter);
Form := TFormCadenaEnFichero.Create(self);
Form.Show;
end;

procedure TMainForm.ActionEstructurarDemodulacionExecute(Sender: TObject);
var Form: TFormEstructurarDemodulacion;
begin
Inc (Counter);
Form := TFormEstructurarDemodulacion.Create(self);
Form.Show;
end;

procedure TMainForm.ActionBuscarBloquesExecute(Sender: TObject);
var Form: TFormBloqueDeCadenaEnFichero;
begin
Inc (Counter);
Form := TFormBloqueDeCadenaEnFichero.Create(self);
Form.Show;
end;


end.


