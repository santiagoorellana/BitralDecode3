
/////////////////////////////////////////////////////////////////
//  Nombre: ULista.pas                                         //
//  Autor:  Santiago Alejandro Orellana Pérez                  //
//  Fechar: 23/09/2011                                         //
//  Objeto exportado: TList                                    //
//  Descripción: Implementa una lista de punteros genéricos.   //
//               Puede almacenar punteros a cualquier objeto.  //
//               Es responsabilidad del programador recordar   //
//               el tipo de objeto al que se hace referencia.  //
/////////////////////////////////////////////////////////////////

unit UListaSegmentos;

interface

uses Classes;

type
  TSegmento = record
              Columna: Integer;                             //Indica la columna a la que pertenece esta repetición.
              Inicio: Integer;                              //Posición de inicio de la repetición.
              Final: Integer;                               //Posición donde termina la repetición.
              end;

  PSegmento = ^TSegmento;                                   //Puntero a un dato to tipo "TSegmento" creado en la memoria. 

  TLista = class                                            //Clase que define la lista que guarda los segmentos.
  private
     lista: TList;
  public
     constructor Create;                                           //Inicia la lista.
     procedure Vaciar;                                             //Vacía la lista.
     procedure Insertar(indice: Integer; dato: TSegmento);         //Inserta un dato en la posición indicada.
     procedure Agregar(dato: TSegmento); overload;                 //Agrega un dato al final de la lista.
     procedure Agregar(Columna, Inicio, Final: Integer); overload;
     function Extraer(indice: Integer): TSegmento;                 //Extrae el dato de la posición indicada.
     function Optener(indice: Integer): TSegmento;                 //Devuelve una copia del dato de la posición indicada.
     function Insertados: Integer;                                 //Devuelve el número de datos insertados en la lista.
  end;


/////////////////////////////////////////////////////////////////

implementation

//-----------------------------------------------------------
// Inicia la lista vacía.
//-----------------------------------------------------------

constructor TLista.Create;
begin
lista := TList.Create;
end;

//-----------------------------------------------------------
// Agrega un dato al final de la lista.
//-----------------------------------------------------------

procedure TLista.Agregar(Dato: TSegmento);
var NuevoSegmento: PSegmento;
begin
new(NuevoSegmento);
NuevoSegmento^ := Dato;
lista.Add(NuevoSegmento);
end;

procedure TLista.Agregar(Columna, Inicio, Final: Integer);
var NuevoSegmento: TSegmento;
begin
NuevoSegmento.Columna := Columna;
NuevoSegmento.Inicio := Inicio;
NuevoSegmento.Final := Final;
Agregar(NuevoSegmento);
end;

//-----------------------------------------------------------
// Inserta un dato en la posición indicada.
//-----------------------------------------------------------

procedure TLista.Insertar(Indice: Integer; Dato: TSegmento);
var NuevoSegmento: PSegmento;
begin
if (indice <= lista.Count) then
   begin
   new(NuevoSegmento);
   NuevoSegmento^ := Dato;
   lista.Insert(Indice, NuevoSegmento);
   end;
end;

//-----------------------------------------------------------
// Extrae el dato de la posición indicada. Devuelve su
// valor y lo borra de la lista.
//-----------------------------------------------------------

function TLista.Extraer(indice: Integer): TSegmento;
var Extraido: PSegmento;
begin
Result.Columna := MaxInt;
Result.Inicio := MaxInt;
Result.Final := MaxInt;
if (lista.Count > 0) and (lista.Count > indice) then
   begin
   Extraido := PSegmento(lista.Extract(lista.Items[indice]));
   Result := Extraido^;
   Dispose(Extraido);
   end;
end;

//-----------------------------------------------------------
// Optiene el dato de la posición indicada.
//-----------------------------------------------------------

function TLista.Optener(indice: Integer): TSegmento;
begin
Result.Columna := MaxInt;
Result.Inicio := MaxInt;
Result.Final := MaxInt;
if (lista.Count > 0) and (lista.Count > indice) then
   Result := (PSegmento(lista.Items[indice]))^;
end;

//-----------------------------------------------------------
// Vacía la lista.
//-----------------------------------------------------------

procedure TLista.Vaciar;
begin
if Assigned(lista) then
   if lista.Count > 0 then
      lista.Clear;
end;

//-----------------------------------------------------------
// Devuelve la cantidad de datos insertados.
//-----------------------------------------------------------

function TLista.Insertados: Integer;
begin
Result := lista.Count;
end;

//-----------------------------------------------------------

end.
