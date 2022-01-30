/////////////////////////////////////////////////////////////////////
// Fecha: 6/11/2011                                                //
// Autor: Santiago A. Orellana Pérez                               //
// Fución: Implementa un componente que muestra el raster          //
//         de una demodulación, la cual se carga desde un          //
//         fichero tipo TXT.                                       //
/////////////////////////////////////////////////////////////////////


unit SimpleRaster;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Controls,
  Graphics,
  Dialogs,
  ExtCtrls,
  Math,
  HistoryDataManager;

const C_PERIODO_MINIMO = 2;
const C_PERIODO_MAXIMO = 2048;
const C_INCREMENTO_DE_LINEAS = 10;
const C_HANDLE_INVALIDO = $ffffffff;
const C_ARRASTRE_MAXIMO = 3;

type TScaleColor = (TwoColor, RainbowColor);

type
  TSimpleRaster = class(TCustomControl)
  private
     //Variables de Apariencia
     FColorDeAusencia: TColor;
     FColorDeCaracteresNoValidos: TColor;
     FScaleColor: TScaleColor;
     FScaleInitialColor: TColor;
     FScaleFinalColor: TColor;
     Copia: TBitmap;

     //Variables de Funcionamiento.
     FFuenteDeDatos: THistoryDataManager;        //Período actual en que se muestran los datos.
     FPeriodoActual: Integer;                    //Período actual en que se muestran los datos.
     FLineas: Integer;                           //Cantidad de líneas de datos que se muestran.
     mov_horizontal: Integer;
     mov_vertical: Integer;
     BrushColors: Array[0..31]of TColor;
     MouseDownX: Integer;
     MouseDownY: Integer;
     PAncho: Double;
     PAlto: Double;

     //Eventos nuevos de este componente.
     FOnAnyChange: TNotifyEvent;
     FOnPeriodChange: TNotifyEvent;
     FOnLoadDemodulationFile: TNotifyEvent;

     //Métodos de Apariencia.
     procedure SetScaleColor(Value:TScaleColor);
     procedure SetScaleInitialColor(Value:TColor);
     procedure SetScaleFinalColor(Value:TColor);

     //Métodos de Funcionamiento.
     procedure SetFuenteDeDatos(Value: THistoryDataManager);
     function GetFuenteDeDatos: THistoryDataManager;
     procedure SetPeriodoActual(Value:Integer);
     procedure SetLineas(Value:Integer);
     procedure FromFile(FileName: String);
     procedure CreateColors(CountSimbols: Byte);
     function GetTwoColorInterpolateRampScale(fraction:DOUBLE; Color1, Color2:TColor): TColor;
     function GetRainbowColorRampScale(valor: Double): TColor;

  protected
     procedure Click; override;
     procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
     procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
     procedure Paint; override;
     procedure ReSize; override;
     procedure GuardarImagen(nombre: String);
     procedure CrearImagenDelRaster;

  public
     constructor Create(AOwner:TComponent); override;
     constructor Iniciar(AOwner:TWinControl; Extender: Boolean; x, y, ancho, altura: Integer);  overload;
     constructor Iniciar(AOwner:TWinControl); overload;
     procedure Mostrar(pFuente: THistoryDataManager; pPeriodo, pDesplazamiento: Integer; UsarColor: Boolean);
     Destructor Destroy; override;
     procedure CargarDemodulacion(nombre: String);
     procedure BuscarYCargarDemodulacion;
     procedure SeleccionarRutaParaGuardarImagen;
     procedure MoverIzquierda(posiciones: Integer);
     procedure MoverDerecha(posiciones: Integer);
     procedure MoverArriba(posiciones: Integer);
     procedure MoverAbajo(posiciones: Integer);
     procedure CambiarColores;
     procedure AumentarPeriodo(posiciones: Integer);
     procedure DisminuirPeriodo(posiciones: Integer);
     procedure ReiniciarParametrosDelRaster;
     function DesplazamientoHorizontal: Integer;
     procedure ActualizarRaster;
     procedure ActualizarColores;

  published
     //Propiedades que hereda de sus ansestros.
     property TabOrder;
     property Action;
     property Align;
     property Anchors;
     property Visible;
     property Enabled;
     property Constraints;
     property ParentShowHint;
     property PopupMenu;
     property ShowHint;

     //Eventos que hereda de sus ansestros.
     property OnClick;
     property OnContextPopup;
     property OnDblClick;
     property OnMouseDown;
     property OnMouseMove;
     property OnMouseUp;
     property OnEnter;
     property OnExit;

     //Propiedades nuevas que implementa.
     property Periodo:Integer read FPeriodoActual Write SetPeriodoActual default 4;
     property Lineas:Integer read FLineas Write SetLineas default 100;
     property ScaleColor:TScaleColor read FScaleColor Write SetScaleColor default TwoColor;
     property ScaleInitialColor:TColor read FScaleInitialColor Write SetScaleInitialColor default clWhite;
     property ScaleFinalColor:TColor read FScaleFinalColor Write SetScaleFinalColor default clBlack;
     property FuenteDeDatos: THistoryDataManager read GetFuenteDeDatos Write SetFuenteDeDatos;

     //Nuevos eventos de este componente.
     property OnAnyChange:TNotifyEvent read FOnAnyChange Write FOnAnyChange;
     property OnPeriodChange:TNotifyEvent read FOnPeriodChange Write FOnPeriodChange;
     property OnLoadDemodulationFile:TNotifyEvent read FOnLoadDemodulationFile Write FOnLoadDemodulationFile;

  end;


