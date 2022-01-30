/////////////////////////////////////////////////////////////////////
// Fecha: 27/1/2012                                                //
// Autor: Santiago A. Orellana Pérez                               //
// Fución: Implementa un componente que muestra el raster          //
//         de una demodulación, la cual se carga desde un          //
//         fichero tipo TXT y puede ser modificado mediante        //
//         operaciones de edición como: Borrado, movimiento        //
//         y reemplazamiento de areas rectangulares. También       //
//         permite insertar cadenas de símbolos a partir de        //
//         una posición dada.                                      //
/////////////////////////////////////////////////////////////////////


unit EditableRaster;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Forms,
  StdCtrls,
  Grids,
  Controls,
  Graphics,
  Dialogs,
  ExtCtrls,
  Math,
  HistoryDataManager,
  DataManager,
  Clipbrd;

type TScaleColor = (TwoColor, RainbowColor);

type TRasterMouseMoveEvent = procedure(Sender: TObject; Shift: TShiftState; X, Y, PosicionValor: Integer; Valor: Byte) of object;

type
  TEditableRaster = class(TCustomControl)
  private
     //Variables de parámetros.
     PeriodoActual: Integer;                    //Período actual en que se muestran los datos.
     DesplazamientoHorizontal: Integer;
     VisibleRaster: TPoint;

     //Variables de los colores que se muestran en el raster.
     BrushColors: Array[0..31]of TBrush;          //Arreglo de colores de símbolos.
     ColorDeSeleccion: TColor;                    //Color de la selección.
     ColorDeAusencia: TColor;                     //Color de los elementos que no representan caracteres.
     ColorDeCaracteresNoValidos: TColor;          //Color para los caracteres no válidos.

     ScaleInitialColor: TColor;
     ScaleFinalColor: TColor;
     ScaleColor: TScaleColor;

     //Variables de fucionamiento interno.
     InicioDeMovimiento: TPoint;
     PuntoInicial: TPoint;
     Moviendo: Boolean;
     DrawX, DrawY: Integer;
     Copia : TBitmap;
     PixelSize: Integer;
     Lineas: Integer;                             //Cantidad de líneas de datos que se muestran.
     LongitudTotal: Integer;
     Columnas: Integer;

     //Variables que controlan la selección.
     Seleccion: TRect;                            //Guarda las coordenadas de la representación de la selección.
     InicioSeleccion: Integer;                    //Posición de incio de la selección en el arreglo de datos.
     Seleccionar: Boolean;                        //Indica que se deben calcular las coordenadas de la selección.
     AreaSeleccionada: TDataSeleccion;            //Representa el area de selección en los datos. Esta varaible se usa para las operaciones con los datos.

     //Varaibles de los eventos nuevos de este componente.
     FOnLoadDemodulationFile: TNotifyEvent;
     FOnRasterMouseMoveEvent: TRasterMouseMoveEvent;

     //Métodos de Funcionamiento.
     procedure FromFile(FileName: String);
     procedure CreateColors(CantidadDeSimbolos: Byte);
     function GetTwoColorInterpolateRampScale(fraction:DOUBLE; Color1, Color2:TColor): TColor;
     function GetRainbowColorRampScale(valor: Double): TColor;
     procedure StringGrid1DrawCell(Sender: TObject; Col, Row: Integer; Rect: TRect; State: TGridDrawState);
     procedure CentrarCoordenada(Coordenada: Tpoint);
     procedure LlenarSeleccionCon(Simbolo: Byte);
     procedure InsertarCaracteres(Lugar: TLugar; Cadena: AnsiString);
     procedure EstablecerCantidadDeSimbolos(Cantidad: Integer);
     procedure CrearDibujoDelRaster;
     function SeleccionValida: Boolean;
     procedure GuardarImagenEnFichero(nombre: String);
     procedure CargarFicheroDeDemodulacion(nombre: String);

     procedure CMMouseLeave(var msg: TMessage); message CM_MOUSELEAVE;

  protected
     procedure Click; override;
     procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
     procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
     procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
     procedure Paint; override;
     procedure Resize; override;

  public
     //Variables de Funcionamiento.
     FuenteDeDatos: THistoryDataManager;        //Período actual en que se muestran los datos.

     constructor Create(AOwner:TComponent); override;
     constructor Iniciar(AOwner:TWinControl; Extender: Boolean; x, y, ancho, altura: Integer); overload;
     constructor Iniciar(AOwner:TWinControl);  overload;
     procedure Mostrar(Fuente: THistoryDataManager; Periodo, Desplazamiento: Integer; UsarColor: Boolean);
     Destructor Destroy; override;

     //Operaciones de fichero.
     procedure CargarDemodulacion;
     procedure GuardarCambios;
     procedure GuardarDemodulacionComo;
     procedure GuardarImagen;

     //Movimiento por el componente, zoom y apariencia.
     procedure MoverIzquierda(Posiciones: Integer);
     procedure MoverDerecha(Posiciones: Integer);
     procedure MoverArriba(Posiciones: Integer);
     procedure MoverAbajo(Posiciones: Integer);
     procedure MoverInicio;
     procedure MoverFinal;
     procedure PageUp;
     procedure PageDown;
     procedure PageLeft;
     procedure PageRight;
     procedure AumentarAnchoDePixel;
     procedure DisminuirAnchoDePixel;
     procedure AjustarAncho;
     procedure CambiarColores;
     procedure ActualizarColores;
     procedure DisminuirPeriodo;
     procedure AumentarPeriodo;
     procedure DesplazarIzquierda;
     procedure DesplazarDerecha;
     procedure NuevoPeriodo(Cantidad: Integer);
     procedure NuevoDesplazamiento(Cantidad: Integer);
     procedure SumarAlDesplazamiento(Cantidad: Integer);

     //Métodos de edición.
     procedure Deshacer;
     procedure Rehacer;
     procedure Desseleccionar;
     procedure BorrarSeleccion;
     procedure CopiarSeleccion;
     procedure CortarSeleccion;
     procedure PegarSeleccionCopiada;
     procedure FiltrarDatos;
     procedure PedirCaracterParaLlenarSeleccion;
     procedure PedirCaracteresParaInsertar;
     procedure PedirCantidadDeSimbolos;
     procedure PedirDesplazamiento;
     procedure PedirPeriodo;
     procedure CalcularLaCantidadDeSimbolosActualDelRaster;
     procedure MostrarTextoDeSeleccion;
     procedure ActualizarRaster;

     //Descripciones.
     procedure MostrarLeyenda;
     function ObtenerPeriodoActual: Integer;

  published
     //Propiedades que hereda de sus ancestros.
     property TabOrder;
     property Action;
     property Visible;
     property Enabled;
     property ParentShowHint;
     property PopupMenu;
     property ShowHint;
     property Hint;

     //Eventos que hereda de sus ancestros.
     property OnClick;
     property OnContextPopup;
     property OnDblClick;
     property OnMouseDown;
     property OnMouseMove;
     property OnMouseUp;
     property OnEnter;
     property OnExit;

     //Nuevos eventos de este componente.
     property OnLoadDemodulationFile:TNotifyEvent read FOnLoadDemodulationFile Write FOnLoadDemodulationFile;
     property OnRasterMouseMove: TRasterMouseMoveEvent read FOnRasterMouseMoveEvent Write FOnRasterMouseMoveEvent;

  end;


implementation

uses Types, Frame;

/////////////////////////////////////////////////////////////////////
// METODOS
/////////////////////////////////////////////////////////////////////

//-------------------------------------------------------------------
constructor TEditableRaster.Create(AOwner:TComponent);
begin
inherited;                                            //Llama al método Create del ancestro (TCustomControl).
DoubleBuffered := True;
Copia := TBitmap.Create;
PixelSize := 1;
PeriodoActual := 4;
VisibleRaster.X := 0;
VisibleRaster.Y := 0;
DrawX := 0;
DrawY := 0;
Desseleccionar;
AreaSeleccionada.Inicio := MaxInt;
AreaSeleccionada.Ancho := MaxInt;
AreaSeleccionada.Altura := MaxInt;
AreaSeleccionada.Periodo := MaxInt;
DesplazamientoHorizontal := 0;
ScaleColor := TwoColor;
ScaleInitialColor := clBlack;
ScaleFinalColor := clWhite;
end;

