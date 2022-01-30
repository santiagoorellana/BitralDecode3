///////////////////////////////////////////////////////////////////////////
//      Objeto: TComparadorDeFicheros                                    //
//       Autor: Santiago A. Orellana P�rez.                              //
//       Fecha: 2011                                                     //
// Descripci�n: Compara dos ficheros.                                    //
///////////////////////////////////////////////////////////////////////////

unit UBuscaPeriodos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, ExtCtrls, ComCtrls, UListaSegmentos, UFuenteDeDemodulacion, HistoryDataManager;


type TPeriodo = record                                 //Guarda los datos de un p�r�odo.
                Periodo: Integer;
                Peso: Integer;
                end;

type TEstadistica = Array of TPeriodo;

type TDatos = Array of Byte;

     TDataPeriod = record
                   Inicio: Integer;         //Posici�n de inicio de la primera de las cadenas.
                   Longitud: Integer;       //Longitud de las cadenas de datos.
                   Repeticiones: Integer;   //Cantidad de cadenas.
                   Periodo: Integer         //Per�odo de repetici�n de las cadenas.
                   end;

     TCopyDataPeriod = record
                       Copia: TDatos;
                       Parametros: TDataPeriod;
                       end;


type TBuscadorDePeriodos = class(TThread)
     private
        Lista: TLista;
        PakData: TDatos;
        FDesde: Integer;
        FHasta: Integer;
        FAlgoritmo: Integer;
        FResolucion: Integer;
        FPrioridad: Integer;
        FEliminarArmonicos: Boolean;
        EstadisticasDePeriodos: TEstadistica;
        Segmentacion: Integer;
        function GetPakBit(posicion: Integer): Boolean;
        procedure SetPakBit(posicion: Integer; bit: Boolean);
        procedure MarcarRepeticion(Inicio, Final: Integer);
        procedure BuscarPeriodos;
        procedure QuickSort(desde, hasta: Integer);
        procedure PatronesDeAreasEnElRango(Desde, Hasta: Integer);
        procedure PatronesDeAreas;
        procedure PatronesDeAreasIIEnElRango(Desde, Hasta: Integer);
        procedure PatronesDeAreasII;
        procedure SumatoriaDeRepeticionesEnElRango(Desde, Hasta: Integer);
        procedure SumatoriaDeRepeticiones;
        function LongitudDeDatos: Integer;
     protected
        procedure Execute; override;
     public
        FuenteDeDatos: THistoryDataManager;
        PeriodosEncontrados: TStringList;
        constructor Create;
        destructor Destroy;
        procedure Parametros(Desde, Hasta, Algoritmo, Resolucion, Prioridad: Integer; EliminarArmonicos: Boolean);
     end;



implementation

uses Types;


//-------------------------------------------------------------------
// Crea un comparador de ficheros y lo prepara para trabajar.
//-------------------------------------------------------------------
constructor TBuscadorDePeriodos.Create;
begin
FreeOnTerminate := False;                    //El objeto subproceso no se destruye al terminar.
PeriodosEncontrados := TStringList.Create;
inherited Create(True);                      //Crea el subproceso.
end;


//-------------------------------------------------------------------
// Destruye el comparador de ficheros.
//-------------------------------------------------------------------
destructor TBuscadorDePeriodos.Destroy;
begin
inherited Destroy;
end;


//-------------------------------------------------------------------
// Devuelve la longitud de los datos.
//-------------------------------------------------------------------
function TBuscadorDePeriodos.LongitudDeDatos: Integer;
begin
Result := FuenteDeDatos.Longitud;
end;


//-------------------------------------------------------------------
// Inicia el funcionamiento del subproceso.
//-------------------------------------------------------------------
procedure TBuscadorDePeriodos.Execute;
begin
BuscarPeriodos;
end;


//------------------------------------------------------------------------------
// Establece los par�metros de funcionamiento del algoritmo.
//------------------------------------------------------------------------------
procedure TBuscadorDePeriodos.Parametros(Desde, Hasta, Algoritmo, Resolucion, Prioridad: Integer; EliminarArmonicos: Boolean);
begin
if Hasta >= Desde then
   begin
   FDesde := Desde;
   FHasta := Hasta;
   end
else
   begin
   FDesde := Hasta;
   FHasta := Desde;
   end;
FAlgoritmo := Algoritmo;
FResolucion := Resolucion;
FPrioridad := Prioridad;
FEliminarArmonicos := EliminarArmonicos;
end;

//------------------------------------------------------------------------------
// Compara dos ficheros.
// Chequea constantemente la variable Terminated para salir si el usuario
// requiere detener el subproceso de comparaci�n.
//------------------------------------------------------------------------------
procedure TBuscadorDePeriodos.BuscarPeriodos;
begin
if Terminated then Exit;
case FPrioridad of                                                     //Establece la prioridad del subproceso.
     0: begin
        SetPriorityClass(GetCurrentProcess, NORMAL_PRIORITY_CLASS);           //Ejecuta el c�digo a su velocidad normal.
        SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_NORMAL);
        end;
     1: begin
        SetPriorityClass(GetCurrentProcess, NORMAL_PRIORITY_CLASS);           //Ejecuta el c�digo r�pidamente.
        SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_ABOVE_NORMAL);
        end;
     2: begin
        SetPriorityClass(GetCurrentProcess, REALTIME_PRIORITY_CLASS);         //Ejecuta el c�digo a su m�xima velocidad.
        SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_TIME_CRITICAL);
        end;
     end;
