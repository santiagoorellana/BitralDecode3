
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

unit UListaMost;

interface

uses Classes, Windows, Messages, SysUtils, Variants;

type PSegmento = ^TRect;                                    //Puntero a un dato to tipo "TSegmento" creado en la memoria.

type
  TLista = class                                            //Clase que define la lista que guarda los segmentos.
  private
     lista: TList;
  public
     constructor Create;                                           //Inicia la lista.
     procedure Vaciar;                                             //Vacía la lista.
     procedure Insertar(indice: Integer; dato: TRect);             //Inserta un dato en la posición indicada.
     procedure Agregar(dato: TRect); overload;                     //Agrega un dato al final de la lista.
     procedure Agregar(Left, Right, Top, Bottom: Integer); overload;
     function Extraer(indice: Integer): TRect;                     //Extrae el dato de la posición indicada.
     function Optener(indice: Integer): TRect;                     //Devuelve una copia del dato de la posición indicada.
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

procedure TLista.Agregar(Dato: TRect);
var NuevoSegmento: PSegmento;
begin
new(NuevoSegmento);
NuevoSegmento^ := Dato;
lista.Add(NuevoSegmento);
end;

procedure TLista.Agregar(Left, Right, Top, Bottom: Integer);
var NuevoSegmento: TRect;
begin
NuevoSegmento.Left := Left;
NuevoSegmento.Right := Right;
NuevoSegmento.Top := Top;
NuevoSegmento.Bottom := Bottom;
Agregar(NuevoSegmento);
end;

//-----------------------------------------------------------
// Inserta un dato en la posición indicada.
//-----------------------------------------------------------

procedure TLista.Insertar(Indice: Integer; Dato: TRect);
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

function TLista.Extraer(indice: Integer): TRect;
var Extraido: PSegmento;
begin
Result.Left := MaxInt;
Result.Right := MaxInt;
Result.Top := MaxInt;
Result.Bottom := MaxInt;
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

function TLista.Optener(indice: Integer): TRect;
begin
Result.Left := MaxInt;
Result.Right := MaxInt;
Result.Top := MaxInt;
Result.Bottom := MaxInt;
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