//-------------------------------------------------------------------
// Se utiliza para iniciar el componente desde el código de forma simple.
//-------------------------------------------------------------------
constructor TEditableRaster.Iniciar(AOwner:TWinControl; Extender: Boolean; x, y, ancho, altura: Integer);
begin
Parent := AOwner;
Left := x;
Top := y;
Width := ancho;
Height := altura;
if Extender then Align := alClient
end;

constructor TEditableRaster.Iniciar(AOwner:TWinControl);
begin
Iniciar(AOwner, true, 0, 0, 10, 10);
end;


//-------------------------------------------------------------------
procedure TEditableRaster.Mostrar(Fuente: THistoryDataManager; Periodo, Desplazamiento: Integer; UsarColor: Boolean);
begin
FuenteDeDatos := Fuente;
PeriodoActual := Periodo;
DesplazamientoHorizontal := Desplazamiento;
if UsarColor then ScaleColor := RainbowColor else ScaleColor := TwoColor;
CreateColors(FuenteDeDatos.OptenerCantidadDeSimbolos);                      //Crea los colores para representar los símbolos encontrados en los datos.
CrearDibujoDelRaster;
end;

//-------------------------------------------------------------------
procedure TEditableRaster.CargarFicheroDeDemodulacion(nombre: String);
begin
if FileExists(nombre) then
   begin
   Desseleccionar;
   FromFile(nombre);                                                         //Carga datos de un fichero.
   CreateColors(FuenteDeDatos.OptenerCantidadDeSimbolos);                    //Crea los colores para representar los símbolos encontrados en los datos.
   CrearDibujoDelRaster;
   if Assigned(FOnLoadDemodulationFile) then FOnLoadDemodulationFile(Self);  //Informa el cambio.
   end;
end;

//-------------------------------------------------------------------
procedure TEditableRaster.CargarDemodulacion;
var dlg: TOpenDialog;
begin
dlg := TOpenDialog.Create(Self);                                                 //Crea un diálogo.
dlg.Title := 'Buscar y cargar demodulación...';                                  //Título del diálogo.
dlg.Filter := 'Ficheros de texto (*.txt)|*.TXT|Todos los ficheros (*.*)|*.*';    //Ficheros que se muestran.
if dlg.Execute then                                                              //
   if FileExists(dlg.FileName) then
      CargarFicheroDeDemodulacion(dlg.FileName);
dlg.Free;                                                                        //Libera el diálogo creado.
end;


//-------------------------------------------------------------------
procedure TEditableRaster.GuardarImagen;
var dlg: TSaveDialog;
begin
if not FuenteDeDatos.Valido then Exit;
dlg := TSaveDialog.Create(Self);                                                //Crea un diálogo.
dlg.InitialDir := MainForm.RutaParaGuardarImagenes;
dlg.Title := 'Guardar imagen...';                                               //Título del diálogo.
dlg.DefaultExt := 'BMP';                                                        //Si no se pone extensión, se toma esta.
dlg.Filter := 'Ficheros de imagen (*.bmp)|*.BMP|Todos los ficheros (*.*)|*.*';  //Ficheros que se muestran.
if dlg.Execute then                                                             //
   GuardarImagenEnFichero(dlg.FileName);
dlg.Free;                                                                      //Libera el diálogo creado.
end;


//-----------------------------------------------------------------------------
// Muestra el raster dibujado en "Copia" pegándolo en el DC del objeto.
//-----------------------------------------------------------------------------
procedure TEditableRaster.GuardarImagenEnFichero(nombre: String);
var bmp: TImage;
begin
if not FuenteDeDatos.Valido then Exit;
if Assigned(Copia) then
   begin
   MainForm.RutaParaGuardarImagenes := nombre;
   bmp := TImage.Create(Self);
   bmp.Width := Copia.Width;
   bmp.Height := Copia.Height;
   bmp.Canvas.Draw(DrawX, DrawY, Copia);         //Dibuja el raster.
   bmp.Picture.SaveToFile(nombre);
   bmp.Free;
   end;
end;

//-------------------------------------------------------------------
// Permite guardar la demodulación en un nuevo fichero.
//-------------------------------------------------------------------
procedure TEditableRaster.GuardarDemodulacionComo;
begin
if not FuenteDeDatos.Valido then Exit;
FuenteDeDatos.BuscarYGuardarFicheroComo;
end;

//-------------------------------------------------------------------
// Permite guardar los cambios en el mismo fichero.
//-------------------------------------------------------------------
procedure TEditableRaster.GuardarCambios;
begin
if not FuenteDeDatos.Valido then Exit;
FuenteDeDatos.GuardarCambios;
end;

//-------------------------------------------------------------------
Destructor TEditableRaster.Destroy;
begin
Copia.Free;
inherited;
end;


//-------------------------------------------------------------------
// Permite iniciar la selección de areas rectángulares del raster.
//-------------------------------------------------------------------
procedure TEditableRaster.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var vx, vy, vp: Integer;
begin
inherited;
if not FuenteDeDatos.Valido then Exit;
InicioDeMovimiento.X := MaxInt;
InicioDeMovimiento.Y := MaxInt;
PuntoInicial.X := MaxInt;
PuntoInicial.Y := MaxInt;
Moviendo := False;
if Button = mbLeft then                                          //Si se ha presionado el botón izquierdo del mouse: Selecciona.
   begin
   if HiWord(GetKeyState(VK_SHIFT)) <> 0 then                    //Determina si la tecla SHIFT está pulsada.
      begin
      vx := X div PixelSize + VisibleRaster.X;
      vy := Y div PixelSize + VisibleRaster.Y;
      vp := vy * PeriodoActual + vx + DesplazamientoHorizontal;
      if (vp >= 0) and (vp < FuenteDeDatos.Longitud)and
         (vx >= 0) and (vx < PeriodoActual)and                   //Si el valor representa una posición del arreglo de datos:
         (vx >= Seleccion.Left) and
         (vy >= Seleccion.Top) then
         begin
         Seleccion.Right := vx;                                  //Si se está pulsando SHIFT: Este es el
         Seleccion.Bottom := vy;                                 //segundo clic de la selección.
         end
      else
         begin
         InicioSeleccion := MaxInt;
         Seleccion.Right := MaxInt;                              //Declara como nulo el clic.
         Seleccion.Bottom := MaxInt;
         end;
      Seleccionar := False;
      Repaint;
      end
   else                                                          //Si la tecla SHIFT no está pulsada.
      begin
      vx := X div PixelSize + VisibleRaster.X;
      vy := Y div PixelSize + VisibleRaster.Y;
      vp := vy * PeriodoActual + vx + DesplazamientoHorizontal;
      if (vp >= 0) and (vp < FuenteDeDatos.Longitud)and
         (vx >= 0) and (vx < PeriodoActual)then                  //Si el valor representa una posición del arreglo de datos:
         begin
         Seleccionar := True;                                    //Si no es SHIFT: entonces este es el
         InicioSeleccion := vp;
         Seleccion.Left := vx;                                   //primer clic de la selección.
         Seleccion.Top := vy;
         Seleccion.BottomRight := Seleccion.TopLeft;
         end
      else
         begin
         Seleccionar := False;                                   //Declara como nulo el clic.
         InicioSeleccion := MaxInt;
         Seleccion.Left := MaxInt;
         Seleccion.Top := MaxInt;
         Seleccion.BottomRight := Seleccion.TopLeft;
         end;
      end;
   end
