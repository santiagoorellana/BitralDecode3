///////////////////////////////////////////////////////////////////////////
//      Objeto: TComparadorDeFicheros                                    //
//       Autor: Santiago A. Orellana Pérez.                              //
//       Fecha: 2011                                                     //
// Descripción: Compara dos ficheros.                                    //
///////////////////////////////////////////////////////////////////////////

unit UComparadorDeFicherosMost;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, ExtCtrls, ComCtrls, ULista;

const C_IGUALDAD      = $22DD22;        //
const C_DIFERENCIA    = $2222FF;        //
const C_SELECCION     = $FF2222;        //

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
        procedure FiltrarDatos(Datos: TArrayDeBytes);
        procedure CargarFichero(FileName: String; Dato: TOrdenFichero);
        procedure Comparar;
        procedure BuscarLaContinuidadMasLargaEn(MarcoDeBusqueda: TRect);
        procedure QuickSort(desde, hasta: Integer);
        procedure AgregarContinuidad(Continuidad: TRect);
     protected
        procedure Execute; override;
     public
        ContinuidadesInsertadas: Integer;
        Datos1: TArrayDeBytes;
        Datos2: TArrayDeBytes;
        Seleccion: Integer;
        ColorDeIgualdad: TColor;
        ColorDeDiferencia: TColor;
        ColorDeSeleccion: TColor;
        ListaDeContinuidades: Array of TRect;
        FileName1: String;
        FileName2: String;
        constructor Create;
        procedure DibujarGraficoDeFicheros(Grafico: TPaintBox);
        function ObtenerResultados: TStringList;
        procedure GuardarImagenEn(Destino: String; PaintBox: TPaintBox);
        destructor Destroy;
     end;



implementation

uses Types;


//-------------------------------------------------------------------
// Crea un comparador de ficheros y lo prepara para trabajar.
//-------------------------------------------------------------------
constructor TComparadorDeFicheros.Create;
begin
ColorDeIgualdad   := C_IGUALDAD;       //Establece los colores por defecto
ColorDeDiferencia := C_DIFERENCIA;
ColorDeSeleccion := C_SELECCION;

FreeOnTerminate := False;                //El objeto subproceso no se destruye al terminar.
Seleccion := MaxInt;
inherited Create(True);                  //Crea el subproceso.
end;


//-------------------------------------------------------------------
// Destruye el comparador de ficheros.
//-------------------------------------------------------------------
destructor TComparadorDeFicheros.Destroy;
begin
ListaDeContinuidades := nil;
Datos1 := nil;
Datos2 := nil;
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
// Agrega una Continuidad a la lista.
//-------------------------------------------------------------------
procedure TComparadorDeFicheros.AgregarContinuidad(Continuidad: TRect);
begin
ListaDeContinuidades[ContinuidadesInsertadas] := Continuidad;
Inc(ContinuidadesInsertadas);
end;

//----------------------------------------------------------------------------
// Este procedimiento busca dentro de las demodulaciones las coincidencias
// más largas y llena una lista con los datos de las coincidencias.
//----------------------------------------------------------------------------
procedure TComparadorDeFicheros.BuscarLaContinuidadMasLargaEn(MarcoDeBusqueda: TRect);
var n, X, Y, LongitudMasLarga, LongitudMasCorta, MediaDiagonalMas1: Integer;
    LargoDeNuevaContinuidad: Integer;
    NuevoMarcoDeBusqueda: TRect;
    ContinuidadMasLarga: TRect;

    //Si la continuidad encontrada es más grande que la anterior, la guarda como mayor continuidad.
    procedure GuardarSiEsMasGrande;
    begin                                                                //Si esta continuidad es más grande que la anterior:
    if Terminated then Exit;
    if LargoDeNuevaContinuidad > Abs(ContinuidadMasLarga.Right - ContinuidadMasLarga.Left) then
       begin
       ContinuidadMasLarga.Left := x - LargoDeNuevaContinuidad;          //Calcula los datos de la nueva continuidad
       ContinuidadMasLarga.Top := y - LargoDeNuevaContinuidad;           //encontrada a partir de su longitud.
       ContinuidadMasLarga.Right := x - 1;
       ContinuidadMasLarga.Bottom := y - 1;
       end;
    end;

    //Explora la diagonal iniciada en (X;Y).
    procedure ExplorarDiagonal;
    begin
    if Terminated then Exit;                                                //Si el subproceso ha sido detenido, sale de la función.
    if ContinuidadMasLarga.Right - ContinuidadMasLarga.Left < MediaDiagonalMas1 then
       begin
       LargoDeNuevaContinuidad := 0;                                        //Incia el contador para la búsqueda de una continuidad.       
       if (x <= MarcoDeBusqueda.Right) and
          (y <= MarcoDeBusqueda.Bottom) then                                //Si la coordenada inicial se encuentra dentro del arreglo:
          begin
          while (x <= MarcoDeBusqueda.Right) and                            //Repite esto hasta el final del arreglo.
                (y <= MarcoDeBusqueda.Bottom) do
                begin
                if Terminated then Exit;                                    //Si el subproceso ha sido detenido, sale de la función.
                if Datos1[x] = Datos2[y] then
                   Inc(LargoDeNuevaContinuidad)                             //Cuenta el largo de la continuidad.
                else
                   begin
                   GuardarSiEsMasGrande;                                    //Si se encuentra una continuidad la guarda.
                   if ContinuidadMasLarga.Right - ContinuidadMasLarga.Left >= MediaDiagonalMas1 then Exit;
                   LargoDeNuevaContinuidad := 0;                            //Se inicia el contador para una nueva búsqueda.
                   end;
                Inc(x);                                                     //Avanza una posición más en la diagonal.
                Inc(y);
                end;
          GuardarSiEsMasGrande;                                             //Si hay una nueva continuidad la guarda.
          end;
       end;
    end;

