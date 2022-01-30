///////////////////////////////////////////////////////////////////////////
//      Objeto: TComparadorDeFicheros                                    //
//       Autor: Santiago A. Orellana Pérez.                              //
//       Fecha: 2011                                                     //
// Descripción: Compara dos ficheros.                                    //
///////////////////////////////////////////////////////////////////////////

unit UComparadorDeFicheros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, UDiff, ExtCtrls, ComCtrls;

const C_IGUALDAD_CARACTERES   = $AAFFAA;        //88FF88
const C_BORRADO_CARACTERES    = $AAAAFF;        //
const C_INSERCION_CARACTERES  = $33DDDD;        //
const C_CAMBIO_CARACTERES     = $FFAAAA;        //

const C_IGUALDAD_REFERENCIA   = $22DD22;        // 11FF11
const C_BORRADO_REFERENCIA    = $2222FF;        //
const C_INSERCION_REFERENCIA  = $22DDDD;        //
const C_CAMBIO_REFERENCIA     = $FF2222;        //

type TOrdenFichero = (ComoPrimero, ComoSegundo);
type TComparacion = (Igualdad, Borrado, Insercion, Cambio);

type TCaracterComparado = record
                          Caracter: Char;
                          Comparacion: TComparacion;
                          end;

type TArrayDeBytes = array of Byte;
type TArrayDeCaracterComparado = array of TCaracterComparado;

type TComparadorDeFicheros = class(TThread)
     private
        Datos1: TArrayDeBytes;
        Datos2: TArrayDeBytes;
        Cadena1: TArrayDeCaracterComparado;
        Cadena2: TArrayDeCaracterComparado;
        FInicioDeMuestra: Integer;
        FComparaciones: Integer;
        FDiferencias: Integer;
        FIgualdades: Integer;
        FBorrados: Integer;
        FInserciones: Integer;
        FCambios: Integer;
        procedure FiltrarDatos(Datos: TArrayDeBytes);
        procedure CargarFichero(FileName: String; Dato: TOrdenFichero);
        procedure Comparar;
        procedure MostrarCadena(PaintBox: TPaintBox; x,y: integer; Cadena: TArrayDeCaracterComparado);
        function DataX(GraficoDeReferencia: TPaintBox; ClicX: Integer): Integer;
        function ClicX(GraficoDeReferencia: TPaintBox; DataX: Integer): Integer;
     protected
        procedure Execute; override;
     public
        ColorDeIgualdadDeCaracteres: TColor;
        ColorDeBorradoDeCaracteres: TColor;
        ColorDeInsercionDeCaracteres: TColor;
        ColorDeCambioDeCaracteres: TColor;

        ColorDeIgualdadDeReferencia: TColor;
        ColorDeBorradoDeReferencia: TColor;
        ColorDeInsercionDeReferencia: TColor;
        ColorDeCambioDeReferencia: TColor;
        FileName1: String;
        FileName2: String;
        constructor Create;
        procedure DibujarGraficoDeComparacionEn(GraficoDeComparacion: TPaintBox);
        procedure DibujarGraficoDeReferenciaEn(GraficoDeReferencia: TPaintBox);
        Function ComparacionesRealizadas: Integer;
        Function DiferenciasEncontradas: Integer;
        Function IgualdadesEncontradas: Integer;
        Function CaracteresBorrados: Integer;
        Function CaracteresInsertados: Integer;
        Function CaracteresCambiados: Integer;
        function DesplazarIzquierda: Integer;
        function DesplazarDerecha: Integer;
        function DesplazarA(Posicion: Integer): Integer;
        function DesplazarAClic(GraficoDeReferencia: TPaintBox; ClicX: Integer): Integer;
        function Posicion: Integer;
        destructor Destroy;
     end;



implementation