else
   begin
   Seleccionar := False;
   Moviendo := True;
   InicioDeMovimiento.X := X div PixelSize + VisibleRaster.X;
   InicioDeMovimiento.Y := Y div PixelSize + VisibleRaster.Y;
   PuntoInicial.X := X;
   PuntoInicial.Y := Y;
   end;
end;


//------------------------------------------------------------------------------
// Permite finalizar la selección de areas rectángulares del raster.
//------------------------------------------------------------------------------
procedure TEditableRaster.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var vx, vy, vp: Integer;
begin
inherited;
if not FuenteDeDatos.Valido then Exit;
if Button = mbLeft then                                          //Si es el botçon izquierdo:
   begin
   if Seleccionar then                                           //Si está editando.
      begin
      vx := X div PixelSize + VisibleRaster.X;
      vy := Y div PixelSize + VisibleRaster.Y;
      vp := vy * PeriodoActual + vx + DesplazamientoHorizontal;
      if (vp >= 0) and (vp < FuenteDeDatos.Longitud) and
         (vx >= 0) and (vx < PeriodoActual) and                  //Si el valor representa una posición del arreglo de datos:
         (vx >= Seleccion.Left) and
         (vy >= Seleccion.Top) then
         begin
         Seleccion.Right := vx;
         Seleccion.Bottom := vy;
         end;
      Seleccionar := False;
      Repaint;
      end;
   end
else                                                             //Si se presiona CONTROL:
   begin
   if Moviendo then
      begin
      Moviendo := False;
      VisibleRaster.X := VisibleRaster.X - ((X div PixelSize + VisibleRaster.X) - InicioDeMovimiento.X);
      VisibleRaster.Y := VisibleRaster.Y - ((Y div PixelSize + VisibleRaster.Y) - InicioDeMovimiento.Y);
      DrawX := 0;
      DrawY := 0;
      CrearDibujoDelRaster;
      end;
   end;
end;


//------------------------------------------------------------------------------
// Permite modificar el area rectángular seleccionada en el raster.
//------------------------------------------------------------------------------
procedure TEditableRaster.MouseMove(Shift: TShiftState; X, Y: Integer);
var vx, vy, vp: Integer;
begin
if not FuenteDeDatos.Valido then Exit;
if not Moviendo then
   begin
   if Assigned(FOnRasterMouseMoveEvent) then
      begin
      if (X > 0) and (X <= Width) and                               //Si la X  y la Y están dentro de la
         (Y > 0) and (Y <= Height) then                             //imagen excluyendo los bordes:
         begin
         vx := X div PixelSize + VisibleRaster.X;                   //Fila dentro de la imagen.
         vy := Y div PixelSize + VisibleRaster.Y;                   //Columna dentro de la imagen.
         vp := vy * PeriodoActual + vx + DesplazamientoHorizontal;  //Valor de posición dentro de arreglo de datos.
         if (vp >= 0) and (vp < FuenteDeDatos.Longitud) and
            (vx >= 0) and (vx < PeriodoActual) then                 //Si el valor representa una posición del arreglo de datos:
             begin
             FOnRasterMouseMoveEvent(Self, Shift, vx, vy, vp, FuenteDeDatos.LeerDato(vp));
             if Seleccionar and
               (vx >= Seleccion.Left) and
               (vy >= Seleccion.Top) then
               begin
               Seleccion.Right := vx;
               Seleccion.Bottom := vy;
               end;
             end;
         Repaint;
         end;
      end;
   end
else
   begin
   DrawX := (X - PuntoInicial.X);
   DrawY := (Y - PuntoInicial.Y);
   Repaint;
   end;
end;

//-------------------------------------------------------------------
// Detiene las operaciones del mouse cuando se sale del componente.
//-------------------------------------------------------------------
procedure TEditableRaster.CMMouseLeave(var msg: TMessage);
begin
if Moviendo then
   begin
   Moviendo := False;
   DrawX := 0;
   DrawY := 0;
   CrearDibujoDelRaster;
   end;
end;


//-------------------------------------------------------------------
procedure  TEditableRaster.Click;
begin
inherited;
SetFocus;
end;

//-------------------------------------------------------------------
procedure TEditableRaster.FromFile(FileName: String);
begin
if Assigned(FuenteDeDatos) then
   FuenteDeDatos.CargarDemodulacion(FileName);
end;


//-------------------------------------------------------------------
// Crea los colores que se muestran en el raster.
//-------------------------------------------------------------------
procedure TEditableRaster.CreateColors(CantidadDeSimbolos: Byte);
var n: Integer;
begin
if not FuenteDeDatos.Valido then Exit;
if CantidadDeSimbolos > 0 then
   for n := 0 to 31 do
       begin
       BrushColors[n] := TBrush.Create;
       case ScaleColor of
            TwoColor: begin
                      ColorDeSeleccion := clRed;                    //Rojo.
                      ColorDeAusencia := RGB(0, 0, 100);            //Azul oscuro.
                      ColorDeCaracteresNoValidos := clOlive;        //Verde oscuro.
                      if n < CantidadDeSimbolos then
                         BrushColors[n].Color := GetTwoColorInterpolateRampScale(n / (CantidadDeSimbolos - 1), ScaleInitialColor, ScaleFinalColor)
                      else
                         BrushColors[n].Color := ColorDeCaracteresNoValidos;
                      end;
            RainbowColor: begin
                          ColorDeSeleccion := clBlack;              //Negro.
                          ColorDeAusencia := clBlack;               //Negro.
                          ColorDeCaracteresNoValidos := clGray;     //Griz.
                          if n < CantidadDeSimbolos then
                             BrushColors[n].Color := GetRainbowColorRampScale(n / (CantidadDeSimbolos - 1))
                          else
                             BrushColors[n].Color := ColorDeCaracteresNoValidos;
                          end;
            end;
       end;
end;


//-------------------------------------------------------------------
function TEditableRaster.GetTwoColorInterpolateRampScale(fraction:Double; Color1, Color2:TColor): TColor;
var complement: Double;
    R1, R2, G1, G2, B1, B2: BYTE;
begin
if fraction <= 0 then
   Result := Color1
else
   if fraction >= 1.0 then
      Result := Color2
   else
      begin
      R1 := GetRValue(Color1);
      G1 := GetGValue(Color1);
      B1 := GetBValue(Color1);
      R2 := GetRValue(Color2);
      G2 := GetGValue(Color2);
      B2 := GetBValue(Color2);
      complement := 1.0 - fraction;
      Result := RGB(Round(complement*R1 + fraction*R2),
                    Round(complement*G1 + fraction*G2),
                    Round(complement*B1 + fraction*B2));
      end
end;


//-------------------------------------------------------------------
function TEditableRaster.GetRainbowColorRampScale(valor: Double): TColor;
var p: Double;
begin
p := 6 * valor;
case Trunc(p) of
     0: Result := GetTwoColorInterpolateRampScale(Frac(p), $0000FF, $0080FF);
     1: Result := GetTwoColorInterpolateRampScale(Frac(p), $0080FF, $00FFFF);
     2: Result := GetTwoColorInterpolateRampScale(Frac(p), $00FFFF, $00FF00);
     3: Result := GetTwoColorInterpolateRampScale(Frac(p), $00FF00, $FFFF00);
     4: Result := GetTwoColorInterpolateRampScale(Frac(p), $FFFF00, $FF0000);
     5: Result := GetTwoColorInterpolateRampScale(Frac(p), $FF0000, $FF0080);
     6: Result := GetTwoColorInterpolateRampScale(Frac(p), $FF0080, $FF00FF);
     else Result := clBlack;
     end;
end;


//-------------------------------------------------------------------
procedure TEditableRaster.CrearDibujoDelRaster;
var n, m: Integer;
    pd: Integer;
    rectangulo: TRect;