begin
if Terminated then Exit;
ContinuidadMasLarga.Left := MaxInt;                                      //Indica que no se ha encontrado ninguna continuidad.
ContinuidadMasLarga.Right := MaxInt;

if MarcoDeBusqueda.Right >= MarcoDeBusqueda.Bottom then                  //Selecciona la longitud más larga del rectángulo marco de búsqueda.
   begin
   LongitudMasLarga := MarcoDeBusqueda.Right - MarcoDeBusqueda.Left + 1;
   LongitudMasCorta := MarcoDeBusqueda.Bottom - MarcoDeBusqueda.Top + 1;
   end
else
   begin
   LongitudMasLarga := MarcoDeBusqueda.Bottom - MarcoDeBusqueda.Top + 1;
   LongitudMasCorta := MarcoDeBusqueda.Right - MarcoDeBusqueda.Left + 1;
   end;

for n := 0 to LongitudMasLarga do                                        //Explora todas las diagonales que se forman en el marco de búsqueda.
    begin
    if Terminated then Exit;
    if n <= LongitudMasLarga - LongitudMasCorta then                     //Calcula la mitad de la diagonal más uno.
       MediaDiagonalMas1 := (LongitudMasCorta div 2) + 1                 //Este valor calculado se utiliza para
    else                                                                 //optimizar un poco el algoritmo.
       MediaDiagonalMas1 := ((LongitudMasLarga - n + 1) div 2) + 1;
    x := MarcoDeBusqueda.Left + n;                                       //Establece el inicio de X.
    y := MarcoDeBusqueda.Top;                                            //Establece el inicio de Y que será el origen.
    ExplorarDiagonal;                                                    //Explora por encima de la diagonal del medio.
    if n = 0 then Continue;                                              //Si es la diagonal del medio, salta para el próximo ciclo.
    x := MarcoDeBusqueda.Left;                                           //Establece el inicio de X que será el origen.
    y := MarcoDeBusqueda.Top + n;                                        //Establece el inicio de Y.
    ExplorarDiagonal;                                                    //Explora por debajo de la diagonal del medio.
    end;

if Terminated then Exit;
if (ContinuidadMasLarga.Right <> MaxInt)and
   (ContinuidadMasLarga.Left <> MaxInt) then
   begin
   AgregarContinuidad(ContinuidadMasLarga);                              //Guardar "ContinuidadEncontrada" en la lista de continuidades encontradas.
   if (ContinuidadMasLarga.Left > MarcoDeBusqueda.Left)and
      (ContinuidadMasLarga.Top > MarcoDeBusqueda.Top) then               //Busca las continuidades que anteceden a la
      begin                                                              //más larga encontrada.
      NuevoMarcoDeBusqueda.Left := MarcoDeBusqueda.Left;
      NuevoMarcoDeBusqueda.Top := MarcoDeBusqueda.Top;
      NuevoMarcoDeBusqueda.Right := ContinuidadMasLarga.Left - 1;
      NuevoMarcoDeBusqueda.Bottom := ContinuidadMasLarga.Top - 1;
      BuscarLaContinuidadMasLargaEn(NuevoMarcoDeBusqueda);
      end;
   if (ContinuidadMasLarga.Right < MarcoDeBusqueda.Right)and             //Busca las continuidades que preceden a la
      (ContinuidadMasLarga.Bottom < MarcoDeBusqueda.Bottom) then         //más larga encontrada.
      begin
      NuevoMarcoDeBusqueda.Left := ContinuidadMasLarga.Right + 1;
      NuevoMarcoDeBusqueda.Top := ContinuidadMasLarga.Bottom + 1;
      NuevoMarcoDeBusqueda.Right := MarcoDeBusqueda.Right;
      NuevoMarcoDeBusqueda.Bottom := MarcoDeBusqueda.Bottom;
      BuscarLaContinuidadMasLargaEn(NuevoMarcoDeBusqueda);
      end;
   end;
