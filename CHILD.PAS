unit Child;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, Dialogs, HistoryDataManager, SimpleRaster,
  Spin, ExtCtrls, ComCtrls, Menus, ActnList, UBuscaPeriodos,
  ImgList, Buttons, ToolWin, EditableRaster, EditableText;

type
  TChildForm = class(TForm)
    PageControl1: TPageControl;
    ActionList1: TActionList;
    ActionMoverIzquierda: TAction;
    ActionMoverDerecha: TAction;
    ActionMoverArriba: TAction;
    ActionMoverAbajo: TAction;
    ActionMoverInicio: TAction;
    ActionMoverFinal: TAction;
    ActionPaginaArriba: TAction;
    ActionPaginaAbajo: TAction;
    ActionPaginaIzquierda: TAction;
    ActionPaginaDerecha: TAction;
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
    ActionRecalcularCantidadSimbolos: TAction;
    ActionDesplazamiento: TAction;
    ActionPeriodo: TAction;
    ActionLeyenda: TAction;
    ActionAyuda: TAction;
    ActionCerrar: TAction;
    ActionSalvarCambios: TAction;
    ActionGuardarImagen: TAction;
    ActionVerTexto: TAction;
    ActionBuscar: TAction;
    ActionBuscarSiguiente: TAction;
    ActionDesplazarIzquierda: TAction;
    ActionDesplazarDerecha: TAction;
    ActionDisminuirPeriodo: TAction;
    ActionAumentarPeriodo: TAction;
    ActionConvertirEnBinario: TAction;
    MainMenu1: TMainMenu;
    Fichero1: TMenuItem;
    Salvarcambios1: TMenuItem;
    N5: TMenuItem;
    Guardarimagen1: TMenuItem;
    N4: TMenuItem;
    Cerrar1: TMenuItem;
    Edicin1: TMenuItem;
    Deshacer1: TMenuItem;
    Rehacer1: TMenuItem;
    N7: TMenuItem;
    Copiarseleccin1: TMenuItem;
    Cortarseleccin1: TMenuItem;
    Pegar1: TMenuItem;
    Llenarseleccin1: TMenuItem;
    Insertardatos1: TMenuItem;
    Vertextoseleccionado1: TMenuItem;
    Borrarseleccin1: TMenuItem;
    Filtrardatos1: TMenuItem;
    Cantidaddesmbolos1: TMenuItem;
    Recalcularcantidaddesmbolos1: TMenuItem;
    N11: TMenuItem;
    Buscar1: TMenuItem;
    Buscarsiguiente1: TMenuItem;
    N9: TMenuItem;
    Desseleccionar1: TMenuItem;
    Visualizacin1: TMenuItem;
    Aumentar1: TMenuItem;
    Disminuir1: TMenuItem;
    N2: TMenuItem;
    Inicio1: TMenuItem;
    Final1: TMenuItem;
    N1: TMenuItem;
    Periodo1: TMenuItem;
    Desplazamientohorizontal1: TMenuItem;
    N3: TMenuItem;
    Cambiarcolores1: TMenuItem;
    Ayuda1: TMenuItem;
    Ayuda2: TMenuItem;
    Leyendadelraster1: TMenuItem;
    StatusBar1: TStatusBar;
    ActionSalvarComo: TAction;
    ActionEstadistica: TAction;
    Verestadisticadesmbolos1: TMenuItem;
    N6: TMenuItem;
    Salvarcomo1: TMenuItem;
    Ventana1: TMenuItem;
    Utilidades1: TMenuItem;
    Ampliador1: TMenuItem;
    ComparadorDIFF1: TMenuItem;
    ComparadorMOSTWOLE1: TMenuItem;
    Buscadordeperiodos1: TMenuItem;
    Buscarcadena1: TMenuItem;
    Abrirdemodulacin1: TMenuItem;
    Cascada1: TMenuItem;
    MosaicoVertical1: TMenuItem;
    MosaicoHorizontal1: TMenuItem;
    Distribuiriconos1: TMenuItem;
    Minimizartodas1: TMenuItem;
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton38: TToolButton;
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
    ToolButton29: TToolButton;
    ToolButton6: TToolButton;
    ToolButton34: TToolButton;
    ToolButton35: TToolButton;
    ToolButton36: TToolButton;
    ToolButton4: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton31: TToolButton;
    ToolButton18: TToolButton;
    ControlBar2: TControlBar;
    ToolBar2: TToolBar;
    ToolButton32: TToolButton;
    ToolButton33: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton26: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton27: TToolButton;
    ToolButton37: TToolButton;
    ToolButton30: TToolButton;
    ToolButton3: TToolButton;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    ActionInformacion: TAction;
    ToolButton28: TToolButton;
    Informacin1: TMenuItem;
    Panel1: TPanel;
    GroupBox3: TGroupBox;
    SpinEdit2: TSpinEdit;
    Button1: TButton;
    GroupBox2: TGroupBox;
    SpinEdit1: TSpinEdit;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox4: TGroupBox;
    Edit1: TEdit;
    Button3: TButton;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    Eliminarseleccin1: TMenuItem;
    Eliminartodos1: TMenuItem;
    Exportarlista1: TMenuItem;
    Recalcular1: TMenuItem;
    Guardarimagen2: TMenuItem;
    Agregarperodoalalista1: TMenuItem;
    Cambiarcolores2: TMenuItem;
    Editaresteperodo1: TMenuItem;
    Procedencia1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ActionCerrarExecute(Sender: TObject);
    procedure ActionSalvarCambiosExecute(Sender: TObject);
    procedure ActionSalvarComoExecute(Sender: TObject);
    procedure ActionGuardarImagenExecute(Sender: TObject);
    procedure ActionLeyendaExecute(Sender: TObject);
    procedure ActionAyudaExecute(Sender: TObject);
    procedure ActionDeshacerExecute(Sender: TObject);
    procedure ActionRehacerExecute(Sender: TObject);
    procedure ActionDesseleccionarExecute(Sender: TObject);
    procedure ActionBorrarExecute(Sender: TObject);
    procedure ActionCopiarExecute(Sender: TObject);
    procedure ActionCortarExecute(Sender: TObject);
    procedure ActionPegarExecute(Sender: TObject);
    procedure ActionFiltrarExecute(Sender: TObject);
    procedure ActionLlenarExecute(Sender: TObject);
    procedure ActionInsertarExecute(Sender: TObject);
    procedure ActionCantidadSimbolosExecute(Sender: TObject);
    procedure ActionRecalcularCantidadSimbolosExecute(Sender: TObject);
    procedure ActionDesplazamientoExecute(Sender: TObject);
    procedure ActionPeriodoExecute(Sender: TObject);
    procedure ActionVerTextoExecute(Sender: TObject);
    procedure ActionBuscarExecute(Sender: TObject);
    procedure ActionBuscarSiguienteExecute(Sender: TObject);
    procedure ActionDesplazarIzquierdaExecute(Sender: TObject);
    procedure ActionDesplazarDerechaExecute(Sender: TObject);
    procedure ActionDisminuirPeriodoExecute(Sender: TObject);
    procedure ActionAumentarPeriodoExecute(Sender: TObject);
    procedure ActionMoverIzquierdaExecute(Sender: TObject);
    procedure ActionMoverDerechaExecute(Sender: TObject);
    procedure ActionMoverArribaExecute(Sender: TObject);
    procedure ActionMoverAbajoExecute(Sender: TObject);
    procedure ActionMoverInicioExecute(Sender: TObject);
    procedure ActionMoverFinalExecute(Sender: TObject);
    procedure ActionPaginaArribaExecute(Sender: TObject);
    procedure ActionPaginaAbajoExecute(Sender: TObject);
    procedure ActionPaginaIzquierdaExecute(Sender: TObject);
    procedure ActionPaginaDerechaExecute(Sender: TObject);
    procedure ActionAumentarExecute(Sender: TObject);
    procedure ActionDisminuirExecute(Sender: TObject);
    procedure ActionCambiarColoresExecute(Sender: TObject);
    procedure ActionConvertirEnBinarioExecute(Sender: TObject);
    procedure ActionEstadisticaExecute(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ActionInformacionExecute(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Eliminarseleccin1Click(Sender: TObject);
    procedure Eliminartodos1Click(Sender: TObject);
    procedure Exportarlista1Click(Sender: TObject);
    procedure Recalcular1Click(Sender: TObject);
    procedure Agregarperodoalalista1Click(Sender: TObject);
  private
    procedure DataChange(Sender: TObject);
    procedure SimbolChange(Sender: TObject);
    procedure RasterMouseMove(Sender: TObject; Shift: TShiftState; X, Y, PosicionValor: Integer; Valor: Byte);
    procedure AnyChange(Sender: TObject);
  public
    HistoryDataManager1: THistoryDataManager;
    RasterEditableSimple: TEditableRaster;
    RasterEditableDeTexto: TEditableText;
    RasterSimple: TSimpleRaster;
    ProcesoBuscadorDePeriodos1: TBuscadorDePeriodos;
    procedure BusquedaDePeriodosTerminada(Sender: TObject);
    procedure Cargar(FileName: string);
    procedure BuscarPeriodos;
    procedure MostrarPropiedades;
    procedure SincronizarEditores;
  end;


var
  ChildForm: TChildForm;

implementation

uses Frame, UEstadisticas, UCoincidencia, UBusqueda, UConvertirEnBinario,
  UDialogoBuscar;


{$R *.DFM}

//-------------------------------------------------------------------
procedure TChildForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
end;

//-------------------------------------------------------------------
// Inicia el formulario hijo.
//-------------------------------------------------------------------
procedure TChildForm.FormCreate(Sender: TObject);
begin
PageControl1.DoubleBuffered := True;
Panel1.DoubleBuffered := True;
GroupBox1.DoubleBuffered := True;

//Inicia el objeto "HistoryDataManager".
HistoryDataManager1 := THistoryDataManager.Create;
HistoryDataManager1.OnDataChange := DataChange;
HistoryDataManager1.OnSimbolChange := SimbolChange;

//Inicia el componente de raster simple
RasterSimple := TSimpleRaster.Create(Self);
RasterSimple.Iniciar(Panel1);
RasterSimple.OnAnyChange := AnyChange;
SpinEdit1.Value := 10;
SpinEdit2.Value := 50;

//Inicia el componente de raster editable simple
RasterEditableSimple := TEditableRaster.Create(Self);
RasterEditableSimple.Iniciar(TabSheet2);
RasterEditableSimple.OnRasterMouseMove := RasterMouseMove;

//Inicia el componente de raster editable de texto
RasterEditableDeTexto := TEditableText.Create(Self);
RasterEditableDeTexto.Iniciar(TabSheet3);
RasterEditableDeTexto.OnRasterMouseMove := RasterMouseMove;
end;

//-------------------------------------------------------------------
// Actualiza los raster cada vez que se hace un cambio.
//-------------------------------------------------------------------
procedure TChildForm.DataChange(Sender: TObject);
begin
if Assigned(RasterEditableSimple) then RasterEditableSimple.ActualizarRaster;
if Assigned(RasterEditableDeTexto) then RasterEditableDeTexto.ActualizarRaster;
if Assigned(RasterSimple) then RasterSimple.ActualizarRaster;
end;

procedure TChildForm.SimbolChange(Sender: TObject);
begin
if Assigned(RasterEditableSimple) then RasterEditableSimple.ActualizarColores;
if Assigned(RasterEditableDeTexto) then RasterEditableDeTexto.ActualizarColores;
if Assigned(RasterSimple) then RasterSimple.ActualizarColores;
end;

procedure TChildForm.AnyChange(Sender: TObject);
begin
Edit1.Text := IntToStr(RasterSimple.DesplazamientoHorizontal);
end;

//-------------------------------------------------------------------
// Muestra en la barra de estado los datos de las
// coordenadas del puntero del Mouse.
//-------------------------------------------------------------------
procedure TChildForm.RasterMouseMove(Sender: TObject; Shift: TShiftState; X, Y, PosicionValor: Integer; Valor: Byte);
begin
StatusBar1.Panels[0].Text := ' X: ' + IntToStr(X) + '  Y: ' + IntToStr(Y);
StatusBar1.Panels[1].Text := ' Posición: ' + IntToStr(PosicionValor);
StatusBar1.Panels[2].Text := ' Valor: ' + Chr(Valor);
end;

//-------------------------------------------------------------------
// Al cerrar el formulario, pregunta si se desean salvar las modificaciones.
//-------------------------------------------------------------------
procedure TChildForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
CanClose := not HistoryDataManager1.Modificado or (MessageDlg('¿Cerrar sin salvar los cambios?', mtCustom, [mbYes, mbNo], 0) = mrYes);
end;

//-------------------------------------------------------------------
// Carga una demodulación desde un fichero y la muestra en los
// editores de raster simple y de texto. 
//-------------------------------------------------------------------
procedure TChildForm.Cargar(FileName: string);
begin
Refresh;                                                                //Para que se dibuje completo el formulario.
if Assigned(HistoryDataManager1) then
   begin
   HistoryDataManager1.CargarDemodulacion(FileName);                    //Carga la demodulación.
   RasterEditableSimple.Mostrar(HistoryDataManager1, 10, 0, True);      //Muestra la demodulación en los editores.
   RasterEditableDeTexto.Mostrar(HistoryDataManager1, 10, 0, True);
   RasterSimple.Mostrar(HistoryDataManager1, 10, 0, True);
   end;
Caption := MainForm.ExtraerNombreDeFichero(FileName);                   //Nombra a la ventana con el nombre del fichero.
end;


//-------------------------------------------------------------------
// Incia la búsqueda de períodos.
//-------------------------------------------------------------------
procedure TChildForm.BuscarPeriodos;
begin
Button3.Enabled := False;
StatusBar1.Panels[0].Text := 'Calculando';
ProcesoBuscadorDePeriodos1 := TBuscadorDePeriodos.Create;
ProcesoBuscadorDePeriodos1.FreeOnTerminate := False;
ProcesoBuscadorDePeriodos1.FuenteDeDatos := HistoryDataManager1;
ProcesoBuscadorDePeriodos1.Parametros(8, 1024, 0, 8, 0, True);
ProcesoBuscadorDePeriodos1.OnTerminate := BusquedaDePeriodosTerminada;
ProcesoBuscadorDePeriodos1.Resume;
end;


//-------------------------------------------------------------------
// Se ejecuta al terminar la búsqueda de períodos.
//-------------------------------------------------------------------
procedure TChildForm.BusquedaDePeriodosTerminada(Sender: TObject);
begin
ListBox1.Items := ProcesoBuscadorDePeriodos1.PeriodosEncontrados;
ListBox1.ItemIndex := 0;
if ListBox1.Items.Count > 0 then
   begin
   if (ListBox1.Items[ListBox1.ItemIndex] <> '')and         
      (ListBox1.Items.Count > 0) then
      begin
      ListBox1.Enabled := True;
      RasterSimple.ReiniciarParametrosDelRaster;
      SpinEdit1.Value := StrToInt(ListBox1.Items[ListBox1.ItemIndex]);
      SincronizarEditores;
      MessageBeep(MB_OK);
      end;
   BuscadorDePeriodos1.Free;
   StatusBar1.Panels[0].Text := '';
   Button3.Enabled := True;
   end;
end;


//-------------------------------------------------------------------
// Eventos de control de las acciones.
//-------------------------------------------------------------------

procedure TChildForm.ActionCerrarExecute(Sender: TObject);
begin
Close;
end;

procedure TChildForm.ActionSalvarCambiosExecute(Sender: TObject);
begin
if HistoryDataManager1.Modificado then
   HistoryDataManager1.GuardarCambios;
end;

procedure TChildForm.ActionSalvarComoExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.GuardarDemodulacionComo;
     2: RasterEditableDeTexto.GuardarDemodulacionComo;
     end;
end;

procedure TChildForm.ActionGuardarImagenExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     0: RasterSimple.SeleccionarRutaParaGuardarImagen;
     1: RasterEditableSimple.GuardarImagen;
     2: RasterEditableDeTexto.GuardarImagen;
     end;
end;


procedure TChildForm.ActionLeyendaExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.MostrarLeyenda;
     2: RasterEditableDeTexto.MostrarLeyenda;
     end;
end;

procedure TChildForm.ActionAyudaExecute(Sender: TObject);
begin
MainForm.ActionUtilizacionExecute(Sender);
end;

procedure TChildForm.ActionDeshacerExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.Deshacer;
     2: RasterEditableDeTexto.Deshacer;
     end;
end;

procedure TChildForm.ActionRehacerExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.Rehacer;
     2: RasterEditableDeTexto.Rehacer;
     end;
end;

procedure TChildForm.ActionDesseleccionarExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.Desseleccionar;
     2: RasterEditableDeTexto.Desseleccionar;
     end;
end;

procedure TChildForm.ActionBorrarExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.BorrarSeleccion;
     2: RasterEditableDeTexto.BorrarSeleccion;
     end;
end;

procedure TChildForm.ActionCopiarExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.CopiarSeleccion;
     2: RasterEditableDeTexto.CopiarSeleccion;
     end;
end;

procedure TChildForm.ActionCortarExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.CortarSeleccion;
     2: RasterEditableDeTexto.CortarSeleccion;
     end;
end;

procedure TChildForm.ActionPegarExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.PegarSeleccionCopiada;
     2: RasterEditableDeTexto.PegarSeleccionCopiada;
     end;
end;

procedure TChildForm.ActionFiltrarExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.FiltrarDatos;
     2: RasterEditableDeTexto.FiltrarDatos;
     end;
end;

procedure TChildForm.ActionLlenarExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.PedirCaracterParaLlenarSeleccion;
     2: RasterEditableDeTexto.PedirCaracterParaLlenarSeleccion;
     end;
end;

procedure TChildForm.ActionInsertarExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.PedirCaracteresParaInsertar;
     2: RasterEditableDeTexto.PedirCaracteresParaInsertar;
     end;
end;

procedure TChildForm.ActionCantidadSimbolosExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.PedirCantidadDeSimbolos;
     2: RasterEditableDeTexto.PedirCantidadDeSimbolos;
     end;
end;

procedure TChildForm.ActionRecalcularCantidadSimbolosExecute(
  Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.CalcularLaCantidadDeSimbolosActualDelRaster;
     2: RasterEditableDeTexto.CalcularLaCantidadDeSimbolosActualDelRaster;
     end;
end;

procedure TChildForm.ActionDesplazamientoExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.PedirDesplazamiento;
     2: RasterEditableDeTexto.PedirDesplazamiento;
     end;
end;

procedure TChildForm.ActionPeriodoExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.PedirPeriodo;
     2: RasterEditableDeTexto.PedirPeriodo;
     end;
end;

procedure TChildForm.ActionVerTextoExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.MostrarTextoDeSeleccion;
     2: RasterEditableDeTexto.MostrarTextoDeSeleccion;
     end;
end;

procedure TChildForm.ActionBuscarExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: begin
        end;
     2: begin
        with TFormBuscaCoincidencia.Create(Self) do
             begin
             Fuente := RasterEditableDeTexto;
             FormStyle := fsStayOnTop;
             Show;
             end;
        end;
     end;
end;

procedure TChildForm.ActionBuscarSiguienteExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: begin end; 
     2: RasterEditableDeTexto.BuscarSiguienteCoincidencia;
     end;
end;

procedure TChildForm.ActionDesplazarIzquierdaExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.DesplazarIzquierda;
     2: RasterEditableDeTexto.DesplazarIzquierda;
     end;
end;

procedure TChildForm.ActionDesplazarDerechaExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.DesplazarDerecha;
     2: RasterEditableDeTexto.DesplazarDerecha;
     end;
end;

procedure TChildForm.ActionDisminuirPeriodoExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.DisminuirPeriodo;
     2: RasterEditableDeTexto.DisminuirPeriodo;
     end;
end;

procedure TChildForm.ActionAumentarPeriodoExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.AumentarPeriodo;
     2: RasterEditableDeTexto.AumentarPeriodo;
     end;
end;

procedure TChildForm.ActionMoverIzquierdaExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.MoverIzquierda(1);
     2: RasterEditableDeTexto.MoverIzquierda(1);
     end;
end;

procedure TChildForm.ActionMoverDerechaExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.MoverDerecha(1);
     2: RasterEditableDeTexto.MoverDerecha(1);
     end;
end;

procedure TChildForm.ActionMoverArribaExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.MoverArriba(1);
     2: RasterEditableDeTexto.MoverArriba(1);
     end;
end;

procedure TChildForm.ActionMoverAbajoExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.MoverAbajo(1);
     2: RasterEditableDeTexto.MoverAbajo(1);
     end;
end;

procedure TChildForm.ActionMoverInicioExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.MoverInicio;
     2: RasterEditableDeTexto.MoverInicio;
     end;
end;

procedure TChildForm.ActionMoverFinalExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.MoverFinal;
     2: RasterEditableDeTexto.MoverFinal;
     end;
end;

procedure TChildForm.ActionPaginaArribaExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.PageUp;
     2: RasterEditableDeTexto.PageUp;
     end;
end;

procedure TChildForm.ActionPaginaAbajoExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.PageDown;
     2: RasterEditableDeTexto.PageDown;
     end;
end;

procedure TChildForm.ActionPaginaIzquierdaExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.PageLeft;
     2: RasterEditableDeTexto.PageLeft;
     end;
end;

procedure TChildForm.ActionPaginaDerechaExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.PageRight;
     2: RasterEditableDeTexto.PageRight;
     end;
end;

procedure TChildForm.ActionAumentarExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.AumentarAnchoDePixel;
     2: RasterEditableDeTexto.AumentarAnchoDePixel;
     end;
end;

procedure TChildForm.ActionDisminuirExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: RasterEditableSimple.DisminuirAnchoDePixel;
     2: RasterEditableDeTexto.DisminuirAnchoDePixel;
     end;
end;

procedure TChildForm.ActionCambiarColoresExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     0: RasterSimple.CambiarColores;
     1: RasterEditableSimple.CambiarColores;
     2: RasterEditableDeTexto.CambiarColores;
     end;
end;

procedure TChildForm.ActionConvertirEnBinarioExecute(Sender: TObject);
begin
case PageControl1.ActivePage.TabIndex of
     1: with TFormConvertirEnBinario.Create(Self) do Mostrar(RasterEditableSimple.FuenteDeDatos);
     2: with TFormConvertirEnBinario.Create(Self) do Mostrar(RasterEditableDeTexto.FuenteDeDatos);
     end;
end;

procedure TChildForm.ActionEstadisticaExecute(Sender: TObject);
begin
with TFormEstadisticas.Create(Self) do Mostrar(HistoryDataManager1);
end;

procedure TChildForm.ListBox1Click(Sender: TObject);
begin
if ListBox1.ItemIndex >= 0 then
   if StrToInt(ListBox1.Items[ListBox1.ItemIndex]) <> SpinEdit1.Value then
      SpinEdit1.Value := StrToInt(ListBox1.Items[ListBox1.ItemIndex]);
end;

procedure TChildForm.SincronizarEditores;
begin
RasterEditableSimple.NuevoPeriodo(RasterSimple.Periodo);
RasterEditableSimple.NuevoDesplazamiento(RasterSimple.DesplazamientoHorizontal);
RasterEditableDeTexto.NuevoPeriodo(RasterSimple.Periodo);
RasterEditableDeTexto.NuevoDesplazamiento(RasterSimple.DesplazamientoHorizontal);
end;

//-------------------------------------------------------------------
// Diálogo que muestra las propiedades del raster.
//-------------------------------------------------------------------
procedure TChildForm.MostrarPropiedades;
const Separacion = 3;
var
  Form: TForm;
  Memo: TMemo;
  Button1: TButton;
  lst: TStringList;
  str: String;
  n: Integer;
begin
lst := TStringList.Create;
str := '';
if not HistoryDataManager1.Valido then Exit;
lst.Add('Fichero:  ' + HistoryDataManager1.DemodulationFileName);
str := 'Tamaño:  ' + IntToStr(HistoryDataManager1.Longitud) + ' Bytes';
if Round(HistoryDataManager1.Longitud / (1024 * 1024)) > 0 then
   str := str + ' (' + IntToStr(Round(HistoryDataManager1.Longitud / (1024 * 1024))) + ' MegaBytes)'
else
   if Round(HistoryDataManager1.Longitud / 1024) > 0 then
      str := str + ' (' + IntToStr(Round(HistoryDataManager1.Longitud / 1024)) + ' KiloBytes)';
lst.Add(str);
lst.Add('Cantidad de símbolos:  ' + IntToStr(HistoryDataManager1.OptenerCantidadDeSimbolos));

if ListBox1.Items.Count > 0 then
   begin
   str := 'Períodos posibles:  ';
   for n := 0 to ListBox1.Items.Count - 1 do
       begin
       str := str + ListBox1.Items[n];
       if n < ListBox1.Items.Count - 1 then str := str + '; ';
       end;
   lst.Add(str);
   end;

Form := TForm.Create(Application);
with Form do
  try
    Canvas.Font := Font;
    BorderStyle := bsSizeToolWin;
    Caption := 'Información:';
    Position := poScreenCenter;
    Memo := TMemo.Create(Form);
    Height := 170;
    Width := 350;
    with Memo do
         begin
         DoubleBuffered := True;
         Parent := Form;
         Left := Separacion;
         Top := Separacion;
         Height := Form.ClientHeight - (Separacion * 2) - 20;
         Width := Form.ClientWidth - (Separacion * 2);
         MaxLength := 0;
         Lines.Clear;
         WordWrap := False;
         ScrollBars := ssBoth;
         SelectAll;
         Font.Name := 'Arial';
         Font.Size := 10;
         Lines := lst;
         Anchors := [akTop, akLeft, akRight, akBottom];
         end;
    Button1 := TButton.Create(Form);
    with Button1 do
         begin
         Anchors := [akRight, akBottom];
         Parent := Form;
         Caption := 'Cerrar';
         ModalResult := mrOk;
         Default := True;
         SetBounds(Memo.Left + Memo.Width - 60, Memo.Top + Memo.Height + Separacion, 60, 20);
         ShowHint := True;
         Hint := 'Clic aquí para cerrar el diálogo.';
         end;
    ClientWidth := Memo.Width + (Separacion * 2);
    ClientHeight := Button1.Top + Button1.Height + Separacion;
    ShowModal;
  finally
    Form.Free;
  end;
end;


procedure TChildForm.ActionInformacionExecute(Sender: TObject);
begin
MostrarPropiedades;
end;


procedure TChildForm.SpinEdit1Change(Sender: TObject);
begin
try
   RasterSimple.Periodo := SpinEdit1.Value;
   ListBox1.ItemIndex := -1;
except
   Application.MessageBox('Solo se admiten números enteros.', 'Entrada incorrecta', MB_ICONERROR)
end;
end;

procedure TChildForm.SpinEdit2Change(Sender: TObject);
begin
try
   RasterSimple.Lineas := SpinEdit2.Value;
except
   Application.MessageBox('Solo se admiten números enteros.', 'Entrada incorrecta', MB_ICONERROR)
end;
end;

procedure TChildForm.Button1Click(Sender: TObject);
begin
SincronizarEditores;
PageControl1.ActivePageIndex := 1;
end;

procedure TChildForm.PageControl1Change(Sender: TObject);
begin
case PageControl1.ActivePageIndex of
     0: begin
        StatusBar1.Panels[0].Text := '';
        StatusBar1.Panels[1].Text := '';
        StatusBar1.Panels[2].Text := '';
        end;
     1: ;
     2: ;
     end;
end;

procedure TChildForm.Button3Click(Sender: TObject);
begin
BuscarPeriodos;
end;

procedure TChildForm.Eliminarseleccin1Click(Sender: TObject);
begin
if ListBox1.ItemIndex >= 0 then ListBox1.Items.Delete(ListBox1.ItemIndex);
end;

procedure TChildForm.Eliminartodos1Click(Sender: TObject);
begin
ListBox1.Clear;
end;

procedure TChildForm.Exportarlista1Click(Sender: TObject);
var dlg: TSaveDialog;
begin
dlg := TSaveDialog.Create(Self);                                               //Crea un diálogo.
dlg.InitialDir := MainForm.RutaParaBuscarDemodulaciones;
dlg.Title := 'Cargar demodulación...';                                         //Título del diálogo.
dlg.DefaultExt := 'txt';
dlg.FileName := Copy(Caption, 1, Pos('.', Caption) - 1) + '_Periodos';
dlg.Filter := 'Ficheros de texto (*.txt)|*.TXT|Todos los ficheros (*.*)|*.*';  //Ficheros que se muestran.
if dlg.Execute then                                                            //Permite seleccionar un raster.
   ListBox1.Items.SaveToFile(dlg.FileName);
dlg.Free;                                                                      //Libera el diálogo creado.
end;

procedure TChildForm.Recalcular1Click(Sender: TObject);
begin
BuscarPeriodos;
end;

procedure TChildForm.Agregarperodoalalista1Click(Sender: TObject);
begin
ListBox1.Items.Add(IntToStr(RasterSimple.Periodo));
end;

end.