begin
if not FuenteDeDatos.Valido then Exit;
if (Width < Copia.Width) and (Height < Copia.Height) then       //Si la nueva area visible es más chiquita:
   begin                                                        //Redimensiona y sale del procedimiento.
   Copia.Width := Width;                                        //Ancho del area visible.
   Copia.Height := Height;                                      //Altura del area visible.
   Exit;                                                        //Sale del procedimiento.
   end;
Copia.Width := Width;                                           //Ancho del area visible.
Copia.Height := Height;                                         //Altura del area visible.
Columnas := Copia.Width div PixelSize + 1;                      //Cantidad de Columnas que caben en el area visible.
Lineas := Copia.Height div PixelSize + 1;                       //Cantidad de Lineas que caben en el area visible.
LongitudTotal := FuenteDeDatos.Longitud div PeriodoActual - 1;

rectangulo.Top := 0;
rectangulo.Left := 0;
rectangulo.Right := ClientWidth;
rectangulo.Bottom := ClientHeight;
Copia.Canvas.Brush.Color := ColorDeAusencia;
Copia.Canvas.FillRect(Copia.Canvas.ClipRect);

if Assigned(FuenteDeDatos) then
   begin
   if FuenteDeDatos.Longitud > 0 then                                                              //Si existen datos que mostrar:
      begin
      for n := VisibleRaster.Y to VisibleRaster.Y + Lineas do                                      //Por cada línea visible hace los siguiente:
          begin
          if (n < 0) or (n > FuenteDeDatos.Longitud div PeriodoActual) then Continue;              //Si está fuera de los límites del raster, continúa.
          rectangulo.Top := (n - VisibleRaster.Y) * PixelSize;                                     //Calcula el límite superior de los pixeles de la línea.
          rectangulo.Bottom := rectangulo.Top + PixelSize;                                         //Calcula el límite inferior de los pixeles de la línea.
          for m := VisibleRaster.X to VisibleRaster.X + Columnas do                                //Repite esto por cada columna visible de cada línea:
              begin
              if (m < 0) or (m > PeriodoActual - 1) then Continue;                                 //Si está fuera de los límites del raster, continúa.
              rectangulo.Left := (m - VisibleRaster.X) * PixelSize;                                //Calcula el límite izquierdo de los pixeles de la línea.
              rectangulo.Right := rectangulo.Left + PixelSize;                                     //Calcula el límite derecho de los pixeles de la línea.
              pd := (n * PeriodoActual) + m + DesplazamientoHorizontal;                            //Calcula la posición del dato dentro del arreglo.
              if pd < FuenteDeDatos.Longitud then                                                  //Si la posición calculada es válida:
                 begin
                 if pd >= 0 then                                                                   //Si el puntero es negativo, no se muestra color.
                    begin                                                                          //Aquí se utiliza el CASE para proporcionar repidez.                                                     //E esta parte se puede agregar una condicional que compruebe si el caracter está en el rango debido.
                    case Chr(FuenteDeDatos.LeerDato(pd)) of
                         '0': Copia.Canvas.Brush := BrushColors[0];
                         '1': Copia.Canvas.Brush := BrushColors[1];
                         '2': Copia.Canvas.Brush := BrushColors[2];
                         '3': Copia.Canvas.Brush := BrushColors[3];
                         '4': Copia.Canvas.Brush := BrushColors[4];
                         '5': Copia.Canvas.Brush := BrushColors[5];
                         '6': Copia.Canvas.Brush := BrushColors[6];
                         '7': Copia.Canvas.Brush := BrushColors[7];
                         '8': Copia.Canvas.Brush := BrushColors[8];
                         '9': Copia.Canvas.Brush := BrushColors[9];
                         'A','a': Copia.Canvas.Brush := BrushColors[10];
                         'B','b': Copia.Canvas.Brush := BrushColors[11];
                         'C','c': Copia.Canvas.Brush := BrushColors[12];
                         'D','d': Copia.Canvas.Brush := BrushColors[13];
                         'E','e': Copia.Canvas.Brush := BrushColors[14];
                         'F','f': Copia.Canvas.Brush := BrushColors[15];
                         'G','g': Copia.Canvas.Brush := BrushColors[16];
                         'H','h': Copia.Canvas.Brush := BrushColors[17];
                         'I','i': Copia.Canvas.Brush := BrushColors[18];
                         'J','j': Copia.Canvas.Brush := BrushColors[19];
                         'K','k': Copia.Canvas.Brush := BrushColors[20];
                         'L','l': Copia.Canvas.Brush := BrushColors[21];
                         'M','m': Copia.Canvas.Brush := BrushColors[22];
                         'N','n': Copia.Canvas.Brush := BrushColors[23];
                         'O','o': Copia.Canvas.Brush := BrushColors[24];
                         'P','p': Copia.Canvas.Brush := BrushColors[25];
                         'Q','q': Copia.Canvas.Brush := BrushColors[26];
                         'R','r': Copia.Canvas.Brush := BrushColors[27];
                         'S','s': Copia.Canvas.Brush := BrushColors[28];
                         'T','t': Copia.Canvas.Brush := BrushColors[29];
                         'U','u': Copia.Canvas.Brush := BrushColors[30];
                         'V','v': Copia.Canvas.Brush := BrushColors[31];
                         else Copia.Canvas.Brush.Color := ColorDeCaracteresNoValidos;
                         end;
                    Copia.Canvas.FillRect(rectangulo);
                    end;
                 end;
              end;
          end;
      Repaint;
      end;
   end;
end;


//-----------------------------------------------------------------------------
// Muestra el raster dibujado en "Copia" pegándolo en el DC del objeto.
//-----------------------------------------------------------------------------
procedure TEditableRaster.Paint;
var Rectangulo: TRect;
begin
if not FuenteDeDatos.Valido then Exit;
if Assigned(Copia) then
   begin
   Canvas.Brush.Color := ColorDeAusencia;
   Canvas.FillRect(ClientRect);
   Canvas.Draw(DrawX, DrawY, Copia);         //Dibuja el raster.
   end;
if (Seleccion.Left <> MaxInt) and                                 //Si es válida la selección, la representa.
   (Seleccion.Top <> MaxInt) and
   (Seleccion.Right <> MaxInt) and
   (Seleccion.Bottom <> MaxInt) then
   begin
   //Prepara para dibujar la selección.
   Canvas.Pen.Width := 1;
   Canvas.Pen.Color := ColorDeSeleccion;
   Canvas.Pen.Style := psSolid;
   Canvas.Brush.Style := bsDiagCross;
   Canvas.Brush.Color := ColorDeSeleccion;

   //Calcula las coordenadas y dibuja la selección.
   if (Seleccion.Right >= Seleccion.Left) and
      (Seleccion.Bottom >= Seleccion.Top)then
      begin
      Rectangulo.Left := (Seleccion.Left - VisibleRaster.X)* PixelSize + DrawX;
      Rectangulo.Top := (Seleccion.Top - VisibleRaster.Y) * PixelSize + DrawY;
      if (Seleccion.Left = Seleccion.Right) and
         (Seleccion.Top = Seleccion.Bottom) and
         (PixelSize = 1) then
         begin
         Canvas.Pixels[Rectangulo.Left, Rectangulo.Top] := ColorDeSeleccion
         end
      else
         begin
         Rectangulo.Right := (Seleccion.Right - VisibleRaster.X + 1)* PixelSize + DrawX;
         Rectangulo.Bottom := (Seleccion.Bottom - VisibleRaster.Y + 1) * PixelSize + DrawY;
         Canvas.Rectangle(Rectangulo);
         end;
      AreaSeleccionada.Inicio := InicioSeleccion;
      AreaSeleccionada.Ancho := Seleccion.Right - Seleccion.Left + 1;
      AreaSeleccionada.Altura := Seleccion.Bottom - Seleccion.Top + 1;
      AreaSeleccionada.Periodo := PeriodoActual;
      Exit;
      end;
   end;
AreaSeleccionada.Inicio := MaxInt;
AreaSeleccionada.Ancho := MaxInt;
AreaSeleccionada.Altura := MaxInt;
AreaSeleccionada.Periodo := MaxInt;
end;

