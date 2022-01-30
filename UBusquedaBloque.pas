unit UBusquedaBloque;

interface

uses Classes, StdCtrls, ComCtrls, SysUtils, Dialogs;

type
  TSearchThread = class(TThread)
  private
    FLista: TListbox;
    FBarra: TStatusBar;
    PrioridadDelSubproceso: Integer;
    CaseSens: Boolean;
    Recurse: Boolean;
    SearchBloq: TStrings;
    Periodo: Integer;
    SearchPath: string;
    FileSpec: string;
    AddStr: string;
    FSearchFile: string;
    SearchString: string;
    procedure AddToList;
    procedure DoSearch(const Path: string);
    procedure FindAllFiles(const Path: string);
    procedure ScanForBloc(const FName: string; var FileStr: string);
    procedure SearchFile(const FName: string);
    procedure SetSearchFile;
  protected
    procedure Execute; override;
  public
    constructor Create(CaseS, Rec: Boolean; const Bloq: TStrings; pPeriodoBase: Integer; const SPath, FSpec: string; Lista: TListBox; Barra: TStatusBar; Prioridad: Integer);
    destructor Destroy; override;
  end;

implementation

uses StrUtils, Windows, Forms;

//----------------------------------------------------------------------------
constructor TSearchThread.Create(CaseS, Rec: Boolean; const Bloq: TStrings; pPeriodoBase: Integer; const SPath, FSpec: string; Lista: TListBox; Barra: TStatusBar; Prioridad: Integer);
begin
FLista := Lista;
FBarra := Barra;
PrioridadDelSubproceso := Prioridad;
CaseSens := CaseS;
Recurse := Rec;
SearchBloq := Bloq;
Periodo := pPeriodoBase;
SearchPath := SPath;
FileSpec := FSpec;
inherited Create(True);
end;

//----------------------------------------------------------------------------
destructor TSearchThread.Destroy;
begin
FSearchFile := '';
Synchronize(SetSearchFile);
inherited Destroy;
end;

//----------------------------------------------------------------------------
procedure TSearchThread.Execute;
begin
FreeOnTerminate := True;
Priority := TThreadPriority(PrioridadDelSubproceso);
if not CaseSens then SearchBloq.Text := UpperCase(SearchBloq.Text);
FindAllFiles(SearchPath);
if Recurse then DoSearch(SearchPath);
end;

//----------------------------------------------------------------------------
procedure TSearchThread.SetSearchFile;
begin
FBarra.Panels[0].Text := FSearchFile;
end;

//----------------------------------------------------------------------------
procedure TSearchThread.AddToList;
begin
FLista.Items.Add(AddStr);
end;



//----------------------------------------------------------------------------
// Busca el bloque dentro del fichero con el método
// de la fuerza bruta. 
//----------------------------------------------------------------------------
procedure TSearchThread.ScanForBloc(const FName: string; var FileStr: string);
var Desde: Integer;

   function Coincide(p, q: Integer): Boolean;
   var i: Integer;
       s: String;
   begin
   Result := True;
   for i := 1 to Length(SearchBloq[q]) - 1 do
      begin
      if FileStr[p + i - 1] <> SearchBloq[q][i] then
          begin
          Result := False;
          Exit;
          end
       end;
   end;

   function BloqueEncontrado: Boolean;
   var n, m: integer;
   begin
   Result := False;
   Desde := 1;
   for n := 1 to Length(FileStr) do
       begin
       if Terminated then Exit;
       if Pos(SearchBloq[0], Copy(FileStr, Desde, Length(FileStr) - Desde + 1)) > 0 then
          begin
//       for m := 1 to SearchBloq.Count - 1 do
//           if not Coincide(n + (Periodo * m), m) then Continue;
          Result := True;
          Exit;
          end
       end;
   end;


begin
if Terminated then Exit;
if BloqueEncontrado then
   begin
   AddStr := FName;
   Synchronize(AddToList);
   end;
end;

//----------------------------------------------------------------------------
// Prepara la búsqueda dentro de un fichero.
//----------------------------------------------------------------------------
procedure TSearchThread.SearchFile(const FName: string);
var DataFile: THandle;
    FileSize: Integer;
//    SearchString: string;
begin
FSearchFile := FName;
Synchronize(SetSearchFile);
try
   DataFile := FileOpen(FName, fmOpenRead or fmShareDenyWrite);          //Abre el fichero.
   if DataFile = 0 then raise Exception.Create('');
   try
      FileSize := GetFileSize(DataFile, nil);                            //busca la longitud del fichero.
      SetLength(SearchString, FileSize);                                 //Crea una cadena con la misma longitud.
      FileRead(DataFile, Pointer(SearchString)^, FileSize);              //Copia los datos del fichero a la cadena.
   finally
      CloseHandle(DataFile);                                             //Cierra el fichero.
   end;
   if not CaseSens then SearchString := UpperCase(SearchString);         //Lleva todo a mayúscula para tomar por iguales la mayúsculas y minúsculas.
   ScanForBloc(FName, SearchString);                                      //Busca la conincidencia dentro del fichero.
except
   on Exception do                                                       //Maneja los errores...
      begin
      AddStr := Format('Error leyendo el fichero: %s', [FName]);
      Synchronize(AddToList);
      end;
end;
end;

//----------------------------------------------------------------------------
// Busca en los ficheros que se encuentran dentro de los directorios.
//----------------------------------------------------------------------------
procedure TSearchThread.FindAllFiles(const Path: string);
var SR: TSearchRec;
begin
if FindFirst(Path + FileSpec, faArchive, SR) = 0 then
   try
      repeat SearchFile(Path + SR.Name);                 //Busca en el fichero específico.
      until (FindNext(SR) <> 0) or Terminated;           //Busca los siguientes ficheros.
   finally
      SysUtils.FindClose(SR);                       
   end;
end;

//----------------------------------------------------------------------------
// Busca en los directorios y los que se encuentran de forma anidada.
//----------------------------------------------------------------------------
procedure TSearchThread.DoSearch(const Path: string);
var SR: TSearchRec;
begin
if FindFirst(Path + '*.*', faDirectory, SR) = 0 then     //Busca los directorios existentes.
   try
      repeat
      if ((SR.Attr and faDirectory) <> 0) and            //Si es un directorio diferente de '.' o '..' entoces:
         (SR.Name[1] <> '.') and
         not Terminated then
         begin
         FindAllFiles(Path + SR.Name + '\');             //Analiza los ficheros que se encuentran en el directorio.
         DoSearch(Path + SR.Name + '\');                 //Se llama a si mismo para buscar dentro de los directorios.
         end;
      until (FindNext(SR) <> 0) or Terminated;           //Busca los siguientes directorios.
   finally
      SysUtils.FindClose(SR);
   end;
end;

end.