if Terminated then Exit;
if not Assigned(FuenteDeDatos)then Exit;                                      //Si el fichero no han sido cargado, abandona el algoritmo.
case FAlgoritmo of                                                            //Selecciona el algoritmo de b�squeda.
     0: PatronesDeAreas;
     1: SumatoriaDeRepeticiones;
     2: PatronesDeAreasII;
     end;
SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_NORMAL);                  //Devuelve el subproceso su prioridad normal.
end;


//-------------------------------------------------------------------
function TBuscadorDePeriodos.GetPakBit(posicion: Integer): Boolean;
begin
Result := (PakData[posicion div 8] and  + (1 shl (posicion mod 8))) > 0;
end;

//-------------------------------------------------------------------
procedure TBuscadorDePeriodos.SetPakBit(posicion: Integer; bit: Boolean);
begin
PakData[posicion div 8] := PakData[posicion div 8] or (1 shl (posicion mod 8));
end;


//-------------------------------------------------------------------
// 2/12/2011
// Organiza la lista de per�odos de mayor a menor.
//-------------------------------------------------------------------

procedure TBuscadorDePeriodos.QuickSort(desde, hasta: Integer);
var Lo, Hi: Integer;
    medio: Integer;
    T: TPeriodo;
begin
if Terminated then Exit;
Lo := desde;
Hi := hasta;
medio := EstadisticasDePeriodos[(Lo + Hi) div 2].Peso;
repeat
   while EstadisticasDePeriodos[Lo].Peso > medio do Inc(Lo);
   while EstadisticasDePeriodos[Hi].Peso < medio do Dec(Hi);
   if Lo <= Hi then
      begin
      T := EstadisticasDePeriodos[Lo];
      EstadisticasDePeriodos[Lo] := EstadisticasDePeriodos[Hi];
      EstadisticasDePeriodos[Hi] := T;
      Inc(Lo);
      Dec(Hi);
      end;
until Lo > Hi;
if Hi > desde then QuickSort(desde, Hi);
if Lo < hasta then QuickSort(Lo, hasta);
end;

//-------------------------------------------------------------------
// 3/12/2011
// Calcula el solapamiento entre dos segmentos de diferentes columnas.
//-------------------------------------------------------------------

function SolapamientoEntre(s1, s2: TSegmento): Integer;
var r1, r2, c1, c2: Double;
    d: Integer;
begin
if Abs(s1.Columna - s2.Columna) = 1  then
   begin
   d := Abs(s1.Columna - s2.Columna);
   r1 := (s1.Final - s1.Inicio) / 2;
   r2 := (s2.Final - s2.Inicio) / 2;
   c1 := (s1.Final + s1.Inicio) / 2;
   c2 := (s2.Final + s2.Inicio) / 2;
   Result := Round((r1 + r2 - (Abs(c1 - c2) + Abs(r1 - r2))) / d);
   if Result < 0 then Result := 0;
   end
else
   Result := 0;
end;


//-------------------------------------------------------------------
procedure TBuscadorDePeriodos.MarcarRepeticion(Inicio, Final: Integer);
var n: Integer;
begin
for n := Inicio to Final do SetPakBit(n, True);
end;


//-------------------------------------------------------------------
// 3/12/2011
//
// Algoritmo: PatronesDeAreas
//
// Encuentra los per�odos de la se�al utilizando el siguiente
// m�todo:
//
// Busca las repeticiones continuas en cada columna y guarda
// su posici�n de inicio y final. Luego busca las intersecciones
// o solapamiento de los fragmentos de diferentes columnas.
// El per�odo en el que m�s cantidad de intersecciones de
// columnas consecutivas se produscan, tiene mayor probabilidad
// de ser un candidato positivo.
//-------------------------------------------------------------------

procedure TBuscadorDePeriodos.PatronesDeAreas;
var Periodo: Integer;                                                                  //Mantiene el valor del per�odo en el que se est� realizando la b�squeda.
    Explorador: Integer;                                                               //Recorre la columna comparando los valores consecutivos.
    Repeticiones: Integer;                                                             //Almacena la cantidad de repeticiones de los fragmentos que son encontrados.
    Inicio, EmpezarEn, TerminarEn, n, m, k: Integer;                                   //Indica el inicio del fragmento.
begin
Segmentacion := FHasta * (FResolucion + 1);                                            //Tama�o de los fragmentos en que se dividen los ficheros para ser analizados.
SetLength(EstadisticasDePeriodos, FHasta + 1);                                         //Asigna memoria a las estad�sticas de per�odo.
for n := FDesde to FHasta do
    begin
    if Terminated then Exit;
    EstadisticasDePeriodos[n].Periodo := 0;
    EstadisticasDePeriodos[n].Peso := 0;
    end;