//-------------------------------------------------------------------
// Redibuja el componente cada vez que se redimensiona.
//-------------------------------------------------------------------
procedure TEditableRaster.Resize;
begin
if not FuenteDeDatos.Valido then Exit;
CrearDibujoDelRaster
end;

//-------------------------------------------------------------------
// Deselecciona los datos.
//-------------------------------------------------------------------
procedure TEditableRaster.Desseleccionar;
begin
Seleccion.Left := MaxInt;
Seleccion.Top := MaxInt;
Seleccion.Right := MaxInt;
Seleccion.Bottom := MaxInt;
InicioSeleccion := MaxInt;
AreaSeleccionada.Inicio := MaxInt;
AreaSeleccionada.Ancho := MaxInt;
AreaSeleccionada.Altura := MaxInt;
AreaSeleccionada.Periodo := MaxInt;
Repaint;
end;


//-------------------------------------------------------------------
// Borra los caracteres del rectángulo seleccionado.
//-------------------------------------------------------------------
function TEditableRaster.SeleccionValida: Boolean;
begin
with AreaSeleccionada do
     begin
     if (Inicio <> MaxInt) and
        (Ancho <> MaxInt) and
        (Altura <> MaxInt) and
        (Periodo <> MaxInt) and
        (Inicio + (Periodo * (Altura - 1) + (Ancho - 1)) < FuenteDeDatos.Longitud) and
        (Inicio >= 0) then
        Result := True
     else
        Result := False;
     end;
end;

//-------------------------------------------------------------------
// Borra los caracteres del rectángulo seleccionado.
//-------------------------------------------------------------------
procedure TEditableRaster.BorrarSeleccion;
begin
if SeleccionValida then
   begin
   FuenteDeDatos.EliminarDatos(AreaSeleccionada);
   Desseleccionar;
   CrearDibujoDelRaster;
   end;
end;

//-------------------------------------------------------------------
// Llena el rectángulo seleccionado con el caracter indicado.
//-------------------------------------------------------------------
procedure TEditableRaster.LlenarSeleccionCon(Simbolo: Byte);
begin
if SeleccionValida then
   begin
   FuenteDeDatos.SustituirDatos(AreaSeleccionada, Simbolo);
   Desseleccionar;
   CrearDibujoDelRaster;
   end;
end;

//-------------------------------------------------------------------
// Copia el rectángulo seleccionado.
//-------------------------------------------------------------------
procedure TEditableRaster.CopiarSeleccion;
var Lineas: TStringList;
begin
if SeleccionValida then
   begin
   //Lineas := TStringList.Create;
   FuenteDeDatos.CopiarDatos(AreaSeleccionada);
   Lineas := FuenteDeDatos.TextoDelAreaSeleccionada(AreaSeleccionada);    //Extrae el texto del area seleccionada.
   ClipBoard.SetTextBuf(PChar(Lineas.Text));                              //Copia el texto seleccionado al portapapeles.
   Repaint;
   end;
end;

//-------------------------------------------------------------------
// Copia el rectángulo seleccionado.
//-------------------------------------------------------------------
procedure TEditableRaster.CortarSeleccion;
var Lineas: TStringList;
begin
if SeleccionValida then
   begin
   //Lineas := TStringList.Create;
   FuenteDeDatos.CopiarDatos(AreaSeleccionada);
   Lineas := FuenteDeDatos.TextoDelAreaSeleccionada(AreaSeleccionada);    //Extrae el texto del area seleccionada.
   ClipBoard.SetTextBuf(PChar(Lineas.Text));                              //Copia el texto seleccionado al portapapeles.
   FuenteDeDatos.EliminarDatos(AreaSeleccionada);
   Desseleccionar;
   CrearDibujoDelRaster;
   end;
end;

//-------------------------------------------------------------------
// Pega el rectángulo copiado en el raster en la posición indicada.
//-------------------------------------------------------------------
procedure TEditableRaster.PegarSeleccionCopiada;
var Inicio, X, Y: Integer;
begin
if SeleccionValida then
   begin
   FuenteDeDatos.PegarDatosCopiados(AreaSeleccionada.Inicio);
   end
else
   begin
   if (VisibleRaster.Y < 0) then Y := 0 else Y := VisibleRaster.Y;
   if (VisibleRaster.X < 0) then X := 0 else X := VisibleRaster.X;
   Inicio := (Y * PeriodoActual) + X;
   FuenteDeDatos.PegarDatosCopiados(Inicio);
   end;
Desseleccionar;
CrearDibujoDelRaster;
end;

//-------------------------------------------------------------------
// Inserta caracteres en el raster en la posición indicada.
//-------------------------------------------------------------------
procedure TEditableRaster.InsertarCaracteres(Lugar: TLugar; Cadena: AnsiString);
begin
if SeleccionValida then
   begin
   FuenteDeDatos.InsertarDatos(AreaSeleccionada.Inicio, Lugar, Cadena);
   Desseleccionar;
   CrearDibujoDelRaster;
   end;
end;


//-------------------------------------------------------------------
// Inserta caracteres en el raster en la posición indicada.
//-------------------------------------------------------------------
procedure TEditableRaster.FiltrarDatos;
begin
FuenteDeDatos.FiltrarDatos;
Desseleccionar;
CrearDibujoDelRaster;
end;

//-------------------------------------------------------------------
// Cambiar la cantidad de símbolos.
//-------------------------------------------------------------------
procedure TEditableRaster.EstablecerCantidadDeSimbolos(Cantidad: Integer);
begin
if (Cantidad >= 2) and (Cantidad <= 32) then
   begin
   FuenteDeDatos.CambiarCantidadDeSimbolos(Cantidad);
   CreateColors(FuenteDeDatos.OptenerCantidadDeSimbolos);
   Desseleccionar;
   CrearDibujoDelRaster;
   end
else
   Application.MessageBox('Solo se admiten números enteros entre 2 y 32.', 'DATOS INCORRECTOS', MB_ICONERROR)
end;

//-------------------------------------------------------------------
// Recalcular la cantidad de símbolos actual del raster.
//-------------------------------------------------------------------
procedure TEditableRaster.CalcularLaCantidadDeSimbolosActualDelRaster;
begin
CreateColors(FuenteDeDatos.ContarSimbolos);
Desseleccionar;
CrearDibujoDelRaster;
end;


//-------------------------------------------------------------------
// Cambiar el período.
//-------------------------------------------------------------------
procedure TEditableRaster.NuevoPeriodo(Cantidad: Integer);
begin
if not FuenteDeDatos.Valido then Exit;
if (Cantidad >= 2) and (Cantidad <= 2048) then
   begin
   PeriodoActual := Cantidad;
   Desseleccionar;
   CrearDibujoDelRaster;
   end
else
   Application.MessageBox('Solo se admiten números enteros entre 2 y 2048.', 'DATOS INCORRECTOS', MB_ICONERROR)
end;

//-------------------------------------------------------------------
// Cambiar el desplazamiento.
//-------------------------------------------------------------------
procedure TEditableRaster.SumarAlDesplazamiento(Cantidad: Integer);
begin
if not FuenteDeDatos.Valido then Exit;
DesplazamientoHorizontal := DesplazamientoHorizontal - Cantidad;
Desseleccionar;
CrearDibujoDelRaster;
end;

//-------------------------------------------------------------------
// Cambiar el desplazamiento.
//-------------------------------------------------------------------
procedure TEditableRaster.NuevoDesplazamiento(Cantidad: Integer);
begin
if not FuenteDeDatos.Valido then Exit;
DesplazamientoHorizontal := Cantidad * -1;
Desseleccionar;
CrearDibujoDelRaster;
end;


