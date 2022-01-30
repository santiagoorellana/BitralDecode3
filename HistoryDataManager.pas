unit HistoryDataManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataManager;

const C_HISTORY_MAX_COUNT = $0F;                 //Una máscara que determina la cantidad máxima de copias del historial.

type THistory = Array [0..C_HISTORY_MAX_COUNT]of TDataManager;

type
  THistoryDataManager = class(TComponent)
  private
     CopiaDeDatos: TCopyDataPeriod;              //Guarda los datos copiados y sus parámetros.
     FValido: Boolean;
     HistoryMin: DWORD;                          //Apunta al momento anterior más lejano, al que se puede retroceder.
     HistoryMax: DWORD;                          //Apunta al momento siguiente más lejano, al que se puede avanzar.
     FOnDataChange: TNotifyEvent;                //Varaible del evento que informa cambios en lops datos.
     FOnSimbolChange: TNotifyEvent;              //Informa que se deben recalcular los colores del raster.
  protected
  public
     Modificado: Boolean;
     DemodulationFileName: String;
     History: THistory;                          //Guarda el historial de la edición del raster.
     HistoryMoment: DWORD;                       //Apunta al estado actual de los datos dentro del historial.

     constructor Create;
     function Valido: Boolean;
     //Métodos de ficheros.
     procedure CargarDemodulacion(NombreFichero: String);
     procedure GuardarFichero(nombreFichero: String);
     procedure GuardarCambios;
     procedure BuscarYCargarDemodulacion;
     procedure BuscarYGuardarFicheroComo;
     //Métodos de historial.
     function EstadoAnterior: Boolean;
     function EstadoSiguiente: Boolean;
     //Métodos de trabajo con los datos.
     function Longitud: Integer;
     function LeerDato(posicion: Integer): Byte;
     procedure InsertarDato(posicion: Integer; Dato: Byte);
     procedure PrepararParaEdicion;
     function OptenerCantidadDeSimbolos: Integer;
     procedure CambiarCantidadDeSimbolos(cantidad: Integer);
     //Métodos de edición.
     procedure SustituirDatos(Inicio, Ancho, Altura, Periodo: Integer; Sustituto: Byte); overload;
     procedure SustituirDatos(Seleccion: TDataSeleccion; Sustituto: Byte); overload;
     procedure CopiarDatos(Inicio, Ancho, Altura, Periodo: Integer); overload;
     procedure CopiarDatos(Seleccion: TDataSeleccion); overload;
     procedure PegarDatosCopiados(Inicio: Integer);
     procedure InsertarDatos(Inicio: Integer; Lugar: TLugar; Cadena: String);
     procedure ConvertirEnBinario(Simbolos: TStringList);
     procedure EliminarDatos(Inicio, Ancho, Altura, Periodo: Integer); overload;
     procedure EliminarDatos(Seleccion: TDataSeleccion); overload;
     function ContarSimbolos: Integer;
     procedure FiltrarDatos;
     function TextoDelAreaSeleccionada(Inicio, Ancho, Altura, Periodo: Integer): TStringList; overload;
     function TextoDelAreaSeleccionada(Seleccion: TDataSeleccion): TStringList; overload;
     function BuscarPrimeraCoincidencia(Cadena: String): TCadenaEncontrada;
     function BuscarSiguienteCoincidencia: TCadenaEncontrada;
  published
     //Nuevos eventos de este componente.
     property OnDataChange:TNotifyEvent read FOnDataChange Write FOnDataChange;
     property OnSimbolChange:TNotifyEvent read FOnSimbolChange Write FOnSimbolChange;
  end;


implementation

uses Frame;

/////////////////////////////////////////////////////////////////////////////
////////  FUNCIONES PÚBLICAS  ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

constructor THistoryDataManager.Create;
var n: Integer;
begin
FValido := False;
Modificado := False;
DemodulationFileName := '';            //No se ha cargado ningún fichero.
HistoryMoment := 0;
HistoryMin := HistoryMoment;
HistoryMax := HistoryMoment;
for n := 0 to C_HISTORY_MAX_COUNT do   //Vacía el historial;
    History[n] := nil;
end;

//-------------------------------------------------------------------
// Indica si el objeto contiene datos válidos.
//-------------------------------------------------------------------
function THistoryDataManager.Valido: Boolean;
begin
//Result := FValido;
end;