//-------------------------------------------------------------------
// Crea un comparador de ficheros y lo prepara para trabajar.
//-------------------------------------------------------------------
constructor TComparadorDeFicheros.Create;
begin
ColorDeIgualdadDeCaracteres  := C_IGUALDAD_CARACTERES;       //Establece los colores por defecto
ColorDeBorradoDeCaracteres   := C_BORRADO_CARACTERES;
ColorDeInsercionDeCaracteres := C_INSERCION_CARACTERES;
ColorDeCambioDeCaracteres    := C_CAMBIO_CARACTERES;

ColorDeIgualdadDeReferencia  := C_IGUALDAD_REFERENCIA;       //Establece los colores por defecto
ColorDeBorradoDeReferencia   := C_BORRADO_REFERENCIA;
ColorDeInsercionDeReferencia := C_INSERCION_REFERENCIA;
ColorDeCambioDeReferencia    := C_CAMBIO_REFERENCIA;

FComparaciones := 0;
FreeOnTerminate := False;                //El objeto subproceso no se destruye al terminar.
inherited Create(True);                  //Crea el subproceso.
end;


//-------------------------------------------------------------------
// Destruye el comparador de ficheros.
//-------------------------------------------------------------------
destructor TComparadorDeFicheros.Destroy;
begin
Cadena1 := nil;
Cadena2 := nil;
inherited Destroy;
end;


//-------------------------------------------------------------------
// Inicia el funcionamiento del subproceso.
//-------------------------------------------------------------------
procedure TComparadorDeFicheros.Execute;
begin
Comparar;
end;

//-------------------------------------------------------------------
// Convierte la posición de dato en una posición de Clic.
//-------------------------------------------------------------------
function TComparadorDeFicheros.ClicX(GraficoDeReferencia: TPaintBox; DataX: Integer): Integer;
begin
Result := Round(((GraficoDeReferencia.Width - 2) / FComparaciones) * DataX);
end;

//-------------------------------------------------------------------
// Convierte la posición del Clic en una posición de cadena.
//-------------------------------------------------------------------
function TComparadorDeFicheros.DataX(GraficoDeReferencia: TPaintBox; ClicX: Integer): Integer;
begin
Result := Round((ClicX / (GraficoDeReferencia.Width - 2)) * FComparaciones);
end;


//-------------------------------------------------------------------
// Convierte la posición del Clic en una posición de cadena.
//-------------------------------------------------------------------
function TComparadorDeFicheros.DesplazarAClic(GraficoDeReferencia: TPaintBox; ClicX: Integer): Integer;
begin
if (ClicX > 1) and (ClicX < GraficoDeReferencia.ClientWidth - 2) then
   FInicioDeMuestra := DataX(GraficoDeReferencia, ClicX);
Result := FInicioDeMuestra;
end;


//-------------------------------------------------------------------
// Dibuja el los caracteres de los ficheros comparados mostrando
// en colores el resultado de la comparación.
//-------------------------------------------------------------------
procedure TComparadorDeFicheros.DibujarGraficoDeComparacionEn(GraficoDeComparacion: TPaintBox);
begin
GraficoDeComparacion.Canvas.Brush.Color := clWhite;
GraficoDeComparacion.Canvas.Pen.Color := clBlack;
GraficoDeComparacion.Canvas.Pen.Width := 1;
GraficoDeComparacion.Canvas.Rectangle(GraficoDeComparacion.ClientRect);
if FComparaciones > 0  then
   begin
   GraficoDeComparacion.Canvas.Pen.Width := 5;
   GraficoDeComparacion.Canvas.Pen.Color := clBlack;
   GraficoDeComparacion.Canvas.Brush.Color := clBlack;
   GraficoDeComparacion.Canvas.Rectangle(0, 0, 5, GraficoDeComparacion.ClientHeight - 1);
   MostrarCadena(GraficoDeComparacion, 8, 5, Cadena1);
   MostrarCadena(GraficoDeComparacion, 8, 25, Cadena2);
   end;
end;


