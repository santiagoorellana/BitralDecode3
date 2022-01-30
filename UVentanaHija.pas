unit UVentanaHija;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Menus, ExtCtrls, DataManager, EditableText,
  HistoryDataManager, Grids, ActnList, ImgList, ToolWin;

type
  TForm1 = class(TForm)
    ActionMoverIzquierda: TAction;
    ActionMoverDerecha: TAction;
    ActionMoverArriba: TAction;
    ActionMoverAbajo: TAction;
    ActionMoverInicio: TAction;
    ActionMoverFinal: TAction;
    ActionPaginaArriba: TAction;
    ActionPaginaAbajo: TAction;
    ActionAumentar: TAction;
    ActionDisminuir: TAction;
    ActionCambiarColores: TAction;
    ActionDeshacer: TAction;
    ActionRehacer: TAction;
    ActionDesseleccionar: TAction;
    ActionBorrar: TAction;
    ActionCopiar: TAction;
    ActionCortar: TAction;
    ActionPegar: TAction;
    ActionFiltrar: TAction;
    ActionLlenar: TAction;
    ActionInsertar: TAction;
    ActionCantidadSimbolos: TAction;
    ActionDesplazamiento: TAction;
    ActionPeriodo: TAction;
    ActionLeyenda: TAction;
    ActionAyuda: TAction;
    ActionList1: TActionList;
    ActionCerrar: TAction;
    ActionPaginaIzquierda: TAction;
    ActionPaginaDerecha: TAction;
    ActionRecalcularCantidadSimbolos: TAction;
    ActionSalvarCambios: TAction;
    ActionGuardarImagen: TAction;
    MainMenu1: TMainMenu;
    Fichero1: TMenuItem;
    Edicin1: TMenuItem;
    Ayuda1: TMenuItem;
    Visualizacin1: TMenuItem;
    Salvarcambios1: TMenuItem;
    Guardarimagen1: TMenuItem;
    Cerrar1: TMenuItem;
    Deshacer1: TMenuItem;
    Rehacer1: TMenuItem;
    Copiarseleccin1: TMenuItem;
    Cortarseleccin1: TMenuItem;
    Pegar1: TMenuItem;
    Llenarseleccin1: TMenuItem;
    Insertardatos1: TMenuItem;
    Desseleccionar1: TMenuItem;
    Filtrardatos1: TMenuItem;
    Final1: TMenuItem;
    Inicio1: TMenuItem;
    Aumentar1: TMenuItem;
    Disminuir1: TMenuItem;
    Cambiarcolores1: TMenuItem;
    Leyendadelraster1: TMenuItem;
    Ayuda2: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N7: TMenuItem;
    N9: TMenuItem;
    StatusBar1: TStatusBar;
    ActionVerTexto: TAction;
    ActionBuscar: TAction;
    Vertextoseleccionado1: TMenuItem;
    Buscar1: TMenuItem;
    N11: TMenuItem;
    ActionBuscarSiguiente: TAction;
    Buscarsiguiente1: TMenuItem;
    ImageList1: TImageList;
    Borrarseleccin1: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    ToolButton18: TToolButton;
    ToolBar2: TToolBar;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    ToolButton27: TToolButton;
    ToolButton32: TToolButton;
    ToolButton33: TToolButton;
    ToolButton37: TToolButton;
    ToolButton28: TToolButton;
    ToolButton30: TToolButton;
    ToolButton29: TToolButton;
    ToolButton31: TToolButton;
    ToolButton3: TToolButton;
    ToolButton34: TToolButton;
    ToolButton35: TToolButton;
    N1: TMenuItem;
    Periodo1: TMenuItem;
    Desplazamientohorizontal1: TMenuItem;
    Cantidaddesmbolos1: TMenuItem;
    Recalcularcantidaddesmbolos1: TMenuItem;
    ActionDesplazarIzquierda: TAction;
    ActionDesplazarDerecha: TAction;
    ActionDisminuirPeriodo: TAction;
    ActionAumentarPeriodo: TAction;
    ActionConvertorEnBinario: TAction;
    ToolButton36: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure ActionDesseleccionarExecute(Sender: TObject);
    procedure ActionCerrarExecute(Sender: TObject);
    procedure ActionLeyendaExecute(Sender: TObject);
    procedure ActionAyudaExecute(Sender: TObject);
    procedure ActionMoverIzquierdaExecute(Sender: TObject);
    procedure ActionMoverDerechaExecute(Sender: TObject);
    procedure ActionMoverArribaExecute(Sender: TObject);
    procedure ActionMoverAbajoExecute(Sender: TObject);
    procedure ActionMoverInicioExecute(Sender: TObject);
    procedure ActionMoverFinalExecute(Sender: TObject);
    procedure ActionPaginaArribaExecute(Sender: TObject);
    procedure ActionPaginaAbajoExecute(Sender: TObject);
    procedure ActionAumentarExecute(Sender: TObject);
    procedure ActionDisminuirExecute(Sender: TObject);
    procedure ActionCambiarColoresExecute(Sender: TObject);
    procedure ActionDeshacerExecute(Sender: TObject);
    procedure ActionRehacerExecute(Sender: TObject);
    procedure ActionBorrarExecute(Sender: TObject);
    procedure ActionCopiarExecute(Sender: TObject);
    procedure ActionCortarExecute(Sender: TObject);
    procedure ActionPegarExecute(Sender: TObject);
    procedure ActionFiltrarExecute(Sender: TObject);
    procedure ActionLlenarExecute(Sender: TObject);
    procedure ActionInsertarExecute(Sender: TObject);
    procedure ActionCantidadSimbolosExecute(Sender: TObject);
    procedure ActionDesplazamientoExecute(Sender: TObject);
    procedure ActionPeriodoExecute(Sender: TObject);
    procedure ActionPaginaIzquierdaExecute(Sender: TObject);
    procedure ActionPaginaDerechaExecute(Sender: TObject);
    procedure ActionSalvarCambiosExecute(Sender: TObject);
    procedure ActionGuardarImagenExecute(Sender: TObject);
    procedure ActionAjustarAnchoExecute(Sender: TObject);
    procedure RasterMouseMove(Sender: TObject; Shift: TShiftState; X, Y, PosicionValor: Integer; Valor: Byte);
    procedure ActionVerTextoExecute(Sender: TObject);
    procedure ActionBuscarExecute(Sender: TObject);
    procedure ActionBuscarSiguienteExecute(Sender: TObject);
    procedure ActionRecalcularCantidadSimbolosExecute(Sender: TObject);
    procedure ActionDesplazarIzquierdaExecute(Sender: TObject);
    procedure ActionDesplazarDerechaExecute(Sender: TObject);
    procedure ActionDisminuirPeriodoExecute(Sender: TObject);
    procedure ActionAumentarPeriodoExecute(Sender: TObject);
    procedure ActionConvertorEnBinarioExecute(Sender: TObject);
  private
    Raster1: TEditableText;
    HistoryDataManager1: THistoryDataManager;
  public
    procedure Iniciar(FuenteDeDatos: THistoryDataManager; Periodo, Desplazamiento: Integer; UsarColor: Boolean);
    procedure CargarDemodulacion;
    procedure ActualizarRaster;
    procedure ActualizarColores;
  end;