//-------------------------------------------------------------------
// Carga los datos de un fichero e inicia el historial de edición.
// Los parámetros son los siguientes:
//
// NombreFichero: Nombre del fichero.
//-------------------------------------------------------------------
procedure THistoryDataManager.CargarDemodulacion(NombreFichero: String);
var n: Integer;
begin
if FileExists(NombreFichero) then
   begin
   for n := 0 to C_HISTORY_MAX_COUNT do                                 //Borra toda la historia anterior.
       if Assigned(History[n]) then History[n].Free;                    //Si existe un objeto en esta posición, lo borra.
   DemodulationFileName := NombreFichero;                               //Guarda el nombre del fichero.
   HistoryMoment := 0;                                                  //Inicia el momento de la historia de edición.
   HistoryMin := HistoryMoment;                                         //No se puede retroceder.
   HistoryMax := HistoryMoment;                                         //No se puede avanzar.
   History[HistoryMoment] := TDataManager.Create;                       //Crea el objeto que maneja los datos.
   History[HistoryMoment].CargarDesdeFichero(NombreFichero);            //Carga los datos desde el fichero.
   FValido := True;
   Modificado := False;
   if Assigned(FOnDataChange) then FOnDataChange(Self);
   end;
end;

//-------------------------------------------------------------------
// Abre un diálogo que permite buscar y seleccionar un fichero
// para cargarlo e inicia el historial de edición.
//-------------------------------------------------------------------
procedure THistoryDataManager.BuscarYCargarDemodulacion;
var dlg: TOpenDialog;
begin
dlg := TOpenDialog.Create(Self);                                               //Crea un diálogo.
dlg.Title := 'Cargar demodulación...';                                         //Título del diálogo.
dlg.Filter := 'Ficheros de texto (*.txt)|*.TXT|Todos los ficheros (*.*)|*.*';  //Tipos de ficheros que se muestran.
if dlg.Execute then
   if FileExists(dlg.FileName) then                                            //Si el fichero existe, se carga.
      CargarDemodulacion(dlg.FileName);
dlg.Free;                                                                      //Destruye el diálogo creado.
end;

//-------------------------------------------------------------------
// Guarda los cambios realizados en la edición.
//-------------------------------------------------------------------
procedure THistoryDataManager.GuardarCambios;
begin
GuardarFichero(DemodulationFileName);
end;

//-------------------------------------------------------------------
// Guarda los datos del momento actual en un fichero.
//-------------------------------------------------------------------
procedure THistoryDataManager.GuardarFichero(nombreFichero: String);
begin
if Assigned(History[HistoryMoment]) then
   begin
   MainForm.RutaParaGuardarDemodulaciones := nombreFichero;
   DemodulationFileName := nombreFichero;
   History[HistoryMoment].SalvarEnFichero(DemodulationFileName);
   Modificado := False;
   end;
end;

//-------------------------------------------------------------------
// Abre un diálogo que permite buscar y seleccionar un directorio
// para guardar los datos en un fichero.
//-------------------------------------------------------------------
procedure THistoryDataManager.BuscarYGuardarFicheroComo;
var dlg: TSaveDialog;
begin
dlg := TSaveDialog.Create(Self);                                               //Crea un diálogo.
dlg.InitialDir := MainForm.RutaParaGuardarDemodulaciones;
dlg.Title := 'Guardar demodulación como...';                                   //Título del diálogo.
dlg.DefaultExt := 'TXT';                                                       //Si no se pone extensión, se toma esta.
dlg.Filter := 'Ficheros de texto (*.txt)|*.TXT|Todos los ficheros (*.*)|*.*';  //Tipos de ficheros que se muestran.
if dlg.Execute then GuardarFichero(dlg.FileName);                              //Guarda el fichero.
dlg.Free;                                                                      //Destruye el diálogo creado.
end;

//-------------------------------------------------------------------
// Retrocede un paso en el historial, si es posible.
//-------------------------------------------------------------------
function THistoryDataManager.EstadoAnterior: Boolean;
begin
Result := False;
if HistoryMoment <> MaxInt then
   if HistoryMoment <> HistoryMin then
      begin
      HistoryMoment := (HistoryMoment - 1) and C_HISTORY_MAX_COUNT;
      Result := True;
      Modificado := True;
      if Assigned(FOnDataChange) then FOnDataChange(Self);
      end;
end;

//-------------------------------------------------------------------
// Avanza un paso en el historial, si es posible.
//-------------------------------------------------------------------
function THistoryDataManager.EstadoSiguiente: Boolean;
begin
Result := False;
if HistoryMoment <> MaxInt then
   if HistoryMoment <> HistoryMax then
      begin
      HistoryMoment := (HistoryMoment + 1) and C_HISTORY_MAX_COUNT;
      Result := True;
      Modificado := True;
      if Assigned(FOnDataChange) then FOnDataChange(Self);
      end;
end;


//-------------------------------------------------------------------
// Devuelve la longitud de los datos.
//-------------------------------------------------------------------
function THistoryDataManager.Longitud: Integer;
begin
Result := 0;
if History[HistoryMoment] <> nil then
   if History[HistoryMoment].Datos <> nil then
      Result := length(History[HistoryMoment].Datos);
end;

