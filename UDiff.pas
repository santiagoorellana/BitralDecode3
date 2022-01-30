///////////////////////////////////////////////////////////////////////////
//      Objeto: TDiff                                                    //
//       Autor: Santiago A. Orellana Pérez.                              //
//       Fecha: 2011                                                     //
// Descripción: Compara dos arreglos.                                    //
//        Nota: Para la creación de esta unit se utilizó el código       //
//              fuente (Free) desarrollado por Angus Johnson en el       //
//              2009, el cual se encuentra disponible en la red.         //
//              El código ha sido modificado en algunos detalles         //
//              para daptarlo a la especificación requerida.             //
//              Los comentarios en ingles, son del autor original.       //
///////////////////////////////////////////////////////////////////////////


unit UDiff;

interface

uses
  Windows, SysUtils, Classes, Math, Forms;

const
  //Maximum realistic deviation from centre diagonal vector ...
  MAX_DIAGONAL = $FFFFFF; //~16 million

type

{$IFDEF UNICODE}
  P8Bits = PByte;
{$ELSE}
  P8Bits = PAnsiChar;
{$ENDIF}

  PDiags = ^TDiags;
  TDiags = array [-MAX_DIAGONAL .. MAX_DIAGONAL] of integer;


  PChrArray = ^TChrArray;
  TChrArray = array[0 .. MAXINT div sizeof(char) -1] of Char;

  TChangeKind = (ckNone, ckAdd, ckDelete, ckModify);

  PCompareRec = ^TCompareRec;
  TCompareRec = record
                Kind: TChangeKind;
                oldIndex1, oldIndex2 : integer;
                chr1, chr2 : Char;
                end;

  TDiffStats = record
               matches: integer;
               adds: integer;
               deletes: integer;
               modifies: integer;
               end;

  TDiff = class
  private
    TerminatedProcess: PBoolean;
    fCompareList: TList;
    fCancelled: boolean;
    fExecuting: boolean;
    fDiagBuffer, bDiagBuffer: pointer;
    Chrs1, Chrs2: PChrArray;
    LastCompareRec: TCompareRec;
    fDiag, bDiag: PDiags;
    fDiffStats: TDiffStats;
    procedure InitDiagArrays(MaxOscill, len1, len2: integer);
    //nb: To optimize speed, separate functions are called for either
    //integer or character compares ...
    procedure RecursiveDiffChr(offset1, offset2, len1, len2: integer);
    procedure AddChangeChrs(offset1, range: integer; ChangeKind: TChangeKind);

    function GetCompareCount: integer;
    function GetCompare(index: integer): TCompareRec;
  public
    constructor Create(Terminated: PBoolean);
    destructor Destroy; override;

    //compare either and array of characters or an array of integers ...
    function Execute(pchrs1, pchrs2: PChar; len1, len2: integer): boolean; overload;

    //Cancel allows interrupting excessively prolonged comparisons
    procedure Cancel;
    procedure Clear;

    property Cancelled: boolean read fCancelled;
    property Count: integer read GetCompareCount;
    property Compares[index: integer]: TCompareRec read GetCompare; default;
    property DiffStats: TDiffStats read fDiffStats;
  end;


implementation


constructor TDiff.Create(Terminated: PBoolean);
begin
inherited Create;
TerminatedProcess := Terminated;
fCompareList := TList.create;
end;

//------------------------------------------------------------------------------
destructor TDiff.Destroy;
begin
Clear;
fCompareList.free;
inherited;
end;

//------------------------------------------------------------------------------
function TDiff.Execute(pchrs1, pchrs2: PChar; len1, len2: integer): boolean;
var maxOscill, x1,x2, savedLen: integer;
    compareRec: PCompareRec;
