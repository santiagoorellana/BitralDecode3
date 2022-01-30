unit DataManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Math;

//-----------------------------------------------------------
// Parámetros de funcionamiento para la búsqueda de períodos.
//-----------------------------------------------------------

const C_PERIODO_MIN = 8;                               //Período mínimo.
const C_PERIODO_MAX = 1024;                            //Período máximo.
const C_CANTIDAD_DE_REPETICIONES_MIN = 16;             //Cantidad mínima de repeticiones que se aceptan como criterio de existencia de un período en una columna.

//-----------------------------------------------------------
type TLugar = (DelanteDelCaracter, DetrasDelCaracter);

type TDatos = array of Byte;

     TDataSeleccion = record
                      Inicio: Integer;         //Posición de inicio de la primera de las cadenas.
                      Ancho: Integer;          //Ancho del rectángulo de datos seleccionado.
                      Altura: Integer;         //Altura del rectángulo de datos seleccionado.
                      Periodo: Integer         //Período en que se forma el rectángulo.
                      end;

     TCopyDataPeriod = record
                       Copia: TDatos;
                       Longitud: Integer;
                       Parametros: TDataSeleccion;
                       end;

     TDatosDeBusqueda = record
                        Valido: Boolean;
                        Cadena: String;
                        BuscarDesde: Integer;
                        end;

     TCadenaEncontrada = record
                         Inicio: Integer;
                         Final: Integer;
                         end;

     TEstadisticasSimbolosNodo = record
                                 Caracter: Char;
                                 Cantidad: Longint;
                                 end;

     TEstadisticasSimbolos = Array[0..31]of TEstadisticasSimbolosNodo;                             

     TDataManager = class
     private
        FDatosDeBusqueda: TDatosDeBusqueda;
        procedure EliminarCaracter(Caracter: Byte); overload;
        procedure EliminarCaracter(Caracter: Char); overload;
        function BuscarConFuerzaBruta(Cadena: String; BuscarDesde: Integer): Integer;
     public
        Datos: TDatos;
        CantidadDeSimbolos: Integer;
        EstadisticasDeSimbolos: TEstadisticasSimbolos;

        constructor Create;
        destructor Destroy;
        //Trabajo con ficheros.
        procedure CargarDesdeFichero(FileName: String);
        procedure SalvarEnFichero(FileName: String);
        function LongitudDelFichero: Integer;                                     //Devuelve la longitud del fichero cargado.
        //Métodos de edición.
        procedure SustituirDatos(Inicio, Ancho, Altura, Periodo: Integer; Sustituto: Byte); overload;
        procedure SustituirDatos(Seleccion: TDataSeleccion; Sustituto: Byte); overload;
        function CopiarDatos(Inicio, Ancho, Altura, Periodo: Integer): TCopyDataPeriod; overload;
        function CopiarDatos(Seleccion: TDataSeleccion): TCopyDataPeriod; overload;
        procedure PegarDatosCopiados(Inicio: Integer; CopiaDeDatos: TCopyDataPeriod);
        procedure InsertarDatos(Inicio: Integer; Lugar: TLugar; Cadena: String);
        procedure EliminarDatos(Inicio, Ancho, Altura, Periodo: Integer); overload;
        procedure EliminarDatos(Seleccion: TDataSeleccion); overload;
        procedure ConvertirEnBinario(Simbolos: TStringList);
        function ContarSimbolos: Integer;
        procedure FiltrarDatos;
        function TextoDelAreaSeleccionada(Inicio, Ancho, Altura, Periodo: Integer): TStringList; overload;
        function TextoDelAreaSeleccionada(Seleccion: TDataSeleccion): TStringList; overload;
        function BuscarPrimeraCoincidencia(Cadena: String): TCadenaEncontrada;
        function BuscarSiguienteCoincidencia: TCadenaEncontrada;
     end;

implementation

/////////////////////////////////////////////////////////////////////
////////  FUNCIONES Y PROCEDIMIENTOS  ///////////////////////////////
/////////////////////////////////////////////////////////////////////