implementation

uses Frame;


/////////////////////////////////////////////////////////////////////
// METODOS PÚBLICOS
/////////////////////////////////////////////////////////////////////


//-------------------------------------------------------------------
constructor TSimpleRaster.Create(AOwner:TComponent);
begin
inherited;                                             //Llama al método Create del ancestro (TCustomControl).
MouseDownX := MaxInt;  
MouseDownY := MaxInt;
DoubleBuffered := True;
Copia := TBitmap.Create;
Copia.Width := Width;
Copia.Height := Height;
FPeriodoActual := 4;
FLineas := 100;
FScaleColor := RainbowColor;
FScaleInitialColor := clBlack;
FScaleFinalColor := clWhite;
mov_horizontal := 0;
mov_vertical := 0;
Cursor := crHandPoint;
end;

//-------------------------------------------------------------------
// Se utiliza para iniciar el componente desde el código de forma simple.
//-------------------------------------------------------------------
constructor TSimpleRaster.Iniciar(AOwner:TWinControl; Extender: Boolean; x, y, ancho, altura: Integer);
begin
Parent := AOwner;
Left := x;
Top := y;
Width := ancho;
Height := altura;
if Extender then Align := alClient
end;

constructor TSimpleRaster.Iniciar(AOwner:TWinControl);
begin
Iniciar(AOwner, true, 0, 0, 10, 10);
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.CargarDemodulacion(nombre: String);
begin
if FileExists(nombre) then
   begin
   MouseDownX := MaxInt;  
   MouseDownY := MaxInt;
   mov_horizontal := 0;
   mov_vertical := 0;
   FromFile(nombre);                                                         //Carga datos de un fichero.
   CreateColors(FuenteDeDatos.OptenerCantidadDeSimbolos);                    //Crea los colores para representar los símbolos encontrados en los datos.
   CrearImagenDelRaster;
   if Assigned(FOnAnyChange) then FOnAnyChange(Self);                        //Informa el cambio.
   if Assigned(FOnLoadDemodulationFile) then FOnLoadDemodulationFile(Self);  //Informa el cambio.
   end;
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.Mostrar(pFuente: THistoryDataManager; pPeriodo, pDesplazamiento: Integer; UsarColor: Boolean);
begin
if Assigned(pFuente) then
   begin
   MouseDownX := MaxInt;
   MouseDownY := MaxInt;
   mov_horizontal := 0;
   mov_vertical := 0;
   FuenteDeDatos := pFuente;
   Periodo := pPeriodo;
   CreateColors(FuenteDeDatos.OptenerCantidadDeSimbolos);                    //Crea los colores para representar los símbolos encontrados en los datos.
   CrearImagenDelRaster;
   if Assigned(FOnAnyChange) then FOnAnyChange(Self);                        //Informa el cambio.
   if Assigned(FOnLoadDemodulationFile) then FOnLoadDemodulationFile(Self);  //Informa el cambio.
   end;
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.BuscarYCargarDemodulacion;
var dlg: TOpenDialog;
begin
dlg := TOpenDialog.Create(Self);                                               //Crea un diálogo.
dlg.Title := 'Buscar y cargar demodulación...';                                //Título del diálogo.
dlg.Filter := 'Ficheros de texto (*.txt)|*.TXT|Todos los ficheros (*.*)|*.*';  //Ficheros que se muestran.
if dlg.Execute then                                                            //
   if FileExists(dlg.FileName) then
      CargarDemodulacion(dlg.FileName);
dlg.Free;                                                                      //Libera el diálogo creado.
end;