//-------------------------------------------------------------------
// Devuelve el dato de la posición indicada.
//-------------------------------------------------------------------
function THistoryDataManager.LeerDato(posicion: Integer): Byte;
begin
Result := 0;
if (posicion >= 0)and(posicion < Longitud) then
   Result := History[HistoryMoment].Datos[posicion];
end;

//-------------------------------------------------------------------
// Sustituye el dato de la posición indicada.
//-------------------------------------------------------------------
procedure THistoryDataManager.InsertarDato(posicion: Integer; Dato: Byte);
begin
if (posicion > 0)and(posicion < Longitud) then
   begin
   History[HistoryMoment].Datos[posicion] := Dato;
   Modificado := True;
   if Assigned(FOnDataChange) then FOnDataChange(Self);
   end;
end;


//-------------------------------------------------------------------
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
procedure THistoryDataManager.SustituirDatos(Inicio: Integer;         //Inicio de la primera de las cadenas a eliminar.
                                             Ancho: Integer;          //Longitud de las cadenas de datos.
                                             Altura: Integer;         //Cantidad de repeticiones de las cadenas.
                                             Periodo: Integer;        //Período de repetición de las cadenas.
                                             Sustituto: Byte          //Dato con el que se van a llenar las cadenas.
                                             );
begin
PrepararParaEdicion;
History[HistoryMoment].SustituirDatos(Inicio, Ancho, Altura, Periodo, Sustituto);
Modificado := True;
if Assigned(FOnDataChange) then FOnDataChange(Self);
end;