SetLength(PakData, LongitudDeDatos);

//Marca las grandes repeticiones consecutivas que existen en la cadena de datos, para que sean despreciadas en la b�squeda.
 for n := 0 to Length(PakData) - 1 do PakData[n] := 0;                                 //Borra las marcas de repeticiones.
Repeticiones := 0;                                                                     //Inicia el contador de repeticiones.
Explorador := 1;
Inicio := Explorador - 1;                                                              //Establece el inicio del primer segmento de repetici�n que se encontrar�.
while Explorador < LongitudDeDatos do                                                  //Mientras la posici�n se encuentre dentro del arreglo de datos:
      begin
      if Terminated then Exit;
      if FuenteDeDatos.LeerDato(Explorador) = FuenteDeDatos.LeerDato(Explorador - 1) then                                //Si los datos son iguales:
         Inc(Repeticiones)                                                             //Incrementa el contador de repeticiones.
      else
         begin                                                                         //Si los datos son diferentes: Busca una nueva repetici�n.
         m := FResolucion * FDesde;
         if Repeticiones >= m then                                                     //Si el segmento de repetici�n encontrado es lo suficientemente grande:
            begin
            MarcarRepeticion(Inicio, Explorador - 1);                                  //Guarda los datos del segmento de repetici�n encontrado.
            end;
         Inicio := Explorador;                                                         //Establece el inicio del pr�ximo segmento de repetici�n que se encontrar�.
         Repeticiones := 0;                                                            //Inicia el contador de repeticiones de segmento.
         end;
      Inc(Explorador);                                                                 //Incrementa para la siguiente comparaci�n.
      end;

//Divide el fichero en fragmentos y en cada uno busca los per�odos.
if Terminated then Exit;
k := 1;                                                                                //Se comienza siempre por 1.
while k < LongitudDeDatos do                                                           //Repetir esto hasta que se analicen todos los fragmentos.
      begin
      if Terminated then Exit;
      EmpezarEn := K;                                                                  //Inicio del fragmento.
      TerminarEn := K + Segmentacion;                                                  //Final del fragmento.
      if TerminarEn > LongitudDeDatos - 1 then                                         //Si el final del fragmento sobrepasa al final del fichero:
         TerminarEn := LongitudDeDatos - 1;                                            //Se utiliza como final del fragmento el final del fichero.
      PatronesDeAreasEnElRango(EmpezarEn, TerminarEn);                                 //Busca per�odos en este fragmento.
      Inc(K, Segmentacion);                                                            //Incrementa para buscar en el otro fragmento.
      end;

//Ordena los resultados (Rasters) de acuerdo con las probabilidades de periodicidad calculadas.
if Terminated then Exit;
QuickSort(0, FHasta);                                                                  //Ordena los per�odos encontrados de mayor a menor seg�n su estad�stica.
//Elimina los arm�nicos (m�ltiplos) superiores de los resultados intentando quedarse siempre con el menor.
if Terminated then Exit;
if FEliminarArmonicos then
   for n := FDesde to FHasta do                                                                            //Este algoritmo es para eliminar los arm�nicos superiores de los per�odos.
       begin
       if Terminated then Exit;
       if EstadisticasDePeriodos[n].Peso > 0 then                                                          //Si el per�odo primitivo tiene un peso mayor que cero:
          for m := n to FHasta do                                                                          //Intenta eliminar los arm�nicos que tengan menor peso.
              begin
              if Terminated then Exit;
              if EstadisticasDePeriodos[n].Periodo < EstadisticasDePeriodos[m].Periodo then                //Si el per�odo es superior al primitivo, verifica si es un m�ltiplo.
                 if EstadisticasDePeriodos[m].Periodo mod EstadisticasDePeriodos[n].Periodo > 0 then       //Si es un m�ltiplo del per�odo primitivo:
                    EstadisticasDePeriodos[m].Peso := 0;                                                   //Elimina el per�odo m�ltiplo (arm�nico).
              end;
       end;

//Devuelve los datos en una lista.
if Terminated then Exit;
PeriodosEncontrados := TStringList.Create;
if not Assigned(PeriodosEncontrados) then exit;
for Periodo := 0 to FHasta do
    begin
    if Terminated then Exit;
    if EstadisticasDePeriodos[Periodo].Peso <> 0 then
       PeriodosEncontrados.Add(IntToStr(EstadisticasDePeriodos[Periodo].Periodo));
    end;
EstadisticasDePeriodos := nil;
end;