//-------------------------------------------------------------------
constructor TDataManager.Create;
begin
inherited Create;                           //Llama al código anterior de la clase base.
end;

//-------------------------------------------------------------------
destructor TDataManager.Destroy;
begin
if Assigned(Datos) then Datos := nil;       //Vacía el arreglo de datos si está lleno.
inherited;                                  //Llama al código anterior de la clase base.
end;

//-------------------------------------------------------------------
// 17/11/2011
// Carga los datos de un fichero al arreglo "Datos".
// Los parámetros son los siguientes:
//
// FileName: Nombre del fichero.
//-------------------------------------------------------------------
procedure TDataManager.CargarDesdeFichero(FileName: String);
var stream: TStream;
begin
stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
SetLength(Datos, TFileStream(stream).Size);
try stream.ReadBuffer(Datos[0], TFileStream(stream).Size) finally stream.Free end;
ContarSimbolos;
end;

//-------------------------------------------------------------------
// 17/11/2011
// Guarda los datos del arreglo "Datos" en un fichero.
// Los parámetros son los siguientes:
//
// FileName: Nombre del fichero.
//-------------------------------------------------------------------
procedure TDataManager.SalvarEnFichero(FileName: String);
var stream: TStream;
begin
stream := TFileStream.Create(FileName, fmCreate or fmShareDenyWrite);
try stream.WriteBuffer(Datos[0], Length(Datos)) finally stream.Free end;
end;

//-------------------------------------------------------------------
// 17/11/2011
// Elimina cadenas que se repiten en los datos de forma periódica.
// Los parámetros para la eliminación son los siguientes:
//
// Inicio:        Inicio de la primera de las cadenas a eliminar.
// Longitud:      Longitud de las cadenas de datos.
// Repeticiones:  Cantidad de repeticiones de las cadenas.
// Periodo:       Período de repetición de las cadenas.
// Sustituto:     Dato con el que se van a llenar las cadenas.
//
// Los parámetros se pueden pasar directamente o agrupados
// en una estructura del tipo "TDataPeriod".
//-------------------------------------------------------------------
procedure TDataManager.SustituirDatos(Inicio: Integer;         //Inicio de la primera de las cadenas a eliminar.
                                      Ancho: Integer;          //Longitud de las cadenas de datos.
                                      Altura: Integer;         //Cantidad de repeticiones de las cadenas.
                                      Periodo: Integer;        //Período de repetición de las cadenas.
                                      Sustituto: Byte          //Dato con el que se van a llenar las cadenas.
                                      ); 
var n, m, a: Integer;
begin
for n := 0 to Altura - 1 do
    begin
    for m := 0 to Ancho - 1 do
        begin
        a := Inicio + (n * Periodo + m);
        if (a >= 0) and (a < Length(Datos)) then Datos[a] := Sustituto;
        end;
    end;
end;

procedure TDataManager.SustituirDatos(Seleccion : TDataSeleccion;   //Datos de las cadenas periódicas.
                                      Sustituto: Byte             //Dato con el que se van a llenar las cadenas.
                                      );
begin
SustituirDatos(Seleccion.Inicio,
               Seleccion.Ancho,
               Seleccion.Altura,
               Seleccion.Periodo,
               Sustituto
               );
end;


//-------------------------------------------------------------------
// 17/11/2011
// Copia cadenas que se repiten en los datos de forma periódica.
// Los parámetros son los siguientes:
//
// Inicio:        Inicio de la primera de las cadenas a eliminar.
// Longitud:      Longitud de las cadenas de datos.
// Repeticiones:  Cantidad de repeticiones de las cadenas.
// Periodo:       Período de repetición de las cadenas.
//
// Los parámetros se pueden pasar directamente o agrupados
// en una estructura del tipo "TDataPeriod".
//-------------------------------------------------------------------
function TDataManager.CopiarDatos(Inicio: Integer;         //Inicio de la primera de las cadenas.
                                  Ancho: Integer;          //Longitud de las cadenas de datos.
                                  Altura: Integer;         //Cantidad de repeticiones de las cadenas.
                                  Periodo: Integer         //Período de repetición de las cadenas.
                                  ): TCopyDataPeriod;