//-------------------------------------------------------------------
procedure TSimpleRaster.MoverIzquierda(posiciones: Integer);
begin
Inc(mov_horizontal, posiciones);
CrearImagenDelRaster;
if Assigned(FOnAnyChange) then FOnAnyChange(Self);  //Informa el cambio.
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.MoverDerecha(posiciones: Integer);
begin
Dec(mov_horizontal, posiciones);
CrearImagenDelRaster;
if Assigned(FOnAnyChange) then FOnAnyChange(Self);  //Informa el cambio.
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.MoverArriba(posiciones: Integer);
begin
Inc(mov_vertical, posiciones);
CrearImagenDelRaster;
if Assigned(FOnAnyChange) then FOnAnyChange(Self);  //Informa el cambio.
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.MoverAbajo(posiciones: Integer);
begin
Dec(mov_vertical, posiciones);
CrearImagenDelRaster;
if Assigned(FOnAnyChange) then FOnAnyChange(Self);  //Informa el cambio.
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.AumentarPeriodo(posiciones: Integer);
begin
Inc(FPeriodoActual, posiciones);
CrearImagenDelRaster;
if Assigned(FOnAnyChange) then FOnAnyChange(Self);        //Informa el cambio.
if Assigned(FOnPeriodChange) then FOnPeriodChange(Self);  //Informa el cambio.
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.DisminuirPeriodo(posiciones: Integer);
begin
Dec(FPeriodoActual, posiciones);
CrearImagenDelRaster;
if Assigned(FOnAnyChange) then FOnAnyChange(Self);        //Informa el cambio.
if Assigned(FOnPeriodChange) then FOnPeriodChange(Self);  //Informa el cambio.
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.SeleccionarRutaParaGuardarImagen;
var dlg: TSaveDialog;
begin
dlg := TSaveDialog.Create(Self);                                                //Crea un diálogo.
dlg.InitialDir := MainForm.RutaParaGuardarImagenes;
dlg.Title := 'Guardar imagen...';                                               //Título del diálogo.
dlg.DefaultExt := 'BMP';                                                        //Si no se pone extensión, se toma esta.
dlg.Filter := 'Ficheros de imagen (*.bmp)|*.BMP|Todos los ficheros (*.*)|*.*';  //Ficheros que se muestran.
if dlg.Execute then                                                             //
   GuardarImagen(dlg.FileName);
dlg.Free;                                                                      //Libera el diálogo creado.
end;


//-------------------------------------------------------------------
// Guarda la imagen del raster.
//-------------------------------------------------------------------
procedure TSimpleRaster.GuardarImagen(nombre: String);
var bmp: TImage;
begin
if Assigned(Copia) then
   begin
   MainForm.RutaParaGuardarImagenes := nombre;
   bmp := TImage.Create(Self);
   bmp.Width := Copia.Width;
   bmp.Height := Copia.Height;
   bmp.Canvas.Draw(0, 0, Copia);         //Dibuja el raster.
   bmp.Picture.SaveToFile(nombre);
   bmp.Free;
   end;
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.ReiniciarParametrosDelRaster;
begin
FPeriodoActual := C_PERIODO_MINIMO;
mov_horizontal := 0;
mov_vertical := 0;
CrearImagenDelRaster;
if Assigned(FOnAnyChange) then FOnAnyChange(Self);  //Informa el cambio.
end;

//-------------------------------------------------------------------
Destructor TSimpleRaster.Destroy;
begin
inherited Destroy;
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.CambiarColores;
begin
if FScaleColor = TwoColor then
   FScaleColor := RainbowColor
else
   FScaleColor := TwoColor;
CreateColors(FuenteDeDatos.OptenerCantidadDeSimbolos);       //Crea los colores para representar los símbolos encontrados en los datos.
CrearImagenDelRaster;
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.SetFuenteDeDatos(Value: THistoryDataManager);
begin
if Value <> nil then FFuenteDeDatos := Value;
end;

//-------------------------------------------------------------------
function TSimpleRaster.GetFuenteDeDatos: THistoryDataManager;
begin
Result := FFuenteDeDatos;
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
inherited;
if Button = mbLeft then       //Si se presiona con el botón izquierdo:
   begin
   MouseDownX := X;           //Se guarda la coordenada del mouse.
   MouseDownY := Y;
   end
