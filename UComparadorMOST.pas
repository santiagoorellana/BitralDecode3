unit UComparadorMOST;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, ExtCtrls, ComCtrls, UComparadorDeFicherosMost,
  Buttons, Grids, ValEdit, Menus;

type TDatos = array of Byte;

type
  TFormComparadorMost = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Panel2: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button1: TButton;
    Panel4: TPanel;
    Timer1: TTimer;
    Button6: TButton;
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    Label2: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    Panel3: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    GroupBox2: TGroupBox;
    EditValor2: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    EditValor3: TEdit;
    GroupBox3: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    EditValor4: TEdit;
    EditValor5: TEdit;
    Button4: TButton;
    Label1: TLabel;
    Label12: TLabel;
    PaintBox2: TPaintBox;
    Timer2: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    function BuscarYCargarFichero: string;
    procedure Button1Click(Sender: TObject);
    procedure ActualizarTiempoTranscurrido(Sender: TObject);
    procedure StatusBar1Resize(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button6Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button4Click(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer2Timer(Sender: TObject);
    procedure PaintBox2Paint(Sender: TObject);
  protected
  private
    Progreso: Integer;
    Comparador: TComparadorDeFicheros;
    procedure MostrarComponentesDeResultado;
    procedure OcultarComponentesDeResultado;
    procedure Seleccionar;
  public
    TiempoInicial: TDateTime;
    procedure ThreadDone(Sender: TObject);
    procedure DibujarProgreso;
  end;



var
  FormComparadorMost: TFormComparadorMost;


implementation

uses UCoincidencia, Frame;


{$R *.dfm}

//------------------------------------------------------------------------------
// Inicia el subproceso.
//------------------------------------------------------------------------------
procedure TFormComparadorMost.FormCreate(Sender: TObject);
begin
Progreso := 0;
Timer2.Enabled := False;
PaintBox2.Visible := False;
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
Panel3.Color := C_DIFERENCIA;
Panel5.Color := C_IGUALDAD;
Panel6.Color := C_SELECCION;
OcultarComponentesDeResultado;
end;

//-------------------------------------------------------------------
// Manejador del evento que informa el estado del subproceso.
//-------------------------------------------------------------------
procedure TFormComparadorMost.ThreadDone(Sender: TObject);
begin
Timer2.Enabled := False;                                                //Oculta la barra de progreso.
PaintBox2.Visible := False;
Timer1.Enabled := False;
ActualizarTiempoTranscurrido(Self);                                     //Indica el tiempo transcurrido.
StatusBar1.Panels[0].Text := ' Comparación terminada';                  //Indica el estado de la operación.
ListBox1.Items := Comparador.ObtenerResultados;
WindowState := wsNormal;                                                //Muestra la ventana si está minimizada.
MostrarComponentesDeResultado;                                          //Despliega el resultado.
MessageBeep(MB_OK);                                                     //Lanza un menzaje sonoro.
end;


//------------------------------------------------------------------------------
// Dibuja el fichero que se busca.
//------------------------------------------------------------------------------
procedure TFormComparadorMost.PaintBox1Paint(Sender: TObject);
begin
if Assigned(Comparador) then
   Comparador.DibujarGraficoDeFicheros(PaintBox1)
else
   begin
   PaintBox1.Canvas.Brush.Color := clWhite;
   PaintBox1.Canvas.Pen.Color := clBlack;
   PaintBox1.Canvas.Pen.Width := 1;
   PaintBox1.Canvas.Rectangle(PaintBox1.ClientRect);
   end;
end;

//-------------------------------------------------------------------
// Abre un diálogo que permite buscar y seleccionar un fichero.
//-------------------------------------------------------------------
function TFormComparadorMost.BuscarYCargarFichero: string;
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
procedure TFormComparadorMost.Button2Click(Sender: TObject);
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
procedure TFormComparadorMost.Button3Click(Sender: TObject);
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
procedure TFormComparadorMost.Button1Click(Sender: TObject);
begin
if (FileExists(Edit1.Text))and(FileExists(Edit1.Text)) then  //Si se han seleccionado ficheros:
   begin
   Button1.Visible := False;
   PaintBox2.Visible := True;
   Timer2.Enabled := True;
   TiempoInicial := Time;                                    //Marca el tiempo de inicio de la comparación.
   StatusBar1.Panels[0].Text := ' Comparando ficheros...';   //Indica el estado de la comparación.
   ActualizarTiempoTranscurrido(Self);                       //Indica el tiempo transcurrido.
   Timer1.Enabled := True;                                   //Activa el temporizador para que haga las actualizaciones.
   if Assigned(Comparador) then Comparador.Free;             //Si ya existe un comparador, lo libera.
   Comparador := TComparadorDeFicheros.Create;               //Crea el subproceso de comparación.
   Comparador.OnTerminate := ThreadDone;                     //Le asigna un manejador de eventos para la finalización.
   Comparador.Priority := tpNormal;
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
procedure TFormComparadorMost.ActualizarTiempoTranscurrido(Sender: TObject);
begin
StatusBar1.Panels[1].Text := ' Tiempo transcurrido: ' + TimeToStr(Time - TiempoInicial);
end;

//-------------------------------------------------------------------
// Actualiza el tamaño de los paneles de la barra de estado.
//-------------------------------------------------------------------
procedure TFormComparadorMost.StatusBar1Resize(Sender: TObject);
begin
StatusBar1.Panels[1].Width := 200;
StatusBar1.Panels[0].Width := StatusBar1.Width - StatusBar1.Panels[1].Width;
end;

//------------------------------------------------------------------------------
// Redibuja el gráfico de referencia el redimensionarse el panel.
//------------------------------------------------------------------------------
procedure TFormComparadorMost.Panel1Resize(Sender: TObject);
begin
PaintBox1.Refresh;
end;


//------------------------------------------------------------------------------
// Muestra los componentes donde se presentan los resultados.
//------------------------------------------------------------------------------
procedure TFormComparadorMost.MostrarComponentesDeResultado;
begin
Constraints.MaxHeight := 0;                                                            //Permite que se pueda ampliar la altura del formulario.
Panel4.Height := 190;                                                                  //Establece la altura del panel de presentación de resultados.
ClientHeight := Panel2.Height + Panel1.Height + Panel4.Height + StatusBar1.Height;     //Establece el tamaño del area cliente.
Constraints.MinHeight := Height;                                                       //Mantiene los límites inferiores de las dimensiones del formulario.
Constraints.MinWidth := Width;

Button1.Visible := False;          //Oculta el botón que inicia la comparación.
Label2.Visible := True;
Label3.Visible := True;
Label9.Visible := True;
Panel3.Visible := True;
Panel5.Visible := True;
Panel6.Visible := True;
Panel1.Visible := True;            //Muestra los paneles de análisis
Panel4.Visible := True;            //y de resultados.
Panel4.Height := 188;
GroupBox1.Height := 177;
ListBox1.Height := 155;
end;

//------------------------------------------------------------------------------
// Oculta los componentes donde se presentan los resultados.
//------------------------------------------------------------------------------
procedure TFormComparadorMost.OcultarComponentesDeResultado;
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
Label2.Visible := False;
Label3.Visible := False;
Label9.Visible := False;
Panel3.Visible := False;
Panel5.Visible := False;
Panel6.Visible := False;
Panel1.Visible := False;          //Muestra los paneles de análisis
Panel4.Visible := False;          //y de resultados.
end;

//------------------------------------------------------------------------------
// Muestra la ayuda de la ventana.
//------------------------------------------------------------------------------
procedure TFormComparadorMost.Button6Click(Sender: TObject);
var msg: String;
begin
msg := 'COMPARADOR DE DEMODULACIONES (MOST WOLE COINCIDENCE)' + #13#13;
msg := msg + 'Esta herramienta compara dos demodulaciones previamente guardadas' + #13;
msg := msg + 'en ficheros de texto con extensión TXT.' + #13#13;
msg := msg + 'Dadas las dos demodulaciones A y B, el algoritmo busca partes de' + #13;
msg := msg + 'la demodulación A dentro de la demodulación B, mostrando las' + #13;
msg := msg + 'mayores coincidencias que existen entre ellas.' + #13#13;
msg := msg + 'Las coincidencias encontradas se muestran en una gráfica de' + #13;
msg := msg + 'enlace que ilustra la relación estructural que existe entre' + #13;
msg := msg + 'las demodulaciones A y B.' + #13#13;
msg := msg + 'Este algoritmo ha sido diseñado expecialmente para comparar' + #13;
msg := msg + 'demodulaciones ya que permite ver las estructuras comunes' + #13;
msg := msg + 'a los dos ficheros.';
MessageBox(0, PChar(msg), 'AYUDA', MB_OK);
end;


//------------------------------------------------------------------------------
// Cierra la ventana.
//------------------------------------------------------------------------------
procedure TFormComparadorMost.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if Assigned(Comparador) then Comparador.Terminate;
end;


//------------------------------------------------------------------------------
procedure TFormComparadorMost.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if Assigned(Comparador) then Comparador.Terminate;
end;


//------------------------------------------------------------------------------
procedure TFormComparadorMost.Seleccionar;
var rectangulo: TRect;
begin
if ListBox1.ItemIndex >= 0 then
   begin
   rectangulo := Comparador.ListaDeContinuidades[ListBox1.ItemIndex];
   EditValor2.Text := IntToStr(rectangulo.Left);
   EditValor3.Text := IntToStr(rectangulo.Right);
   EditValor4.Text := IntToStr(rectangulo.Top);
   EditValor5.Text := IntToStr(rectangulo.Bottom);
   Comparador.Seleccion := ListBox1.ItemIndex;
   Button4.Enabled := True;
   PaintBox1.Refresh;
   end
else
   begin
   EditValor2.Text := '';
   EditValor3.Text := '';
   EditValor4.Text := '';
   EditValor5.Text := '';
   Comparador.Seleccion := MaxInt;
   Button4.Enabled := False;
   PaintBox1.Refresh;
   end;
end;


//------------------------------------------------------------------------------
procedure TFormComparadorMost.ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Seleccionar;
end;

//------------------------------------------------------------------------------
procedure TFormComparadorMost.ListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
Seleccionar;
end;

//------------------------------------------------------------------------------
procedure TFormComparadorMost.ListBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
Seleccionar;
end;

//------------------------------------------------------------------------------
// Muestra los datos de la coincidencia.
//------------------------------------------------------------------------------
procedure TFormComparadorMost.Button4Click(Sender: TObject);
var n: Integer;
    rectangulo: TRect;
begin
rectangulo := Comparador.ListaDeContinuidades[ListBox1.ItemIndex];
with TFormCoincidencia.Create(Self) do
     begin
     for n := rectangulo.Left to rectangulo.Right do
         Insertar(Chr(Comparador.Datos1[n]));
     MostrarDatos(rectangulo);
     Show;
     end;
end;

//------------------------------------------------------------------------------
// Desselecciona las coincidencias.
//------------------------------------------------------------------------------
procedure TFormComparadorMost.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
ListBox1.ItemIndex := -1;
Seleccionar;
end;


//------------------------------------------------------------------------------
// Dibuja una barra de progreso en el paint box.
//------------------------------------------------------------------------------
procedure TFormComparadorMost.DibujarProgreso;
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
procedure TFormComparadorMost.Timer2Timer(Sender: TObject);
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
procedure TFormComparadorMost.PaintBox2Paint(Sender: TObject);
begin
DibujarProgreso;
end;

end.