//-------------------------------------------------------------------
// Cambiar el color del raster.
//-------------------------------------------------------------------
procedure TEditableRaster.CambiarColores;
begin
if not FuenteDeDatos.Valido then Exit;
if ScaleColor = TwoColor then ScaleColor := RainbowColor else ScaleColor := TwoColor;
CreateColors(FuenteDeDatos.OptenerCantidadDeSimbolos);
CrearDibujoDelRaster;
end;

//-------------------------------------------------------------------
// Ir a la coordenada.
//-------------------------------------------------------------------
procedure TEditableRaster.CentrarCoordenada(Coordenada: Tpoint);
begin
if not FuenteDeDatos.Valido then Exit;
if Assigned(Copia) then
   begin
   VisibleRaster.X := Round(Coordenada.X - (Copia.Width / PixelSize / 2));
   VisibleRaster.Y := Round(Coordenada.Y - (Copia.Height / PixelSize / 2));
   CrearDibujoDelRaster;
   end;
end;

//-------------------------------------------------------------------
// Centrar raster.
//-------------------------------------------------------------------
procedure TEditableRaster.AjustarAncho;
begin
if not FuenteDeDatos.Valido then Exit;
if Assigned(Copia) then
   begin
   VisibleRaster.X := 0;
   VisibleRaster.Y := 0;
   PixelSize := Width div PeriodoActual;
   CrearDibujoDelRaster;
   end;
end;

//-------------------------------------------------------------------
// Permiten Deshacer y Rehacer los cambios realizados al raster.
//-------------------------------------------------------------------
procedure TEditableRaster.Deshacer;
begin
if not FuenteDeDatos.Valido then Exit;
FuenteDeDatos.EstadoAnterior;
CrearDibujoDelRaster;
end;

procedure TEditableRaster.Rehacer;
begin
if not FuenteDeDatos.Valido then Exit;
FuenteDeDatos.EstadoSiguiente;
CrearDibujoDelRaster;
end;


//-------------------------------------------------------------------
// Aumenta y diminuye el tamaño de los pixeles del raster.
//-------------------------------------------------------------------
procedure TEditableRaster.AumentarAnchoDePixel;
begin
if not FuenteDeDatos.Valido then Exit;
if Assigned(Copia) then
   if PixelSize < 20 then
      begin
      Inc(PixelSize);
      if SeleccionValida then
         begin
         VisibleRaster.X := Seleccion.Left;
         VisibleRaster.Y := Seleccion.Top;
         end
      else
         begin
         VisibleRaster.X := 0;
         VisibleRaster.Y := 0;
         end;
      CrearDibujoDelRaster;
      end;
end;

procedure TEditableRaster.DisminuirAnchoDePixel;
begin
if not FuenteDeDatos.Valido then Exit;
if Assigned(Copia) then
   if PixelSize > 1 then
      begin
      Dec(PixelSize);
      if SeleccionValida then
         begin
         VisibleRaster.X := Seleccion.Left;
         VisibleRaster.Y := Seleccion.Top;
         end
      else
         begin
         VisibleRaster.X := 0;
         VisibleRaster.Y := 0;
         end;
      CrearDibujoDelRaster;
      end;
end;


//-------------------------------------------------------------------
// Realizan los movimientos del raster.
//-------------------------------------------------------------------
procedure TEditableRaster.MoverIzquierda(Posiciones: Integer);
begin
if not FuenteDeDatos.Valido then Exit;
Inc(VisibleRaster.X, Posiciones);
CrearDibujoDelRaster;
end;

procedure TEditableRaster.MoverDerecha(Posiciones: Integer);
begin
if not FuenteDeDatos.Valido then Exit;
Dec(VisibleRaster.X, Posiciones);
CrearDibujoDelRaster;
end;

procedure TEditableRaster.MoverArriba(Posiciones: Integer);
begin
if not FuenteDeDatos.Valido then Exit;
Inc(VisibleRaster.Y, Posiciones);
CrearDibujoDelRaster;
end;

procedure TEditableRaster.MoverAbajo(Posiciones: Integer);
begin
if not FuenteDeDatos.Valido then Exit;
Dec(VisibleRaster.Y, Posiciones);
CrearDibujoDelRaster;
end;

procedure TEditableRaster.MoverInicio;
begin
if not FuenteDeDatos.Valido then Exit;
VisibleRaster.x := 0;
VisibleRaster.Y := 0;
CrearDibujoDelRaster;
end;

procedure TEditableRaster.MoverFinal;
begin
if not FuenteDeDatos.Valido then Exit;
VisibleRaster.x := PeriodoActual - Columnas + 2;
VisibleRaster.Y := LongitudTotal - Lineas + 3;
CrearDibujoDelRaster;
end;

procedure TEditableRaster.PageUp;
begin
if not FuenteDeDatos.Valido then Exit;
MoverArriba(Lineas div 2);
end;

procedure TEditableRaster.PageDown;
begin
if not FuenteDeDatos.Valido then Exit;
MoverAbajo(Lineas div 2);
end;

procedure TEditableRaster.PageLeft;
begin
if not FuenteDeDatos.Valido then Exit;
MoverIzquierda(Lineas div 2);
end;

procedure TEditableRaster.PageRight;
begin
if not FuenteDeDatos.Valido then Exit;
MoverDerecha(Lineas div 2);
end;

//-------------------------------------------------------------------
// Diálogo que pide un caracter para llenar la selección.
//-------------------------------------------------------------------
procedure TEditableRaster.PedirCaracterParaLlenarSeleccion;
const Separacion = 3;
var
  Form: TForm;
  Edit: TEdit;
  Button1, Button2: TButton;
  r: String;
begin
if not FuenteDeDatos.Valido then Exit;
  Form := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      BorderStyle := bsDialog;
      Caption := 'Llenar selección con:';
      Position := poScreenCenter;
      Edit := TEdit.Create(Form);
      with Edit do
           begin
           Parent := Form;
           Left := Separacion;
           Top := Separacion;
           Width := 25;
           MaxLength := 1;
           Text := '';
           SelectAll;
           ShowHint := True;
           Hint := 'Inserte aquí el caracter.';
           end;
      Button1 := TButton.Create(Form);
      with Button1 do
           begin
           Parent := Form;
           Caption := 'Aceptar';
           ModalResult := mrOk;
           Default := True;
           SetBounds(Edit.Left + Edit.Width + Separacion, Separacion, 60, 21);
           ShowHint := True;
           Hint := 'Clic aquí para insertar el caracter.';
           end;
      Button2 := TButton.Create(Form);
      with Button2 do
           begin
           Parent := Form;
           Caption := 'Cancelar';
           ModalResult := mrCancel;
           Cancel := True;
           SetBounds(Button1.Left + Button1.Width + Separacion, Separacion, 60, 21);
           ShowHint := True;
           Hint := 'Clic aquí para cancelar la operación.';
           Form.ClientHeight := Top + Height + Separacion;
           Form.ClientWidth := Left + Width + Separacion;
           end;
      if ShowModal = mrOk then
         begin
         r := Edit.Text;
         if r <> '' then LlenarSeleccionCon(Ord(r[1]));
         end;
    finally
      Form.Free;
    end;
end;


//-------------------------------------------------------------------
// Diálogo que pide caracter para insertar en una posición.
//-------------------------------------------------------------------
procedure TEditableRaster.PedirCaracteresParaInsertar;
const Separacion = 3;
var
  Form: TForm;
  Memo: TMemo;
  Combo: TComboBox;
  Button1, Button2: TButton;
  Posicion: TLugar;
  r: String;