//-------------------------------------------------------------------
procedure TBuscadorDePeriodos.PatronesDeAreasEnElRango(Desde, Hasta: Integer);
var Periodo: Integer;                                                                  //Mantiene el valor del per�odo en el que se est� realizando la b�squeda.
    CantidadDeLineas: Integer;                                                         //Cantidad de l�neas que ser�n analizadas por cada per�odo.
    Columna: Integer;                                                                  //Columan en la cual se buscan los fragmentos de repeticiones.
    Explorador: Integer;                                                               //Recorre la columna comparando los valores consecutivos.
    Repeticiones: Integer;                                                             //Almacena la cantidad de repeticiones de los fragmentos que son encontrados.
    Inicio, n, m, Sumatoria: Integer;                                                  //Indica el inicio del fragmento.
begin
//Por cada per�odo, conforma el raster y busca las repeticiones consecutivas que se producen de forma vertical en cada columna de cada raster formado.
Lista := TLista.Create;                                                                //Crea una lista para guardar los segmentos de repeticiones.
for Periodo := FDesde to FHasta do                                                     //Por cada per�odo posible, realiza una b�squeda...
    begin
    if Terminated then Exit;
    Lista.Vaciar;
    CantidadDeLineas := LongitudDeDatos div Periodo;                                   //Calcula la cantidad de lineas con que se trabajar� la b�squeda.
    if CantidadDeLineas < FResolucion then Break;                                      //Si no son suficientes lineas para una b�squeda, detiene el algoritmo.

    for Columna := 0 to Periodo - 1 do                                                 //Por cada columna del raster que se simula en memoria: Busca las repeticiones.
        begin
        if Terminated then Exit;
        Repeticiones := 1;                                                             //Inicia el contador de repeticiones.
        Explorador := Desde + Periodo + Columna;
        Inicio := Explorador - Periodo;                                                //Establece el inicio del primer segmento de repetici�n que se encontrar�.
        while Explorador < Hasta do                                                    //Mientras la posici�n se encuentre dentro del l�mite definido:
              begin
              if Terminated then Exit;
              if (FuenteDeDatos.LeerDato(Explorador) = FuenteDeDatos.LeerDato(Explorador - Periodo))and                  //Si los datos son iguales y
                 (not GetPakBit(Explorador - Periodo))and                              //son posiciones v�lidas para
                 (not GetPakBit(Explorador))then                                       //realizar una comparaci�n:
                 Inc(Repeticiones)                                                     //Incrementa el contador de repeticiones.
              else
                 begin                                                                 //Si los datos son diferentes: Busca una nueva repetici�n.
                 if Repeticiones >= FResolucion then                                   //Si el segmento de repetici�n encontrado es lo suficientemente grande:
                    Lista.Agregar(Columna, Inicio, Explorador - Periodo);              //Guarda los datos del segmento de repetici�n encontrado.
                 Inicio := Explorador;                                                 //Establece el inicio del pr�ximo segmento de repetici�n que se encontrar�.
                 Repeticiones := 1;                                                    //Inicia el contador de repeticiones de segmento.
                 end;
              Inc(Explorador, Periodo);                                                //Incrementa para la siguiente comparaci�n.
              end;
        if Repeticiones >= FResolucion then                                            //Si el segmento de repetici�n encontrado es lo suficientemente grande:
           Lista.Agregar(Columna, Inicio, Explorador - Periodo);                       //Guarda los datos del segmento de repetici�n encontrado.
        end;

    //Busca las intersecciones (solapamientos) que se producen entre las repeticiones encontradas y calcula las probabilidades de que el raster contenga un per�odo.
    Sumatoria := 0;
    for n := 0 to Lista.Insertados - 1 do                                              //Busca los solapamientos o intersecciones entre los fragmentos.
        begin
        if Terminated then Exit;
        for m := 0 to Lista.Insertados - 1 do
            begin
            if Terminated then Exit;
            Inc(Sumatoria, SolapamientoEntre(Lista.Optener(n), Lista.Optener(m)));     //Acumula la suma de los solapamientos entre los segmentos o fragmentos de repeticiones.
            end;
        end;
    EstadisticasDePeriodos[Periodo].Periodo := Periodo;                                //Guarda el identificador del per�odo.
    Inc(EstadisticasDePeriodos[Periodo].Peso, Sumatoria);                              //Guarda la sumatoria de los solapamientos como estad�stica para este per�odo.
    end;
Lista.Destroy;                                                                         //Libera la memoria asignada a la lista.
end;


//-------------------------------------------------------------------
// 19/1/2012
//
// Algoritmo: SumatoriaDeRepeticiones
//
// Encuentra los per�odos de la se�al utilizando el siguiente
// m�todo:
//
// Suma la longitud de las repeticiones continuas encontradas en cada
// columna y devuelve este valor como probabilidad del per�odo.
//-------------------------------------------------------------------

procedure TBuscadorDePeriodos.SumatoriaDeRepeticiones;
var Periodo: Integer;                                                                  //Mantiene el valor del per�odo en el que se est� realizando la b�squeda.
    Explorador: Integer;                                                               //Recorre la columna comparando los valores consecutivos.
    Repeticiones: Integer;                                                             //Almacena la cantidad de repeticiones de los fragmentos que son encontrados.
    Inicio, EmpezarEn, TerminarEn, n, m, k: Integer;                                   //Indica el inicio del fragmento.