end;


//-------------------------------------------------------------------
// Dibuja el gráfico del fichero #1.
//-------------------------------------------------------------------
procedure TComparadorDeFicheros.DibujarGraficoDeFicheros(Grafico: TPaintBox);
const FileHeight = 20;     //Ancho del gráfico de cada fichero.
      FileSpace = 50;      //Espacio entre los gráficos de los ficheros.
      ArrowSpace = 3;      //Espacio entre los enlaces y el borde del gráfico.
      BorderSpace = 5;     //Separación entre el gráfico y el borde de la imagen.

var n: Integer;
    Rectangulo1: TRect;
    Rectangulo2: TRect;
    File1: TRect;
    File2: TRect;
    Igualdad: TRect;

    procedure DibujarCoincidencia;
    var d: Integer;
    begin
    //Dibuja la gráfica del fichero #1.
    d := Igualdad.Right - Igualdad.Left + 1;
    Rectangulo1.Top := File1.Top + 1;
    Rectangulo1.Bottom := File1.Bottom - 1;
    Rectangulo1.Left := Round((Igualdad.Left / Length(Datos1)) * (File1.Right - File1.Left - 2)) + File1.Left + 1;
    Rectangulo1.Right := Round(((Igualdad.Left + d) / Length(Datos1)) * (File1.Right - File1.Left - 2)) + File1.Left + 1;
    Grafico.Canvas.FillRect(Rectangulo1);
    //Dibuja la gráfica del fichero #2.
    d := Igualdad.Bottom - Igualdad.Top + 1;
    Rectangulo2.Top := File2.Top + 1;
    Rectangulo2.Bottom := File2.Bottom - 1;      
    Rectangulo2.Left := Round((Igualdad.Top / Length(Datos2)) * (File2.Right - File2.Left - 2)) + File2.Left + 1;
    Rectangulo2.Right := Round(((Igualdad.Top + d) / Length(Datos2)) * (File2.Right - File2.Left - 2)) + File2.Left + 1;
    Grafico.Canvas.FillRect(Rectangulo2);
    //Dibuja los enlaces entre los ficheros 1 y 2.
    Grafico.Canvas.MoveTo((Rectangulo1.Right + Rectangulo1.Left)div 2, File1.Bottom + ArrowSpace);
    Grafico.Canvas.LineTo((Rectangulo2.Right + Rectangulo2.Left)div 2, File2.Top - ArrowSpace);
    end;

begin
File1.Left := BorderSpace;
File1.Right := Grafico.ClientWidth - BorderSpace;
File1.Top := BorderSpace;
File1.Bottom := File1.Top + FileHeight;

File2.Left := BorderSpace;
File2.Right := Grafico.ClientWidth - BorderSpace;
File2.Top := File1.Bottom + FileSpace;
File2.Bottom := File2.Top + FileHeight;

if Length(Datos1) < Length(Datos2) then
   File1.Right := File1.Left + Round((Length(Datos1) / Length(Datos2)) * (File2.Right - File2.Left));
if Length(Datos1) > Length(Datos2) then
   File2.Right := File2.Left + Round((Length(Datos2) / Length(Datos1)) * (File1.Right - File1.Left));

Grafico.Canvas.Pen.Width := 1;
Grafico.Canvas.Pen.Color := clBlack;
Grafico.Canvas.Brush.Color := clWhite;
Grafico.Canvas.Rectangle(Grafico.ClientRect);
Grafico.Canvas.Brush.Color := ColorDeDiferencia;
Grafico.Canvas.Rectangle(File1);
Grafico.Canvas.Rectangle(File2);

if ContinuidadesInsertadas > 0 then
   begin
   for n := 0 to ContinuidadesInsertadas - 1 do
       begin
       Igualdad := ListaDeContinuidades[n];
       if (Igualdad.Right <> MaxInt) and
          (Igualdad.Left <> MaxInt) and
          (Igualdad.Top <> MaxInt) and
          (Igualdad.Bottom <> MaxInt) then
          begin
          Grafico.Canvas.Brush.Color := ColorDeIgualdad;
          Grafico.Canvas.Pen.Color := ColorDeIgualdad;
          DibujarCoincidencia;
          end;
       end;
   if Seleccion <> MaxInt then
      begin
      Igualdad := ListaDeContinuidades[Seleccion];
      Grafico.Canvas.Brush.Color := ColorDeSeleccion;
      Grafico.Canvas.Pen.Color := ColorDeSeleccion;
      DibujarCoincidencia;
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

