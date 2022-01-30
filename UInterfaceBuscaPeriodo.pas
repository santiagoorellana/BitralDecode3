unit UInterfaceBuscaPeriodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, ExtCtrls, ComCtrls,
  Buttons, Grids, ValEdit, Menus, UBuscaPeriodos, Spin, SimpleRaster, HistoryDataManager;

type
  TFormBuscaPeriodos = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Timer1: TTimer;
    Button6: TButton;
    PaintBox2: TPaintBox;
    Timer2: TTimer;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    GroupBox3: TGroupBox;
    ComboBox1: TComboBox;
    GroupBox4: TGroupBox;
    ComboBox2: TComboBox;
    GroupBox5: TGroupBox;
    SpinEdit3: TSpinEdit;
    GroupBox6: TGroupBox;
    Edit1: TEdit;
    Button2: TButton;
    GroupBox7: TGroupBox;
    CheckBox1: TCheckBox;
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    GroupBox8: TGroupBox;
    PopupMenu1: TPopupMenu;
    Guardarimagen1: TMenuItem;
    PopupMenu2: TPopupMenu;
    Guardarlista1: TMenuItem;
    Monocromtico1: TMenuItem;
    Procesarfichero1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    function BuscarYCargarFichero: string;
    procedure Button1Click(Sender: TObject);
    procedure ActualizarTiempoTranscurrido(Sender: TObject);
    procedure StatusBar1Resize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button6Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer2Timer(Sender: TObject);
    procedure PaintBox2Paint(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Guardarimagen1Click(Sender: TObject);
    procedure Guardarlista1Click(Sender: TObject);
    procedure Monocromtico1Click(Sender: TObject);
    procedure Procesarfichero1Click(Sender: TObject);
  protected
  private
    Progreso: Integer;
    Buscador: TBuscadorDePeriodos;
    procedure MostrarComponentesDeResultado;
    procedure OcultarComponentesDeResultado;
    procedure ReadIni;
    procedure WriteIni;
  public
    FuenteDeDatos: THistoryDataManager;
    Raster: TSimpleRaster;
    TiempoInicial: TDateTime;
    procedure ThreadDone(Sender: TObject);
    procedure DibujarProgreso;
  end;



var
  FormBuscaPeriodos: TFormBuscaPeriodos;


implementation

uses UCoincidencia, Frame, UGuardaEnRegistro;


{$R *.dfm}

//------------------------------------------------------------------------------
// Inicia el subproceso.
//------------------------------------------------------------------------------
procedure TFormBuscaPeriodos.FormCreate(Sender: TObject);
begin
ReadIni;
Progreso := 0;
Timer2.Enabled := False;
PaintBox2.Visible := False;
DoubleBuffered := True;
Panel1.DoubleBuffered := True;
Panel2.DoubleBuffered := True;
GroupBox1.DoubleBuffered := True;
GroupBox2.DoubleBuffered := True;
GroupBox3.DoubleBuffered := True;
GroupBox4.DoubleBuffered := True;
GroupBox5.DoubleBuffered := True;
GroupBox6.DoubleBuffered := True;
GroupBox7.DoubleBuffered := True;
GroupBox8.DoubleBuffered := True;
Edit1.DoubleBuffered := True;
StatusBar1.Panels[1].Width := 200;
StatusBar1.Panels[0].Width := StatusBar1.Width - StatusBar1.Panels[1].Width;
StatusBar1.Panels[0].Text := '';
StatusBar1.Panels[1].Text := '';
ComboBox1.ItemIndex := 0;
ComboBox2.ItemIndex := 0;
OcultarComponentesDeResultado;
//
FuenteDeDatos := THistoryDataManager.Create;
Raster := TSimpleRaster.Create(Self);
Raster.FuenteDeDatos := FuenteDeDatos;
Raster.Parent := GroupBox8;
Raster.Align := alClient;
Raster.PopupMenu := PopupMenu1;
Raster.Cursor := crHandPoint;
Raster.DoubleBuffered := True;
raster.Show;
end;

//-------------------------------------------------------------------
// Manejador del evento que informa el estado del subproceso.
//-------------------------------------------------------------------
procedure TFormBuscaPeriodos.ThreadDone(Sender: TObject);
begin
Timer2.Enabled := False;                                                //Oculta la barra de progreso.
PaintBox2.Visible := False;
Timer1.Enabled := False;
ActualizarTiempoTranscurrido(Self);                                     //Indica el tiempo transcurrido.
StatusBar1.Panels[0].Text := ' Búsqueda terminada.';                    //Indica el estado de la operación.
WindowState := wsNormal;                                                //Muestra la ventana si está minimizada.
MostrarComponentesDeResultado;                                          //Despliega el resultado.
ListBox1.Items := Buscador.PeriodosEncontrados;                         //Llena la lista de períodos encontrados.
ListBox1.ItemIndex := 0;                                                //Selecciona el primer elemento de la lista.
Raster.ScaleColor := RainbowColor;
if ListBox1.ItemIndex >= 0 then
   Raster.Periodo := StrToInt(ListBox1.Items[ListBox1.ItemIndex]);      //Representa al primer período.
MessageBeep(MB_OK);                                                     //Lanza un menzaje sonoro.
end;


//-------------------------------------------------------------------
// Abre un diálogo que permite buscar y seleccionar un fichero.
//-------------------------------------------------------------------
function TFormBuscaPeriodos.BuscarYCargarFichero: string;
var dlg: TOpenDialog;
begin
result := '';
dlg := TOpenDialog.Create(nil);                                                //Crea un diálogo.
dlg.InitialDir := MainForm.RutaParaBuscarDemodulaciones;
dlg.Title := 'Cargar demodulación...';                                         //Título del diálogo.
dlg.Filter := 'Ficheros de texto (*.txt)|*.TXT|Todos los ficheros (*.*)|*.*';  //Tipos de ficheros que se muestran.
if dlg.Execute then
   if FileExists(dlg.FileName) then
      begin
      MainForm.RutaParaBuscarDemodulaciones := dlg.FileName;
      result := dlg.FileName;                    //Si el fichero existe, se carga.
      end;
dlg.Free;                                                                      //Destruye el diálogo creado.
end;


//-------------------------------------------------------------------
procedure TFormBuscaPeriodos.Button2Click(Sender: TObject);
var Seleccion: String;
begin
Seleccion := BuscarYCargarFichero;
if Seleccion <> '' then
   begin
   Monocromtico1.Checked := False;
   Edit1.Text := Seleccion;
   OcultarComponentesDeResultado;
   end;
end;

//-------------------------------------------------------------------
procedure TFormBuscaPeriodos.Button3Click(Sender: TObject);
var Seleccion: String;
begin
Seleccion := BuscarYCargarFichero;
if Seleccion <> '' then
   begin
   OcultarComponentesDeResultado;
   end;
end;


//-------------------------------------------------------------------
procedure TFormBuscaPeriodos.Button1Click(Sender: TObject);
var msg: String;
begin
if FileExists(Edit1.Text) then                               //Si se han seleccionado ficheros:
   begin
   if ComboBox2.ItemIndex = 2 then
      begin
      msg :=       'Mientras se ejecute el proceso de búsqueda de períodos a' + #13;
      msg := msg + 'máxima velocidad, no se podrá utilizar la computadora.' + #13#13;
      msg := msg + 'La interfaz gráfica quedará completamente paralizada' + #13;
      msg := msg + 'mientras se ejecute la búsqueda.' + #13#13;
      msg := msg + '¿Desea proceder con la búsqueda?';
      if Application.MessageBox(PChar(msg), 'ATENCIÓN', MB_YESNO) = ID_NO then Exit;
      end;
   Raster.CargarDemodulacion(Edit1.Text);
   Raster.FuenteDeDatos.ContarSimbolos;
   Button1.Visible := False;
   PaintBox2.Visible := True;
   Timer2.Enabled := True;
   TiempoInicial := Time;                                    //Marca el tiempo de inicio de la búsqueda.
   StatusBar1.Panels[0].Text := ' Buscando períodos...';     //Indica el estado de la búsqueda.
   ActualizarTiempoTranscurrido(Self);                       //Indica el tiempo transcurrido.
   Timer1.Enabled := True;                                   //Activa el temporizador para que haga las actualizaciones.
   if Assigned(Buscador) then Buscador.Free;                 //Si ya existe un buscador, lo libera.
   Buscador := TBuscadorDePeriodos.Create;                   //Crea el subproceso de búsqueda.
   Buscador.FuenteDeDatos := FuenteDeDatos;
   Buscador.OnTerminate := ThreadDone;                       //Le asigna un manejador de eventos para la finalización.
   Buscador.Priority := tpNormal;
   Buscador.Parametros(SpinEdit1.Value,                      //Pasa los parámetros de funcionamiento.
                       SpinEdit2.Value,
                       ComboBox1.ItemIndex,
                       SpinEdit3.Value,
                       ComboBox2.ItemIndex,
                       CheckBox1.Checked);
   Buscador.Resume;                                          //Inicia el funcionamientos del subproceso.
   end
else
   begin
   Application.MessageBox('Debe seleccionar un fichero.','PARÁMETROS INCORRECTOS', MB_OK);
   end;
end;


//-------------------------------------------------------------------
// Actualiza el tiempo transcurrido.
//-------------------------------------------------------------------
procedure TFormBuscaPeriodos.ActualizarTiempoTranscurrido;
begin
StatusBar1.Panels[1].Text := ' Tiempo transcurrido: ' + TimeToStr(Time - TiempoInicial);
end;

//-------------------------------------------------------------------
// Actualiza el tamaño de los paneles de la barra de estado.
//-------------------------------------------------------------------
procedure TFormBuscaPeriodos.StatusBar1Resize(Sender: TObject);
begin
StatusBar1.Panels[1].Width := 200;
StatusBar1.Panels[0].Width := StatusBar1.Width - StatusBar1.Panels[1].Width;
end;


//------------------------------------------------------------------------------
// Muestra los componentes donde se presentan los resultados.
//------------------------------------------------------------------------------
procedure TFormBuscaPeriodos.MostrarComponentesDeResultado;
begin
Constraints.MaxHeight := 0;                                            //Permite que se pueda ampliar la altura del formulario.
Panel1.Height := 200;                                                  //Establece la altura del panel de presentación de resultados.
ClientHeight := Panel2.Height + Panel1.Height + StatusBar1.Height;     //Establece el tamaño del area cliente.
Constraints.MinHeight := Height;                                       //Mantiene los límites inferiores de las dimensiones del formulario.
Constraints.MinWidth := Width;

Button1.Visible := False;          //Oculta el botón que inicia la comparación.
GroupBox2.Enabled := False;        //Oculta las cajas de agrupación.
GroupBox3.Enabled := False;
GroupBox4.Enabled := False;
GroupBox5.Enabled := False;
GroupBox7.Enabled := False;

Panel1.Visible := True;            //Muestra los paneles de análisis
end;

//------------------------------------------------------------------------------
// Oculta los componentes donde se presentan los resultados.
//------------------------------------------------------------------------------
procedure TFormBuscaPeriodos.OcultarComponentesDeResultado;
begin
StatusBar1.Panels[0].Text := '';
StatusBar1.Panels[1].Text := '';
Constraints.MinHeight := 0;
Constraints.MaxHeight := 0;
ClientHeight := Panel2.Height + StatusBar1.Height;
Constraints.MinHeight := Height;
Constraints.MaxHeight := Height;
Constraints.MinWidth := Width;

Button1.Visible := True;          //Oculta el botón que inicia la comparación.
GroupBox2.Enabled := True;
GroupBox3.Enabled := True;
GroupBox4.Enabled := True;
GroupBox5.Enabled := True;
GroupBox7.Enabled := True;

Panel1.Visible := False;          //Muestra los paneles de análisis
end;

//------------------------------------------------------------------------------
// Muestra la ayuda de la ventana.
//------------------------------------------------------------------------------
procedure TFormBuscaPeriodos.Button6Click(Sender: TObject);
var msg: String;
begin
msg := 'BUSCADOR DE PERÍODOS' + #13#13;
msg := msg + 'Esta herramienta analiza una demodulación previamente guardada' + #13;
msg := msg + 'en un fichero de texto con extensión TXT y devuelve los posibles.' + #13;
msg := msg + 'períodos de la demodulación en una lista.' + #13#13;
msg := msg + 'El análisis se puede realizar con diferentes algoritmos que' + #13;
msg := msg + 'han sido diseñados especialmente para detectar períodos. ';
MessageBox(0, PChar(msg), 'AYUDA', MB_OK);
end;


//------------------------------------------------------------------------------
// Cierra la ventana.
//------------------------------------------------------------------------------
procedure TFormBuscaPeriodos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if Assigned(Buscador) then Buscador.Terminate;
WriteIni;
end;


//------------------------------------------------------------------------------
procedure TFormBuscaPeriodos.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if Assigned(Buscador) then Buscador.Terminate;
end;



//------------------------------------------------------------------------------
// Dibuja una barra de progreso en el paint box.
//------------------------------------------------------------------------------
procedure TFormBuscaPeriodos.DibujarProgreso;
const Porciento = 70;
      Bordes = 1;
      Separacion = 2;
var Rectangulo: TRect;
begin
PaintBox2.Canvas.Brush.Color := clBlack;
PaintBox2.Canvas.FillRect(PaintBox2.ClientRect);

PaintBox2.Canvas.Brush.Color := Rgb(200, 200, 200);
Rectangulo.Left := PaintBox2.ClientRect.Left + Bordes;
Rectangulo.Right := PaintBox2.ClientRect.Right - Bordes;
Rectangulo.Top := PaintBox2.ClientRect.Top + Bordes;
Rectangulo.Bottom := PaintBox2.ClientRect.Bottom - Bordes;
PaintBox2.Canvas.FillRect(Rectangulo);

if Progreso - (PaintBox2.Width div 100 * Porciento) < 0 then
   Rectangulo.Left := 0
else
   Rectangulo.Left := Progreso - (PaintBox2.Width div 100 * Porciento);
Rectangulo.Right := Progreso;
Rectangulo.Left := Rectangulo.Left + Separacion;
Rectangulo.Right := Rectangulo.Right - Separacion;
Rectangulo.Top := Rectangulo.Top + Separacion;
Rectangulo.Bottom := Rectangulo.Bottom - Separacion;
PaintBox2.Canvas.Brush.Color := clBlack;
PaintBox2.Canvas.FillRect(Rectangulo);

Rectangulo.Left := Rectangulo.Left + Bordes;
Rectangulo.Right := Rectangulo.Right - Bordes;
Rectangulo.Top := Rectangulo.Top + Bordes;
Rectangulo.Bottom := Rectangulo.Bottom - Bordes;
PaintBox2.Canvas.Brush.Color := Rgb(0, 0, 150);
PaintBox2.Canvas.FillRect(Rectangulo);
end;

//------------------------------------------------------------------------------
// Mueve la barra de progreso.
//------------------------------------------------------------------------------
procedure TFormBuscaPeriodos.Timer2Timer(Sender: TObject);
begin
if Progreso < PaintBox2.Width + (PaintBox2.Width div 100 * 70) then
   Inc(Progreso, (PaintBox2.Width div 20))
else
   Progreso := 0;
PaintBox2.Refresh;
end;

//------------------------------------------------------------------------------
// Dibuja la barra de progreso.
//------------------------------------------------------------------------------
procedure TFormBuscaPeriodos.PaintBox2Paint(Sender: TObject);
begin
DibujarProgreso;
end;

//------------------------------------------------------------------------------
// Muestra el raster del período seleccionado.
//------------------------------------------------------------------------------
procedure TFormBuscaPeriodos.ListBox1Click(Sender: TObject);
begin
Raster.ReiniciarParametrosDelRaster;
Raster.Periodo := StrToInt(ListBox1.Items[ListBox1.ItemIndex]);
end;

//------------------------------------------------------------------------------
// Guarda la imagen del raster.
//------------------------------------------------------------------------------
procedure TFormBuscaPeriodos.Guardarimagen1Click(Sender: TObject);
begin
Raster.SeleccionarRutaParaGuardarImagen;
end;

//------------------------------------------------------------------------------
// Guarda la lista de los períodos encontrados.
//------------------------------------------------------------------------------
procedure TFormBuscaPeriodos.Guardarlista1Click(Sender: TObject);
var dlg: TSaveDialog;
begin
dlg := TSaveDialog.Create(nil);                                                //Crea un diálogo.
dlg.Title := 'Guardar lista...';                                               //Título del diálogo.
dlg.DefaultExt := 'txt';
dlg.Filter := 'Ficheros de texto (*.txt)|*.TXT|Todos los ficheros (*.*)|*.*';  //Tipos de ficheros que se muestran.
if dlg.Execute then
   ListBox1.Items.SaveToFile(dlg.FileName);
dlg.Free;                                                                      //Destruye el diálogo creado.
end;

//------------------------------------------------------------------------------
// Activa o desactiva los colores del raster.
//------------------------------------------------------------------------------
procedure TFormBuscaPeriodos.Monocromtico1Click(Sender: TObject);
begin
Monocromtico1.Checked := not Monocromtico1.Checked;
if Monocromtico1.Checked then
   begin
   Raster.ScaleInitialColor := clBlack;
   Raster.ScaleFinalColor := clWhite;
   Raster.ScaleColor := TwoColor;
   end
else
   begin
   Raster.ScaleColor := RainbowColor;
   end;
end;

//-----------------------------------------------------------------------------
// Lee del registro los valores de configuración.
//-----------------------------------------------------------------------------
procedure TFormBuscaPeriodos.ReadIni;
begin
with SrchIniFile do
     begin
     SpinEdit1.Text := ReadString('HerramientaBuscadorDePeriodos', 'Desde', '8');
     SpinEdit2.Text := ReadString('HerramientaBuscadorDePeriodos', 'Hasta', '1024');
     SpinEdit3.Text := ReadString('HerramientaBuscadorDePeriodos', 'Resolucion', '16');
     CheckBox1.Checked := ReadBool('HerramientaBuscadorDePeriodos', 'EliminarMultiplos', True);
     ComboBox1.ItemIndex := ReadInteger('HerramientaBuscadorDePeriodos', 'Algoritmo', 0);
     end;
end;

//-----------------------------------------------------------------------------
// Escribe en el registro los valores de configuración.
//-----------------------------------------------------------------------------
procedure TFormBuscaPeriodos.WriteIni;
begin
with SrchIniFile do
     begin
     WriteString('HerramientaBuscadorDePeriodos', 'Desde', SpinEdit1.Text);
     WriteString('HerramientaBuscadorDePeriodos', 'Hasta', SpinEdit2.Text);
     WriteString('HerramientaBuscadorDePeriodos', 'Resolucion', SpinEdit3.Text);
     WriteBool('HerramientaBuscadorDePeriodos', 'EliminarMultiplos', CheckBox1.Checked);
     WriteInteger('HerramientaBuscadorDePeriodos', 'Algoritmo', ComboBox1.ItemIndex);
     end;
end;


procedure TFormBuscaPeriodos.Procesarfichero1Click(Sender: TObject);
begin
MainForm.ProcesarFichero(Edit1.Text);
end;

end.