begin
Segmentacion := FHasta * (FResolucion + 1);                                            //Tama�o de los fragmentos en que se dividen los ficheros para ser analizados.
SetLength(EstadisticasDePeriodos, FHasta + 1);                                         //Asigna memoria a las estad�sticas de per�odo.
for n := FDesde to FHasta do
    begin
    if Terminated then Exit;
    EstadisticasDePeriodos[n].Periodo := 0;
    EstadisticasDePeriodos[n].Peso := 0;
    end;

SetLength(PakData, LongitudDeDatos);

//Marca las grandes repeticiones consecutivas que existen en la cadena de datos, para que sean despreciadas en la b�squeda.
 for n := 0 to Length(PakData) - 1 do PakData[n] := 0;                                 //Borra las marcas de repeticiones.
Repeticiones := 0;                                                                     //Inicia el contador de repeticiones.
Explorador := 1;
Inicio := Explorador - 1;                                                              //Establece el inicio del primer segmento de repetici�n que se encontrar�.
while Explorador < LongitudDeDatos do                                                  //Mientras la posici�n se encuentre dentro del arreglo de datos:
      begin
      if Terminated then Exit;
      if FuenteDeDatos.LeerDato(Explorador) = FuenteDeDatos.LeerDato(Explorador - 1) then                                //Si los datos son iguales:
         Inc(Repeticiones)                                                             //Incrementa el contador de repeticiones.
      else
         begin                                                                         //Si los datos son diferentes: Busca una nueva repetici�n.
         m := FResolucion * FDesde;
         if Repeticiones >= m then                                                     //Si el segmento de repetici�n encontrado es lo suficientemente grande:
            begin
            MarcarRepeticion(Inicio, Explorador - 1);                                  //Guarda los datos del segmento de repetici�n encontrado.
            end;
         Inicio := Explorador;                                                         //Establece el inicio del pr�ximo segmento de repetici�n que se encontrar�.
         Repeticiones := 0;                                                            //Inicia el contador de repeticiones de segmento.
         end;
      Inc(Explorador);                                                                 //Incrementa para la siguiente comparaci�n.
      end;

//Divide el fichero en fragmentos y en cada uno busca los per�odos.
if Terminated then Exit;
k := 1;                                                                                //Se comienza siempre por 1.
while k < LongitudDeDatos do                                                           //Repetir esto hasta que se analicen todos los fragmentos.
      begin
      if Terminated then Exit;
      EmpezarEn := K;                                                                  //Inicio del fragmento.
      TerminarEn := K + Segmentacion;                                                  //Final del fragmento.
      if TerminarEn > LongitudDeDatos - 1 then                                         //Si el final del fragmento sobrepasa al final del fichero:
         TerminarEn := LongitudDeDatos - 1;                                            //Se utiliza como final del fragmento el final del fichero.
      SumatoriaDeRepeticionesEnElRango(EmpezarEn, TerminarEn);                         //Busca per�odos en este fragmento.
      Inc(K, Segmentacion);                                                            //Incrementa para buscar en el otro fragmento.
      end;

//Ordena los resultados (Rasters) de acuerdo con las probabilidades de periodicidad calculadas.
if Terminated then Exit;
QuickSort(0, FHasta);                                                                  //Ordena los per�odos encontrados de mayor a menor seg�n su estad�stica.
//Elimina los arm�nicos (m�ltiplos) superiores de los resultados intentando quedarse siempre con el menor.
if Terminated then Exit;
if FEliminarArmonicos then
   for n := FDesde to FHasta do                                                                            //Este algoritmo es para eliminar los arm�nicos superiores de los per�odos.
       begin
       if Terminated then Exit;
       if EstadisticasDePeriodos[n].Peso > 0 then                                                          //Si el per�odo primitivo tiene un peso mayor que cero:
          for m := n to FHasta do                                                                          //Intenta eliminar los arm�nicos que tengan menor peso.
              begin
              if Terminated then Exit;
              if EstadisticasDePeriodos[n].Periodo < EstadisticasDePeriodos[m].Periodo then                //Si el per�odo es superior al primitivo, verifica si es un m�ltiplo.
                 if EstadisticasDePeriodos[m].Periodo mod EstadisticasDePeriodos[n].Periodo > 0 then       //Si es un m�ltiplo del per�odo primitivo:
                    EstadisticasDePeriodos[m].Peso := 0;                                                   //Elimina el per�odo m�ltiplo (arm�nico).
              end;
       end;

//Devuelve los datos en una lista.
if Terminated then Exit;
PeriodosEncontrados := TStringList.Create;
if not Assigned(PeriodosEncontrados) then exit;
for Periodo := 0 to FHasta do
    begin
    if Terminated then Exit;
    if EstadisticasDePeriodos[Periodo].Peso <> 0 then
       PeriodosEncontrados.Add(IntToStr(EstadisticasDePeriodos[Periodo].Periodo));
    end;
EstadisticasDePeriodos := nil;
end;