var
  Form1: TForm1;

implementation

uses UDialogoBuscar, UConvertirEnBinario;

{$R *.dfm}

//-------------------------------------------------------------------
// Crea el formulario y establece los valores por defecto.
//-------------------------------------------------------------------
procedure TForm1.FormCreate(Sender: TObject);
begin
DoubleBuffered := True;
//Inicia el objeto "HistoryDataManager".
HistoryDataManager1 := THistoryDataManager.Create;
//Inicia el componente visible "SimpleRaster".
Raster1 := TEditableText.Create(Self);
Raster1.Parent := Self;
Raster1.Align := alClient;
Raster1.Width := 10;
Raster1.Height := 10;
Raster1.OnRasterMouseMove := RasterMouseMove;
end;

//-------------------------------------------------------------------
// Establece los parámetros de funcionamiento del editor.
//-------------------------------------------------------------------
procedure TForm1.Iniciar(FuenteDeDatos: THistoryDataManager; Periodo, Desplazamiento: Integer; UsarColor: Boolean);
begin
Raster1.Iniciar(FuenteDeDatos, Periodo, Desplazamiento, UsarColor);
end;


//-------------------------------------------------------------------
// Carga un fichero de demodulación con los parámetros preestablecidos.
//-------------------------------------------------------------------
procedure TForm1.CargarDemodulacion;
begin
Raster1.CargarDemodulacion;
end;