begin
if TerminatedProcess^ then Exit;
Result := False;
result := not fExecuting;
if not result then exit;
fExecuting := true;
fCancelled := false;
try
   Clear;
   //save first string length for later (ie for any trailing matches) ...
   savedLen := len1-1;
   //setup the character arrays ...
   Chrs1 := pointer(pchrs1);
   Chrs2 := pointer(pchrs2);
   //ignore top matches ...
   x1:= 0; x2 := 0;
   while (len1 > 0) and (len2 > 0) and (Chrs1[len1-1] = Chrs2[len2-1]) do
         begin
         if TerminatedProcess^ then Exit;
         dec(len1); dec(len2);
         end;
   if TerminatedProcess^ then Exit;
   //if something doesn't match ...
   if (len1 <> 0) or (len2 <> 0) then
      begin
      //ignore bottom of matches too ...
      while (len1 > 0) and (len2 > 0) and (Chrs1[x1] = Chrs2[x2]) do
            begin
            if TerminatedProcess^ then Exit;
            dec(len1); dec(len2);
            inc(x1); inc(x2);
            end;
      if TerminatedProcess^ then Exit;
      maxOscill := min(max(len1,len2), MAX_DIAGONAL);
      fCompareList.Capacity := len1 + len2;
      //nb: the Diag arrays are extended by 1 at each end to avoid testing
      //for array limits. Hence '+3' because will also includes Diag[0] ...
      GetMem(fDiagBuffer, sizeof(integer)*(maxOscill*2+3));
      GetMem(bDiagBuffer, sizeof(integer)*(maxOscill*2+3));
      if TerminatedProcess^ then Exit;
      try
         RecursiveDiffChr(x1, x2, len1, len2);
         if TerminatedProcess^ then Exit;
      finally
         freeMem(fDiagBuffer);
         freeMem(bDiagBuffer);
      end;
   end;
   if fCancelled then
      begin
      result := false;
      Clear;
      exit;
      end;
   if TerminatedProcess^ then Exit;
   //finally, append any trailing matches onto compareList ...
   while (LastCompareRec.oldIndex1 < savedLen) do
         begin
         if TerminatedProcess^ then Exit;
         with LastCompareRec do
              begin
              Kind := ckNone;
              inc(oldIndex1);
              inc(oldIndex2);
              chr1 := Chrs1[oldIndex1];
              chr2 := Chrs2[oldIndex2];
              end;
         New(compareRec);
         compareRec^ := LastCompareRec;
         fCompareList.Add(compareRec);
         inc(fDiffStats.matches);
         end;
finally
   fExecuting := false;
end;
end;


//------------------------------------------------------------------------------
procedure TDiff.InitDiagArrays(MaxOscill, len1, len2: integer);
var diag: integer;
begin
if TerminatedProcess^ then Exit;
inc(maxOscill); //for the extra diag at each end of the arrays ...
P8Bits(fDiag) := P8Bits(fDiagBuffer) - sizeof(integer)*(MAX_DIAGONAL-maxOscill);
P8Bits(bDiag) := P8Bits(bDiagBuffer) - sizeof(integer)*(MAX_DIAGONAL-maxOscill);
//initialize Diag arrays (assumes 0 based arrays) ...
for diag := - maxOscill to maxOscill do
    begin
    if TerminatedProcess^ then Exit;
    fDiag[diag] := -MAXINT;
    end;
fDiag[0] := -1;
for diag := - maxOscill to maxOscill do
    begin
    if TerminatedProcess^ then Exit;
    bDiag[diag] := MAXINT;
    end;
bDiag[len1 - len2] := len1-1;
end;

//------------------------------------------------------------------------------
procedure TDiff.RecursiveDiffChr(offset1, offset2, len1, len2: integer);
var diag, lenDelta, Oscill, maxOscill, x1, x2: integer;
begin
if TerminatedProcess^ then Exit;
//nb: the possible depth of recursion here is most unlikely to cause
//problems with stack overflows.
application.processmessages;
if fCancelled then exit;
if (len1 = 0) then
    begin
    AddChangeChrs(offset1, len2, ckAdd);
    exit;
    end
else if (len2 = 0) then
        begin
        AddChangeChrs(offset1, len1, ckDelete);
        exit;
        end
     else if (len1 = 1) and (len2 = 1) then
          begin
          AddChangeChrs(offset1, 1, ckDelete);
          AddChangeChrs(offset1, 1, ckAdd);
          exit;
          end;
maxOscill := min(max(len1,len2), MAX_DIAGONAL);
InitDiagArrays(MaxOscill, len1, len2);
lenDelta := len1 -len2;
Oscill := 1; //ie assumes prior filter of top and bottom matches
if TerminatedProcess^ then Exit;
while Oscill <= maxOscill do
      begin
      if TerminatedProcess^ then Exit;
      if (Oscill mod 200) = 0 then
         begin
         application.processmessages;
         if fCancelled then exit;
         end;