//-------------------------------------------------------------------
// Dibuja el gráfico de referencia de la comparación de los ficheros
// mostrando en colores el resultado de la comparación.
//-------------------------------------------------------------------
procedure TComparadorDeFicheros.DibujarGraficoDeReferenciaEn(GraficoDeReferencia: TPaintBox);
var n, p: Integer;
begin
GraficoDeReferencia.Canvas.Pen.Width := 1;
GraficoDeReferencia.Canvas.Pen.Color := clBlack;
GraficoDeReferencia.Canvas.Brush.Color := clWhite;
GraficoDeReferencia.Canvas.Rectangle(GraficoDeReferencia.ClientRect);
if FComparaciones > 0 then
   begin
   for n := 1 to GraficoDeReferencia.ClientWidth - 2 do
       begin
       p := DataX(GraficoDeReferencia, n);
       case Cadena1[p].Comparacion of
            Igualdad:  GraficoDeReferencia.Canvas.Pen.Color := ColorDeIgualdadDeReferencia;
            Borrado:   GraficoDeReferencia.Canvas.Pen.Color := ColorDeBorradoDeReferencia;
            Insercion: GraficoDeReferencia.Canvas.Pen.Color := ColorDeInsercionDeReferencia;
            Cambio:    GraficoDeReferencia.Canvas.Pen.Color := ColorDeCambioDeReferencia;
            end;
       GraficoDeReferencia.Canvas.MoveTo(n, 1);
       GraficoDeReferencia.Canvas.LineTo(n, GraficoDeReferencia.ClientHeight - 1);
       end;
   p := ClicX(GraficoDeReferencia, FInicioDeMuestra);
   GraficoDeReferencia.Canvas.Pen.Width := 5;    
   GraficoDeReferencia.Canvas.Pen.Color := clBlack;
   GraficoDeReferencia.Canvas.MoveTo(p, 1);
   GraficoDeReferencia.Canvas.LineTo(p, GraficoDeReferencia.ClientHeight - 2);
   end;
end;

//------------------------------------------------------------------------------
// Dibuja una cadena de texto en un Canvas.
//------------------------------------------------------------------------------
procedure TComparadorDeFicheros.MostrarCadena(PaintBox: TPaintBox; x,y: integer; Cadena: TArrayDeCaracterComparado);
var n: integer;
    savedPt: TPoint;
    Caracter: TCaracterComparado;
    Final: Integer;
begin
if (FInicioDeMuestra < Length(Cadena) - 1) and
   (FInicioDeMuestra >= 0) and
   (Length(Cadena) > 0) then
   begin
   PaintBox.Canvas.Font.Size := 14;
   SetTextAlign(PaintBox.canvas.Handle, TA_UPDATECP);       //Selecciona el tipo de alineación del texto.
   MoveToEx(PaintBox.canvas.Handle, x, y, @savedPt);        //Mueve a pa posición de inpresión del texto.
   SetTextColor(PaintBox.canvas.handle, clBlack);           //Selecciona el color de los caracteres.
   SetTextCharacterExtra(PaintBox.canvas.handle, 5);        //Le agrega 5 píxeles de ancho a cada caracter.
   Final := 0;
   for n := FInicioDeMuestra to Length(Cadena) - 1 do
       begin
       Caracter :=Cadena[n];
       case Caracter.Comparacion of
            Igualdad:  SetBkColor(PaintBox.canvas.handle, ColorDeIgualdadDeCaracteres);
            Borrado:   SetBkColor(PaintBox.canvas.handle, ColorDeBorradoDeCaracteres);
            Insercion: SetBkColor(PaintBox.canvas.handle, ColorDeInsercionDeCaracteres);
            Cambio:    SetBkColor(PaintBox.canvas.handle, ColorDeCambioDeCaracteres);
            end;
       if Final + PaintBox.canvas.TextWidth(Caracter.Caracter) >= PaintBox.Width - 6 then Break;
       TextOut(PaintBox.canvas.handle, 0, 0, @Caracter.Caracter, 1);                       
       Inc(Final, PaintBox.canvas.TextWidth(Caracter.Caracter));
       end;
   end;