else                          //Si es otro botón:
   begin
   MouseDownX := MaxInt;      //Se indica mediante una coordenada inválida.
   MouseDownY := MaxInt;
   end;
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var dx, dy: Integer;
begin
inherited;
if (MouseDownX <> MaxInt)and(MouseDownY <> MaxInt) then     //Si se presionó el botón izquierdo:
   begin
   dx := X - MouseDownX;                                    //Se realiza el desplazamiento.
   dy := Y - MouseDownY;
   if (dx <> 0)or(dy <> 0) then
      begin
      mov_horizontal := mov_horizontal - Round(dx / PAncho);
      mov_vertical := mov_vertical - Round(dy / PAlto);
      CrearImagenDelRaster;
      if Assigned(FOnAnyChange) then FOnAnyChange(Self);    //Informa el cambio.
      end;
   end;
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.SetScaleColor(Value:TScaleColor);
begin
FScaleColor := Value;
CreateColors(FuenteDeDatos.OptenerCantidadDeSimbolos);
CrearImagenDelRaster;
if Assigned(FOnAnyChange) then FOnAnyChange(Self);  //Informa el cambio.
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.SetScaleInitialColor(Value:TColor);
begin
FScaleInitialColor := Value;
CreateColors(FuenteDeDatos.OptenerCantidadDeSimbolos);
CrearImagenDelRaster;
if Assigned(FOnAnyChange) then FOnAnyChange(Self);  //Informa el cambio.
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.SetScaleFinalColor(Value:TColor);
begin
FScaleFinalColor := Value;
CreateColors(FuenteDeDatos.OptenerCantidadDeSimbolos);
CrearImagenDelRaster;
if Assigned(FOnAnyChange) then FOnAnyChange(Self);  //Informa el cambio.
end;

//-------------------------------------------------------------------
procedure  TSimpleRaster.Click;
begin
inherited;
SetFocus;
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.SetPeriodoActual(Value:Integer);
begin
FPeriodoActual := Value;
CrearImagenDelRaster;
if Assigned(FOnAnyChange) then FOnAnyChange(Self);        //Informa el cambio.
if Assigned(FOnPeriodChange) then FOnPeriodChange(Self);  //Informa el cambio.
end;

//-------------------------------------------------------------------
function TSimpleRaster.DesplazamientoHorizontal: Integer;
begin
Result := mov_horizontal * -1;
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.SetLineas(Value:Integer);
begin
FLineas := Value;
CrearImagenDelRaster;
if Assigned(FOnAnyChange) then FOnAnyChange(Self);        //Informa el cambio.
if Assigned(FOnPeriodChange) then FOnPeriodChange(Self);  //Informa el cambio.
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.Paint;
begin
SetStretchBltMode(Canvas.Handle, COLORONCOLOR);
Canvas.CopyRect(ClientRect, Copia.Canvas, Rect(0, 0, Copia.Width, Copia.Height));
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.ReSize;
begin
Repaint;
end;

//-------------------------------------------------------------------
procedure TSimpleRaster.FromFile(FileName: String);
begin
if Assigned(FFuenteDeDatos) then
   FuenteDeDatos.CargarDemodulacion(FileName);
end;


//-------------------------------------------------------------------
procedure TSimpleRaster.CreateColors(CountSimbols: Byte);
var n: Integer;
begin
if CountSimbols > 0 then
   begin
   for n := 0 to 31 do
       begin
       BrushColors[n] := 0;
       case ScaleColor of
            TwoColor: begin
                      FColorDeAusencia := RGB(0, 0, 100);            //Azul oscuro.
                      FColorDeCaracteresNoValidos := clOlive;        //Verde oscuro.
                      if n < CountSimbols then
                         BrushColors[n] := GetTwoColorInterpolateRampScale(n / (CountSimbols - 1), ScaleInitialColor, ScaleFinalColor)
                      else
                         BrushColors[n] := FColorDeCaracteresNoValidos;
                      end;
            RainbowColor: begin
                          FColorDeAusencia := clBlack;               //Negro.
                          FColorDeCaracteresNoValidos := clGray;     //Griz.
                          if n < CountSimbols then
                             BrushColors[n] := GetRainbowColorRampScale(n / (CountSimbols - 1))
                          else
                             BrushColors[n] := FColorDeCaracteresNoValidos;
                          end;
            end;
       end;
   end;
end;


//-------------------------------------------------------------------
function TSimpleRaster.GetTwoColorInterpolateRampScale(fraction:Double; Color1, Color2:TColor): TColor;
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
      Result := RGB( Round(complement*R1 + fraction*R2),
                     Round(complement*G1 + fraction*G2),
                     Round(complement*B1 + fraction*B2));
      end
end;

//-------------------------------------------------------------------
function TSimpleRaster.GetRainbowColorRampScale(valor: Double): TColor;
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
procedure TSimpleRaster.CrearImagenDelRaster;
var n, m: Integer;
    pd: Integer;
