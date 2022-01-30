unit UFuenteDeDemodulacion;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, Math;




type TFuenteDeDemodulacion = class
     private
     public
     CantidadDeSimbolos: Integer;
     function LongitudDeDatos: Integer;

     function Llena: Boolean;
     end;


implementation

//-------------------------------------------------------------------
// Devuelve la longitud de los datos.
//-------------------------------------------------------------------
function TFuenteDeDemodulacion.LongitudDeDatos: Integer;
begin

end;



//-------------------------------------------------------------------
// Devuelve TRUE si la fuente de datos está llena.
//-------------------------------------------------------------------
function TFuenteDeDemodulacion.Llena: Boolean;
begin

end;


end.