//-------------------------------------------------------------------
procedure TBuscadorDePeriodos.SumatoriaDeRepeticionesEnElRango(Desde, Hasta: Integer);
var Periodo: Integer;                                                                  //Mantiene el valor del per�odo en el que se est� realizando la b�squeda.
    CantidadDeLineas: Integer;                                                         //Cantidad de l�neas que ser�n analizadas por cada per�odo.
    Columna: Integer;                                                                  //Columan en la cual se buscan los fragmentos de repeticiones.
    Explorador: Integer;                                                               //Recorre la columna comparando los valores consecutivos.
    Repeticiones: Integer;                                                             //Almacena la cantidad de repeticiones de los fragmentos que son encontrados.
    Inicio, Sumatoria: Integer;                                                  //Indica el inicio del fragmento.
begin
//Por cada per�odo, conforma el raster y busca las repeticiones consecutivas que se producen de forma vertical en cada columna de cada raster formado.
for Periodo := FDesde to FHasta do                                                     //Por cada per�odo posible, realiza una b�squeda...
    begin
    if Terminated then Exit;
    CantidadDeLineas := LongitudDeDatos div Periodo;                                   //Calcula la cantidad de lineas con que se trabajar� la b�squeda.
    if CantidadDeLineas < FResolucion then Break;                                      //Si no son suficientes lineas para una b�squeda, detiene el algoritmo.
    Sumatoria := 0;
    for Columna := 0 to Periodo - 1 do                                                 //Por cada columna del raster que se simula en memoria: Busca las repeticiones.
        begin
        if Terminated then Exit;
        Repeticiones := 1;                                                             //Inicia el contador de repeticiones.
        Explorador := Desde + Periodo + Columna;
        Inicio := Explorador - Periodo;                                                //Establece el inicio del primer segmento de repetici�n que se encontrar�.
        while Explorador < Hasta do                                                    //Mientras la posici�n se encuentre dentro del l�mite definido:
              begin
              if Terminated then Exit;
              if FPrioridad = 2 then
                 begin
                 if GetKeyState(VK_Escape) and 128 =128 then
                    begin
                    Terminate;
                    Exit;
                    end;
                 end;
              if (FuenteDeDatos.LeerDato(Explorador) = FuenteDeDatos.LeerDato(Explorador - Periodo))and                  //Si los datos son iguales y
                 (not GetPakBit(Explorador - Periodo))and                              //son posiciones v�lidas para
                 (not GetPakBit(Explorador))then                                       //realizar una comparaci�n:
                 Inc(Repeticiones)                                                     //Incrementa el contador de repeticiones.
              else
                 begin                                                                 //Si los datos son diferentes: Busca una nueva repetici�n.
                 if Repeticiones >= FResolucion then                                   //Si el segmento de repetici�n encontrado es lo suficientemente grande:
                    Inc(Sumatoria, Abs((Explorador - Periodo) - Inicio));
                 Inicio := Explorador;                                                 //Establece el inicio del pr�ximo segmento de repetici�n que se encontrar�.
                 Repeticiones := 1;                                                    //Inicia el contador de repeticiones de segmento.
                 end;
              Inc(Explorador, Periodo);                                                //Incrementa para la siguiente comparaci�n.
              end;
        if Repeticiones >= FResolucion then                                            //Si el segmento de repetici�n encontrado es lo suficientemente grande:
           Inc(Sumatoria, Abs((Explorador - Periodo) - Inicio));
        end;
    EstadisticasDePeriodos[Periodo].Periodo := Periodo;                                //Guarda el identificador del per�odo.
    Inc(EstadisticasDePeriodos[Periodo].Peso, Sumatoria);                              //Guarda la sumatoria de los solapamientos como estad�stica para este per�odo.
    end;
end;


//-------------------------------------------------------------------
// 3/12/2011
//
// Algoritmo: PatronesDeAreas
//
// Encuentra los per�odos de la se�al utilizando el siguiente
// m�todo:
//
// Busca las repeticiones continuas en cada columna y guarda
// su posici�n de inicio y final. Luego busca las intersecciones
// o solapamiento de los fragmentos de diferentes columnas.
// El per�odo en el que m�s cantidad de intersecciones de
// columnas consecutivas se produscan, tiene mayor probabilidad
// de ser un candidato positivo.
//-------------------------------------------------------------------

procedure TBuscadorDePeriodos.PatronesDeAreasII;
var Periodo: Integer;                                                                  //Mantiene el valor del per�odo en el que se est� realizando la b�squeda.
    Explorador: Integer;                                                               //Recorre la columna comparando los valores consecutivos.
    Repeticiones: Integer;                                                             //Almacena la cantidad de repeticiones de los fragmentos que son encontrados.
    Inicio, EmpezarEn, TerminarEn, n, m, k: Integer;                                   //Indica el inicio del fragmento.