begin
Copia.Width := FPeriodoActual;
Copia.Height := FLineas;
Copia.Canvas.Brush.Color := FColorDeAusencia;
Copia.Canvas.FillRect(Rect(0, 0, Copia.Width, Copia.Height));
PAncho := Width / Copia.Width;
PAlto := Height / Copia.Height;
if Assigned(FFuenteDeDatos) and (FuenteDeDatos.Longitud > 0) then
   begin
   for n := 0 to Copia.Height - 1 do                                                           //Por cada línea hace los siguiente:
       for m := 0 to Copia.Width - 1 do                                                        //Repite esto por cada columna de cada línea:
           begin
           pd := mov_horizontal + (mov_vertical * FPeriodoActual) + (n * FPeriodoActual)+ m;   //Calcula la posición del dato dentro del arreglo.
           if (pd >= 0)and(pd < FuenteDeDatos.Longitud) then
              case Chr(FuenteDeDatos.LeerDato(pd)) of
                   '0': Copia.Canvas.Pixels[m, n] := BrushColors[0];
                   '1': Copia.Canvas.Pixels[m, n] := BrushColors[1];
                   '2': Copia.Canvas.Pixels[m, n] := BrushColors[2];
                   '3': Copia.Canvas.Pixels[m, n] := BrushColors[3];
                   '4': Copia.Canvas.Pixels[m, n] := BrushColors[4];
                   '5': Copia.Canvas.Pixels[m, n] := BrushColors[5];
                   '6': Copia.Canvas.Pixels[m, n] := BrushColors[6];
                   '7': Copia.Canvas.Pixels[m, n] := BrushColors[7];
                   '8': Copia.Canvas.Pixels[m, n] := BrushColors[8];
                   '9': Copia.Canvas.Pixels[m, n] := BrushColors[9];
                   'A','a': Copia.Canvas.Pixels[m, n] := BrushColors[10];
                   'B','b': Copia.Canvas.Pixels[m, n] := BrushColors[11];
                   'C','c': Copia.Canvas.Pixels[m, n] := BrushColors[12];
                   'D','d': Copia.Canvas.Pixels[m, n] := BrushColors[13];
                   'E','e': Copia.Canvas.Pixels[m, n] := BrushColors[14];
                   'F','f': Copia.Canvas.Pixels[m, n] := BrushColors[15];
                   'G','g': Copia.Canvas.Pixels[m, n] := BrushColors[16];
                   'H','h': Copia.Canvas.Pixels[m, n] := BrushColors[17];
                   'I','i': Copia.Canvas.Pixels[m, n] := BrushColors[18];
                   'J','j': Copia.Canvas.Pixels[m, n] := BrushColors[19];
                   'K','k': Copia.Canvas.Pixels[m, n] := BrushColors[20];
                   'L','l': Copia.Canvas.Pixels[m, n] := BrushColors[21];
                   'M','m': Copia.Canvas.Pixels[m, n] := BrushColors[22];
                   'N','n': Copia.Canvas.Pixels[m, n] := BrushColors[23];
                   'O','o': Copia.Canvas.Pixels[m, n] := BrushColors[24];
                   'P','p': Copia.Canvas.Pixels[m, n] := BrushColors[25];
                   'Q','q': Copia.Canvas.Pixels[m, n] := BrushColors[26];
                   'R','r': Copia.Canvas.Pixels[m, n] := BrushColors[27];
                   'S','s': Copia.Canvas.Pixels[m, n] := BrushColors[28];
                   'T','t': Copia.Canvas.Pixels[m, n] := BrushColors[29];
                   'U','u': Copia.Canvas.Pixels[m, n] := BrushColors[30];
                   'V','v': Copia.Canvas.Pixels[m, n] := BrushColors[31];
                   else Copia.Canvas.Pixels[m, n] := FColorDeCaracteresNoValidos;
                   end;
           end;
   Invalidate;
   end;
end;

//-------------------------------------------------------------------
// Actualiza la imagen del raster redibujándolo.
//-------------------------------------------------------------------
procedure TSimpleRaster.ActualizarRaster;
begin
CrearImagenDelRaster;
end;

//-------------------------------------------------------------------
// Actualiza los colores para la nueva cantidad de símbolos.
//-------------------------------------------------------------------
procedure TSimpleRaster.ActualizarColores;
begin
CreateColors(FuenteDeDatos.OptenerCantidadDeSimbolos);
CrearImagenDelRaster;
end;



end.