if TerminatedProcess^ then Exit;         
//do forward oscillation (keeping diag within assigned grid)...
diag := Oscill;
while diag > len1 do
      begin
      if TerminatedProcess^ then Exit;
      dec(diag,2);
      end;
if TerminatedProcess^ then Exit;
while diag >= max(- Oscill, -len2) do
      begin
      if TerminatedProcess^ then Exit;
      if fDiag[diag-1] < fDiag[diag+1] then
         x1 := fDiag[diag+1]
      else
         x1 := fDiag[diag-1]+1;
      x2 := x1 - diag;
      if TerminatedProcess^ then Exit;
      while (x1 < len1-1) and
            (x2 < len2-1) and
            (Chrs1[offset1+x1+1] = Chrs2[offset2+x2+1]) do
            begin
            if TerminatedProcess^ then Exit;
            inc(x1); inc(x2);
            end;
      fDiag[diag] := x1;
      if TerminatedProcess^ then Exit;
      //nb: (fDiag[diag] is always < bDiag[diag]) here when NOT odd(lenDelta) ...
      if odd(lenDelta) and (fDiag[diag] >= bDiag[diag]) then
         begin
         inc(x1);inc(x2);
         //save x1 & x2 for second recursive_diff() call by reusing no longer
         //needed variables (ie minimize variable allocation in recursive fn) ...
         diag := x1; Oscill := x2;
         while (x1 > 0) and
               (x2 > 0) and
               (Chrs1[offset1+x1-1] = Chrs2[offset2+x2-1]) do
               begin
               if TerminatedProcess^ then Exit;
               dec(x1); dec(x2);
               end;
         RecursiveDiffChr(offset1, offset2, x1, x2);
         x1 := diag; x2 := Oscill;
         RecursiveDiffChr(offset1+x1, offset2+x2, len1-x1, len2-x2);
         exit; //ALL DONE
         end;
      dec(diag,2);
      end;
if TerminatedProcess^ then Exit;
//do backward oscillation (keeping diag within assigned grid)...
diag := lenDelta + Oscill;
while diag > len1 do
      begin
      if TerminatedProcess^ then Exit;
      dec(diag,2);
      end;
if TerminatedProcess^ then Exit;
while diag >= max(lenDelta - Oscill, -len2)  do
      begin
      if TerminatedProcess^ then Exit;
      if bDiag[diag-1] < bDiag[diag+1] then
         x1 := bDiag[diag-1]
      else
         x1 := bDiag[diag+1]-1;
      x2 := x1 - diag;
      if TerminatedProcess^ then Exit;
      while (x1 > -1) and
            (x2 > -1) and
            (Chrs1[offset1+x1] = Chrs2[offset2+x2]) do
            begin
            if TerminatedProcess^ then Exit;
            dec(x1); dec(x2);
            end;
      bDiag[diag] := x1;
      if TerminatedProcess^ then Exit;
      if bDiag[diag] <= fDiag[diag] then
         begin
         //flag return value then ...
         inc(x1);inc(x2);
         RecursiveDiffChr(offset1, offset2, x1, x2);
         while (x1 < len1) and
               (x2 < len2) and
               (Chrs1[offset1+x1] = Chrs2[offset2+x2]) do
               begin
               if TerminatedProcess^ then Exit;
               inc(x1); inc(x2);
               end;
         RecursiveDiffChr(offset1+x1, offset2+x2, len1-x1, len2-x2);
         exit; //ALL DONE
         end;
      dec(diag,2);
      if TerminatedProcess^ then Exit;
      end;
inc(Oscill);
end;         //while Oscill <= maxOscill
raise Exception.create('Error en la función "RecursiveDiffChr()"');
end;


//------------------------------------------------------------------------------
procedure TDiff.Clear;
var i: integer;
begin
if TerminatedProcess^ then Exit;
for i := 0 to fCompareList.Count-1 do
    begin
    if TerminatedProcess^ then Exit;
    dispose(PCompareRec(fCompareList[i]));
    end;
fCompareList.clear;
LastCompareRec.Kind := ckNone;
LastCompareRec.oldIndex1 := -1;
LastCompareRec.oldIndex2 := -1;
fDiffStats.matches := 0;
fDiffStats.adds := 0;
fDiffStats.deletes :=0;
fDiffStats.modifies :=0;
Chrs1 := nil;
Chrs2 := nil;
end;