var n, m, a, b: Integer;
    CopiaDeDatos: TCopyDataPeriod;
begin
CopiaDeDatos.Parametros.Inicio := 0;
CopiaDeDatos.Parametros.Ancho := Ancho;
CopiaDeDatos.Parametros.Altura := Altura;
CopiaDeDatos.Parametros.Periodo := Periodo;
SetLength(CopiaDeDatos.Copia , Altura * Ancho);
b := 0;
for n := 0 to Altura - 1 do
    begin
    for m := 0 to Ancho - 1 do
        begin
        a := Inicio + (n * Periodo + m);
        if (a >= 0) and (a < Length(Datos)) and
           (b >= 0) and (b < Length(CopiaDeDatos.Copia)) then
           CopiaDeDatos.Copia[b] := Datos[a];
        Inc(b);
        end;
    end;
CopiaDeDatos.Longitud := Altura * Ancho;
Result := CopiaDeDatos;
end;

function TDataManager.CopiarDatos(Seleccion : TDataSeleccion): TCopyDataPeriod;
begin
Result := CopiarDatos(Seleccion.Inicio,
                      Seleccion.Ancho,
                      Seleccion.Altura,
                      Seleccion.Periodo
                      );
end;

//-------------------------------------------------------------------
// 17/11/2011
// Pega las cadenas copiadas. Los parámetros son los siguientes:
//
// Inicio: Posición a partir de la cual se pegarán las cadenas.
//-------------------------------------------------------------------
procedure TDataManager.PegarDatosCopiados(Inicio: Integer; CopiaDeDatos: TCopyDataPeriod);
var n, m, a, b: Integer;
begin
b := 0;
for n := 0 to CopiaDeDatos.Parametros.Altura - 1 do
    begin
    for m := 0 to CopiaDeDatos.Parametros.Ancho - 1 do
        begin
        a := Inicio + (n * CopiaDeDatos.Parametros.Periodo + m);
        if (a >= 0) and (a < Length(Datos)) and
           (b >= 0) and (b < Length(CopiaDeDatos.Copia)) then
           Datos[a] := CopiaDeDatos.Copia[b];
        Inc(b);
        end;
    end;
end;


//-------------------------------------------------------------------
// 17/11/2011
// Elimina cadenas que se repiten en los datos de forma periódica.
// Los parámetros para la eliminación son los siguientes:
//
// Inicio:        Inicio de la primera de las cadenas a eliminar.
// Longitud:      Longitud de las cadenas de datos.
// Repeticiones:  Cantidad de repeticiones de las cadenas.
// Periodo:       Período de repetición de las cadenas.
// Sustituto:     Dato con el que se van a llenar las cadenas.
//
// Los parámetros se pueden pasar directamente o agrupados
// en una estructura del tipo "TDataPeriod".
//-------------------------------------------------------------------
procedure TDataManager.EliminarDatos(Inicio: Integer;         //Inicio de la primera de las cadenas a eliminar.
                                     Ancho: Integer;          //Longitud de las cadenas de datos.
                                     Altura: Integer;         //Cantidad de repeticiones de las cadenas.
                                     Periodo: Integer         //Período de repetición de las cadenas.
                                     );
begin
SustituirDatos(Inicio, Ancho, Altura, Periodo, 0);
EliminarCaracter(0);
end;

procedure TDataManager.EliminarDatos(Seleccion : TDataSeleccion);
begin
EliminarDatos(Seleccion.Inicio,
              Seleccion.Ancho,
              Seleccion.Altura,
              Seleccion.Periodo
              );
end;


//-------------------------------------------------------------------
// 17/11/2011
// Elimina todos los caracteres que coinciden con el
// parámetro indicado.
//-------------------------------------------------------------------
procedure TDataManager.EliminarCaracter(Caracter: Byte);
var colector, depositador: Integer;
begin
depositador := 0;
for colector := 0 to Length(Datos) - 1 do
    if Datos[colector] <> Caracter then
       begin
       if colector > depositador then Datos[depositador] := Datos[colector];
       Inc(depositador);
       end;
SetLength(Datos, depositador);
end;