//-------------------------------------------------------------------
// Muestra en la barra de estado los datos de las
// coordenadas del puntero del Mouse.
//-------------------------------------------------------------------
procedure TForm1.RasterMouseMove(Sender: TObject; Shift: TShiftState; X, Y, PosicionValor: Integer; Valor: Byte);
begin
StatusBar1.Panels[0].Text := ' X: ' + IntToStr(X) + '  Y: ' + IntToStr(Y);
StatusBar1.Panels[1].Text := ' Posición: ' + IntToStr(PosicionValor);
StatusBar1.Panels[2].Text := ' Valor: ' + IntToHex(Valor, 2) + 'h  (' + Chr(Valor) + ')';
end;


//-------------------------------------------------------------------
// Actualiza la imagen del raster.
//-------------------------------------------------------------------
procedure TForm1.ActualizarRaster;
begin
Raster1.ActualizarRaster;
end;

//-------------------------------------------------------------------
// Actualiza los colores del raster.
//-------------------------------------------------------------------
procedure TForm1.ActualizarColores;
begin
Raster1.ActualizarColores;
end;


//-------------------------------------------------------------------
// Estos procedimientos controlan los eventos del menú.
//-------------------------------------------------------------------
procedure TForm1.ActionDesseleccionarExecute(Sender: TObject);
begin
Raster1.Desseleccionar;
end;

procedure TForm1.ActionCerrarExecute(Sender: TObject);
begin
Close;
end;

procedure TForm1.ActionLeyendaExecute(Sender: TObject);
begin
Raster1.MostrarLeyenda;
end;

procedure TForm1.ActionAyudaExecute(Sender: TObject);
var msg: String;
begin
msg := 'EDITOR DE CARACTERES' + #13#13;
msg := msg + 'Muestra los caracteres (símbolos) de la demodulación' + #13;
msg := msg + 'ordenados según el período previamente establecido' + #13;
msg := msg + 'permitiendo modificarlos por medio de comandos muy' + #13;
msg := msg + 'simples como los que utilizan algunos programas de' + #13;
msg := msg + 'edición de texto o imágenes.' + #13#13;
msg := msg + 'Mediante el puntero del ratón (mouse) se pueden' + #13;
msg := msg + 'seleccionar las areas de texto a las cuales se' + #13;
msg := msg + 'le aplicará alguno de los comandos.' + #13#13;
msg := msg + 'Para desplazarse por el texto, se utilizarán las ' + #13;
msg := msg + 'teclas de dirección, el mouse o comandos.' + #13;
Application.MessageBox(PChar(msg), 'AYUDA', MB_OK);
end;

procedure TForm1.ActionMoverIzquierdaExecute(Sender: TObject);
begin
Raster1.MoverIzquierda(1);
end;

procedure TForm1.ActionMoverDerechaExecute(Sender: TObject);
begin
Raster1.MoverDerecha(1);
end;

procedure TForm1.ActionMoverArribaExecute(Sender: TObject);
begin
Raster1.MoverArriba(1);
end;

procedure TForm1.ActionMoverAbajoExecute(Sender: TObject);
begin
Raster1.MoverAbajo(1);
end;

procedure TForm1.ActionMoverInicioExecute(Sender: TObject);
begin
Raster1.MoverInicio;
end;

procedure TForm1.ActionMoverFinalExecute(Sender: TObject);
begin
Raster1.MoverFinal;
end;

procedure TForm1.ActionPaginaArribaExecute(Sender: TObject);
begin
Raster1.PageUp;
end;

procedure TForm1.ActionPaginaAbajoExecute(Sender: TObject);
begin
Raster1.PageDown;
end;

procedure TForm1.ActionAumentarExecute(Sender: TObject);
begin
Raster1.AumentarAnchoDePixel;
end;