begin
if not FuenteDeDatos.Valido then Exit;
  Form := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      BorderStyle := bsDialog;
      Caption := 'Insertar los siguientes caracteres:';
      Position := poScreenCenter;
      Memo := TMemo.Create(Form);
      with Memo do
           begin
           Parent := Form;
           Left := Separacion;
           Top := Separacion;
           Height := 100;
           Width := 25;
           MaxLength := 0;
           Lines.Clear;
           WordWrap := True;
           ScrollBars := ssBoth;
           ShowHint := True;
           Hint := 'Teclee aquí los caracteres que desea insertar.';
           SelectAll;
           end;
      Combo := TComboBox.Create(Form);
      with Combo do
           begin
           Parent := Form;
           Left := Separacion;
           Top := Memo.Top + Memo.Height + Separacion;
           Width := 200;
           Items.Add('Insertar antes de la posición');
           Items.Add('Insertar después de la posición');
           ItemIndex := 0;
           ShowHint := True;
           Hint := 'Posición con respecto al punto seleccionado.';
           SelectAll;
           end;
      Button1 := TButton.Create(Form);
      with Button1 do
           begin
           Parent := Form;
           Caption := 'Aceptar';
           ModalResult := mrOk;
           Default := True;
           SetBounds(Combo.Left + Combo.Width + Separacion, Memo.Top + Memo.Height + Separacion, 60, 20);
           ShowHint := True;
           Hint := 'Clic aquí para insertar los caracteres.';
           end;
      Button2 := TButton.Create(Form);
      with Button2 do
           begin
           Parent := Form;
           Caption := 'Cancelar';
           ModalResult := mrCancel;
           Cancel := True;
           SetBounds(Button1.Left + Button1.Width + Separacion, Memo.Top + Memo.Height + Separacion, 60, 20);
           Memo.Width := Button2.Left + Button2.Width - Separacion;
           Form.ClientHeight := Top + Height + Separacion;
           Form.ClientWidth := Left + Width + Separacion;
           ShowHint := True;
           Hint := 'Clic aquí para cancelar la operación.';
           end;
      if ShowModal = mrOk then
         begin
         r := Memo.Text;
         if Combo.ItemIndex = 1 then
            Posicion := DetrasDelCaracter
         else
            Posicion := DelanteDelCaracter;
         if r <> '' then InsertarCaracteres(Posicion, r);
         end;
    finally
      Form.Free;
    end;
end;




//-------------------------------------------------------------------
// Diálogo que pide caracter para insertar en una posición.
//-------------------------------------------------------------------
procedure TEditableRaster.MostrarLeyenda;
const Separacion = 3;
var Form: TForm;
    Grid: TStringGrid;
    Button: TButton;
    simbolos: Integer;
begin
if not FuenteDeDatos.Valido then Exit;
simbolos := FuenteDeDatos.OptenerCantidadDeSimbolos;
  Form := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      BorderStyle := bsDialog;
      Caption := 'Leyenda:';
      Position := poScreenCenter;
      Grid := TStringGrid.Create(Form);
      with Grid do
           begin
           Parent := Form;
           Left := Separacion;
           Top := Separacion;
           RowCount := simbolos + 2;
           ColCount := 2;
           FixedCols := 0;
           FixedRows := 1;
           DefaultColWidth := 55;
           DefaultRowHeight := 15;
           ClientHeight := (DefaultRowHeight + GridLineWidth) * (simbolos + 1) + 2;
           ClientWidth := DefaultColWidth * 2 - 10;
           Cells[0, 0] := 'Color';
           Cells[1, 0] := 'Símbolo';
           Cells[1, 1] := '0';
           Cells[1, 2] := '1';
           Cells[1, 3] := '2';
           Cells[1, 4] := '3';
           Cells[1, 5] := '4';
           Cells[1, 6] := '5';
           Cells[1, 7] := '6';
           Cells[1, 8] := '7';
           Cells[1, 9] := '8';
           Cells[1, 10] := '9';
           Cells[1, 11] := 'A';
           Cells[1, 12] := 'B';
           Cells[1, 13] := 'C';
           Cells[1, 14] := 'D';
           Cells[1, 15] := 'E';
           Cells[1, 16] := 'F';
           Cells[1, 17] := 'G';
           Cells[1, 18] := 'H';
           Cells[1, 19] := 'I';
           Cells[1, 20] := 'J';
           Cells[1, 21] := 'K';
           Cells[1, 22] := 'L';
           Cells[1, 23] := 'M';
           Cells[1, 24] := 'N';
           Cells[1, 25] := 'O';
           Cells[1, 26] := 'P';
           Cells[1, 27] := 'Q';
           Cells[1, 28] := 'R';
           Cells[1, 29] := 'S';
           Cells[1, 30] := 'T';
           Cells[1, 31] := 'U';
           Cells[1, 32] := 'V';
           Cells[1, simbolos + 1] := 'No válidos';
           OnDrawCell := StringGrid1DrawCell;
           end;
      Button := TButton.Create(Form);
      with Button do
           begin
           Parent := Form;
           Caption := 'Aceptar';
           ModalResult := mrOk;
           Default := True;
           SetBounds(5, Grid.Top + Grid.Height + Separacion, Grid.Width, 20);
           ShowHint := True;
           Hint := 'Cerrar leyenda';
           end;
      ClientWidth := Grid.Left + Grid.Width + Separacion;
      ClientHeight := Button.Top + Button.Height + Separacion;
      ShowModal;
    finally
      Form.Free;
    end;
end;

procedure TEditableRaster.StringGrid1DrawCell(Sender: TObject; Col, Row: Integer; Rect: TRect; State: TGridDrawState);
begin
if (Col = 0)and(Row > 0)then
   begin
   if (Row <= FuenteDeDatos.OptenerCantidadDeSimbolos) then
      TStringGrid(Sender).Canvas.Brush := BrushColors[Row - 1]
   else
      TStringGrid(Sender).Canvas.Brush.Color := ColorDeCaracteresNoValidos;
   TStringGrid(Sender).Canvas.FillRect(Rect);
   end;
end;

//-------------------------------------------------------------------
// Diálogo que pide el período nuevo.
//-------------------------------------------------------------------
procedure TEditableRaster.PedirPeriodo;
const Separacion = 3;
var Form: TForm;
    Edit: TEdit;
    Button1, Button2: TButton;
    r: Integer;
begin
if not FuenteDeDatos.Valido then Exit;
  Form := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      BorderStyle := bsDialog;
      Caption := 'Nuevo período:';
      Position := poScreenCenter;
      Edit := TEdit.Create(Form);
      with Edit do
           begin
           Parent := Form;
           Left := Separacion;
           Top := Separacion;
           Width := 100;
           MaxLength := 0;
           Text := '';
           SelectAll;
           ShowHint := True;
           Hint := 'Inserte aquí el nuevo período.';
           end;
      Button1 := TButton.Create(Form);
      with Button1 do
           begin
           Parent := Form;
           Caption := 'Aceptar';
           ModalResult := mrOk;
           Default := True;
           SetBounds(Edit.Left + Edit.Width + Separacion, Separacion, 60, 21);
           ShowHint := True;
           Hint := 'Clic aquí para cambiar el período.';
           end;
      Button2 := TButton.Create(Form);
      with Button2 do
           begin
           Parent := Form;
           Caption := 'Cancelar';
           ModalResult := mrCancel;
           Cancel := True;
           SetBounds(Button1.Left + Button1.Width + Separacion, Separacion, 60, 21);
           ShowHint := True;
           Hint := 'Clic aquí para cancelar la operación.';
           Form.ClientHeight := Top + Height + Separacion;
           Form.ClientWidth := Left + Width + Separacion;
           end;
      if ShowModal = mrOk then
         begin
         try
            r := StrToInt(Edit.Text);
         except
            Application.MessageBox('Solo se admiten números enteros.', 'DATOS INCORRECTOS', MB_ICONERROR);
            Exit;
         end;
         NuevoPeriodo(r);
         end;
    finally
      Form.Free;
    end;
end;


//-------------------------------------------------------------------
// Diálogo que pide la cantidad de símbolos.
//-------------------------------------------------------------------
procedure TEditableRaster.PedirCantidadDeSimbolos;
const Separacion = 3;
var
  Form: TForm;
  Edit: TEdit;
  Button1, Button2: TButton;
  r: Integer;