//------------------------------------------------------------------------------
function TDiff.GetCompareCount: integer;
begin
result := fCompareList.count;
end;

//------------------------------------------------------------------------------
function TDiff.GetCompare(index: integer): TCompareRec;
begin
result := PCompareRec(fCompareList[index])^;
end;

//------------------------------------------------------------------------------
procedure TDiff.AddChangeChrs(offset1, range: integer; ChangeKind: TChangeKind);
var i,j: integer;
    compareRec: PCompareRec;
begin
if TerminatedProcess^ then Exit;
//first, add any unchanged items into this list ...
while (LastCompareRec.oldIndex1 < offset1 -1) do
      begin
      if TerminatedProcess^ then Exit;
      with LastCompareRec do
           begin
           Kind := ckNone;
           inc(oldIndex1);
           inc(oldIndex2);
           chr1 := Chrs1[oldIndex1];
           chr2 := Chrs2[oldIndex2];
      end;
      New(compareRec);
      compareRec^ := LastCompareRec;
      fCompareList.Add(compareRec);
      inc(fDiffStats.matches);
      end;
case ChangeKind of
     ckAdd: begin
            if TerminatedProcess^ then Exit;
            for i := 1 to range do
                begin
                if TerminatedProcess^ then Exit;
                with LastCompareRec do
                     begin
                     //check if a range of adds are following a range of deletes
                     //and convert them to modifies ...
                     if Kind = ckDelete then
                        begin
                        j := fCompareList.Count -1;
                        while (j > 0) and
                              (PCompareRec(fCompareList[j-1]).Kind = ckDelete) do
                              begin
                              if TerminatedProcess^ then Exit;
                              dec(j);
                              end;
                        PCompareRec(fCompareList[j]).Kind := ckModify;
                        dec(fDiffStats.deletes);
                        inc(fDiffStats.modifies);
                        inc(LastCompareRec.oldIndex2);
                        PCompareRec(fCompareList[j]).oldIndex2 := LastCompareRec.oldIndex2;
                        PCompareRec(fCompareList[j]).chr2 := Chrs2[oldIndex2];
                        if j = fCompareList.Count-1 then LastCompareRec.Kind := ckModify;
                        continue;
                        end;
                     Kind := ckAdd;
                     chr1 := #0;
                     inc(oldIndex2);
                     chr2 := Chrs2[oldIndex2]; //ie what we added
                     end;
                New(compareRec);
                compareRec^ := LastCompareRec;
                fCompareList.Add(compareRec);
                inc(fDiffStats.adds);
                end;
            end;
     ckDelete: begin
               if TerminatedProcess^ then Exit;
               for i := 1 to range do
                   begin
                   if TerminatedProcess^ then Exit;
                   with LastCompareRec do
                        begin
                        //check if a range of deletes are following a range of adds
                        //and convert them to modifies ...
                        if Kind = ckAdd then
                           begin
                           j := fCompareList.Count -1;
                           while (j > 0) and
                                 (PCompareRec(fCompareList[j-1]).Kind = ckAdd) do
                                 begin
                                 if TerminatedProcess^ then Exit;
                                 dec(j);
                                 end;
                           PCompareRec(fCompareList[j]).Kind := ckModify;
                           dec(fDiffStats.adds);
                           inc(fDiffStats.modifies);
                           inc(LastCompareRec.oldIndex1);
                           PCompareRec(fCompareList[j]).oldIndex1 := LastCompareRec.oldIndex1;
                           PCompareRec(fCompareList[j]).chr1 := Chrs1[oldIndex1];
                           if j = fCompareList.Count-1 then LastCompareRec.Kind := ckModify;
                           continue;
                           end;
                        Kind := ckDelete;
                        chr2 := #0;
                        inc(oldIndex1);
                        chr1 := Chrs1[oldIndex1]; //ie what we deleted
                        end;
                   New(compareRec);
                   compareRec^ := LastCompareRec;
                   fCompareList.Add(compareRec);
                   inc(fDiffStats.deletes);
                   end;
               end;
     end;
end;


//------------------------------------------------------------------------------
procedure TDiff.Cancel;
begin
fCancelled := true;
end;


end.