procedure TDataManager.EliminarCaracter(Caracter: Char);
begin
EliminarCaracter(Ord(Caracter));
end;


//-------------------------------------------------------------------
// 31/1/2012
// Inserta una cadena de caracteres antes o despues de la
// posición indicada.
//
// Los parámetros son los siguientes:
//
// Inicio:        Posición de inserción.
// Lugar:         Indica si se debe insertar antes o después.
// Cadena:        Contiene los caracteres que se deben insertar.
//-------------------------------------------------------------------
procedure TDataManager.InsertarDatos(Inicio: Integer;         //Posición de inserción.
                                     Lugar: TLugar;           //Indica si se debe insertar antes o después.
                                     Cadena: String           //Contiene los caracteres que se deben insertar.
                                     );
var n, d: Integer;
begin
if Length(Cadena) = 0 then Exit;
if (Inicio >= 0)and(Inicio < Length(Datos)) then
   begin
   if Lugar = DetrasDelCaracter then Inc(Inicio);                           //Determina si se agrega antes o después del caracter marcado.
   d := Length(Datos) - Inicio - 1;                                         //Cantidad de datos que se deben desplazar.
   SetLength(Datos, Length(Datos) + Length(Cadena));                        //Crea espacio al final del arreglo.
   if d >= 0 then                                                           //Si hay datos para desplazar:
      for n := 0 to d do                                                    //Mueve los datos para crear un espacio intermedio.
          Datos[Length(Datos) - 1 - n] := Datos[Length(Datos) - 1 - n - Length(Cadena)];
   for n := 0 to Length(Cadena) - 1 do                                      //Inserta la cadena en el espacio intermedio.
       Datos[Inicio + n] := Ord(Cadena[n + 1]);
   end;
end;

//-------------------------------------------------------------------
// Cuenta los símbolos que se encuentran en el rango 0-9 o A-V.
//-------------------------------------------------------------------
function TDataManager.ContarSimbolos: Integer;
const Nulo = 0;
var n: Integer;
begin
for n := 0 to 31  do
    begin
    EstadisticasDeSimbolos[n].Caracter := Chr(0);
    EstadisticasDeSimbolos[n].Cantidad := 0;
    end;