end;

//-------------------------------------------------------------------
// Elimina los caracteres que no son vñalidos para una demodulación.
//-------------------------------------------------------------------
procedure TComparadorDeFicheros.FiltrarDatos(Datos: TArrayDeBytes);
var n: Integer;
begin
if Assigned(Datos) then
   for n := 0 to Length(Datos) - 1 do
       begin
       if Terminated then Exit;
       if (Datos[n] < $21)or(Datos[n] > $7E) then Datos[n] := Ord('?');     //Sustituye los caracteres no válidos por un caracter nulo.
       end;
end;

//-------------------------------------------------------------------
// Carga los datos de un fichero al arreglo "Datos1" o "Datos1".
// Los parámetros son los siguientes:
//
// FileName: Nombre del fichero.
// Dato: Arreglo en el que se carga el fichero (1 o 2).
//-------------------------------------------------------------------
procedure TComparadorDeFicheros.CargarFichero(FileName: String; Dato: TOrdenFichero);
var stream: TStream;
begin
if Terminated then Exit;
if not FileExists(FileName) then Exit;
stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
case Dato of
     ComoPrimero: begin
                  if Datos1 <> nil then Datos1 := nil;
                  SetLength(Datos1, TFileStream(stream).Size);
                  try stream.ReadBuffer(Datos1[0], TFileStream(stream).Size) finally stream.Free end;
                  end;
     ComoSegundo: begin
                  if Datos2 <> nil then Datos2 := nil;
                  SetLength(Datos2, TFileStream(stream).Size);
                  try stream.ReadBuffer(Datos2[0], TFileStream(stream).Size) finally stream.Free end;
                  end;
     end;
end;


//------------------------------------------------------------------------------
// Compara dos ficheros.
// Chequea constantemente lavariable Terminated para salir si el usuario
// requiere detener el subproceso de comparación.
//------------------------------------------------------------------------------
procedure TComparadorDeFicheros.Comparar;
var i: Integer;
    lastKind: TChangeKind;
    Diff: TDiff;

  procedure AddCharToList(i: Integer; var Cadena: TArrayDeCaracterComparado; c: char; kind, lastkind: TChangeKind);
  begin
  if Terminated then Exit;
  Cadena[i].Caracter := c;
  case Kind of
       ckNone:   Cadena[i].Comparacion := Igualdad;
       ckDelete: Cadena[i].Comparacion := Borrado;
       ckAdd:    Cadena[i].Comparacion := Insercion;
       ckModify: Cadena[i].Comparacion := Cambio;
       end;
  end;

begin
if Terminated then Exit;
FComparaciones := 0;
FIgualdades := 0;
FDiferencias := 0;
FBorrados := 0;
FInserciones := 0;
FCambios := 0;
FInicioDeMuestra := 0;                                                            //Inicia el controlador de desplazamiento.
CargarFichero(FileName1, ComoPrimero);                                            //Carga el primer fichero.
CargarFichero(FileName2, ComoSegundo);                                            //Carga el segundo fichero.
FiltrarDatos(Datos1);
FiltrarDatos(Datos2);
if Terminated then Exit;
if (Datos1 = nil) or (Datos2 = nil) then Exit;                                    //Si los ficheros no han sido cargados, abandona el algoritmo.
Diff := TDiff.Create(@Terminated);                                                //Crea un objeto tipo TDiff.
Diff.Execute(pchar(Datos1), pchar(Datos2), length(Datos1), length(Datos2));       //Realiza la comparación.
if Terminated then Exit;
Datos1 := nil;                                                                    //Libera el espacio guardado para el fichero 1.
Datos2 := nil;                                                                    //Libera el espacio guardado para el fichero 2.
Cadena1 := nil;                                                                   //Vacía la cadena 1.
Cadena2 := nil;
SetLength(Cadena1, Diff.count + 1);                                               //Redimensiona la cedena 1.
SetLength(Cadena2, Diff.count + 1);                                               //Redimensiona la cedena 2.
lastKind := ckNone;
if Terminated then Exit;
for i := 0 to Diff.count-1 do                                                     //Copia el resultado de la comparación.
    begin
    if Terminated then Exit;
    if Diff.Compares[i].Kind = ckAdd then
       AddCharToList(i, cadena1 , ' ', Diff.Compares[i].Kind, lastKind)
    else
       AddCharToList(i, cadena1 , Diff.Compares[i].chr1, Diff.Compares[i].Kind, lastKind);
    if Diff.Compares[i].Kind = ckDelete then
       AddCharToList(i, cadena2 , ' ', Diff.Compares[i].Kind, lastKind)
    else
       AddCharToList(i, cadena2 , Diff.Compares[i].chr2, Diff.Compares[i].Kind, lastKind);
    lastKind := Diff.Compares[i].Kind;
    end;
