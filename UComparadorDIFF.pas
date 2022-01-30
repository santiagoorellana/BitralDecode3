unit UComparadorDIFF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, ExtCtrls, ComCtrls, UComparadorDeFicheros,
  Buttons, Grids, ValEdit;

type TDatos = array of Byte;

type
  TFormComparadorDIFF = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Panel2: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button1: TButton;
    PaintBox2: TPaintBox;
    Panel3: TPanel;
    Button4: TButton;
    Button5: TButton;
    Button7: TButton;
    Button8: TButton;
    Edit3: TEdit;
    Panel4: TPanel;
    EditValor1: TEdit;
    Label1: TLabel;
    EditPorciento1: TEdit;
    Label4: TLabel;
    EditValor2: TEdit;
    EditPorciento2: TEdit;
    Label5: TLabel;
    EditValor3: TEdit;
    EditPorciento3: TEdit;
    EditPorciento4: TEdit;
    EditValor4: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    EditValor5: TEdit;
    EditPorciento5: TEdit;
    EditPorciento6: TEdit;
    EditValor6: TEdit;
    Label8: TLabel;
    Timer1: TTimer;
    Button6: TButton;
    Timer2: TTimer;
    PaintBox3: TPaintBox;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    function BuscarYCargarFichero: string;
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ActualizarTiempoTranscurrido(Sender: TObject);
    procedure StatusBar1Resize(Sender: TObject);
    procedure PaintBox2Paint(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure PaintBox2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button6Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer2Timer(Sender: TObject);
    procedure PaintBox3Paint(Sender: TObject);
  protected
  private
    Progreso: Integer;
    Comparador: TComparadorDeFicheros;
    procedure MostrarComponentesDeResultado;
    procedure OcultarComponentesDeResultado;
  public
    TiempoInicial: TDateTime;
    procedure ThreadDone(Sender: TObject);
    procedure DibujarProgreso;
  end;



var
  FormComparadorDIFF: TFormComparadorDIFF;


implementation

uses Frame;

{$R *.dfm}

//------------------------------------------------------------------------------
// Inicia el subproceso.
//------------------------------------------------------------------------------
procedure TFormComparadorDIFF.FormCreate(Sender: TObject);
begin
Progreso := 0;
Timer2.Enabled := False;
PaintBox3.Visible := False;
DoubleBuffered := True;
Panel1.DoubleBuffered := True;
Panel2.DoubleBuffered := True;
Panel4.DoubleBuffered := True;
Edit1.DoubleBuffered := True;
Edit2.DoubleBuffered := True;
StatusBar1.Panels[1].Width := 200;
StatusBar1.Panels[0].Width := StatusBar1.Width - StatusBar1.Panels[1].Width;
StatusBar1.Panels[0].Text := '';
StatusBar1.Panels[1].Text := '';
Edit3.Text := '0';
Label4.Color := C_IGUALDAD_CARACTERES;
Label5.Color := C_BORRADO_CARACTERES;
Label6.Color := C_INSERCION_CARACTERES;
Label7.Color := C_CAMBIO_CARACTERES;
OcultarComponentesDeResultado;
end;

//-------------------------------------------------------------------
// Manejador del evento que informa el estado del subproceso.
//-------------------------------------------------------------------
procedure TFormComparadorDIFF.ThreadDone(Sender: TObject);
begin
Timer1.Enabled := False;
Timer2.Enabled := False;
PaintBox3.Visible := False;
ActualizarTiempoTranscurrido(Self);                       //Indica el tiempo transcurrido.
StatusBar1.Panels[0].Text := ' Comparación terminada';    //Indica el estado de la operación.
if Assigned(Comparador) and
   (Comparador.ComparacionesRealizadas > 0)then
   With Comparador do
        begin
        EditValor1.Text := inttostr(ComparacionesRealizadas);
        EditValor2.Text := inttostr(IgualdadesEncontradas);
        EditValor3.Text := inttostr(CaracteresBorrados);
        EditValor4.Text := inttostr(CaracteresInsertados);
        EditValor5.Text := inttostr(CaracteresCambiados);
        EditValor6.Text := inttostr(DiferenciasEncontradas);

        EditPorciento1.Text := '100 %';
        EditPorciento2.Text := FloatToStrF((IgualdadesEncontradas / ComparacionesRealizadas) * 100, ffGeneral, 3, 6) +' %';
        EditPorciento3.Text := FloatToStrF((CaracteresBorrados / ComparacionesRealizadas) * 100, ffGeneral, 3, 6) +' %';
        EditPorciento4.Text := FloatToStrF((CaracteresInsertados / ComparacionesRealizadas) * 100, ffGeneral, 3, 6) +' %';
        EditPorciento5.Text := FloatToStrF((CaracteresCambiados / ComparacionesRealizadas) * 100, ffGeneral, 3, 6) +' %';
        EditPorciento6.Text := FloatToStrF((DiferenciasEncontradas / ComparacionesRealizadas) * 100, ffGeneral, 3, 6) +' %';
        end;
Edit3.Text := IntToStr(Comparador.Posicion);
WindowState := wsNormal;                                                //Muestra la ventana si está minimizada.
MostrarComponentesDeResultado;                                          //Despliega el resultado.
MessageBeep(MB_OK);                                                     //Lanza un menzaje sonoro.
end;


//------------------------------------------------------------------------------
// Dibuja el resultado de la comparación.
//------------------------------------------------------------------------------
procedure TFormComparadorDIFF.PaintBox1Paint(Sender: TObject);
begin
if Assigned(Comparador) then
   Comparador.DibujarGraficoDeComparacionEn(PaintBox1)
else
   begin
   PaintBox1.Canvas.Brush.Color := clWhite;
   PaintBox1.Canvas.Pen.Color := clBlack;
   PaintBox1.Canvas.Pen.Width := 1;
   PaintBox1.Canvas.Rectangle(PaintBox1.ClientRect);
   end;
end;

//------------------------------------------------------------------------------
// Dibuja el resultado de la comparación.
//------------------------------------------------------------------------------
procedure TFormComparadorDIFF.PaintBox2Paint(Sender: TObject);
begin
Comparador.DibujarGraficoDeReferenciaEn(PaintBox2);
end;

//-------------------------------------------------------------------
// Abre un diálogo que permite buscar y seleccionar un fichero.
//-------------------------------------------------------------------
function TFormComparadorDIFF.BuscarYCargarFichero: string;
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
procedure TFormComparadorDIFF.Button2Click(Sender: TObject);
var Seleccion: String;
begin
Seleccion := BuscarYCargarFichero;
if Seleccion <> '' then
   begin
   Edit1.Text := Seleccion;
   OcultarComponentesDeResultado;
   end;
end;

//-------------------------------------------------------------------
procedure TFormComparadorDIFF.Button3Click(Sender: TObject);
var Seleccion: String;
begin
Seleccion := BuscarYCargarFichero;
if Seleccion <> '' then
   begin
   Edit2.Text := Seleccion;
   OcultarComponentesDeResultado;
   end;
end;

//-------------------------------------------------------------------
procedure TFormComparadorDIFF.Button4Click(Sender: TObject);
begin
if Assigned(Comparador) then
//   Comparador.ComparacionTerminada then
   begin
   Edit3.Text := IntToStr(Comparador.DesplazarIzquierda);
   PaintBox1.Repaint;
   PaintBox2.Repaint;
   end;
end;

//-------------------------------------------------------------------
procedure TFormComparadorDIFF.Button5Click(Sender: TObject);
begin
if Assigned(Comparador)then
//   Comparador.ComparacionTerminada then
   begin
   Edit3.Text := IntToStr(Comparador.DesplazarDerecha);
   PaintBox1.Repaint;
   PaintBox2.Repaint;
   end;
end;


//-------------------------------------------------------------------
procedure TFormComparadorDIFF.Button1Click(Sender: TObject);
begin
if (FileExists(Edit1.Text))and(FileExists(Edit1.Text)) then  //Si se han seleccionado ficheros:
   begin
   Button1.Visible := False;
   TiempoInicial := Time;                                    //Marca el tiempo de inicio de la comparación.
   PaintBox2.Visible := False;                               //Borra la gráfica de referencia.
   StatusBar1.Panels[0].Text := ' Comparando ficheros...';   //Indica el estado de la comparación.
   ActualizarTiempoTranscurrido(Self);                       //Indica el tiempo transcurrido.
   Timer1.Enabled := True;                                   //Activa el temporizador para que haga las actualizaciones.
   Timer2.Enabled := True;
   PaintBox3.Visible := True;
   if Assigned(Comparador) then Comparador.Free;             //Si ya existe un comparador, lo libera.
   Comparador := TComparadorDeFicheros.Create;               //Crea el subproceso de comparación.
   Comparador.OnTerminate := ThreadDone;                     //Le asigna un manejador de eventos para la finalización.
   Comparador.Priority := tpLower;
   Comparador.FileName1 := Edit1.Text;                       //Primer fichero que se compara.
   Comparador.FileName2 := Edit2.Text;                       //Segundo fichero que se compara.
   Comparador.Resume;                                        //Inicia el funcionamientos del subproceso.
   end
else
   begin
   Application.MessageBox('Debe seleccionar dos ficheros para comparar.','PARÁMETROS INCORRECTOS', MB_OK);
   end;
end;


//-------------------------------------------------------------------
// Actualiza el tiempo transcurrido.
//-------------------------------------------------------------------
procedure TFormComparadorDIFF.ActualizarTiempoTranscurrido(Sender: TObject);
begin
StatusBar1.Panels[1].Text := ' Tiempo transcurrido: ' + TimeToStr(Time - TiempoInicial);
end;

//-------------------------------------------------------------------
// Actualiza el tamaño de los paneles de la barra de estado.
//-------------------------------------------------------------------
procedure TFormComparadorDIFF.StatusBar1Resize(Sender: TObject);
begin
StatusBar1.Panels[1].Width := 200;
StatusBar1.Panels[0].Width := StatusBar1.Width - StatusBar1.Panels[1].Width;
end;

//------------------------------------------------------------------------------
// Redibuja el gráfico de referencia el redimensionarse el panel.
//------------------------------------------------------------------------------
procedure TFormComparadorDIFF.Panel1Resize(Sender: TObject);
begin
PaintBox1.Refresh;
PaintBox2.Refresh;
end;

//------------------------------------------------------------------------------
// Seleccionar la posición a partir de la cual mostrar el gráfico de comparación.
//------------------------------------------------------------------------------
procedure TFormComparadorDIFF.PaintBox2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Edit3.Text := IntToStr(Comparador.DesplazarAClic(PaintBox2, x));
PaintBox1.Refresh;
PaintBox2.Refresh;
end;

//------------------------------------------------------------------------------
// Mueve la vista al inicio.
//------------------------------------------------------------------------------
procedure TFormComparadorDIFF.Button7Click(Sender: TObject);
begin
if Assigned(Comparador) then
//   Comparador.ComparacionTerminada then
   begin
   Edit3.Text := IntToStr(Comparador.DesplazarA(0));
   PaintBox1.Repaint;
   PaintBox2.Repaint;
   end;
end;

//------------------------------------------------------------------------------
// Mueve la vista al final.
//------------------------------------------------------------------------------
procedure TFormComparadorDIFF.Button8Click(Sender: TObject);
begin
if Assigned(Comparador)then
//   Comparador.ComparacionTerminada then
   begin
   Edit3.Text := IntToStr(Comparador.DesplazarA(Comparador.ComparacionesRealizadas - 1));
   PaintBox1.Repaint;
   PaintBox2.Repaint;
   end;
end;

//------------------------------------------------------------------------------
// Muestra los componentes donde se presentan los resultados.
//------------------------------------------------------------------------------
procedure TFormComparadorDIFF.MostrarComponentesDeResultado;
begin
Constraints.MaxHeight := 0;                                                            //Permite que se pueda ampliar la altura del formulario.
Panel4.Height := 170;                                                                  //Establece la altura del panel de presentación de resultados.
ClientHeight := Panel2.Height + Panel1.Height + Panel4.Height + StatusBar1.Height;     //Establece el tamaño del area cliente.
Constraints.MinHeight := Height;                                                       //Mantiene los límites inferiores de las dimensiones del formulario.
Constraints.MinWidth := Width;

Button1.Visible := False;          //Oculta el botón que inicia la comparación.
PaintBox2.Visible := True;         //Muestra el gráfico de referencia.
Panel1.Visible := True;            //Muestra los paneles de análisis
Panel4.Visible := True;            //y de resultados.
end;

//------------------------------------------------------------------------------
// Oculta los componentes donde se presentan los resultados.
//------------------------------------------------------------------------------
procedure TFormComparadorDIFF.OcultarComponentesDeResultado;
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
PaintBox2.Visible := False;       //Muestra el gráfico de referencia.
Panel1.Visible := False;          //Muestra los paneles de análisis
Panel4.Visible := False;          //y de resultados.
end;

//------------------------------------------------------------------------------
// Muestra la ayuda de la ventana.
//------------------------------------------------------------------------------
procedure TFormComparadorDIFF.Button6Click(Sender: TObject);
var msg: String;
begin
msg := 'COMPARADOR DE DEMODULACIONES (DIFF)' + #13#13;
msg := msg + 'Esta herramienta compara dos demodulaciones' + #13;
msg := msg + 'previamente guardadas en ficheros de texto' + #13;
msg := msg + 'con extensión TXT.' + #13#13;
msg := msg + 'Dadas las dos demodulaciones, el algoritmo busca' + #13;
msg := msg + 'la mayor cantidad de coincidencias de forma tal' + #13;
msg := msg + 'que mantengan el mismo orden con que aparecen.' + #13#13;
msg := msg + 'Las diferencias encontradas se clasifican como:' + #13;
msg := msg + 'Borrados, Inserciones y Reemplazos.' + #13#13;
msg := msg + 'El resultado se muestra de forma gráfica mediante' + #13;
msg := msg + 'colores y de forma numérica.' + #13#13;
msg := msg + 'En la gráfica, algunos caracteres se muestran' + #13;
msg := msg + 'desplazados con el objetivo de mostrar alineadas' + #13;
msg := msg + 'las coincidencias encontradas.' + #13#13;
msg := msg + 'Este algoritmo fue descubierto en la década del 70' + #13;
msg := msg + 'y se emplea en los sistemas operativos Unix y Linux' + #13;
msg := msg + 'para comparar ficheros de texto. También se emplea' + #13;
msg := msg + 'en la biología para comparar las grandes secuencias' + #13;
msg := msg + 'de ADN. Es un algoritmo muy eficiente.' + #13;
MessageBox(0, PChar(msg), 'AYUDA', MB_OK);
end;


//------------------------------------------------------------------------------
// Cierra la ventana.
//------------------------------------------------------------------------------
procedure TFormComparadorDIFF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if Assigned(Comparador) then Comparador.Terminate;
end;


procedure TFormComparadorDIFF.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if Assigned(Comparador) then Comparador.Terminate;
end;


//------------------------------------------------------------------------------
// Dibuja una barra de progreso en el paint box.
//------------------------------------------------------------------------------
procedure TFormComparadorDIFF.DibujarProgreso;
const Porciento = 70;
      Bordes = 1;
      Separacion = 2;
var Rectangulo: TRect;
begin
PaintBox3.Canvas.Brush.Color := clBlack;
PaintBox3.Canvas.FillRect(PaintBox3.ClientRect);

PaintBox3.Canvas.Brush.Color := Rgb(200, 200, 200);
Rectangulo.Left := PaintBox3.ClientRect.Left + Bordes;
Rectangulo.Right := PaintBox3.ClientRect.Right - Bordes;
Rectangulo.Top := PaintBox3.ClientRect.Top + Bordes;
Rectangulo.Bottom := PaintBox3.ClientRect.Bottom - Bordes;
PaintBox3.Canvas.FillRect(Rectangulo);

if Progreso - (PaintBox3.Width div 100 * Porciento) < 0 then
   Rectangulo.Left := 0
else
   Rectangulo.Left := Progreso - (PaintBox3.Width div 100 * Porciento);
Rectangulo.Right := Progreso;
Rectangulo.Left := Rectangulo.Left + Separacion;
Rectangulo.Right := Rectangulo.Right - Separacion;
Rectangulo.Top := Rectangulo.Top + Separacion;
Rectangulo.Bottom := Rectangulo.Bottom - Separacion;
PaintBox3.Canvas.Brush.Color := clBlack;
PaintBox3.Canvas.FillRect(Rectangulo);

Rectangulo.Left := Rectangulo.Left + Bordes;
Rectangulo.Right := Rectangulo.Right - Bordes;
Rectangulo.Top := Rectangulo.Top + Bordes;
Rectangulo.Bottom := Rectangulo.Bottom - Bordes;
PaintBox3.Canvas.Brush.Color := Rgb(0, 0, 150);
PaintBox3.Canvas.FillRect(Rectangulo);
end;

//------------------------------------------------------------------------------
// Mueve la barra de progreso.
//------------------------------------------------------------------------------
procedure TFormComparadorDIFF.Timer2Timer(Sender: TObject);
begin
if Progreso < PaintBox3.Width + (PaintBox3.Width div 100 * 70) then
   Inc(Progreso, (PaintBox3.Width div 20))
else
   Progreso := 0;
PaintBox3.Refresh;
end;

//------------------------------------------------------------------------------
// Dibuja la barra de progreso.
//------------------------------------------------------------------------------
procedure TFormComparadorDIFF.PaintBox3Paint(Sender: TObject);
begin
DibujarProgreso;
end;


end.