Result := 0;
if not Assigned(Datos) then Exit;
for n := 0 to Length(Datos) - 1 do               //Se utiliza un CASE para permitir la
    begin                                        //flexibilidad de modificación del código.
    case Chr(Datos[n]) of
         '0': begin
              if Result < 1 then Result := 1;
              EstadisticasDeSimbolos[0].Caracter := '0';
              Inc(EstadisticasDeSimbolos[0].Cantidad);
              end;
         '1': begin
              if Result < 2 then Result := 2;
              EstadisticasDeSimbolos[1].Caracter := '1';
              Inc(EstadisticasDeSimbolos[1].Cantidad);
              end;
         '2': begin
              if Result < 3 then Result := 3;
              EstadisticasDeSimbolos[2].Caracter := '2';
              Inc(EstadisticasDeSimbolos[2].Cantidad);
              end;
         '3': begin
              if Result < 4 then Result := 4;
              EstadisticasDeSimbolos[3].Caracter := '3';
              Inc(EstadisticasDeSimbolos[3].Cantidad);
              end;
         '4': begin
              if Result < 5 then Result := 5;
              EstadisticasDeSimbolos[4].Caracter := '4';
              Inc(EstadisticasDeSimbolos[4].Cantidad);
              end;
         '5': begin
              if Result < 6 then Result := 6;
              EstadisticasDeSimbolos[5].Caracter := '5';
              Inc(EstadisticasDeSimbolos[5].Cantidad);
              end;
         '6': begin
              if Result < 7 then Result := 7;
              EstadisticasDeSimbolos[6].Caracter := '6';
              Inc(EstadisticasDeSimbolos[6].Cantidad);
              end;
         '7': begin
              if Result < 8 then Result := 8;
              EstadisticasDeSimbolos[7].Caracter := '7';
              Inc(EstadisticasDeSimbolos[7].Cantidad);
              end;
         '8': begin
              if Result < 9 then Result := 9;
              EstadisticasDeSimbolos[8].Caracter := '8';
              Inc(EstadisticasDeSimbolos[8].Cantidad);
              end;
         '9': begin
              if Result < 10 then Result := 10;
              EstadisticasDeSimbolos[9].Caracter := '9';
              Inc(EstadisticasDeSimbolos[9].Cantidad);
              end;
         'A','a': begin
                  if Result < 11 then Result := 11;
                  EstadisticasDeSimbolos[10].Caracter := 'A';
                  Inc(EstadisticasDeSimbolos[10].Cantidad);
                  end;
         'B','b': begin
                  if Result < 12 then Result := 12;
                  EstadisticasDeSimbolos[11].Caracter := 'B';
                  Inc(EstadisticasDeSimbolos[11].Cantidad);
                  end;
         'C','c': begin
                  if Result < 13 then Result := 13;
                  EstadisticasDeSimbolos[12].Caracter := 'C';
                  Inc(EstadisticasDeSimbolos[12].Cantidad);
                  end;
         'D','d': begin
                  if Result < 14 then Result := 14;
                  EstadisticasDeSimbolos[13].Caracter := 'D';
                  Inc(EstadisticasDeSimbolos[13].Cantidad);
                  end;
         'E','e': begin
                  if Result < 15 then Result := 15;
                  EstadisticasDeSimbolos[14].Caracter := 'E';
                  Inc(EstadisticasDeSimbolos[14].Cantidad);
                  end;
         'F','f': begin
                  if Result < 16 then Result := 16;
                  EstadisticasDeSimbolos[15].Caracter := 'F';
                  Inc(EstadisticasDeSimbolos[15].Cantidad);
                  end;
         'G','g': begin
                  if Result < 17 then Result := 17;
                  EstadisticasDeSimbolos[16].Caracter := 'G';
                  Inc(EstadisticasDeSimbolos[16].Cantidad);
                  end;
         'H','h': begin
                  if Result < 18 then Result := 18;
                  EstadisticasDeSimbolos[17].Caracter := 'H';
                  Inc(EstadisticasDeSimbolos[17].Cantidad);
                  end;
         'I','i': begin
                  if Result < 19 then Result := 19;
                  EstadisticasDeSimbolos[18].Caracter := 'I';
                  Inc(EstadisticasDeSimbolos[18].Cantidad);
                  end;
         'J','j': begin
                  if Result < 20 then Result := 20;
                  EstadisticasDeSimbolos[19].Caracter := 'J';
                  Inc(EstadisticasDeSimbolos[19].Cantidad);
                  end;
         'K','k': begin
                  if Result < 21 then Result := 21;
                  EstadisticasDeSimbolos[20].Caracter := 'K';
                  Inc(EstadisticasDeSimbolos[20].Cantidad);
                  end;
         'L','l': begin
                  if Result < 22 then Result := 22;
                  EstadisticasDeSimbolos[21].Caracter := 'L';
                  Inc(EstadisticasDeSimbolos[21].Cantidad);
                  end;
         'M','m': begin
                  if Result < 23 then Result := 23;
                  EstadisticasDeSimbolos[22].Caracter := 'M';
                  Inc(EstadisticasDeSimbolos[22].Cantidad);
                  end;
         'N','n': begin
                  if Result < 24 then Result := 24;
                  EstadisticasDeSimbolos[23].Caracter := 'N';
                  Inc(EstadisticasDeSimbolos[23].Cantidad);
                  end;
         'O','o': begin
                  if Result < 25 then Result := 25;
                  EstadisticasDeSimbolos[24].Caracter := 'O';
                  Inc(EstadisticasDeSimbolos[24].Cantidad);
                  end;
         'P','p': begin
                  if Result < 26 then Result := 26;
                  EstadisticasDeSimbolos[25].Caracter := 'P';
                  Inc(EstadisticasDeSimbolos[25].Cantidad);
                  end;
         'Q','q': begin
                  if Result < 27 then Result := 27;
                  EstadisticasDeSimbolos[26].Caracter := 'Q';
                  Inc(EstadisticasDeSimbolos[26].Cantidad);
                  end;
         'R','r': begin
                  if Result < 28 then Result := 28;
                  EstadisticasDeSimbolos[27].Caracter := 'R';
                  Inc(EstadisticasDeSimbolos[27].Cantidad);
                  end;
         'S','s': begin
                  if Result < 29 then Result := 29;
                  EstadisticasDeSimbolos[28].Caracter := 'S';
                  Inc(EstadisticasDeSimbolos[28].Cantidad);
                  end;
         'T','t': begin
                  if Result < 30 then Result := 30;
                  EstadisticasDeSimbolos[29].Caracter := 'T';
                  Inc(EstadisticasDeSimbolos[29].Cantidad);
                  end;
         'U','u': begin
                  if Result < 31 then Result := 31;
                  EstadisticasDeSimbolos[30].Caracter := 'U';
                  Inc(EstadisticasDeSimbolos[30].Cantidad);
                  end;
         'V','v': begin
                  if Result < 32 then Result := 32;
                  EstadisticasDeSimbolos[31].Caracter := 'V';
                  Inc(EstadisticasDeSimbolos[31].Cantidad);
                  end;
         end;
    end;