begin
Segmentacion := FHasta * (FResolucion + 1);                                            //Tama�o de los fragmentos en que se dividen los ficheros para ser analizados.
SetLength(EstadisticasDePeriodos, FHasta + 1);                                         //Asigna memoria a las estad�sticas de per�odo.
for n := FDesde to FHasta do
    begin
    if Terminated then Exit;
    EstadisticasDePeriodos[n].Periodo := 0;
    EstadisticasDePeriodos[n].Peso := 0;
    end;

SetLength(PakData, LongitudDeDatos);

//Marca las grandes repeticiones consecutivas que existen en la cadena de datos, para que sean despreciadas en la b�squeda.
 for n := 0 to Length(PakData) - 1 do PakData[n] := 0;                                 //Borra las marcas de repeticiones.
Repeticiones := 0;                                                                     //Inicia el contador de repeticiones.
Explorador := 1;
Inicio := Explorador - 1;                                                              //Establece el inicio del primer segmento de repetici�n que se encontrar�.
while Explorador < LongitudDeDatos do                                                  //Mientras la posici�n se encuentre dentro del arreglo de datos:
      begin
      if Terminated then Exit;
      if FuenteDeDatos.LeerDato(Explorador) = FuenteDeDatos.LeerDato(Explorador - 1) then                                //Si los datos son iguales:
         Inc(Repeticiones)                                                             //Incrementa el contador de repeticiones.
      else
         begin                                                                         //Si los datos son diferentes: Busca una nueva repetici�n.
         m := FResolucion * FDesde;
         if Repeticiones >= m then                                                     //Si el segmento de repetici�n encontrado es lo suficientemente grande:
            begin
            MarcarRepeticion(Inicio, Explorador - 1);                                  //Guarda los datos del segmento de repetici�n encontrado.
            end;
         Inicio := Explorador;                                                         //Establece el inicio del pr�ximo segmento de repetici�n que se encontrar�.
         Repeticiones := 0;                                                            //Inicia el contador de repeticiones de segmento.
         end;
      Inc(Explorador);                                                                 //Incrementa para la siguiente comparaci�n.
      end;

//Divide el fichero en fragmentos y en cada uno busca los per�odos.
if Terminated then Exit;
k := 1;                                                                                //Se comienza siempre por 1.
while k < LongitudDeDatos do                                                           //Repetir esto hasta que se analicen todos los fragmentos.
      begin
      if Terminated then Exit;
      EmpezarEn := K;                                                                  //Inicio del fragmento.
      TerminarEn := K + Segmentacion;                                                  //Final del fragmento.
      if TerminarEn > LongitudDeDatos - 1 then                                         //Si el final del fragmento sobrepasa al final del fichero:
         TerminarEn := LongitudDeDatos - 1;                                            //Se utiliza como final del fragmento el final del fichero.
      PatronesDeAreasIIEnElRango(EmpezarEn, TerminarEn);                               //Busca per�odos en este fragmento.
      Inc(K, Segmentacion);                                                            //Incrementa para buscar en el otro fragmento.
      end;

//Ordena los resultados (Rasters) de acuerdo con las probabilidades de periodicidad calculadas.
if Terminated then Exit;
QuickSort(0, FHasta);                                                                  //Ordena los per�odos encontrados de mayor a menor seg�n su estad�stica.
//Elimina los arm�nicos (m�ltiplos) superiores de los resultados intentando quedarse siempre con el menor.
if Terminated then Exit;
if FEliminarArmonicos then
   for n := FDesde to FHasta do                                                                            //Este algoritmo es para eliminar los arm�nicos superiores de los per�odos.
       begin
       if Terminated then Exit;
       if EstadisticasDePeriodos[n].Peso > 0 then                                                          //Si el per�odo primitivo tiene un peso mayor que cero:
          for m := n to FHasta do                                                                          //Intenta eliminar los arm�nicos que tengan menor peso.
              begin
              if Terminated then Exit;
              if EstadisticasDePeriodos[n].Periodo < EstadisticasDePeriodos[m].Periodo then                //Si el per�odo es superior al primitivo, verifica si es un m�ltiplo.
                 if EstadisticasDePeriodos[m].Periodo mod EstadisticasDePeriodos[n].Periodo > 0 then       //Si es un m�ltiplo del per�odo primitivo:
                    EstadisticasDePeriodos[m].Peso := 0;                                                   //Elimina el per�odo m�ltiplo (arm�nico).
              end;
       end;

//Devuelve los datos en una lista.
if Terminated then Exit;
PeriodosEncontrados := TStringList.Create;
if not Assigned(PeriodosEncontrados) then exit;
for Periodo := 0 to FHasta do
    begin
    if Terminated then Exit;
    if EstadisticasDePeriodos[Periodo].Peso <> 0 then
       PeriodosEncontrados.Add(IntToStr(EstadisticasDePeriodos[Periodo].Periodo));
    end;
EstadisticasDePeriodos := nil;
end;


//-------------------------------------------------------------------
// .
//-------------------------------------------------------------------
function SolapamientoEntreII(s1, s2: TSegmento): Integer;
var r1, r2, c1, c2: Double;
    d: Integer;