if Terminated then Exit;
FComparaciones := Diff.Count;                                                     //Guarda la cantidad de comparaciones.
FIgualdades := Diff.DiffStats.matches;                                            //Guarda la cantidad de coincidencias encontradas.
with Diff.DiffStats do FDiferencias := modifies + adds + deletes;                 //Guarda la cantidad de diferencias encontradas.
FBorrados := Diff.DiffStats.deletes;
FInserciones := Diff.DiffStats.adds;
FCambios := Diff.DiffStats.modifies;
Diff.Free;                                                                        //LIbera la memoria asignada al objeto tipo TDiff.
end;


//-------------------------------------------------------------------
// Devuelve el número de comparaciones de caracteres que se realizó.
//-------------------------------------------------------------------
Function TComparadorDeFicheros.ComparacionesRealizadas: Integer;
begin
Result := FComparaciones;
end;

//-------------------------------------------------------------------
// Devuelve el número de diferencias encontradas en la comparación.
//-------------------------------------------------------------------
Function TComparadorDeFicheros.DiferenciasEncontradas: Integer;
begin
Result := FDiferencias;
end;

//-------------------------------------------------------------------
// Devuelve el número de igualdades encontradas en la comparación.
//-------------------------------------------------------------------
Function TComparadorDeFicheros.IgualdadesEncontradas: Integer;
begin
Result := FIgualdades;
end;


//-------------------------------------------------------------------
// Devuelve el número de diferencias por caracteres borrados.
//-------------------------------------------------------------------
Function TComparadorDeFicheros.CaracteresBorrados: Integer;
begin
Result := FBorrados;
end;

//-------------------------------------------------------------------
// Devuelve el número de diferencias por caracteres insertados.
//-------------------------------------------------------------------
Function TComparadorDeFicheros.CaracteresInsertados: Integer;
begin
Result := FInserciones;
end;

//-------------------------------------------------------------------
// Devuelve el número de diferencias por caracteres cambiados.
//-------------------------------------------------------------------
Function TComparadorDeFicheros.CaracteresCambiados: Integer;
begin
Result := FCambios;
end;

//-------------------------------------------------------------------
function TComparadorDeFicheros.DesplazarIzquierda: Integer;
begin
if FInicioDeMuestra > 0 then Dec(FInicioDeMuestra);
Result := FInicioDeMuestra;
end;

//-------------------------------------------------------------------
function TComparadorDeFicheros.DesplazarDerecha: Integer;
begin
if FInicioDeMuestra < FComparaciones - 1 then inc(FInicioDeMuestra);
Result := FInicioDeMuestra;
end;

//-------------------------------------------------------------------
function TComparadorDeFicheros.DesplazarA(Posicion: Integer): Integer;
begin
if (Posicion >= 0)and
   (Posicion < FComparaciones) then
   FInicioDeMuestra := Posicion;
Result := FInicioDeMuestra;
end;

//-------------------------------------------------------------------
function TComparadorDeFicheros.Posicion: Integer;
begin
Result := FInicioDeMuestra;
end;

end.