if Result < 32 then while Frac(Log2(Result)) <> 0 do Inc(Result);      //Redondea el resultado a la siguiente potencia de 2.
CantidadDeSimbolos := Result;                                          //Guarda el número de símbolos.
end;

//-------------------------------------------------------------------
// 23/2/2012
// Elimina los caracteres que no pertececen a los
// símbolos de la demodulación.
//-------------------------------------------------------------------
procedure TDataManager.FiltrarDatos;
const Nulo = 0;
var n: Integer;
begin
if not Assigned(Datos) then Exit;
for n := 0 to Length(Datos) - 1 do               //Se utiliza un CASE para permitir la
    begin                                        //flexibilidad de modificación del código.
    case Chr(Datos[n]) of
         '0': if CantidadDeSimbolos < 1 then Datos[n] := Nulo;
         '1': if CantidadDeSimbolos < 2 then Datos[n] := Nulo;
         '2': if CantidadDeSimbolos < 3 then Datos[n] := Nulo;
         '3': if CantidadDeSimbolos < 4 then Datos[n] := Nulo;
         '4': if CantidadDeSimbolos < 5 then Datos[n] := Nulo;
         '5': if CantidadDeSimbolos < 6 then Datos[n] := Nulo;
         '6': if CantidadDeSimbolos < 7 then Datos[n] := Nulo;
         '7': if CantidadDeSimbolos < 8 then Datos[n] := Nulo;
         '8': if CantidadDeSimbolos < 9 then Datos[n] := Nulo;
         '9': if CantidadDeSimbolos < 10 then Datos[n] := Nulo;
         'A','a': if CantidadDeSimbolos < 11 then Datos[n] := Nulo;
         'B','b': if CantidadDeSimbolos < 12 then Datos[n] := Nulo;
         'C','c': if CantidadDeSimbolos < 13 then Datos[n] := Nulo;
         'D','d': if CantidadDeSimbolos < 14 then Datos[n] := Nulo;
         'E','e': if CantidadDeSimbolos < 15 then Datos[n] := Nulo;
         'F','f': if CantidadDeSimbolos < 16 then Datos[n] := Nulo;
         'G','g': if CantidadDeSimbolos < 17 then Datos[n] := Nulo;
         'H','h': if CantidadDeSimbolos < 18 then Datos[n] := Nulo;
         'I','i': if CantidadDeSimbolos < 19 then Datos[n] := Nulo;
         'J','j': if CantidadDeSimbolos < 20 then Datos[n] := Nulo;
         'K','k': if CantidadDeSimbolos < 21 then Datos[n] := Nulo;
         'L','l': if CantidadDeSimbolos < 22 then Datos[n] := Nulo;
         'M','m': if CantidadDeSimbolos < 23 then Datos[n] := Nulo;
         'N','n': if CantidadDeSimbolos < 24 then Datos[n] := Nulo;
         'O','o': if CantidadDeSimbolos < 25 then Datos[n] := Nulo;
         'P','p': if CantidadDeSimbolos < 26 then Datos[n] := Nulo;
         'Q','q': if CantidadDeSimbolos < 27 then Datos[n] := Nulo;
         'R','r': if CantidadDeSimbolos < 28 then Datos[n] := Nulo;
         'S','s': if CantidadDeSimbolos < 29 then Datos[n] := Nulo;
         'T','t': if CantidadDeSimbolos < 30 then Datos[n] := Nulo;
         'U','u': if CantidadDeSimbolos < 31 then Datos[n] := Nulo;
         'V','v': if CantidadDeSimbolos < 32 then Datos[n] := Nulo;
         else Datos[n] := Nulo;                                     //Sustituye los caracteres no válidos por un cero.
         end;
    end;