procedure TForm1.ActionDisminuirExecute(Sender: TObject);
begin
Raster1.DisminuirAnchoDePixel;
end;

procedure TForm1.ActionCambiarColoresExecute(Sender: TObject);
begin
Raster1.CambiarColores;
end;

procedure TForm1.ActionDeshacerExecute(Sender: TObject);
begin
Raster1.Deshacer;
end;

procedure TForm1.ActionRehacerExecute(Sender: TObject);
begin
Raster1.Rehacer;
end;

procedure TForm1.ActionBorrarExecute(Sender: TObject);
begin
Raster1.BorrarSeleccion;
end;

procedure TForm1.ActionCopiarExecute(Sender: TObject);
begin
Raster1.CopiarSeleccion;
end;

procedure TForm1.ActionCortarExecute(Sender: TObject);
begin
Raster1.CortarSeleccion;
end;

procedure TForm1.ActionPegarExecute(Sender: TObject);
begin
Raster1.PegarSeleccionCopiada;
end;

procedure TForm1.ActionFiltrarExecute(Sender: TObject);
begin
Raster1.FiltrarDatos;
end;

procedure TForm1.ActionLlenarExecute(Sender: TObject);
begin
Raster1.PedirCaracterParaLlenarSeleccion;
end;

procedure TForm1.ActionInsertarExecute(Sender: TObject);
begin
Raster1.PedirCaracteresParaInsertar;
end;

procedure TForm1.ActionCantidadSimbolosExecute(Sender: TObject);
begin
Raster1.PedirCantidadDeSimbolos;
end;

procedure TForm1.ActionDesplazamientoExecute(Sender: TObject);
begin
Raster1.PedirDesplazamiento;
end;

procedure TForm1.ActionPeriodoExecute(Sender: TObject);
begin
Raster1.PedirPeriodo;
end;

procedure TForm1.ActionPaginaIzquierdaExecute(Sender: TObject);
begin
Raster1.PageLeft;
end;

procedure TForm1.ActionPaginaDerechaExecute(Sender: TObject);
begin
Raster1.PageRight;
end;

procedure TForm1.ActionSalvarCambiosExecute(Sender: TObject);
begin
Raster1.GuardarCambios;
end;

procedure TForm1.ActionGuardarImagenExecute(Sender: TObject);
begin
Raster1.GuardarImagen;
end;

procedure TForm1.ActionAjustarAnchoExecute(Sender: TObject);
begin
Raster1.AjustarAncho;
end;

procedure TForm1.ActionVerTextoExecute(Sender: TObject);
begin
Raster1.MostrarTextoDeSeleccion;
end;

procedure TForm1.ActionBuscarExecute(Sender: TObject);
begin
with TFormBuscaCoincidencia.Create(Self) do
     begin
     Fuente := Raster1;
     FormStyle := fsStayOnTop;
     Show;
     end;
end;

procedure TForm1.ActionBuscarSiguienteExecute(Sender: TObject);
begin
Raster1.BuscarSiguienteCoincidencia;
end;

procedure TForm1.ActionRecalcularCantidadSimbolosExecute(
  Sender: TObject);
begin
Raster1.CalcularLaCantidadDeSimbolosActualDelRaster;
end;

procedure TForm1.ActionDesplazarIzquierdaExecute(
  Sender: TObject);
begin
Raster1.DesplazarIzquierda;
end;

procedure TForm1.ActionDesplazarDerechaExecute(
  Sender: TObject);
begin
Raster1.DesplazarDerecha;
end;

procedure TForm1.ActionDisminuirPeriodoExecute(
  Sender: TObject);
begin
Raster1.DisminuirPeriodo;
end;

procedure TForm1.ActionAumentarPeriodoExecute(
  Sender: TObject);
begin
Raster1.AumentarPeriodo;
end;

procedure TForm1.ActionConvertorEnBinarioExecute(Sender: TObject);
begin
with TFormConvertirEnBinario.Create(Self) do
     begin
     Mostrar(Raster1.FuenteDeDatos);
     if Raster1.FuenteDeDatos.OptenerCantidadDeSimbolos = 2 then
        Raster1.CambiarColores;
     end;
end;

end.