begin
if not FuenteDeDatos.Valido then Exit;
  Form := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      BorderStyle := bsDialog;
      Caption := 'Cantidad de símbolos:';
      Position := poScreenCenter;
      Edit := TEdit.Create(Form);
      with Edit do
           begin
           Parent := Form;
           Left := Separacion;
           Top := Separacion;
           Width := 100;
           MaxLength := 0;
           Text := '';
           SelectAll;
           ShowHint := True;
           Hint := 'Inserte aquí la nueva cantidad de símbolos.';
           end;
      Button1 := TButton.Create(Form);
      with Button1 do
           begin
           Parent := Form;
           Caption := 'Aceptar';
           ModalResult := mrOk;
           Default := True;
           SetBounds(Edit.Left + Edit.Width + Separacion, Separacion, 60, 21);
           ShowHint := True;
           Hint := 'Clic aquí para cambiar la cantidad de símbolos.';
           end;
      Button2 := TButton.Create(Form);
      with Button2 do
           begin
           Parent := Form;
           Caption := 'Cancelar';
           ModalResult := mrCancel;
           Cancel := True;
           SetBounds(Button1.Left + Button1.Width + Separacion, Separacion, 60, 21);
           ShowHint := True;
           Hint := 'Clic aquí para cancelar la operación.';
           Form.ClientHeight := Top + Height + Separacion;
           Form.ClientWidth := Left + Width + Separacion;
           end;
      if ShowModal = mrOk then
         begin
         try
            r := StrToInt(Edit.Text);
         except
            Application.MessageBox('Solo se admiten números enteros.', 'DATOS INCORRECTOS', MB_ICONERROR);
            Exit;
         end;
         EstablecerCantidadDeSimbolos(r);
         end;
    finally
      Form.Free;
    end;
end;


//-------------------------------------------------------------------
// Diálogo que pide el desplazamiento.
//-------------------------------------------------------------------
procedure TEditableRaster.PedirDesplazamiento;
const Separacion = 3;
var
  Form: TForm;
  Edit: TEdit;
  Button1, Button2: TButton;
  r: Integer;
begin
if not FuenteDeDatos.Valido then Exit;
  Form := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      BorderStyle := bsDialog;
      Caption := 'Nuevo desplazamiento:';
      Position := poScreenCenter;
      Edit := TEdit.Create(Form);
      with Edit do
           begin
           Parent := Form;
           Left := Separacion;
           Top := Separacion;
           Width := 100;
           MaxLength := 0;
           Text := '';
           SelectAll;
           ShowHint := True;
           Hint := 'Desplazamiento del raster.';
           end;
      Button1 := TButton.Create(Form);
      with Button1 do
           begin
           Parent := Form;
           Caption := 'Aceptar';
           ModalResult := mrOk;
           Default := True;
           SetBounds(Edit.Left + Edit.Width + Separacion, Separacion, 60, 21);
           ShowHint := True;
           Hint := 'Clic aquí para cambiar el desplazamiento.';
           end;
      Button2 := TButton.Create(Form);
      with Button2 do
           begin
           Parent := Form;
           Caption := 'Cancelar';
           ModalResult := mrCancel;
           Cancel := True;
           SetBounds(Button1.Left + Button1.Width + Separacion, Separacion, 60, 21);
           ShowHint := True;
           Hint := 'Clic aquí para cancelar la operación.';
           Form.ClientHeight := Top + Height + Separacion;
           Form.ClientWidth := Left + Width + Separacion;
           end;
      if ShowModal = mrOk then
         begin
         try
            r := StrToInt(Edit.Text);
         except
            Application.MessageBox('Solo se admiten números enteros.', 'DATOS INCORRECTOS', MB_ICONERROR);
            Exit;
         end;
         SumarAlDesplazamiento(r);
         end;
    finally
      Form.Free;
    end;
end;


//-------------------------------------------------------------------
// Diálogo que muestra el texto del area seleccionada.
//-------------------------------------------------------------------
procedure TEditableRaster.MostrarTextoDeSeleccion;
const Separacion = 3;
var
  Form: TForm;
  Memo: TMemo;
  Button1: TButton;
begin
if not FuenteDeDatos.Valido then Exit;
  if not SeleccionValida then
     begin
     Application.MessageBox('Primero debe seleccionar los datos en el raster.', 'OPERACIÓN INCORRECTA', MB_OK);
     Exit;
     end;
  Form := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      BorderStyle := bsSizeable;
      Caption := 'Texto del area seleccionada:';
      Position := poScreenCenter;
      ClientHeight := 135;
      ClientWidth := 250;
      Button1 := TButton.Create(Form);
      with Button1 do
           begin
           Parent := Form;
           Caption := 'Cerrar';
           ModalResult := mrOk;
           Default := True;
           SetBounds(Separacion, Form.ClientHeight - 20 - Separacion, 60, 20);
           ShowHint := True;
           Hint := 'Clic aquí para cerrar el diálogo.';
           Anchors := [akLeft, akBottom];
           end;
      Memo := TMemo.Create(Form);
      with Memo do
           begin
           DoubleBuffered := True;
           Anchors := [akTop, akLeft, akRight, akBottom];
           Parent := Form;
           Left := Separacion;
           Top := Separacion;
           Height := Button1.Top - Separacion * 2;
           Width := Form.ClientWidth - Separacion * 2;
           MaxLength := 0;
           Lines.Clear;
           WordWrap := False;
           ScrollBars := ssBoth;
           ShowHint := True;
           Hint := 'Muestra el texto del area seleccionada.';
           SelectAll;
           Font.Name := 'Terminal';
           Font.Size := 14;
           Lines := FuenteDeDatos.TextoDelAreaSeleccionada(AreaSeleccionada);
           end;
      ShowModal;
    finally
      Form.Free;
    end;
end;

//-------------------------------------------------------------------
// Actualiza la imagen del raster redibujándolo.
//-------------------------------------------------------------------
procedure TEditableRaster.ActualizarRaster;
begin
CrearDibujoDelRaster;
end;

//-------------------------------------------------------------------
// Actualiza los colores para la nueva cantidad de símbolos.
//-------------------------------------------------------------------
procedure TEditableRaster.ActualizarColores;
begin
CreateColors(FuenteDeDatos.OptenerCantidadDeSimbolos);
Desseleccionar;
CrearDibujoDelRaster;
end;

//-------------------------------------------------------------------
// Disminuye el período actual.
//-------------------------------------------------------------------
procedure TEditableRaster.DisminuirPeriodo;
begin
if not FuenteDeDatos.Valido then Exit;
if PeriodoActual > 2 then
   begin
   Dec(PeriodoActual);
   Desseleccionar;
   CrearDibujoDelRaster;
   end;
end;

//-------------------------------------------------------------------
// Aumenta el período actual.
//-------------------------------------------------------------------
procedure TEditableRaster.AumentarPeriodo;
begin
if not FuenteDeDatos.Valido then Exit;
if PeriodoActual < 2048 then
   begin
   Inc(PeriodoActual);
   Desseleccionar;
   CrearDibujoDelRaster;
   end;
end;

//-------------------------------------------------------------------
// Desplaza el raster a la izquierda.
//-------------------------------------------------------------------
procedure TEditableRaster.DesplazarIzquierda;
begin
if not FuenteDeDatos.Valido then Exit;
Inc(DesplazamientoHorizontal);
Desseleccionar;
CrearDibujoDelRaster;
end;

//-------------------------------------------------------------------
// Desplaza el raster a la izquierda.
//-------------------------------------------------------------------
procedure TEditableRaster.DesplazarDerecha;
begin
if not FuenteDeDatos.Valido then Exit;
Dec(DesplazamientoHorizontal);
Desseleccionar;
CrearDibujoDelRaster;
end;

//-------------------------------------------------------------------
// Devuelve el período actual del raster.
//-------------------------------------------------------------------
function TEditableRaster.ObtenerPeriodoActual;
begin
Result := PeriodoActual;
end;

end.