EliminarCaracter(Nulo);
end;


//-------------------------------------------------------------------
// Sustituye los símbolos por un juego de símbolos binarios.
//-------------------------------------------------------------------
procedure TDataManager.ConvertirEnBinario(Simbolos: TStringList);
const Nulo = 0;
var n, m, Simbolo, LengthSimbolos: Integer;
    CopiaDatos: TDatos;
begin
if not Assigned(Datos) then Exit;
LengthSimbolos := Length(Simbolos[0]);
SetLength(CopiaDatos, Length(Datos) * LengthSimbolos);               //Crea un arreglo para los datos resultantes.
for n := 0 to Length(Datos) - 1 do                                   //Se utiliza un CASE para permitir la
    begin                                                            //flexibilidad de modificación del código.
    case Chr(Datos[n]) of
         '0': Simbolo := 0;
         '1': Simbolo := 1;
         '2': Simbolo := 2;
         '3': Simbolo := 3;
         '4': Simbolo := 4;
         '5': Simbolo := 5;
         '6': Simbolo := 6;
         '7': Simbolo := 7;
         '8': Simbolo := 8;
         '9': Simbolo := 9;
         'A','a': Simbolo := 10;
         'B','b': Simbolo := 11;
         'C','c': Simbolo := 12;
         'D','d': Simbolo := 13;
         'E','e': Simbolo := 14;
         'F','f': Simbolo := 15;
         'G','g': Simbolo := 16;
         'H','h': Simbolo := 17;
         'I','i': Simbolo := 18;
         'J','j': Simbolo := 19;
         'K','k': Simbolo := 20;
         'L','l': Simbolo := 21;
         'M','m': Simbolo := 22;
         'N','n': Simbolo := 23;
         'O','o': Simbolo := 24;
         'P','p': Simbolo := 25;
         'Q','q': Simbolo := 26;
         'R','r': Simbolo := 27;
         'S','s': Simbolo := 28;
         'T','t': Simbolo := 29;
         'U','u': Simbolo := 30;
         'V','v': Simbolo := 31;
         else Simbolo := MaxInt;
         end;
    if Simbolo < Simbolos.Count then
       begin                                               //Sustituye los caracteres por una combinación de ceros y unos.
       for m := 0 to LengthSimbolos - 1 do CopiaDatos[n * LengthSimbolos + m] := Byte(Simbolos[Simbolo][m + 1]);
       end
    else
       begin                                               //Sustituye los caracteres no válidos por un NULL.
       for m := 0 to LengthSimbolos - 1 do CopiaDatos[n * LengthSimbolos + m] := Nulo;
       end;
    end;
Datos := CopiaDatos;                                       //Copia los datos convertidos.
CantidadDeSimbolos := 2;                                   //Establece la cantidad de símbolos.
EliminarCaracter(Nulo);
end;

//-----------------------------------------------------------
// Devuelve la longitud del fichero cargado.
//-----------------------------------------------------------
function TDataManager.LongitudDelFichero: Integer;
begin
Result := Length(Datos);
end;

//-------------------------------------------------------------------
// Devuelve el texto del area seleccionada.
//-------------------------------------------------------------------
function TDataManager.TextoDelAreaSeleccionada(Inicio: Integer;         //Inicio de la primera de las cadenas.
                                               Ancho: Integer;          //Longitud de las cadenas de datos.
                                               Altura: Integer;         //Cantidad de repeticiones de las cadenas.
                                               Periodo: Integer         //Período de repetición de las cadenas.
                                               ): TStringList;