begin
if Abs(s1.Columna - s2.Columna) = 1  then
   begin
   d := Abs(s1.Columna - s2.Columna);
   r1 := (s1.Final - s1.Inicio) / 2;
   r2 := (s2.Final - s2.Inicio) / 2;
   c1 := (s1.Final + s1.Inicio) / 2;
   c2 := (s2.Final + s2.Inicio) / 2;
   Result := Round((r1 + r2 - (Abs(c1 - c2) + Abs(r1 - r2))) / d);
   if Result < 0 then Result := 0;
   end
else
   Result := 0;
end;

//-------------------------------------------------------------------
procedure TBuscadorDePeriodos.PatronesDeAreasIIEnElRango(Desde, Hasta: Integer);
var Periodo: Integer;                                                                  //Mantiene el valor del per�odo en el que se est� realizando la b�squeda.
    CantidadDeLineas: Integer;                                                         //Cantidad de l�neas que ser�n analizadas por cada per�odo.
    Columna: Integer;                                                                  //Columan en la cual se buscan los fragmentos de repeticiones.
    Explorador: Integer;                                                               //Recorre la columna comparando los valores consecutivos.
    Repeticiones: Integer;                                                             //Almacena la cantidad de repeticiones de los fragmentos que son encontrados.
    Inicio, n, m, Sumatoria: Integer;                                                  //Indica el inicio del fragmento.
begin
//Por cada per�odo, conforma el raster y busca las repeticiones consecutivas que se producen de forma vertical en cada columna de cada raster formado.
Lista := TLista.Create;                                                                //Crea una lista para guardar los segmentos de repeticiones.
for Periodo := FDesde to FHasta do                                                     //Por cada per�odo posible, realiza una b�squeda...
    begin
    if Terminated then Exit;
    Lista.Vaciar;
    CantidadDeLineas := LongitudDeDatos div Periodo;                                   //Calcula la cantidad de lineas con que se trabajar� la b�squeda.
    if CantidadDeLineas < FResolucion then Break;                                      //Si no son suficientes lineas para una b�squeda, detiene el algoritmo.

    for Columna := 0 to Periodo - 1 do                                                 //Por cada columna del raster que se simula en memoria: Busca las repeticiones.
        begin
        if Terminated then Exit;
        Repeticiones := 1;                                                             //Inicia el contador de repeticiones.
        Explorador := Desde + Periodo + Columna;
        Inicio := Explorador - Periodo;                                                //Establece el inicio del primer segmento de repetici�n que se encontrar�.
        while Explorador < Hasta do                                                    //Mientras la posici�n se encuentre dentro del l�mite definido:
              begin
              if Terminated then Exit;
              if (FuenteDeDatos.LeerDato(Explorador) = FuenteDeDatos.LeerDato(Explorador - Periodo))and                  //Si los datos son iguales y
                 (not GetPakBit(Explorador - Periodo))and                              //son posiciones v�lidas para
                 (not GetPakBit(Explorador))then                                       //realizar una comparaci�n:
                 Inc(Repeticiones)                                                     //Incrementa el contador de repeticiones.
              else
                 begin                                                                 //Si los datos son diferentes: Busca una nueva repetici�n.
                 if Repeticiones >= FResolucion then                                   //Si el segmento de repetici�n encontrado es lo suficientemente grande:
                    Lista.Agregar(Columna, Inicio, Explorador - Periodo);              //Guarda los datos del segmento de repetici�n encontrado.
                 Inicio := Explorador;                                                 //Establece el inicio del pr�ximo segmento de repetici�n que se encontrar�.
                 Repeticiones := 1;                                                    //Inicia el contador de repeticiones de segmento.
                 end;
              Inc(Explorador, Periodo);                                                //Incrementa para la siguiente comparaci�n.
              end;
        if Repeticiones >= FResolucion then                                            //Si el segmento de repetici�n encontrado es lo suficientemente grande:
           Lista.Agregar(Columna, Inicio, Explorador - Periodo);                       //Guarda los datos del segmento de repetici�n encontrado.
        end;

    //Busca las intersecciones (solapamientos) que se producen entre las repeticiones encontradas y calcula las probabilidades de que el raster contenga un per�odo.
    Sumatoria := 0;
    for n := 0 to Lista.Insertados - 1 do                                              //Busca los solapamientos o intersecciones entre los fragmentos.
        begin
        if Terminated then Exit;
        for m := 0 to Lista.Insertados - 1 do
            begin
            if Terminated then Exit;
            Inc(Sumatoria, SolapamientoEntreII(Lista.Optener(n), Lista.Optener(m)));     //Acumula la suma de los solapamientos entre los segmentos o fragmentos de repeticiones.
            end;
        end;
    EstadisticasDePeriodos[Periodo].Periodo := Periodo;                                //Guarda el identificador del per�odo.
    Inc(EstadisticasDePeriodos[Periodo].Peso, Sumatoria);                              //Guarda la sumatoria de los solapamientos como estad�stica para este per�odo.
    end;
Lista.Destroy;                                                                         //Libera la memoria asignada a la lista.
end;


end.