procedure THistoryDataManager.SustituirDatos(Seleccion : TDataSeleccion;   //Datos de las cadenas periódicas.
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
procedure THistoryDataManager.CopiarDatos(Inicio: Integer;         //Inicio de la primera de las cadenas.
                                          Ancho: Integer;          //Longitud de las cadenas de datos.
                                          Altura: Integer;         //Cantidad de repeticiones de las cadenas.
                                          Periodo: Integer         //Período de repetición de las cadenas.
                                          );
begin
PrepararParaEdicion;
CopiaDeDatos := History[HistoryMoment].CopiarDatos(Inicio, Ancho, Altura, Periodo);
if Assigned(FOnDataChange) then FOnDataChange(Self);
end;

procedure THistoryDataManager.CopiarDatos(Seleccion : TDataSeleccion);
begin
CopiarDatos(Seleccion.Inicio,
            Seleccion.Ancho,
            Seleccion.Altura,
            Seleccion.Periodo
            );
end;

//-------------------------------------------------------------------
// Pega las cadenas copiadas. Los parámetros son los siguientes:
//
// Inicio: Posición a partir de la cual se pegarán las cadenas.
//-------------------------------------------------------------------
procedure THistoryDataManager.PegarDatosCopiados(Inicio: Integer);
begin
PrepararParaEdicion;
History[HistoryMoment].PegarDatosCopiados(Inicio, CopiaDeDatos);
Modificado := True;
if Assigned(FOnDataChange) then FOnDataChange(Self);
end;


//-------------------------------------------------------------------
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
procedure THistoryDataManager.EliminarDatos(Inicio: Integer;         //Inicio de la primera de las cadenas a eliminar.
                                            Ancho: Integer;          //Longitud de las cadenas de datos.
                                            Altura: Integer;         //Cantidad de repeticiones de las cadenas.
                                            Periodo: Integer         //Período de repetición de las cadenas.
                                            );
begin
PrepararParaEdicion;
History[HistoryMoment].EliminarDatos(Inicio, Ancho, Altura, Periodo);
Modificado := True;
if Assigned(FOnDataChange) then FOnDataChange(Self);
end;

procedure THistoryDataManager.EliminarDatos(Seleccion : TDataSeleccion);
begin
EliminarDatos(Seleccion.Inicio,
              Seleccion.Ancho,
              Seleccion.Altura,
              Seleccion.Periodo
              );
end;



//-------------------------------------------------------------------
// Inserta una cadena de caracteres antes o despues de la
// posición indicada.
//
// Los parámetros son los siguientes:
//
// Inicio:        Posición de inserción.
// Lugar:         Indica si se debe insertar antes o después.
// Cadena:        Contiene los caracteres que se deben insertar.
//-------------------------------------------------------------------
procedure THistoryDataManager.InsertarDatos(Inicio: Integer;         //Posición de inserción.
                                            Lugar: TLugar;           //Indica si se debe insertar antes o después.
                                            Cadena: String           //Contiene los caracteres que se deben insertar.
                                            );
begin
PrepararParaEdicion;
History[HistoryMoment].InsertarDatos(Inicio, Lugar, Cadena);
Modificado := True;
if Assigned(FOnDataChange) then FOnDataChange(Self);
end;

//-------------------------------------------------------------------
// Convierte la demodulación en binarios
// Se le pasa una lista con las combinaciones de ceros y unos
// que sustituirán a los símbolos de la demodulación. Por ejemplo:
// 00, 01, 10, 11. Note que los ceros a la izquierda deben ponerse.
//-------------------------------------------------------------------
procedure THistoryDataManager.ConvertirEnBinario(Simbolos: TStringList);
begin
if Simbolos.Count < 2 then Exit;
PrepararParaEdicion;
History[HistoryMoment].ConvertirEnBinario(Simbolos);
Modificado := True;
if Assigned(FOnDataChange) then FOnDataChange(Self);
if Assigned(FOnSimbolChange) then FOnSimbolChange(Self);
end;


//-------------------------------------------------------------------
// Elimina los caracteres que no son válidos para una demodulación.
//-------------------------------------------------------------------
function THistoryDataManager.ContarSimbolos: Integer;
begin
PrepararParaEdicion;
Result := History[HistoryMoment].ContarSimbolos;
Modificado := True;
if Assigned(FOnDataChange) then FOnDataChange(Self);
if Assigned(FOnSimbolChange) then FOnSimbolChange(Self);
end;


//-------------------------------------------------------------------
// Inserta en el historial una copia de los datos actuales para
// editar sobre ellos.
//-------------------------------------------------------------------
procedure THistoryDataManager.PrepararParaEdicion;
var n: Integer;
    Momento: Integer;
begin
Momento := (HistoryMoment + 1) and C_HISTORY_MAX_COUNT;                             //Calcula próxima posición.
History[Momento] := TDataManager.Create;
SetLength(History[Momento].Datos, History[HistoryMoment].LongitudDelFichero);       //Reserva espacio para la copia de los datos.
for n := 0 to History[HistoryMoment].LongitudDelFichero - 1 do                      //Copia los datos.
    History[Momento].Datos[n] := History[HistoryMoment].Datos[n];
History[Momento].CantidadDeSimbolos := History[HistoryMoment].CantidadDeSimbolos;
HistoryMoment := Momento;
HistoryMax := HistoryMoment;
if HistoryMoment = HistoryMin then HistoryMin := HistoryMoment + 1;
end;

//-------------------------------------------------------------------
// Devuelve el texto del area seleccionada.
//-------------------------------------------------------------------
function THistoryDataManager.TextoDelAreaSeleccionada(Inicio: Integer;
                                                      Ancho: Integer;
                                                      Altura: Integer;
                                                      Periodo: Integer
                                                      ): TStringList;
begin
Result := History[HistoryMoment].TextoDelAreaSeleccionada(Inicio,
                                                          Ancho,
                                                          Altura,
                                                          Periodo
                                                          );
end;

function THistoryDataManager.TextoDelAreaSeleccionada(Seleccion : TDataSeleccion): TStringList;
begin
Result := History[HistoryMoment].TextoDelAreaSeleccionada(Seleccion.Inicio,
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
function THistoryDataManager.BuscarPrimeraCoincidencia(Cadena: String): TCadenaEncontrada;
begin
Result := History[HistoryMoment].BuscarPrimeraCoincidencia(Cadena);
end;


//-------------------------------------------------------------------
// Busca la siguiente coincidencia de la cadena.
// Si no se encuentra la cadena, se devuelve MaxInt e informa
// mediante un diálogo la culminación de la búsqueda.
//-------------------------------------------------------------------
function THistoryDataManager.BuscarSiguienteCoincidencia: TCadenaEncontrada;
begin
Result := History[HistoryMoment].BuscarSiguienteCoincidencia;
end;

//-------------------------------------------------------------------
// 23/2/2012
// Elimina los caracteres que no pertececen a los
// símbolos de la demodulación.
//-------------------------------------------------------------------
procedure THistoryDataManager.FiltrarDatos;
begin
PrepararParaEdicion;
History[HistoryMoment].FiltrarDatos;
Modificado := True;
if Assigned(FOnDataChange) then FOnDataChange(Self);
end;

//-------------------------------------------------------------------
// Devuelve la cantidad de símbolos de la demodulación.
//-------------------------------------------------------------------
function THistoryDataManager.OptenerCantidadDeSimbolos: Integer;
begin
Result := History[HistoryMoment].CantidadDeSimbolos;
end;

//-------------------------------------------------------------------
// Modifica la cantidad de símbolos de la demodulación.
//-------------------------------------------------------------------
procedure THistoryDataManager.CambiarCantidadDeSimbolos(cantidad: Integer);
begin
History[HistoryMoment].CantidadDeSimbolos := cantidad;
Modificado := True;
if Assigned(FOnDataChange) then FOnDataChange(Self);
if Assigned(FOnSimbolChange) then FOnSimbolChange(Self);
end;



end.