var n, m, a: Integer;
    s: AnsiString;
begin
Result := TStringList.Create;
for n := 0 to Altura - 1 do
    begin
    s := '';
    for m := 0 to Ancho - 1 do
        begin
        a := Inicio + (n * Periodo + m);
        if (a >= 0) and (a < Length(Datos)) then s := s + Chr(Datos[a]);
        end;
    Result.Add(s);
    end;
end;

function TDataManager.TextoDelAreaSeleccionada(Seleccion: TDataSeleccion): TStringList;
begin
Result := TextoDelAreaSeleccionada(Seleccion.Inicio,
                                   Seleccion.Ancho,
                                   Seleccion.Altura,
                                   Seleccion.Periodo
                                   );
end;


//-------------------------------------------------------------------
// Busca una cadena dentro de la demodulación y si la encuentra,
// devuelve la posición del inicio de la cadena encontrada.
// Si no se encuentra la cadena, se devuelve MaxInt e informa
// mediante un diálogo la culminación de la búsqueda.
//-------------------------------------------------------------------
function TDataManager.BuscarPrimeraCoincidencia(Cadena: String): TCadenaEncontrada;
begin
FDatosDeBusqueda.BuscarDesde := 0;
FDatosDeBusqueda.Cadena := Cadena;
Result.Inicio := BuscarConFuerzaBruta(FDatosDeBusqueda.Cadena, 0);
if Result.Inicio <> MaxInt then
   begin
   FDatosDeBusqueda.Valido := True;
   FDatosDeBusqueda.BuscarDesde := Result.Inicio + Length(FDatosDeBusqueda.Cadena);
   Result.Final := Result.Inicio + Length(FDatosDeBusqueda.Cadena) - 1;
   end
else
   begin
   FDatosDeBusqueda.Valido := False;
   Result.Final := MaxInt;
   Application.MessageBox('Búsqueda terminada.', '', MB_OK);
   end;
end;


//-------------------------------------------------------------------
// Busca la siguiente coincidencia de la cadena dentro de la demodulación.
// Si no se encuentra la cadena, se devuelve MaxInt e informa
// mediante un diálogo la culminación de la búsqueda.
//-------------------------------------------------------------------
function TDataManager.BuscarSiguienteCoincidencia: TCadenaEncontrada;
begin
Result.Inicio := MaxInt;
if FDatosDeBusqueda.Valido then
   begin
   Result.Inicio := BuscarConFuerzaBruta(FDatosDeBusqueda.Cadena, FDatosDeBusqueda.BuscarDesde);
   if Result.Inicio <> MaxInt then
      begin
      FDatosDeBusqueda.Valido := True;
      FDatosDeBusqueda.BuscarDesde := Result.Inicio + Length(FDatosDeBusqueda.Cadena);
      Result.Final := Result.Inicio + Length(FDatosDeBusqueda.Cadena) - 1;
      end
   else
      begin
      FDatosDeBusqueda.Valido := False;
      Result.Final := MaxInt;
      Application.MessageBox('Búsqueda terminada.', '', MB_OK);
      end;
   end;
end;

//-------------------------------------------------------------------
// Implementa un algoritmo de búsqueda por fuerza bruta.
// Se puede sustituir luego por un Boyer-More u otro más rápido.  
//-------------------------------------------------------------------
function TDataManager.BuscarConFuerzaBruta(Cadena: String; BuscarDesde: Integer): Integer;
var n, m, LongCad, LongDat: Integer;
begin
Result := MaxInt;
LongCad := Length(Cadena);
LongDat := Length(Datos) - 1;
for n := BuscarDesde to LongDat - LongCad + 1 do
    begin
    m := 0;
    while (m < LongCad) and (Datos[n + m] = Ord(Cadena[m + 1])) do Inc(m);
    if m = LongCad then
       begin
       Result := n;
       Exit;
       end;
    end;
end;


end.