//-------------------------------------------------------------------
// Organiza la lista de mayor a menor.
//-------------------------------------------------------------------

procedure TComparadorDeFicheros.QuickSort(desde, hasta: Integer);
var Lo, Hi: Integer;
    medio: Integer;
    T: TRect;
begin
Lo := desde;
Hi := hasta;
medio := Abs(ListaDeContinuidades[(Lo + Hi) div 2].Right - ListaDeContinuidades[(Lo + Hi) div 2].Left + 1);
repeat
   while Abs(ListaDeContinuidades[Lo].Right - ListaDeContinuidades[Lo].Left + 1) > medio do Inc(Lo);
   while Abs(ListaDeContinuidades[Hi].Right - ListaDeContinuidades[Hi].Left + 1) < medio do Dec(Hi);
   if Lo <= Hi then
      begin
      T := ListaDeContinuidades[Lo];
      ListaDeContinuidades[Lo] := ListaDeContinuidades[Hi];
      ListaDeContinuidades[Hi] := T;
      Inc(Lo);
      Dec(Hi);
      end;
until Lo > Hi;
if Hi > desde then QuickSort(desde, Hi);
if Lo < hasta then QuickSort(Lo, hasta);
end;


//------------------------------------------------------------------------------
// Compara dos ficheros.
// Chequea constantemente lavariable Terminated para salir si el usuario
// requiere detener el subproceso de comparación.
//------------------------------------------------------------------------------
procedure TComparadorDeFicheros.Comparar;
var marco: TRect;
    n: Integer;
begin
if Terminated then Exit;
CargarFichero(FileName1, ComoPrimero);                                            //Carga el primer fichero.
CargarFichero(FileName2, ComoSegundo);                                            //Carga el segundo fichero.
FiltrarDatos(Datos1);
FiltrarDatos(Datos2);
if Terminated then Exit;
if (Datos1 = nil) or (Datos2 = nil) then Exit;                                    //Si los ficheros no han sido cargados, abandona el algoritmo.
marco.Left := 0;
marco.Top := 0;                                                                   //Establece los límites del rectángulo mayor.
marco.Right := Length(Datos1) - 1;
marco.Bottom := Length(Datos2) - 1;
if marco.Right > marco.Bottom then n := marco.Right else n := marco.Bottom;   
SetLength(ListaDeContinuidades, n + 1);                                           //Asigna memoria para la lista de continuidades.
for n := 0 to Length(ListaDeContinuidades) - 1 do                                 //Invalida los elementos de la
    begin                                                                         //lista de continuidades.
    if Terminated then Exit;
    ListaDeContinuidades[n].Left := MaxInt;
    ListaDeContinuidades[n].Right := MaxInt;
    ListaDeContinuidades[n].Top := MaxInt;
    ListaDeContinuidades[n].Bottom := MaxInt;
    end;
ContinuidadesInsertadas := 0;                                                     //Inicia el contador de continuidades de la lista.
BuscarLaContinuidadMasLargaEn(marco);                                             //Busca las continuidades de forma recursiva.
if ContinuidadesInsertadas > 0 then QuickSort(0, ContinuidadesInsertadas - 1);    //Ordena las continuidades de mayor a menor según su longitud.
SetLength(ListaDeContinuidades, ContinuidadesInsertadas);                         //Libera lo que sobre de la lista.
end;


//------------------------------------------------------------------------------
// Devuelve los resultados de la comparación.
//------------------------------------------------------------------------------
function TComparadorDeFicheros.ObtenerResultados: TStringList;
var n: Integer;
    Rectangulo: TRect;
begin
Result := TStringList.Create;
if ContinuidadesInsertadas > 0 then
   for n := 0 to ContinuidadesInsertadas - 1 do
       begin
       Rectangulo := ListaDeContinuidades[n];
       if (Rectangulo.Right <> MaxInt) and
          (Rectangulo.Left <> MaxInt) and
          (Rectangulo.Top <> MaxInt) and
          (Rectangulo.Bottom <> MaxInt) then
          Result.Add(IntToStr(Rectangulo.Right - Rectangulo.Left + 1) + ' caracteres');
       end;
end;



//------------------------------------------------------------------------------
// Guarda la gráfica en la dirección/nombre indicados.
//------------------------------------------------------------------------------
procedure TComparadorDeFicheros.GuardarImagenEn(Destino: String; PaintBox: TPaintBox);
//var img: TImage;
begin
//img := TImage.Create(nil);
//img.Width := PaintBox.Width;
//img.Height := PaintBox.Height;
//img.Canvas.Draw(0, 0, PaintBox);
//img.Picture.SaveToFile(Destino);
end;


end.
